cwlVersion: v1.2
class: CommandLineTool
baseCommand: mobidic-mpa
label: mobidic-mpa
doc: "Mobidic-MPA (Note: The provided text is a system error log and does not contain
  help information or argument definitions).\n\nTool homepage: https://neuro-2.iurc.montp.inserm.fr/mpaweb/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mobidic-mpa:1.3.0--pyh5e36f6f_0
stdout: mobidic-mpa.out
