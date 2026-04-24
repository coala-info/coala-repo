cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yasma
  - coverage
label: yasma_coverage
doc: "Produces bigwig coverage files\n\nTool homepage: https://github.com/NateyJay/YASMA"
inputs:
  - id: alignment_file
    type:
      - 'null'
      - File
    doc: Alignment file input (bam or cram).
    inputBinding:
      position: 101
      prefix: --alignment_file
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Forces remaking bigwigs even if all expected\n                         \
      \        are found"
    inputBinding:
      position: 101
      prefix: --force
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: "Directory name for annotation output.\n                                \
      \ Defaults to the current directory, with this\n                           \
      \      directory name as the project name."
    inputBinding:
      position: 101
      prefix: --output_directory
  - id: peaks
    type:
      - 'null'
      - type: array
        items: string
    doc: "Entry of size limits for a peak. Encoded as\n                          \
      \       two integers separated by a dash (`-`), for\n                      \
      \           example: 21-22 is an appropriate entry for\n                   \
      \              plant miRNAS. Also accepts single-size peaks\n              \
      \                   without dash. Multiple peaks may be\n                  \
      \               identified, separated with spaces or by\n                  \
      \               calling the option again."
    inputBinding:
      position: 101
      prefix: --peaks
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yasma:1.1.0--pyh7e72e81_0
stdout: yasma_coverage.out
