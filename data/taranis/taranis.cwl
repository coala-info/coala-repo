cwlVersion: v1.2
class: CommandLineTool
baseCommand: taranis
label: taranis
doc: "Taranis is a tool for genomic surveillance and sequence analysis (Note: The
  provided text is a container build log and does not contain specific CLI help documentation).\n
  \nTool homepage: https://github.com/BU-ISCIII/taranis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taranis:2.0.1--hdfd78af_0
stdout: taranis.out
