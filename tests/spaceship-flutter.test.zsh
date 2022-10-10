#!/usr/bin/env zsh

# Required for shunit2 to run correctly
CWD="${${(%):-%x}:A:h}"
setopt shwordsplit
SHUNIT_PARENT=$0

# Use system Spaceship or fallback to Spaceship Docker on CI
typeset -g SPACESHIP_ROOT="${SPACESHIP_ROOT:=/spaceship}"

# Mocked tool CLI
mocked_version="v3.3.3"
mocked_channel="stable"
flutter() {
  printf '%s\n' \
    'Flutter 3.3.3 • channel stable • https://github.com/flutter/flutter.git' \
    'Framework • revision 18a827f393 (11 days ago) • 2022-09-28 10:03:14 -0700' \
    'Engine • revision 5c984c26eb' \
    'Tools • Dart 2.18.2 • DevTools 2.15.0'
}

# ------------------------------------------------------------------------------
# SHUNIT2 HOOKS
# ------------------------------------------------------------------------------

setUp() {
  # Enter the test directory
  cd $SHUNIT_TMPDIR
}

oneTimeSetUp() {
  export TERM="xterm-256color"

  source "$SPACESHIP_ROOT/spaceship.zsh"
  source "$(dirname $CWD)/spaceship-flutter.plugin.zsh"

  SPACESHIP_PROMPT_ASYNC=false
  SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=true
  SPACESHIP_PROMPT_ADD_NEWLINE=false
  SPACESHIP_PROMPT_ORDER=(flutter)

  echo "Spaceship version: $(spaceship --version)"
}

oneTimeTearDown() {
  unset SPACESHIP_PROMPT_ASYNC
  unset SPACESHIP_PROMPT_FIRST_PREFIX_SHOW
  unset SPACESHIP_PROMPT_ADD_NEWLINE
  unset SPACESHIP_PROMPT_ORDER
}

# ------------------------------------------------------------------------------
# TEST CASES
# ------------------------------------------------------------------------------

test_flutter_no_files() {
  local expected=""
  local actual="$(spaceship::testkit::render_prompt)"
  assertEquals "should not render without files" "$expected" "$nactual"
}

test_flutter_upsearch_is_not_flutter_project() {
  local expected=""

  local FILES=( pubspec.yaml pubspec.yml )
  for file in $FILES; do
    printf '%s\n' \
        'dependencies:' \
        '  path: ^1.6.0' \
        '  http: ^0.12.0+2' \
      >! $file
    local actual="$(spaceship::testkit::render_prompt)"
    assertEquals "should not render when file $file has no flutter dependency" "$expected" "$actual"
    rm $file
  done
}

test_flutter_upsearch_is_flutter_project() {
  local prefix="%{%B%}$SPACESHIP_FLUTTER_PREFIX%{%b%}"
  local channel="$SPACESHIP_FLUTTER_CHANNEL_SYMBOL$SPACESHIP_FLUTTER_CHANNEL_PREFIX${mocked_channel}$SPACESHIP_FLUTTER_CHANNEL_SUFFIX"
  local content="%{%B%F{$SPACESHIP_FLUTTER_COLOR}%}$SPACESHIP_FLUTTER_SYMBOL$mocked_version$channel%{%b%f%}"
  local suffix="%{%B%}$SPACESHIP_FLUTTER_SUFFIX%{%b%}"
  local expected="$prefix$content$suffix"

  local FILES=( pubspec.yaml pubspec.yml )
  for file in $FILES; do
    printf '%s\n' \
      'dependencies:' \
      '  flutter:' \
      '    sdk: flutter' \
      >! $file
    local actual="$(spaceship::testkit::render_prompt)"
    assertEquals "should render when file $file has flutter dependency" "$expected" "$actual"
    rm $file
  done
}

test_flutter_show_no_channel() {
  local SPACESHIP_FLUTTER_CHANNEL_SHOW="false"
  local prefix="%{%B%}$SPACESHIP_FLUTTER_PREFIX%{%b%}"
  local channel=""
  local content="%{%B%F{$SPACESHIP_FLUTTER_COLOR}%}$SPACESHIP_FLUTTER_SYMBOL$mocked_version$channel%{%b%f%}"
  local suffix="%{%B%}$SPACESHIP_FLUTTER_SUFFIX%{%b%}"
  local expected="$prefix$content$suffix"

  local FILES=( pubspec.yaml )
  for file in $FILES; do
    printf '%s\n' \
      'dependencies:' \
      '  flutter:' \
      '    sdk: flutter' \
      >! $file
    local actual="$(spaceship::testkit::render_prompt)"
    assertEquals "should render when file $file has flutter dependency" "$expected" "$actual"
    rm $file
  done
}

