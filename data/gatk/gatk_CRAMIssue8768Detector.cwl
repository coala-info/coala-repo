cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- CRAMIssue8768Detector
label: gatk_CRAMIssue8768Detector
doc: |-
  Analyze a CRAM file to check for base corruption caused by GATK issue 8768

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: input
  type: File
  doc: Input path of CRAM file to analyze
  inputBinding:
    prefix: --input
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: ^.bai
    required: false
  - pattern: .crai
    required: false
  - pattern: ^.crai
    required: false
- id: output
  type: string
  doc: Output diagnostics text file
  inputBinding:
    prefix: --output
- id: reference
  type: File
  doc: Reference for the CRAM file
  inputBinding:
    prefix: --reference
  secondaryFiles:
  - pattern: .fai
    required: true
  - pattern: ^.dict
    required: true
- id: echo_to_stdout
  type:
  - 'null'
  - boolean
  doc: 'Echo text output to stdout Default value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --echo-to-stdout
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: mismatch_rate_threshold
  type:
  - 'null'
  - double
  doc: 'Mismatch rate threshold above which we consider the file to be corrupt Default
    value: 0.05.'
  inputBinding:
    prefix: --mismatch-rate-threshold
- id: output_tsv
  type:
  - 'null'
  - string
  doc: Output diagnostics tsv file
  inputBinding:
    prefix: --output-tsv
- id: verbose
  type:
  - 'null'
  - boolean
  doc: 'Calculate and print the mismatch rate for all containers Default value: false.
    Possible values: {true, false}'
  inputBinding:
    prefix: --verbose
    valueFrom: '$(self ? ''true'' : ''false'')'
outputs:
- id: output_output
  type: File
  doc: Output diagnostics text file
  outputBinding:
    glob: $(inputs.output)
- id: output_output_tsv
  type:
  - 'null'
  - File
  doc: Output diagnostics tsv file
  outputBinding:
    glob: $(inputs.output_tsv)
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
