# iscc-sum CWL Generation Report

## iscc-sum

### Tool Description
Compute ISCC (International Standard Content Code) checksums for files.

### Metadata
- **Docker Image**: quay.io/biocontainers/iscc-sum:0.1.0--py314hc1c3326_0
- **Homepage**: https://github.com/bio-codes/iscc-sum
- **Package**: https://anaconda.org/channels/bioconda/packages/iscc-sum/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/iscc-sum/overview
- **Total Downloads**: 551
- **Last updated**: 2025-11-05
- **GitHub**: https://github.com/bio-codes/iscc-sum
- **Stars**: N/A
### Original Help Text
```text
Usage: iscc-sum [OPTIONS] [FILES]...

  Compute ISCC (International Standard Content Code) checksums for files.

  Each checksum consists of a 2-byte self-describing header followed by a
  composite of Data-Code and Instance-Code (BLAKE3) components. All files are
  processed as binary data.

  Unlike traditional checksum tools that only verify exact matches, iscc-sum
  enables similarity detection between files through the Data-Code component.
  Files with similar content will have similar Data-Codes, allowing similarity
  matching based on hamming distance.

  Examples:
    # Generate checksums
    iscc-sum document.pdf
    iscc-sum *.txt

    # Verify checksums   iscc-sum -c checksums.txt

    # Find similar files   iscc-sum --similar *.jpg

Options:
  --version                  Show the version and exit.
  -c, --check                Read checksums from FILEs and verify them
  --tag                      Create a BSD-style checksum output
  -o, --output PATH          Write checksums to FILE instead of stdout
                             (ensures UTF-8, LF encoding)
  -z, --zero                 End each output line with NUL, not newline
  -q, --quiet                Don't print OK for successfully verified files
  --status                   Don't output anything, status code shows success
  -w, --warn                 Warn about improperly formatted checksum lines
  --strict                   Exit non-zero for improperly formatted checksum
                             lines
  --narrow                   Generate narrow format (2×64-bit ISO 24138:2024
                             conformant) (default: 2×128-bit extended format)
  --units                    Include individual Data-Code and Instance-Code
                             units in output (verification mode: ignored)
  --similar                  Group files by similarity based on Data-Code
                             hamming distance
  --threshold INTEGER RANGE  Maximum hamming distance for similarity matching
                             [default: 12; x>=0]
  -t, --tree                 Process directory as a single unit with combined
                             checksum
  -h, --help                 Show this message and exit.

  Exit status: 0 if OK, 1 if checksum verification fails, 2 if trouble.
```

