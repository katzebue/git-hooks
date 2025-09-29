#!/usr/bin/env bats

setup() {
  HOOK="../.githooks/commit-msg"
}

# helper: write commit msg to temp file and run hook
run_hook_with_msg() {
  echo "$1" > tmp_msg.txt
  run "$HOOK" tmp_msg.txt
  echo "🔹 Commit: $1" >&2
  echo "🔹 Exit code: $status" >&2
  echo "🔹 Hook path: $HOOK" >&2
  echo "🔹 Output:" >&2
  echo "$output" >&2
  rm tmp_msg.txt
}

@test "valid commit: feat" {
  run_hook_with_msg "WEB-123 feat: add login button"
  [ "$status" -eq 0 ]
}

@test "valid commit: type with scope" {
  run_hook_with_msg "WEB-123 feat(auth): add login button"
  [ "$status" -eq 0 ]
}

@test "valid commit: breaking change" {
  run_hook_with_msg "WEB-123 refactor!: change API"
  [ "$status" -eq 0 ]
}

@test "valid commit: draft" {
  run_hook_with_msg "draft: WEB-123 fix: temporary patch"
  [ "$status" -eq 0 ]
}

@test "valid commit: fixup" {
  run_hook_with_msg "Fixup! WEB-123 fix: temporary patch"
  [ "$status" -eq 0 ]
}

@test "valid commit: multiple tickets" {
  run_hook_with_msg "WEB-123 WEB-124 refactor: change API"
  [ "$status" -eq 0 ]
}

@test "valid commit: merge branch" {
  run_hook_with_msg "Merge branch 'dev' into 'feature/WEB-123-new-feature'"
  [ "$status" -eq 0 ]
}

@test "invalid commit: missing ticket" {
  run_hook_with_msg "feat: add login button"
  [ "$status" -ne 0 ]
}

@test "invalid commit: lowercase ticket" {
  run_hook_with_msg "web-123 feat: add login button"
  [ "$status" -ne 0 ]
}

@test "invalid commit: missing type" {
  run_hook_with_msg "WEB-123 add login button"
  [ "$status" -ne 0 ]
}
