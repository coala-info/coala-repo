cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metagem
  - memote
label: metagem_memote
doc: "Metabolic model testing (memote) within the metagem pipeline. Note: The provided
  text contains error logs and does not list command-line arguments.\n\nTool homepage:
  https://github.com/franciscozorrilla/metaGEM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metagem:1.0.5--hdfd78af_0
stdout: metagem_memote.out
