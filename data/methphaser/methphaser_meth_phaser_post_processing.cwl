cwlVersion: v1.2
class: CommandLineTool
baseCommand: meth_phaser_post_processing
label: methphaser_meth_phaser_post_processing
doc: "methphaser: use the block relationships from meth_phaser_parallel to write a re-phased VCF file and methylation-tagged BAM files.\n\nTool homepage: https://github.com/treangenlab/methphaser"
inputs:
  - id: input_bam_file
    type: File
    doc: input SNP-phased bam file
    secondaryFiles:
      - .bai
    inputBinding:
      position: 101
      prefix: --input_bam_file
  - id: meth_phasing_input_folder
    type: Directory
    doc: meth phasing input folder (the output folder of meth_phaser_parallel)
    inputBinding:
      position: 101
      prefix: --meth_phasing_input_folder
  - id: vcf_called
    type: File
    doc: SNP-phased VCF file
    secondaryFiles:
      - .tbi
    inputBinding:
      position: 101
      prefix: --vcf_called
  - id: threads
    type:
      - 'null'
      - int
    doc: threads, default 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: vcf_truth
    type:
      - 'null'
      - File
    doc: truth VCF provided by GIAB
    inputBinding:
      position: 101
      prefix: --vcf_truth
  - id: high_success_rate_param
    type:
      - 'null'
      - boolean
    doc: Enable high success rate parameter
    inputBinding:
      position: 101
      prefix: --high_success_rate_param
  - id: minimum_coverage
    type:
      - 'null'
      - int
    doc: "Minimum read number to assign blocks' relationship. default: 0."
    inputBinding:
      position: 101
      prefix: --minimum_coverage
  - id: voting_difference
    type:
      - 'null'
      - float
    doc: "minimum voting difference for relationship assignment, default=0.5"
    inputBinding:
      position: 101
      prefix: --voting_difference
  - id: output_vcf
    type: string
    doc: output VCF file location
    inputBinding:
      position: 102
      prefix: --output_vcf
  - id: output_bam
    type: string
    doc: output BAM file prefix (without .bam suffix); one file per chromosome named <prefix>.<chrom>.methtagged.bam
    inputBinding:
      position: 102
      prefix: --output_bam
outputs:
  - id: output_vcf_file
    type: File
    doc: output VCF file location
    outputBinding:
      glob: $(inputs.output_vcf)
  - id: output_bam_files
    type:
      type: array
      items: File
    doc: output BAM files, one per chromosome
    outputBinding:
      glob: $(inputs.output_bam).*.methtagged.bam
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methphaser:0.0.3--hdfd78af_0
