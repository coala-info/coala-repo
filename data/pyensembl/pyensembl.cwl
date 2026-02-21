cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyensembl
label: pyensembl
doc: "Python interface to Ensembl reference genome metadata (Note: The provided text
  contains container build logs rather than tool help text, so no arguments could
  be extracted).\n\nTool homepage: https://github.com/openvax/pyensembl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyensembl:2.3.13--pyh7cba7a3_0
stdout: pyensembl.out
