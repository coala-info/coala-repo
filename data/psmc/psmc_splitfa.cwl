cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - splitfa
label: psmc_splitfa
doc: "Split sequences of a PSMCFA file into trunks for bootstrapping with psmc -b\n\nTool homepage: https://github.com/lh3/psmc"
inputs:
  - id: input_fasta
    type: File
    doc: "PSMCFA/FASTA file to split"
    inputBinding:
      position: 1
  - id: trunk_size
    type:
      - 'null'
      - int
    doc: "Trunk size in bp (default: 500000)"
    inputBinding:
      position: 2
outputs:
  - id: split_fasta
    type: stdout
    doc: "Split PSMCFA sequences"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psmc:0.6.5--h5ca1c30_4
stdout: split.psmcfa
