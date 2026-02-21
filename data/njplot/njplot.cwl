cwlVersion: v1.2
class: CommandLineTool
baseCommand: njplot
label: njplot
doc: 'A phylogenetic tree drawing program. (Note: The provided text contains container
  runtime error messages rather than tool help documentation, so no arguments could
  be extracted.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/njplot:v2.4-8-deb_cv1
stdout: njplot.out
