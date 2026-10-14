cwlVersion: v1.2
class: CommandLineTool
baseCommand: HCCeval
label: phiercc_HCCeval
doc: "evalHCC evaluates a HierCC scheme using varied statistic summaries.\n\nTool
  homepage: https://github.com/zheminzhou/pHierCC"
inputs:
  - id: profile
    type: File
    doc: Name of a profile file consisting of a table of columns of the ST
      numbers and the allelic numbers, separated by tabs. Can be GZIPped.
    inputBinding:
      position: 1
      prefix: --profile
  - id: cluster
    type: File
    doc: Name of the pHierCC text output. Can be GZIPped.
    inputBinding:
      position: 2
      prefix: --cluster
  - id: output_path
    type: string
    doc: Prefix for the two output files.
    inputBinding:
      position: 3
      prefix: --output
  - id: stepwise
    type:
      - 'null'
      - int
    doc: Evaluate every <stepwise> levels (Default 10).
    inputBinding:
      position: 4
      prefix: --stepwise
  - id: n_proc
    type:
      - 'null'
      - int
    doc: Number of processes (CPUs) to use (Default 4).
    inputBinding:
      position: 5
      prefix: --n_proc
outputs:
  - id: output
    type:
      type: array
      items: File
    doc: The two evaluation output files
    outputBinding:
      glob: $(inputs.output_path)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phiercc:1.24--pyhdfd78af_0
