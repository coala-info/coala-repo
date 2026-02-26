cwlVersion: v1.2
class: CommandLineTool
baseCommand: somalier_extract
label: somalier_extract
doc: "extract genotype-like information for a single-sample at selected sites\n\n\
  Tool homepage: https://github.com/brentp/somalier"
inputs:
  - id: sample_file
    type: File
    doc: single-sample CRAM/BAM/GVCF file or multi/single-sample VCF from which 
      to extract
    inputBinding:
      position: 1
  - id: fasta
    type:
      - 'null'
      - File
    doc: path to reference fasta file
    inputBinding:
      position: 102
      prefix: --fasta
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: path to output directory
    default: .
    inputBinding:
      position: 102
      prefix: --out-dir
  - id: sample_prefix
    type:
      - 'null'
      - string
    doc: prefix for the sample name stored inside the digest
    inputBinding:
      position: 102
      prefix: --sample-prefix
  - id: sites
    type:
      - 'null'
      - File
    doc: sites vcf file of variants to extract
    inputBinding:
      position: 102
      prefix: --sites
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/somalier:0.3.1--hc78c8e0_0
stdout: somalier_extract.out
