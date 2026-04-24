cwlVersion: v1.2
class: CommandLineTool
baseCommand: snp_parser
label: mgkit_snp_parser
doc: "DEPRECATED, use `pnps-gen vcf` SNPs analysis, requires a vcf file\n\nTool homepage:
  https://github.com/frubino/mgkit"
inputs:
  - id: bcftools_vcf
    type:
      - 'null'
      - boolean
    doc: bcftools call was used to produce the VCF file
    inputBinding:
      position: 101
      prefix: --bcftools-vcf
  - id: cite
    type:
      - 'null'
      - boolean
    doc: Show citation for the framework
    inputBinding:
      position: 101
      prefix: --cite
  - id: cov_suff
    type:
      - 'null'
      - string
    doc: Per sample coverage suffix in the GFF
    inputBinding:
      position: 101
      prefix: --cov-suff
  - id: gff_file
    type: File
    doc: GFF file with annotations
    inputBinding:
      position: 101
      prefix: --gff-file
  - id: manual
    type:
      - 'null'
      - boolean
    doc: Show the script manual
    inputBinding:
      position: 101
      prefix: --manual
  - id: min_freq
    type:
      - 'null'
      - float
    doc: Minimum allele frequency
    inputBinding:
      position: 101
      prefix: --min-freq
  - id: min_qual
    type:
      - 'null'
      - int
    doc: Minimum SNP quality (Phred score)
    inputBinding:
      position: 101
      prefix: --min-qual
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Minimum number of reads to accept the SNP
    inputBinding:
      position: 101
      prefix: --min-reads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: less verbose - only error and critical messages
    inputBinding:
      position: 101
      prefix: --quiet
  - id: reference
    type: File
    doc: Fasta file with the GFF Reference
    inputBinding:
      position: 101
      prefix: --reference
  - id: samples_id
    type: string
    doc: the ids of the samples used in the analysis
    inputBinding:
      position: 101
      prefix: --samples-id
  - id: vcf_file
    type: File
    doc: Merged VCF file
    inputBinding:
      position: 101
      prefix: --vcf-file
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: more verbose - includes debug messages
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Ouput file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
