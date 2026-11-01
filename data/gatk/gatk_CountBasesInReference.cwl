cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- CountBasesInReference
label: gatk_CountBasesInReference
doc: |-
  Count the number of times each individual base occurs in a reference file and print to standard output (and optionally to a file).

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: reference
  type: File
  doc: Reference sequence file
  inputBinding:
    position: 1
    prefix: --reference
  secondaryFiles:
  - .fai
  - ^.dict
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
- id: output
  type:
  - 'null'
  - string
  default: base_counts.txt
  doc: Optional output file
  inputBinding:
    position: 1
    prefix: --output
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
  doc: Optional output file
  outputBinding:
    glob: $(inputs.output)
- id: stdout_output
  type: stdout
  doc: Standard output of the tool
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
