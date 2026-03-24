#!/bin/sh

FAIL=0
TMPFILE="/tmp/cwl_files.$$"
find . -type f -name "*.cwl" \
  -not -path "*/templates/*" \
  -not -regex ".*\/.*\.generated\/.*" > "$TMPFILE"

while IFS= read -r cwl_file; do
    echo "Validating: ${cwl_file}"
    if ! cwltool --validate "${cwl_file}"; then
        echo "Validation failed for ${cwl_file}"
        FAIL=1
    else
        echo "Validation succeeded for ${cwl_file}"
    fi
    echo "----------------------------------"
done < "$TMPFILE"

rm -f "$TMPFILE"

if [ "$FAIL" -ne 0 ]; then
    echo "Some CWL files failed validation. Job failing."
    exit 1
else
    echo "All .cwl files validated successfully!"
fi
