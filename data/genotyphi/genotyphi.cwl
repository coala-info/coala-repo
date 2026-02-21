cwlVersion: v1.2
class: CommandLineTool
baseCommand: genotyphi
label: genotyphi
doc: "A tool for genotyping Salmonella Typhi data.\n\nTool homepage: https://github.com/katholt/genotyphi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genotyphi:2.0--hdfd78af_1
stdout: genotyphi.out
