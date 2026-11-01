cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- GatherVcfsCloud
label: gatk_GatherVcfsCloud
doc: |-
  Gathers multiple VCF files from a scatter operation into a single VCF file. Input files must be supplied in genomic order and must not have events at overlapping positions.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: input
  type:
    type: array
    items: File
    inputBinding:
      prefix: --input
  doc: Input VCF file(s).
  inputBinding:
    position: 1
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
    required: false
- id: output
  type: string
  doc: Output VCF file.
  inputBinding:
    position: 1
    prefix: --output
- id: gather_type
  type:
  - 'null'
  - string
  doc: 'Choose which method should be used to gather: BLOCK gathering is faster but
    onlyworks when you have both bgzipped inputs and outputs, while CONVENTIONAL gather
    is much slower but should work on all vcf files. AUTOMATIC chooses BLOCK if possible
    and CONVENTIONAL otherwise. Possible values: BLOCK, CONVENTIONAL, AUTOMATIC.'
  inputBinding:
    position: 1
    prefix: --gather-type
- id: progress_logger_frequency
  type:
  - 'null'
  - int
  doc: The frequency with which the progress is logged to output (i.e. every N records)
  inputBinding:
    position: 1
    prefix: --progress-logger-frequency
- id: disable_contig_ordering_check
  type:
  - 'null'
  - boolean
  doc: 'Don''t check relative ordering of contigs when doing a conventional gather
    Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --disable-contig-ordering-check
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: ignore_safety_checks
  type:
  - 'null'
  - boolean
  doc: 'Disable sanity checks to improve performance, may result in silently creating
    corrupted outputs data Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --ignore-safety-checks
    valueFrom: '$(self ? ''true'' : ''false'')'
outputs:
- id: output_file
  type: File
  doc: Output VCF file.
  outputBinding:
    glob: $(inputs.output)
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
    required: false
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
