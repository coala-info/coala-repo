cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - BastyGenerateFasta
label: biopet_tool_BastyGenerateFasta
doc: "Generate variant and consensus FASTA sequences from a VCF and/or BAM file.\n\nTool homepage:\
  \ https://github.com/biopet/biopet"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_vcf
    type:
      - 'null'
      - File
    doc: vcf file, needed for outputVariants and outputConsensusVariants
    secondaryFiles:
      - pattern: .tbi
        required: false
    inputBinding:
      position: 101
      prefix: --inputVcf
  - id: bam_file
    type:
      - 'null'
      - File
    doc: bam file, needed for outputConsensus and outputConsensusVariants
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 101
      prefix: --bamFile
  - id: output_variants
    type:
      - 'null'
      - string
    doc: fasta with only variants from vcf file
    inputBinding:
      position: 101
      prefix: --outputVariants
  - id: output_consensus
    type:
      - 'null'
      - string
    doc: Consensus fasta from bam, always reference bases else 'N'
    inputBinding:
      position: 101
      prefix: --outputConsensus
  - id: output_consensus_variants
    type:
      - 'null'
      - string
    doc: Consensus fasta from bam with variants from vcf file, always reference bases else
      'N'
    inputBinding:
      position: 101
      prefix: --outputConsensusVariants
  - id: snps_only
    type:
      - 'null'
      - boolean
    doc: Only use snps from vcf file
    inputBinding:
      position: 101
      prefix: --snpsOnly
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Sample name in vcf file
    inputBinding:
      position: 101
      prefix: --sampleName
  - id: output_name
    type: string
    doc: Output name in fasta file header
    inputBinding:
      position: 101
      prefix: --outputName
  - id: min_ad
    type:
      - 'null'
      - int
    doc: 'min AD value in vcf file for sample. Defaults to: 8'
    inputBinding:
      position: 101
      prefix: --minAD
  - id: min_depth
    type:
      - 'null'
      - int
    doc: 'min depth in bam file. Defaults to: 8'
    inputBinding:
      position: 101
      prefix: --minDepth
  - id: reference
    type:
      - 'null'
      - File
    doc: Indexed reference fasta file
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: false
    inputBinding:
      position: 101
      prefix: --reference
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Level of log information printed. Possible levels: ''debug'', ''info'', ''warn'',
      ''error'''
    inputBinding:
      position: 101
      prefix: --log_level
outputs:
  - id: variants_fasta
    type:
      - 'null'
      - File
    doc: Fasta with only variants
    outputBinding:
      glob: '$(inputs.output_variants ? inputs.output_variants : [])'
  - id: consensus_fasta
    type:
      - 'null'
      - File
    doc: Consensus fasta from bam
    outputBinding:
      glob: '$(inputs.output_consensus ? inputs.output_consensus : [])'
  - id: consensus_variants_fasta
    type:
      - 'null'
      - File
    doc: Consensus fasta with variants
    outputBinding:
      glob: '$(inputs.output_consensus_variants ? inputs.output_consensus_variants : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
