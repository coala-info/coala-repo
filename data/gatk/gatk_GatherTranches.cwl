cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- GatherTranches
label: gatk_GatherTranches
doc: |-
  Gathers scattered VQSLOD tranches into a single file. For use when running VariantRecalibrator on scattered input using the -scatterTranches mode.

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: input
  type:
    type: array
    items: File
    inputBinding:
      prefix: --input
  doc: List of scattered tranches files This argument must be specified at least once.
- id: mode
  type: string
  doc: 'Recalibration mode to employ Possible values: {SNP, INDEL, BOTH}'
  inputBinding:
    prefix: --mode
- id: output
  type: string
  doc: File to output the gathered tranches file to
  inputBinding:
    prefix: --output
- id: truth_sensitivity_tranche
  type:
  - 'null'
  - type: array
    items: double
    inputBinding:
      prefix: --truth-sensitivity-tranche
  doc: 'The levels of truth sensitivity at which to slice the data. (in percent, that
    is 1.0 for 1 percent) This argument may be specified 0 or more times. Default
    value: [100.0, 99.9, 99.0, 90.0].'
outputs:
- id: output_output
  type: File
  doc: File to output the gathered tranches file to
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
