cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bamrescue
  - rescue
label: bamrescue_output
doc: "Rescue data from a corrupted BAM file\n\nTool homepage: https://github.com/Arkanosis/bamrescue"
inputs:
  - id: bam_file
    type: File
    doc: Input BAM file to be rescued
    inputBinding:
      position: 1
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output
    type: File
    doc: Output file for the rescued data
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamrescue:0.3.0--h4349ce8_0
