cwlVersion: v1.2
class: CommandLineTool
baseCommand: metagem_fastp
label: metagem_fastp
doc: "FASTQ preprocessing tool (Note: The provided text contains system error messages
  regarding container image building and does not include usage instructions or argument
  definitions).\n\nTool homepage: https://github.com/franciscozorrilla/metaGEM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metagem:1.0.5--hdfd78af_0
stdout: metagem_fastp.out
