cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- PrintVariantsSpark
label: gatk_PrintVariantsSpark
doc: |-
  Prints out variants from the input VCF file.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: output
  type: string
  doc: Uri for the output file (a local file path).
  inputBinding:
    position: 1
    prefix: --output
- id: variant
  type: File
  doc: A VCF file containing variants
  inputBinding:
    position: 1
    prefix: --variant
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
    required: false
- id: exclude_intervals
  type:
  - 'null'
  - type: array
    items:
    - string
    - File
    inputBinding:
      prefix: --exclude-intervals
  doc: One or more genomic intervals to exclude from processing
  inputBinding:
    position: 1
- id: input
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --input
  doc: BAM/SAM/CRAM file containing reads
  inputBinding:
    position: 1
- id: intervals
  type:
  - 'null'
  - type: array
    items:
    - string
    - File
    inputBinding:
      prefix: --intervals
  doc: One or more genomic intervals over which to operate
  inputBinding:
    position: 1
- id: reference
  type:
  - 'null'
  - File
  doc: Reference sequence
  inputBinding:
    position: 1
    prefix: --reference
  secondaryFiles:
  - .fai
  - ^.dict
- id: splitting_index_granularity
  type:
  - 'null'
  - long
  doc: Granularity to use when writing a splitting index, one entry will be put into
    the index every n reads where n is this granularity value. Smaller granularity
    results in a larger index with more available split points.
  inputBinding:
    position: 1
    prefix: --splitting-index-granularity
- id: variantshardsize
  type:
  - 'null'
  - int
  doc: Maximum size of each variant shard, in bases.
  inputBinding:
    position: 1
    prefix: --variantShardSize
outputs:
- id: output_file
  type: File
  doc: Uri for the output file (a local file path).
  outputBinding:
    glob: $(inputs.output)
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
    required: false
requirements:
- class: InlineJavascriptRequirement
- class: EnvVarRequirement
  envDef:
  - envName: SPARK_LOCAL_IP
    envValue: 127.0.0.1
  - envName: SPARK_LOCAL_HOSTNAME
    envValue: localhost
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
