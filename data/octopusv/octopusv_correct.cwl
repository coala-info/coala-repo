cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - octopusv
  - correct
label: octopusv_correct
doc: "Correct SV events with optional quality filtering.\n\nTool homepage: https://github.com/ylab-hi/octopusV"
inputs:
  - id: input_vcf
    type:
      - 'null'
      - File
    doc: Input VCF file to correct.
    inputBinding:
      position: 1
  - id: exclude_nocall
    type:
      - 'null'
      - boolean
    doc: Exclude variants with ./. genotype
    inputBinding:
      position: 102
      prefix: --exclude-nocall
  - id: filter_pass
    type:
      - 'null'
      - boolean
    doc: Only keep variants with FILTER=PASS
    inputBinding:
      position: 102
      prefix: --filter-pass
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input VCF file to correct.
    inputBinding:
      position: 102
      prefix: --input-file
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Maximum total depth to keep variants
    inputBinding:
      position: 102
      prefix: --max-depth
  - id: max_qual
    type:
      - 'null'
      - float
    doc: Maximum QUAL score to keep variants
    inputBinding:
      position: 102
      prefix: --max-qual
  - id: max_support
    type:
      - 'null'
      - int
    doc: Maximum supporting reads to keep variants
    inputBinding:
      position: 102
      prefix: --max-support
  - id: max_svlen
    type:
      - 'null'
      - int
    doc: Maximum SV length to keep variants
    inputBinding:
      position: 102
      prefix: --max-svlen
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum total depth to keep variants
    inputBinding:
      position: 102
      prefix: --min-depth
  - id: min_gq
    type:
      - 'null'
      - int
    doc: Minimum genotype quality to keep variants
    inputBinding:
      position: 102
      prefix: --min-gq
  - id: min_qual
    type:
      - 'null'
      - float
    doc: Minimum QUAL score to keep variants
    inputBinding:
      position: 102
      prefix: --min-qual
  - id: min_support
    type:
      - 'null'
      - int
    doc: Minimum supporting reads to keep variants
    inputBinding:
      position: 102
      prefix: --min-support
  - id: min_svlen
    type:
      - 'null'
      - int
    doc: Minimum SV length to keep variants
    inputBinding:
      position: 102
      prefix: --min-svlen
  - id: pos_tolerance
    type:
      - 'null'
      - int
    doc: Position tolerance for identifying mate BND events, default=3, 
      recommend not to set larger than 5
    default: 3
    inputBinding:
      position: 102
      prefix: --pos-tolerance
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file path.
    outputBinding:
      glob: '*.out'
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file path.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/octopusv:0.3.0--pyhdfd78af_0
