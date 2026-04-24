cwlVersion: v1.2
class: CommandLineTool
baseCommand: svtyper-sso
label: svtyper-python3_svtyper-sso
doc: "Compute genotype of structural variants based on breakpoint depth on a SINGLE
  sample\n\nTool homepage: https://github.com/hall-lab/svtyper"
inputs:
  - id: bam_file
    type:
      type: array
      items: File
    doc: BAM or CRAM file(s), comma-separated if genotyping multiple samples
    inputBinding:
      position: 101
      prefix: --bam
  - id: batch_size
    type:
      - 'null'
      - int
    doc: number of breakpoints to batch for a parallel processing worker job
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: cores
    type:
      - 'null'
      - int
    doc: number of workers to use for parallel processing
    inputBinding:
      position: 101
      prefix: --cores
  - id: disc_weight
    type:
      - 'null'
      - float
    doc: weight for discordant paired-end reads
    inputBinding:
      position: 101
      prefix: --disc_weight
  - id: input_vcf
    type:
      - 'null'
      - File
    doc: VCF input
    inputBinding:
      position: 101
      prefix: --input_vcf
  - id: lib_info
    type:
      - 'null'
      - File
    doc: create/read JSON file of library information
    inputBinding:
      position: 101
      prefix: --lib_info
  - id: max_ci_dist
    type:
      - 'null'
      - int
    doc: maximum size of a confidence interval before 95% CI is used intead
    inputBinding:
      position: 101
      prefix: --max_ci_dist
  - id: max_reads
    type:
      - 'null'
      - int
    doc: maximum number of reads to assess at any variant (reduces processing 
      time in high-depth regions)
    inputBinding:
      position: 101
      prefix: --max_reads
  - id: min_aligned
    type:
      - 'null'
      - int
    doc: minimum number of aligned bases to consider read as evidence
    inputBinding:
      position: 101
      prefix: --min_aligned
  - id: ref_fasta
    type:
      - 'null'
      - File
    doc: Indexed reference FASTA file (recommended for reading CRAM files)
    inputBinding:
      position: 101
      prefix: --ref_fasta
  - id: sample_reads
    type:
      - 'null'
      - int
    doc: number of reads to sample from BAM file for building insert size 
      distribution
    inputBinding:
      position: 101
      prefix: -n
  - id: split_weight
    type:
      - 'null'
      - float
    doc: weight for split reads
    inputBinding:
      position: 101
      prefix: --split_weight
  - id: sum_quals
    type:
      - 'null'
      - boolean
    doc: 'add genotyping quality to existing QUAL (default: overwrite QUAL field)'
    inputBinding:
      position: 101
      prefix: --sum_quals
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: output VCF to write
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtyper-python3:0.7.1--pyhdfd78af_0
