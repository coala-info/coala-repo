cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tiddit
  - --sv
label: tiddit
doc: "TIDDIT identifies structural variants using discordant pairs and split reads,
  and characterizes genomic regions using coverage information.\n\nTool homepage:
  https://github.com/SciLifeLab/TIDDIT"
inputs:
  - id: bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 101
      prefix: --bam
  - id: bin_size
    type:
      - 'null'
      - int
    doc: Bin size for coverage calculation
    inputBinding:
      position: 101
      prefix: --bin
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    inputBinding:
      position: 101
      prefix: --quality
  - id: min_pairs
    type:
      - 'null'
      - int
    doc: Minimum number of discordant pairs to call a SV
    inputBinding:
      position: 101
      prefix: --pair
  - id: min_split_reads
    type:
      - 'null'
      - int
    doc: Minimum number of split reads to call a SV
    inputBinding:
      position: 101
      prefix: --split
  - id: reference
    type:
      - 'null'
      - File
    secondaryFiles:
      - .fai
    doc: Reference fasta file
    inputBinding:
      position: 101
      prefix: --ref
  - id: vcf_output
    type:
      - 'null'
      - boolean
    doc: Output results in VCF format
    inputBinding:
      position: 101
      prefix: --vcf
  - id: output_prefix_path
    type: string
    doc: Output or path parameter `output_prefix_path`
    inputBinding:
      position: 102
      prefix: --output-prefix
outputs:
  - id: output_prefix
    type: File
    doc: Prefix for output files
    outputBinding:
      glob: $(inputs.output_prefix_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tiddit:3.9.4--py311h93dcfea_0
