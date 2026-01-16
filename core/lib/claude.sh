#!/bin/bash
# claude.sh - Claude Code CLI provider module
# Source this file: source lib/claude.sh
#
# Provides:
#   run_claude_code()   - Pipe prompts to claude -p
#   run_claude_vision() - Handle --image flag for vision
#   check_claude()      - Verify claude CLI installed

# Prevent double-sourcing
[ -z "${CLAUDE_PROVIDER_LOADED:-}" ] || return 0
CLAUDE_PROVIDER_LOADED=true

# Default timeout (30 minutes)
CLAUDE_DEFAULT_TIMEOUT=${CLAUDE_DEFAULT_TIMEOUT:-1800}

# Run Claude Code with a prompt
# Usage: run_claude_code "prompt" [timeout_seconds]
# Returns: Claude's response (stdout), exit code from claude CLI
run_claude_code() {
    local prompt="$1"
    local timeout="${2:-$CLAUDE_DEFAULT_TIMEOUT}"

    echo "$prompt" | timeout "$timeout" claude --dangerously-skip-permissions -p 2>&1
}

# Run Claude Code with vision (image analysis)
# Usage: run_claude_vision "prompt" "image_path" [timeout_seconds]
# Returns: Claude's response (stdout), exit code from claude CLI
run_claude_vision() {
    local prompt="$1"
    local image_path="$2"
    local timeout="${3:-$CLAUDE_DEFAULT_TIMEOUT}"

    if [ ! -f "$image_path" ]; then
        echo "Error: Image not found: $image_path" >&2
        return 1
    fi

    echo "$prompt" | timeout "$timeout" claude --dangerously-skip-permissions -p --image "$image_path" 2>&1
}

# Check if Claude CLI is installed and available
# Usage: check_claude
# Returns: 0 if installed, 1 if not
check_claude() {
    if ! command -v claude >/dev/null 2>&1; then
        echo "Error: claude CLI not found. Install with: npm install -g @anthropic-ai/claude-code" >&2
        return 1
    fi
    return 0
}
