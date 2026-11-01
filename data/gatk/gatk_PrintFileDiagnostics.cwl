cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- PrintFileDiagnostics
label: gatk_PrintFileDiagnostics
doc: |-
  Print diagnostic information about a genomics file to stdout

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: input
  type: File
  doc: Input path for diagnostics
  inputBinding:
    prefix: --input
- id: output
  type: string
  doc: Outut file for diagnostics (must be a local file)
  inputBinding:
    prefix: --output
- id: count_limit
  type:
  - 'null'
  - long
  doc: 'Limit on how much output to emit (.cram only) Default value: 1000.'
  inputBinding:
    prefix: --count-limit
outputs:
- id: output_output
  type: File
  doc: Outut file for diagnostics (must be a local file)
  outputBinding:
    glob: $(inputs.output)
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
