cwlVersion: v1.2
class: CommandLineTool
baseCommand: pygvcf2coverage
label: pygvcf2coverage
doc: "Convert gVCF files to coverage BEDGraph files.\n\nTool homepage: https://github.com/varda/varda2_preprocessing"
inputs:
  - id: gvcf_file
    type: File
    doc: Input gVCF file.
    inputBinding:
      position: 1
  - id: interval
    type:
      - 'null'
      - type: array
        items: string
    doc: Intervals to process (e.g., chr1:1000-2000). Can be specified multiple 
      times.
    inputBinding:
      position: 102
      prefix: --interval
  - id: interval_file
    type:
      - 'null'
      - File
    doc: File containing intervals to process.
    inputBinding:
      position: 102
      prefix: --interval-file
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Maximum depth to consider a site covered. If not set, all depths are 
      considered.
    inputBinding:
      position: 102
      prefix: --max-depth
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality to consider a base covered. Defaults to 0.
    default: 0
    inputBinding:
      position: 102
      prefix: --min-base-quality
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum depth to consider a site covered. Defaults to 1.
    default: 1
    inputBinding:
      position: 102
      prefix: --min-depth
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality to consider a base covered. Defaults to 0.
    default: 0
    inputBinding:
      position: 102
      prefix: --min-mapping-quality
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: Path to the reference genome FASTA file. Required if the gVCF does not 
      contain sequence dictionary.
    inputBinding:
      position: 102
      prefix: --reference-genome
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. Defaults to 1.
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_coverage
    type:
      - 'null'
      - File
    doc: Output coverage BEDGraph file. Defaults to stdout.
    outputBinding:
      glob: $(inputs.output_coverage)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygvcf2coverage:0.2--py_0
