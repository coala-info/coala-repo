cwlVersion: v1.2
class: CommandLineTool
baseCommand: jaeger-bio_jaeger
label: jaeger-bio_jaeger
doc: "Deep-learning based bacteriophage discovery\n\nTool homepage: https://github.com/Yasas1994/Jaeger"
inputs:
  - id: command
    type: string
    doc: 'Command to execute: {test,run,tune}'
    inputBinding:
      position: 1
  - id: command_description
    type:
      - 'null'
      - string
    doc: 'Description of the command: test, run, or tune'
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jaeger-bio:1.1.30--pyhdfd78af_0
stdout: jaeger-bio_jaeger.out
