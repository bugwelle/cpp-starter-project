#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

###############################################################################
# Run shellcheck on all bash script (for usage in CIs)
# This is a convenience script that excludes some warnings.
###############################################################################

cd "$(dirname "$0")/.."
source tools/utils.sh

print_important "Run shellcheck on all source files"

find . ! -path "./build/*" -type f -name "*.sh" \
	-exec shellcheck -x \
	-e SC1090,SC2143,SC1091,SC2010,SC2016 \
	{} \+

# SC1090: Can't follow non-constant source. Use a directive to specify location
# SC2143: Use grep -q instead of comparing output with
# SC1091: Not following
# SC2010: Don't use ls | grep. Use a glob or a for loop with a condition to allow non-alphanumeric filenames.
# SC2016: Expressions don't expand in single quotes, use double quotes for that.

print_success "No issues found! Great! :-)"
