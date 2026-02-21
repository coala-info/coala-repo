cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bamrescue
  - check
label: bamrescue_check
doc: "Check a BAM file for corruption\n\nTool homepage: https://github.com/Arkanosis/bamrescue"
inputs:
  - id: bam_file
    type: File
    doc: Input BAM file to check
    inputBinding:
      position: 1
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress status messages
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
stdout: bamrescue_check.out
