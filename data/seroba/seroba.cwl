cwlVersion: v1.2
class: CommandLineTool
baseCommand: seroba
label: seroba
doc: "Seroba is a tool for serotyping Streptococcus pneumoniae from sequence data.
  (Note: The provided text is a container build error log and does not contain usage
  information or argument definitions.)\n\nTool homepage: https://github.com/sanger-pathogens/seroba"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seroba:1.0.2--pyhdfd78af_1
stdout: seroba.out
