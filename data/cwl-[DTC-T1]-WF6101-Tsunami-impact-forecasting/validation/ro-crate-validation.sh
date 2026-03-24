#!/bin/sh

FAIL=0
ALL_ERRORS=""
TMPFILE="/tmp/rocrate_dirs.$$"

# Write the list of directories (each on its own line) to a temporary file
find . -type f -name "ro-crate-metadata.json" \
	-not -path "*/templates/*" \
	-not -regex ".*\/.*\.generated\/.*" \
	-exec dirname {} \; | sort -u > "$TMPFILE"

while IFS= read -r crate_dir; do
    echo "Found ro-crate-metadata.json in: $crate_dir"
    echo "Validating RO-Crate in directory: $crate_dir"
    echo "----------------------------------"

    # For each profile, capture the entire validator output in a variable
    for profile in ro-crate-1.1 workflow-ro-crate-1.0; do
        echo "Validating with profile: $profile"

        # Capture output (both stdout & stderr) into 'output' variable
        output="$(rocrate-validator -y validate "$crate_dir" --no-fail-fast -p "$profile" -v 2>&1)"
        exit_code=$?

        if [ "$exit_code" -ne 0 ]; then
            echo "Validation FAILED for $crate_dir with profile $profile"
            FAIL=1

            # Extract lines that contain the errors
            error_lines="$(echo "$output" | awk '/\[FAILED\] RO-Crate is not a valid/ {found=1} found')"
            ALL_ERRORS="$ALL_ERRORS
-----------------------------------------------
RO-Crate directory: $crate_dir
Profile: $profile
$error_lines
-----------------------------------------------
"
        else
            echo "Validation SUCCEEDED for $crate_dir with profile $profile"
        fi
        echo "----------------------------------"
    done
done < "$TMPFILE"

rm -f "$TMPFILE"

# At the very end, if anything failed, print the error summary and exit
if [ "$FAIL" -ne 0 ]; then
    echo "Some RO-Crates failed validation. Summary of errors:"
    echo "$ALL_ERRORS"
    exit 1
else
    echo "All RO-Crates validated successfully!"
fi

