cwlVersion: v1.2
class: CommandLineTool
baseCommand: bpcomp
label: phylobayes-mpi_bpcomp
doc: "compare bipartition frequencies between independent chains and build consensus
  based on merged lists of trees\n\nTool homepage: https://github.com/bayesiancook/pbmpi"
inputs:
  - id: chain_names
    type:
      type: array
      items: string
    doc: Chain names to compare
    inputBinding:
      position: 1
  - id: burnin
    type:
      - 'null'
      - int
    doc: default burnin = 1/10 of the chain
    default: 1/10 of the chain
    inputBinding:
      position: 102
      prefix: -x
  - id: cutoff
    type:
      - 'null'
      - float
    doc: only partitions with max prob > cutoff.
    default: 0.5
    inputBinding:
      position: 102
      prefix: -c
  - id: postscript_output
    type:
      - 'null'
      - boolean
    doc: postscript output (requires LateX)
    inputBinding:
      position: 102
      prefix: -ps
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: detailed output into file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylobayes-mpi:1.9--h5c6ebe3_0
