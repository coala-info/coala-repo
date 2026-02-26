cwlVersion: v1.2
class: CommandLineTool
baseCommand: kaptive
label: kaptive_In
doc: "In silico serotyping\n\nTool homepage: https://kaptive.readthedocs.io/en/latest"
inputs:
  - id: command
    type: string
    doc: 'Command to run: assembly, extract, or convert'
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print debug messages to stderr
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kaptive:3.1.0--pyhdfd78af_0
stdout: kaptive_In.out
