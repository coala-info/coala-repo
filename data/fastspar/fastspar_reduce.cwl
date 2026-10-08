cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastspar_reduce
label: fastspar_reduce
doc: "Filter FastSpar correlation and p-value tables by thresholds and write sparse matrices\n\nTool
  homepage: https://github.com/scwatts/fastspar"
inputs:
  - id: correlation_table
    type: File
    doc: Correlation input table
    inputBinding:
      position: 1
      prefix: --correlation_table
  - id: pvalue_table
    type: File
    doc: P-value input table
    inputBinding:
      position: 2
      prefix: --pvalue_table
  - id: output_prefix
    type: string
    doc: Output prefix
    inputBinding:
      position: 3
      prefix: --output_prefix
  - id: correlation
    type: ['null', float]
    doc: Absolute (sign is ignored) correlation threshold (default 0.1)
    inputBinding:
      position: 4
      prefix: --correlation
  - id: pvalue
    type: ['null', float]
    doc: P-value threshold (default 0.05)
    inputBinding:
      position: 5
      prefix: --pvalue
outputs:
  - id: filtered_tables
    type: 'File[]'
    doc: Filtered correlation and p-value tables
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastspar:1.0.0--h1b620e3_6
