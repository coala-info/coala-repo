cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scssim
  - simuvars
label: scssim_simuvars
doc: "Simulate genomic variations and SNPs on a reference sequence to generate new
  sequences.\n\nTool homepage: https://github.com/qasimyu/scssim"
inputs:
  - id: ref
    type: File
    doc: reference file (.fasta)
    inputBinding:
      position: 101
      prefix: --ref
  - id: snp
    type:
      - 'null'
      - File
    doc: SNP file containing the SNPs to be simulated
    inputBinding:
      position: 101
      prefix: --snp
  - id: var
    type:
      - 'null'
      - File
    doc: variation file containing the genomic variations to be simulated
    inputBinding:
      position: 101
      prefix: --var
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file (.fasta) to save generated sequences
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scssim:1.0--h9948957_5
