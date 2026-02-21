cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyloaln_transseq.pl
label: phyloaln_transseq.pl
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a failed container build/fetch process.\n\nTool homepage:
  https://github.com/huangyh45/PhyloAln"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
stdout: phyloaln_transseq.pl.out
