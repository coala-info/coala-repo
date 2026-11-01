cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- ScatterIntervalsByNs
label: gatk_ScatterIntervalsByNs
doc: |-
  Writes an interval list created by splitting a reference at Ns.A Program for breaking up a reference into intervals of alternating regions of N and ACGT bases. Used for creating a broken-up interval list that can be used for scattering a variant-calling pipeline in a way that will not cause problems at the edges of the intervals.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: output
  type: string
  doc: Output file for interval list.
  inputBinding:
    position: 1
    prefix: --OUTPUT
- id: reference
  type: File
  doc: 'Reference sequence to use. Note: this tool requires that the reference fasta
    has both an associated index and a dictionary.'
  inputBinding:
    position: 1
    prefix: --REFERENCE
  secondaryFiles:
  - .fai
  - ^.dict
- id: max_to_merge
  type:
  - 'null'
  - int
  doc: Maximal number of contiguous N bases to tolerate, thereby continuing the current
    ACGT interval.
  inputBinding:
    position: 1
    prefix: --MAX_TO_MERGE
- id: output_type
  type:
  - 'null'
  - string
  doc: 'Type of intervals to output. Possible values: N, ACGT, BOTH.'
  inputBinding:
    position: 1
    prefix: --OUTPUT_TYPE
outputs:
- id: output_file
  type: File
  doc: Output file for interval list.
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
