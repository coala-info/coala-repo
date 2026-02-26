cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nextflow
  - fs
label: nextflow_fs
doc: "File system operations\n\nTool homepage: https://github.com/nextflow-io/nextflow"
inputs:
  - id: command
    type: string
    doc: The filesystem command to execute
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the filesystem command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
stdout: nextflow_fs.out
