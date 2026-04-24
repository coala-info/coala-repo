cwlVersion: v1.2
class: CommandLineTool
baseCommand: iscc-sum
label: iscc-sum
doc: "Compute ISCC (International Standard Content Code) checksums for files.\n\n\
  Tool homepage: https://github.com/bio-codes/iscc-sum"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to compute checksums for
    inputBinding:
      position: 1
  - id: check
    type:
      - 'null'
      - boolean
    doc: Read checksums from FILEs and verify them
    inputBinding:
      position: 102
      prefix: --check
  - id: narrow
    type:
      - 'null'
      - boolean
    doc: 'Generate narrow format (2×64-bit ISO 24138:2024 conformant) (default: 2×128-bit
      extended format)'
    inputBinding:
      position: 102
      prefix: --narrow
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print OK for successfully verified files
    inputBinding:
      position: 102
      prefix: --quiet
  - id: similar
    type:
      - 'null'
      - boolean
    doc: Group files by similarity based on Data-Code hamming distance
    inputBinding:
      position: 102
      prefix: --similar
  - id: status
    type:
      - 'null'
      - boolean
    doc: Don't output anything, status code shows success
    inputBinding:
      position: 102
      prefix: --status
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Exit non-zero for improperly formatted checksum lines
    inputBinding:
      position: 102
      prefix: --strict
  - id: tag
    type:
      - 'null'
      - boolean
    doc: Create a BSD-style checksum output
    inputBinding:
      position: 102
      prefix: --tag
  - id: threshold
    type:
      - 'null'
      - int
    doc: Maximum hamming distance for similarity matching
    inputBinding:
      position: 102
      prefix: --threshold
  - id: tree
    type:
      - 'null'
      - boolean
    doc: Process directory as a single unit with combined checksum
    inputBinding:
      position: 102
      prefix: --tree
  - id: units
    type:
      - 'null'
      - boolean
    doc: 'Include individual Data-Code and Instance-Code units in output (verification
      mode: ignored)'
    inputBinding:
      position: 102
      prefix: --units
  - id: warn
    type:
      - 'null'
      - boolean
    doc: Warn about improperly formatted checksum lines
    inputBinding:
      position: 102
      prefix: --warn
  - id: zero
    type:
      - 'null'
      - boolean
    doc: End each output line with NUL, not newline
    inputBinding:
      position: 102
      prefix: --zero
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write checksums to FILE instead of stdout (ensures UTF-8, LF encoding)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iscc-sum:0.1.0--py314hc1c3326_0
