cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdp-alignment
label: rdp-alignment
doc: "Ribosomal Database Project (RDP) alignment tool. (Note: The provided text contains
  container execution logs and error messages rather than command-line help documentation,
  so no arguments could be extracted.)\n\nTool homepage: https://github.com/AlbertoMartinPerez/Sequence_Analyzer_automations"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-alignment:v1.2.0-5-deb_cv1
stdout: rdp-alignment.out
