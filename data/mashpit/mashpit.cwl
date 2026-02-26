cwlVersion: v1.2
class: CommandLineTool
baseCommand: mashpit
label: mashpit
doc: "mashpit: error: argument -h/--help: ignored explicit argument 'elp'\n\nTool
  homepage: https://github.com/tongzhouxu/mashpit"
inputs:
  - id: command
    type: string
    doc: The command to run
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mashpit:0.9.10--pyhdfd78af_1
stdout: mashpit.out
