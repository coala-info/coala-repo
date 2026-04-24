cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_mnv
label: get_mnv
doc: "Identifies multiple SNVs within the same codon, reclassifies them as MNVs, and
  accurately computes resulting amino acid changes from genomic reads\n\nTool homepage:
  https://github.com/PathoGenOmics-Lab/get_mnv"
inputs:
  - id: bam_file
    type:
      - 'null'
      - File
    doc: BAM file with aligned reads (optional)
    inputBinding:
      position: 101
      prefix: --bam
  - id: fasta_file
    type: File
    doc: FASTA file with reference sequence
    inputBinding:
      position: 101
      prefix: --fasta
  - id: genes_file
    type: File
    doc: File with gene information
    inputBinding:
      position: 101
      prefix: --genes
  - id: quality
    type:
      - 'null'
      - int
    doc: 'Minimum Phred quality score (default: 20)'
    inputBinding:
      position: 101
      prefix: --quality
  - id: vcf_file
    type: File
    doc: VCF file with SNPs
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/get_mnv:1.0.0--ha7a4ace_1
stdout: get_mnv.out
