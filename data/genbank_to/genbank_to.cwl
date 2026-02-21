cwlVersion: v1.2
class: CommandLineTool
baseCommand: genbank_to
label: genbank_to
doc: "A tool for GenBank data conversion. (Note: The provided text is a container
  runtime error log and does not contain usage instructions or argument definitions.)\n
  \nTool homepage: https://github.com/linsalrob/genbank_to"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genbank:0.121--py313h366bbf7_1
stdout: genbank_to.out
