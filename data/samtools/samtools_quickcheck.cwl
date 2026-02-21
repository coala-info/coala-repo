cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - quickcheck
label: samtools_quickcheck
doc: "Quickly check if SAM/BAM/CRAM files are intact and have proper headers.\n\n\
  Tool homepage: https://github.com/samtools/samtools"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input SAM, BAM, or CRAM files to check
    inputBinding:
      position: 1
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: suppress warning messages
    inputBinding:
      position: 102
      prefix: -q
  - id: unmapped_input
    type:
      - 'null'
      - boolean
    doc: unmapped input (do not require targets in header)
    inputBinding:
      position: 102
      prefix: -u
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: verbose output (repeat for more verbosity)
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
stdout: samtools_quickcheck.out
