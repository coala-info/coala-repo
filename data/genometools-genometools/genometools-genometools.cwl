cwlVersion: v1.2
class: CommandLineTool
baseCommand: gt
label: genometools-genometools
doc: "The GenomeTools genome analysis system is a free collection of bioinformatics
  tools (genome informatics software) for gene prediction and genome annotation.\n
  \nTool homepage: https://genometools.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometools-genometools:1.6.6--py311h5faa0f1_0
stdout: genometools-genometools.out
