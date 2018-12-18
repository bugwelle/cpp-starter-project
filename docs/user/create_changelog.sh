#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

cd "$( cd "$(dirname "$0")"; pwd -P )"

NOTES=source/release-notes.rst

cat ./release_notes_header.rst > $NOTES

cat ../../CHANGELOG.md >> $NOTES

echo "Markdown --> reStructuredText"

# We assume that the longest title is ~30 characters and we don't
# have headers nested deeper than level 4 (<h4>)
sed -i.bak '/####/ a ------------------------------------' $NOTES
sed -i.bak 's/#### //' $NOTES

sed -i.bak '/###/ a ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^' $NOTES
sed -i.bak 's/### //' $NOTES

sed -i.bak '/##/ a ************************************' $NOTES
sed -i.bak 's/## //' $NOTES

sed -i.bak 's/`/``/g' $NOTES
sed -i.bak '/# Changelog/d' $NOTES

# Create issue/pr URLs
sed -i.bak -r 's/#([0-9]+)/`#\1 <https:\/\/github.com\/bugwelle\/cpp-starter-project\/issues\/\1>`_/g' $NOTES

rm -f $NOTES.bak

echo "Done."
