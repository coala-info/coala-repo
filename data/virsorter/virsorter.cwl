cwlVersion: v1.2
class: CommandLineTool
baseCommand: virsorter
label: virsorter
doc: "A tool for identifying viral sequences in genomic data (Note: The provided text
  contains system logs and error messages rather than help documentation, so no arguments
  could be extracted).\n\nTool homepage: https://github.com/simroux/VirSorter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virsorter:2.2.4--pyhdfd78af_2
stdout: virsorter.out
