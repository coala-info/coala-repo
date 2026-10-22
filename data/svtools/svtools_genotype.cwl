cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtools
  - genotype
label: svtools_genotype
doc: 'Genotype structural variants in a VCF file using the read evidence in a BAM
  or CRAM file.


  Tool homepage: https://github.com/hall-lab/svtools'
inputs:
  - id: input_vcf
    type:
      - 'null'
      - File
    doc: 'VCF input (default: stdin)'
    inputBinding:
      position: 101
      prefix: --input_vcf
  - id: output_vcf
    type:
      - 'null'
      - string
    doc: 'Output VCF to write (default: stdout)'
    inputBinding:
      position: 101
      prefix: --output_vcf
  - id: bam
    type: File
    doc: BAM or CRAM file
    secondaryFiles:
      - .bai
    inputBinding:
      position: 101
      prefix: --bam
  - id: ref_fasta
    type:
      - 'null'
      - File
    doc: Indexed reference FASTA file (recommended for reading CRAM files)
    secondaryFiles:
      - .fai
    inputBinding:
      position: 101
      prefix: --ref_fasta
  - id: lib_info
    type:
      - 'null'
      - string
    doc: Create/read JSON file of library information
    inputBinding:
      position: 101
      prefix: --lib_info
  - id: min_aligned
    type:
      - 'null'
      - int
    doc: Minimum number of aligned bases to consider read as evidence [20]
    inputBinding:
      position: 101
      prefix: --min_aligned
  - id: num_pairs
    type:
      - 'null'
      - int
    doc: Number of pairs to sample from BAM file for building insert size distribution
      [1000000]
    inputBinding:
      position: 101
      prefix: -n
  - id: sum_quals
    type:
      - 'null'
      - boolean
    doc: 'Add genotyping quality to existing QUAL (default: overwrite QUAL field)'
    inputBinding:
      position: 101
      prefix: --sum_quals
  - id: max_reads
    type:
      - 'null'
      - int
    doc: 'Maximum number of reads to assess at any variant (reduces processing time
      in high-depth regions, default: 10000)'
    inputBinding:
      position: 101
      prefix: --max_reads
  - id: max_ci_dist
    type:
      - 'null'
      - int
    doc: 'Maximum size of a confidence interval before 95% CI is used intead (default:
      1e10)'
    inputBinding:
      position: 101
      prefix: --max_ci_dist
  - id: split_weight
    type:
      - 'null'
      - double
    doc: Weight for split reads [1]
    inputBinding:
      position: 101
      prefix: --split_weight
  - id: disc_weight
    type:
      - 'null'
      - double
    doc: Weight for discordant paired-end reads [1]
    inputBinding:
      position: 101
      prefix: --disc_weight
  - id: write_alignment
    type:
      - 'null'
      - string
    doc: Write relevant reads to BAM file
    inputBinding:
      position: 101
      prefix: --write_alignment
outputs:
  - id: out_vcf
    type:
      - 'null'
      - File
    doc: Genotyped VCF
    outputBinding:
      glob: $(inputs.output_vcf)
  - id: out_lib_info
    type:
      - 'null'
      - File
    doc: Library information JSON
    outputBinding:
      glob: $(inputs.lib_info)
  - id: out_alignment
    type:
      - 'null'
      - File
    doc: Relevant reads
    outputBinding:
      glob: $(inputs.write_alignment)
  - id: stdout
    type: stdout
    doc: Output when --output_vcf is not given
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
stdout: svtools_genotype.out
