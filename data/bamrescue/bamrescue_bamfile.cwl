cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bamrescue
  - check
label: bamrescue_bamfile
doc: "Check a BAM file for corruption or rescue data from a corrupted BAM file.\n\n
  Tool homepage: https://github.com/Arkanosis/bamrescue"
inputs:
  - id: bamfile
    type: File
    doc: Input BAM file to check or rescue
    inputBinding:
      position: 1
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress output messages
    inputBinding:
      position: 102
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamrescue:0.3.0--h4349ce8_0
stdout: bamrescue_bamfile.out
