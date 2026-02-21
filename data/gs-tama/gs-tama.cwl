cwlVersion: v1.2
class: CommandLineTool
baseCommand: gs-tama
label: gs-tama
doc: "Transcriptome Annotation by Modular Algorithms (Note: The provided text contains
  container runtime error messages rather than tool help documentation).\n\nTool homepage:
  https://github.com/sguizard/gs-tama"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama.out
