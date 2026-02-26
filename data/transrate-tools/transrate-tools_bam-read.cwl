cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam-read
label: transrate-tools_bam-read
doc: "Reads BAM file and outputs a CSV file.\n\nTool homepage: https://github.com/blahah/transrate-tools"
inputs:
  - id: bam_file
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: nullprior
    type:
      - 'null'
      - float
    doc: Null prior value (optional)
    inputBinding:
      position: 2
outputs:
  - id: output_csv
    type: File
    doc: Output CSV file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/transrate-tools:v1.0.0-2-deb_cv1
