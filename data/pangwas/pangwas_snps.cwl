cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangwas
  - snps
label: pangwas_snps
doc: "Extract SNPs from a pangenome alignment.\n\nTakes as input the pangenome alignment
  fasta, bed, and consensus file from align.\nOutputs an Rtab file of SNPs.\n\nTool
  homepage: https://github.com/phac-nml/pangwas"
inputs:
  - id: alignment
    type: File
    doc: Fasta sequences alignment.
    inputBinding:
      position: 101
      prefix: --alignment
  - id: bed
    type: File
    doc: Bed file of coordinates.
    inputBinding:
      position: 101
      prefix: --bed
  - id: consensus
    type: File
    doc: Fasta consensus/representative sequence.
    inputBinding:
      position: 101
      prefix: --consensus
  - id: core
    type:
      - 'null'
      - float
    doc: Core threshold for calling core SNPs.
    default: 0.95
    inputBinding:
      position: 101
      prefix: --core
  - id: indel_window
    type:
      - 'null'
      - int
    doc: Exclude SNPs that are within this proximity to indels.
    default: 0
    inputBinding:
      position: 101
      prefix: --indel-window
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    default: .
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: snp_window
    type:
      - 'null'
      - int
    doc: Exclude SNPs that are within this proximity to another SNP.
    default: 0
    inputBinding:
      position: 101
      prefix: --snp-window
  - id: structural
    type:
      - 'null'
      - File
    doc: Rtab from the structural subcommand, used to avoid treating terminal 
      ends as indels.
    inputBinding:
      position: 101
      prefix: --structural
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
stdout: pangwas_snps.out
