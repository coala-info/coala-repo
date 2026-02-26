cwlVersion: v1.2
class: CommandLineTool
baseCommand: tracecomp
label: phylobayes-mpi_tracecomp
doc: "measure the effective sizes and overlap between 95% CI of several independent
  chains\n\nTool homepage: https://github.com/bayesiancook/pbmpi"
inputs:
  - id: chain_names
    type:
      type: array
      items: string
    doc: Names of the chains to compare
    inputBinding:
      position: 1
  - id: burnin
    type:
      - 'null'
      - int
    doc: burnin period
    default: 20% of the chain
    inputBinding:
      position: 102
      prefix: -x
  - id: every
    type:
      - 'null'
      - int
    doc: sample every Nth state after burnin
    inputBinding:
      position: 102
      prefix: -x
  - id: until
    type:
      - 'null'
      - int
    doc: stop sampling at state N
    inputBinding:
      position: 102
      prefix: -x
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: detailed output into file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylobayes-mpi:1.9--h5c6ebe3_0
