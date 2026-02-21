cwlVersion: v1.2
class: CommandLineTool
baseCommand: genera_Erassignment
label: genera_Erassignment
doc: "A tool for taxonomic assignment (Note: The provided text contains container
  runtime error logs rather than command-line help documentation).\n\nTool homepage:
  https://github.com/josuebarrera/GenEra"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genera:1.4.2--py38hdfd78af_0
stdout: genera_Erassignment.out
