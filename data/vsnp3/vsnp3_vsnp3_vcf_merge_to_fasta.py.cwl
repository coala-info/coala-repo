cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_vcf_merge_to_fasta.py
label: vsnp3_vsnp3_vcf_merge_to_fasta.py
doc: "Merge VCF SNPs into the FASTA reference sequence the VCF was made from.\n\nTool homepage:\
  \ https://github.com/USDA-VS/vsnp3"
inputs:
  - id: vcf
    type: File
    doc: 'Required: VCF file will be merged into FASTA file it was made from'
    inputBinding:
      position: 101
      prefix: -v
  - id: fasta
    type: File
    doc: 'Required: FASTA used to build the VCF file'
    inputBinding:
      position: 101
      prefix: -f
  - id: qual_threshold
    type:
      - 'null'
      - int
    doc: 'Optional: Minimum QUAL threshold for using a SNP (default: 300)'
    inputBinding:
      position: 101
      prefix: -x
  - id: mq_threshold
    type:
      - 'null'
      - int
    doc: 'Optional: Minimum MQ threshold for using a SNP (default: 56)'
    inputBinding:
      position: 101
      prefix: -y
  - id: ac_threshold
    type:
      - 'null'
      - int
    doc: 'Optional: Minimum AC threshold for using a SNP (default: 1)'
    inputBinding:
      position: 101
      prefix: -z
  - id: indels
    type:
      - 'null'
      - boolean
    doc: 'Optional: Include indels'
    inputBinding:
      position: 101
      prefix: -i
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: merged_fasta
    type: File
    doc: FASTA with the VCF SNPs applied
    outputBinding:
      glob: '*_vcf_merged_*.fasta'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
stdout: vsnp3_vsnp3_vcf_merge_to_fasta.py.stdout.txt
