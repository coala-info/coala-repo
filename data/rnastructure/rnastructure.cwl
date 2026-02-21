cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnastructure
label: rnastructure
doc: "RNAstructure is a software package for RNA secondary structure prediction and
  analysis. (Note: The provided text is a container build error log and does not contain
  help documentation or argument definitions).\n\nTool homepage: http://rna.urmc.rochester.edu/RNAstructure.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnastructure:6.5--hde5307d_0
stdout: rnastructure.out
