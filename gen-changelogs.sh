#!/bin/bash

usage="Android Changelogs Generator v1.0.0

A script to generate changelogs or release notes between two git tags. You can
save or copy and paste it into a new GitHub release, and/or CHANGELOGS.md.

usage: $(basename "$0") [-h] [-d -a] <tag1> <tag2>

where:
    -h  show this help text
    -d  git directory of project (default: .)
    -a  path to apk file (default: ./mobile/build/outputs/apk/mobile-release.apk)"

while getopts ":h:d:a:" opt; do
	case $opt in
		h) echo "$usage"
       exit
       ;;
    d) PROJECT_DIR=$OPTARG >&2
       ;;
    a) APK_DIR=$OPTARG >&2
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done

# Shift out all the already processed options
shift "$((OPTIND - 1))"

# Assign defaults if not set
if [ -z "$PROJECT_DIR" ]; then PROJECT_DIR="."; fi
if [ -z "$APK_DIR" ]; then APK_DIR="$PROJECT_DIR/mobile/build/outputs/apk/mobile-release.apk"; fi

if [ $# -eq 2 ]; then # tag 1, tag2
  TAG_1="$1"
  TAG_2="$2"
else
  echo "Invalid arguments, please specify 2 tags.\n"
  echo "$usage"
  exit 1
fi

echo **Released**: `date '+%B %d, %Y'`
echo
echo **Checksum**
echo
echo '```'
echo $ shasum -a256 mobile-release.apk
echo `shasum -a256 "$APK_DIR"` | awk '{ print $1 " mobile-release.apk"}'
echo '```'
echo
echo "**Changes** [[diff](https://github.com/500px/AndroidV4/compare/$TAG_1...$TAG_2)]"
echo
git -C $PROJECT_DIR log --merges --grep="^Merge pull" --format="%s %b" $TAG_1..$TAG_2 | \
	awk '{ printf "%s", "- ["$4"] _"; for(i=7; i<=NF; ++i) printf "%s ", $i; printf "\n" }' | \
  sed s'/.$/_/'
