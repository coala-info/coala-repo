cwlVersion: v1.2
class: CommandLineTool
baseCommand: metagem_megahit
label: metagem_megahit
doc: "Metagenomic assembly using MEGAHIT (Note: The provided text contains system
  error logs regarding container image acquisition and does not list command-line
  arguments).\n\nTool homepage: https://github.com/franciscozorrilla/metaGEM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metagem:1.0.5--hdfd78af_0
stdout: metagem_megahit.out
