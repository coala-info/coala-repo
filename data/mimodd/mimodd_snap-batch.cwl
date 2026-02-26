cwlVersion: v1.2
class: CommandLineTool
baseCommand: snap-batch
label: mimodd_snap-batch
doc: "Runs multiple snap commands\n\nTool homepage: http://sourceforge.net/projects/mimodd"
inputs:
  - id: commands
    type:
      - 'null'
      - type: array
        items: string
    doc: one or more completely specified command line calls to the snap tool 
      (use "" to enclose individual lines)
    inputBinding:
      position: 101
      prefix: -s
  - id: input_file
    type:
      - 'null'
      - File
    doc: an input file of completely specified command line calls to the snap 
      tool
    inputBinding:
      position: 101
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimodd:0.1.9--py35_0
stdout: mimodd_snap-batch.out
