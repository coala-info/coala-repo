cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nomadic
  - configure
label: nomadic_configure
doc: "Configure different nomadics functionality. This mostly sets standard\n  options
  in '.config.yaml' that can be overwritten from the command line.\n\nTool homepage:
  https://jasonahendry.github.io/nomadic/"
inputs:
  - id: command
    type: string
    doc: The command to configure
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nomadic:0.7.2--pyhdfd78af_0
stdout: nomadic_configure.out
