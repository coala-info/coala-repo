cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyloaln_connect.pl
label: phyloaln_connect.pl
doc: "A tool for connecting phylogenetic alignments (Note: The provided help text
  contains only container build error logs and no usage information).\n\nTool homepage:
  https://github.com/huangyh45/PhyloAln"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
stdout: phyloaln_connect.pl.out
