cwlVersion: v1.2
class: CommandLineTool
baseCommand: mantis
label: mantis_pfa
doc: "Mantis: Protein Function Annotation. (Note: The provided text is an error log
  and does not contain usage information or argument definitions.)\n\nTool homepage:
  https://github.com/PedroMTQ/Mantis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mantis:0.2--h4a1dfb3_4
stdout: mantis_pfa.out
