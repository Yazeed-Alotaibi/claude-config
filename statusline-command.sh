#!/usr/bin/env bash
# Claude Code status line (Windows / Git Bash). No jq, node or python dependency.
# Segments: full cwd | git branch+dirty | model (effort) | ctx % | session cost | style | time

input=$(cat)

# Save the raw payload so field names can be inspected if a segment goes missing.
printf '%s' "$input" > "$HOME/.claude/.statusline-last.json" 2>/dev/null

# --- minimal JSON scalar extraction (keys in this payload are unique enough) ---
# Uses bash's built-in regex: no subprocesses, since this runs on every render.
jstr() { [[ $input =~ \"$1\"[[:space:]]*:[[:space:]]*\"([^\"]*)\" ]] && printf '%s' "${BASH_REMATCH[1]}"; }
jnum() { [[ $input =~ \"$1\"[[:space:]]*:[[:space:]]*([0-9.eE+-]+) ]] && printf '%s' "${BASH_REMATCH[1]}"; }

cwd=$(jstr current_dir); [ -n "$cwd" ] || cwd=$(jstr cwd)
model=$(jstr display_name); [ -n "$model" ] || model=$(jstr id)
effort=$(jstr level)
cost=$(jnum total_cost_usd)
transcript=$(jstr transcript_path)

# output_style.name — match through the object, since "name" alone is not unique.
style=""
[[ $input =~ \"output_style\"[[:space:]]*:[[:space:]]*\{[^}]*\"name\"[[:space:]]*:[[:space:]]*\"([^\"]*)\" ]] \
  && style="${BASH_REMATCH[1]}"
[ -n "$style" ] || style="default"

# --- context usage % ---
used_pct=$(jnum used_percentage)
if [ -z "$used_pct" ]; then
  # Not in the payload: derive from the last usage record in the transcript.
  win=200000
  case "$(jstr id)" in *"[1m]"*|*"-1m"*) win=1000000 ;; esac
  if [ -n "$transcript" ] && [ -f "$transcript" ]; then
    used_pct=$(tail -n 60 "$transcript" 2>/dev/null \
      | grep -o '"usage":{[^}]*}' | tail -1 \
      | grep -o '"\(input_tokens\|cache_creation_input_tokens\|cache_read_input_tokens\|output_tokens\)":[0-9]*' \
      | sed 's/.*://' \
      | awk -v w="$win" '{s+=$1} END {if (s>0 && w>0) printf "%.0f", s*100/w}')
  fi
fi

# --- git branch + dirty (silently omitted outside a repo) ---
branch=""; dirty=""
if [ -n "$cwd" ] && git -C "$cwd" --no-optional-locks rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
  [ -n "$branch" ] || branch=$(git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
  [ -n "$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null | head -1)" ] && dirty="*"
fi

RESET=$'\033[0m'; DIM=$'\033[2;37m'; GREEN=$'\033[2;32m'; CYAN=$'\033[2;36m'
YELLOW=$'\033[2;33m'; MAGENTA=$'\033[2;35m'; BLUE=$'\033[2;34m'
sep=" ${DIM}|${RESET} "

out="${DIM}${cwd}${RESET}"
[ -n "$branch" ] && out="${out}${sep}${GREEN}${branch}${dirty}${RESET}"

model_str="${model:-unknown}"
[ -n "$effort" ] && model_str="${model_str} · ${effort}"
out="${out}${sep}${CYAN}${model_str}${RESET}"

[ -n "$used_pct" ] && out="${out}${sep}${YELLOW}ctx ${used_pct}%${RESET}"

if [ -n "$cost" ]; then
  cost_fmt=$(printf '%.4f' "$cost" 2>/dev/null) || cost_fmt="$cost"
  out="${out}${sep}${MAGENTA}\$${cost_fmt}${RESET}"
fi

out="${out}${sep}${BLUE}${style}${RESET}${sep}${DIM}$(date '+%H:%M:%S')${RESET}"

printf '%s' "$out"