test_flutter_with_beta_channel() {
  local flutter() { # mocked  flutter command
    printf '%s\n' \
      'Flutter 3.4.0-34.1.pre • channel beta • https://github.com/flutter/flutter.git' \
      'Framework • revision 71520442d4 (4 days ago) • 2022-10-05 16:38:28 -0500' \
      'Engine • revision db0cbb2145' \
      'Tools • Dart 2.19.0 (build 2.19.0-255.2.beta) • DevTools 2.18.0'
  }
  local mocked_version="v3.4.0-34.1.pre"
  local mocked_channel="beta"
  local prefix="%{%B%}$SPACESHIP_FLUTTER_PREFIX%{%b%}"
  local channel="$SPACESHIP_FLUTTER_CHANNEL_SYMBOL$SPACESHIP_FLUTTER_CHANNEL_PREFIX${mocked_channel}$SPACESHIP_FLUTTER_CHANNEL_SUFFIX"
  local content="%{%B%F{$SPACESHIP_FLUTTER_COLOR}%}$SPACESHIP_FLUTTER_SYMBOL$mocked_version$channel%{%b%f%}"
  local suffix="%{%B%}$SPACESHIP_FLUTTER_SUFFIX%{%b%}"
  local expected="$prefix$content$suffix"

  local FILES=( pubspec.yaml )
  for file in $FILES; do
    printf '%s\n' \
      'dependencies:' \
      '  flutter:' \
      '    sdk: flutter' \
      >! $file
    local actual="$(spaceship::testkit::render_prompt)"
    assertEquals "should render with beta channel" "$expected" "$actual"
    rm $file
  done
}

test_flutter_has_updates() {
  local flutter() { # mocked  flutter command
    printf '%s\n' \
      'Downloading Darwin x64 Dart SDK from Flutter engine 5c984c26ebc4a0a8897305d3c6bef70ced91090d...' \
      '  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current' \
      '                                 Dload  Upload   Total   Spent    Left  Speed' \
      '100  202M  100  202M    0     0  10.1M      0  0:00:19  0:00:19 --:--:-- 10.9M' \
      'Building flutter tool...' \
      '' \
      '┌─────────────────────────────────────────────────────────┐' \
      '│ A new version of Flutter is available!                  │' \
      '│                                                         │' \
      '│ To update to the latest version, run "flutter upgrade". │' \
      '└─────────────────────────────────────────────────────────┘' \
      'Flutter 3.3.3 • channel stable • https://github.com/flutter/flutter.git' \
      'Framework • revision 18a827f393 (11 days ago) • 2022-09-28 10:03:14 -0700' \
      'Engine • revision 5c984c26eb' \
      'Tools • Dart 2.18.2 • DevTools 2.15.0' 
  }
  local mocked_version="v3.3.3"
  local mocked_channel="stable"
  local prefix="%{%B%}$SPACESHIP_FLUTTER_PREFIX%{%b%}"
  local channel="$SPACESHIP_FLUTTER_CHANNEL_SYMBOL$SPACESHIP_FLUTTER_CHANNEL_PREFIX${mocked_channel}$SPACESHIP_FLUTTER_CHANNEL_SUFFIX"
  local content="%{%B%F{$SPACESHIP_FLUTTER_COLOR}%}$SPACESHIP_FLUTTER_SYMBOL$mocked_version$channel%{%b%f%}"
  local suffix="%{%B%}$SPACESHIP_FLUTTER_SUFFIX%{%b%}"
  local expected="$prefix$content$suffix"

  local FILES=( pubspec.yaml )
  for file in $FILES; do
    printf '%s\n' \
      'dependencies:' \
      '  flutter:' \
      '    sdk: flutter' \
      >! $file
    local actual="$(spaceship::testkit::render_prompt)"
    assertEquals "should render when flutter has updates" "$expected" "$actual"
    rm $file
  done
}

# ------------------------------------------------------------------------------
# SHUNIT2
# Run tests with shunit2
# ------------------------------------------------------------------------------

source "$SPACESHIP_ROOT/tests/shunit2/shunit2"
