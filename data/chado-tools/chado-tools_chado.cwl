cwlVersion: v1.2
class: CommandLineTool
baseCommand: chado
label: chado-tools_chado
doc: "Chado-tools command-line utility. (Note: The provided input text appears to
  be a container runtime error log rather than help text, so no arguments could be
  extracted.)\n\nTool homepage: https://github.com/sanger-pathogens/chado-tools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chado-tools:0.2.15--py_0
stdout: chado-tools_chado.out
