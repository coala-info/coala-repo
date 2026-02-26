cwlVersion: v1.2
class: CommandLineTool
baseCommand: matlock
label: matlock_The
doc: "matlock <command> [options]\n\nTool homepage: https://github.com/phasegenomics/matlock"
inputs:
  - id: command
    type: string
    doc: 'The command to run. Available commands: bam2, bamfilt, cutsites'
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the specified command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/matlock:20181227--h665f8ca_8
stdout: matlock_The.out
