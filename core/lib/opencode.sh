#!/bin/bash
# opencode.sh - OpenCode CLI provider module
# Source this file: source lib/opencode.sh
#
# Provides:
#   run_opencode_code()   - Run prompts with opencode run
#   run_opencode_vision() - Vision support (stub for MCP integration)
#   check_opencode()      - Verify opencode CLI installed

# Prevent double-sourcing
[ -z "${OPENCODE_PROVIDER_LOADED:-}" ] || return 0
OPENCODE_PROVIDER_LOADED=true

# Default timeout (30 minutes)
OPENCODE_DEFAULT_TIMEOUT=${OPENCODE_DEFAULT_TIMEOUT:-1800}

# Run OpenCode with a prompt
# Usage: run_opencode_code "prompt" [timeout_seconds]
# Returns: OpenCode's response (stdout), exit code from opencode CLI
run_opencode_code() {
    local prompt="$1"
    local timeout="${2:-$OPENCODE_DEFAULT_TIMEOUT}"

    local output
    output=$(timeout "$timeout" opencode run "$prompt" --format json 2>&1)
    local exit_code=$?

    if [ $exit_code -ne 0 ]; then
        echo "$output"
        return $exit_code
    fi

    # Parse JSON output to extract content
    # Handle both streaming and non-streaming responses
    if echo "$output" | jq -e '.content' >/dev/null 2>&1; then
        echo "$output" | jq -r '.content'
    elif echo "$output" | jq -e '.response' >/dev/null 2>&1; then
        echo "$output" | jq -r '.response'
    elif echo "$output" | jq -e '.text' >/dev/null 2>&1; then
        echo "$output" | jq -r '.text'
    else
        # Fallback: return raw output if no known JSON structure
        echo "$output"
    fi
}

# Run OpenCode with vision (image analysis)
# Usage: run_opencode_vision "prompt" "image_path" [timeout_seconds]
# Returns: OpenCode's response (stdout), exit code from opencode CLI
# Note: Vision support requires MCP integration (stub implementation)
run_opencode_vision() {
    local prompt="$1"
    local image_path="$2"
    local timeout="${3:-$OPENCODE_DEFAULT_TIMEOUT}"

    if [ ! -f "$image_path" ]; then
        echo "Error: Image not found: $image_path" >&2
        return 1
    fi

    # TODO: Implement via MCP integration when available
    echo "Error: Vision not yet supported by opencode backend (requires MCP integration)" >&2
    return 1
}

# Check if OpenCode CLI is installed and available
# Usage: check_opencode
# Returns: 0 if installed, 1 if not
check_opencode() {
    if ! command -v opencode >/dev/null 2>&1; then
        echo "Error: opencode CLI not found. Install with: go install github.com/opencode-ai/opencode@latest" >&2
        return 1
    fi
    return 0
}
