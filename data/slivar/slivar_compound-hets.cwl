cwlVersion: v1.2
class: CommandLineTool
baseCommand: slivar compound-hets
label: slivar_compound-hets
doc: "find compound-hets in trios from pre-filtered variants\n\nTool homepage: https://github.com/brentp/slivar"
inputs:
  - id: allow_non_trios
    type:
      - 'null'
      - boolean
    doc: allow samples with one or both parent unspecified. if this mode is 
      used, any pair of heterozygotes co-occuring in the same gene, sample will 
      be reported for samples without both parents that don't have kids. if a 
      single parent is present some additional filtering is done.
    inputBinding:
      position: 101
      prefix: --allow-non-trios
  - id: ped
    type: File
    doc: required ped file describing the trios in the VCF
    inputBinding:
      position: 101
      prefix: --ped
  - id: sample_field
    type:
      - 'null'
      - type: array
        items: string
    doc: optional INFO field(s) that contains list of samples (kids) that have 
      passed previous filters. can be specified multiple times. this is needed 
      for multi-family VCFs
    inputBinding:
      position: 101
      prefix: --sample-field
  - id: skip
    type:
      - 'null'
      - string
    doc: skip variants with these impacts (comma-separated)
      splice_region,intergenic_region,intron,non_coding_transcript,non_coding,upstream_gene,downstream_gene,non_coding_transcript_exon,NMD_transcript,5_prime_UTR,3_prime_UTR
    inputBinding:
      position: 101
      prefix: --skip
  - id: vcf
    type:
      - 'null'
      - File
    doc: input VCF
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: out_vcf
    type:
      - 'null'
      - File
    doc: path to output VCF/BCF
    outputBinding:
      glob: $(inputs.out_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slivar:0.3.3--h5f107b1_0
