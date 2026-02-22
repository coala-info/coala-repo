cwlVersion: v1.2
class: CommandLineTool
baseCommand: coptr
label: coptr
doc: "CoPTR (Contig Ploidy and Taxon Retrieval) is a tool for estimating the relative
  ploidy of contigs in metagenomic assemblies.\n\nTool homepage: https://github.com/tyjo/coptr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coptr:1.1.4--pyhdfd78af_3
stdout: coptr.out
