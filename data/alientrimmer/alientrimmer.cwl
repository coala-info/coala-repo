cwlVersion: v1.2
class: CommandLineTool
baseCommand: alientrimmer
label: alientrimmer
doc: "AlienTrimmer is a tool for trimming biological sequences (Note: The provided
  help text contains only container build error logs and no usage information).\n\n
  Tool homepage: https://gitlab.pasteur.fr/GIPhy/AlienTrimmer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alientrimmer:2.1--hdfd78af_0
stdout: alientrimmer.out
