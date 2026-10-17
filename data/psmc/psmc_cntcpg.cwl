cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cntcpg
label: psmc_cntcpg
doc: "Count CpG and non-CpG sites for the CpG-aware mode of psmc (-c); prints 5 numbers: #CpG #CpG-ts #nonCpG #nonCpG-ts+tv #tv\n\nTool homepage: https://github.com/lh3/psmc"
inputs:
  - id: input_fasta
    type: File
    doc: "Input FASTA file"
    inputBinding:
      position: 100
  - id: binary
    type:
      - 'null'
      - boolean
    doc: "Binary output"
    inputBinding:
      position: 1
      prefix: "-b"
  - id: step
    type:
      - 'null'
      - int
    doc: "Step (bin) size (default: 100)"
    inputBinding:
      position: 2
      prefix: "-s"
  - id: n_ratio
    type:
      - 'null'
      - float
    doc: "N ratio (default: 0.9)"
    inputBinding:
      position: 3
      prefix: "-n"
outputs:
  - id: counts
    type: stdout
    doc: "Binary CpG count file for psmc -c"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psmc:0.6.5--h5ca1c30_4
stdout: cpg_counts.bin
