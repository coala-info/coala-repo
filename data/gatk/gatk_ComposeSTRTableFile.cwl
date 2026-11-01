cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- ComposeSTRTableFile
label: gatk_ComposeSTRTableFile
doc: |-
  Composes a genome-wide STR location table used for DragSTR model auto-calibration

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: output
  type: string
  doc: name of the zip file where the sites sampled will be stored
  inputBinding:
    position: 1
    prefix: --output
- id: reference
  type: File
  doc: Reference sequence file
  inputBinding:
    position: 1
    prefix: --reference
  secondaryFiles:
  - .fai
  - ^.dict
- id: decimation
  type:
  - 'null'
  - string
  doc: decimation per period and repeat. It can be "DEFAULT" to use the default values
    (DEFAULT), "NONE" to deactivate decimation (potentially resulting in a very large
    output file) or indicate the path to a file that contains the decimation matrix.
  inputBinding:
    position: 1
    prefix: --decimation
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
- id: max_period
  type:
  - 'null'
  - int
  doc: maximum STR period sampled
  inputBinding:
    position: 1
    prefix: --max-period
- id: max_repeats
  type:
  - 'null'
  - int
  doc: maximum STR repeat sampled
  inputBinding:
    position: 1
    prefix: --max-repeats
- id: sequence_dictionary
  type:
  - 'null'
  - File
  doc: Use the given sequence dictionary as the master/canonical sequence dictionary.
    Must be a .dict file.
  inputBinding:
    position: 1
    prefix: --sequence-dictionary
outputs:
- id: output_file
  type: File
  doc: name of the zip file where the sites sampled will be stored
  outputBinding:
    glob: $(inputs.output)
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
