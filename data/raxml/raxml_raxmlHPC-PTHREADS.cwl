cwlVersion: v1.2
class: CommandLineTool
baseCommand: raxmlHPC-PTHREADS
label: raxml_raxmlHPC-PTHREADS
doc: "RAxML (Randomized Axelerated Maximum Likelihood) is a program for sequential
  and parallel Maximum Likelihood based inference of large phylogenetic trees.\n\n
  Tool homepage: http://sco.h-its.org/exelixis/web/software/raxml/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/raxml:8.2.13--h7b50bb2_3
stdout: raxml_raxmlHPC-PTHREADS.out
