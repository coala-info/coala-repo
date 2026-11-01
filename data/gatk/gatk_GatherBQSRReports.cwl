cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- GatherBQSRReports
label: gatk_GatherBQSRReports
doc: |-
  Gathers scattered BQSR recalibration reports into a single file

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: input
  type:
    type: array
    items: File
    inputBinding:
      prefix: --input
  doc: List of scattered BQSR report files This argument must be specified at least
    once.
- id: output
  type: string
  doc: File to output the gathered file to
  inputBinding:
    prefix: --output
outputs:
- id: output_output
  type: File
  doc: File to output the gathered file to
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
