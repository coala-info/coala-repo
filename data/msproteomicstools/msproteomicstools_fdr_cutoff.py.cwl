cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fdr_cutoff.py
label: msproteomicstools_fdr_cutoff.py
doc: "Sort a tab-delimited table by a score column, estimate the FDR from decoy rows and write the rows up to the FDR cutoff.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: input_tsv
    type: File
    doc: "Input tab-delimited table"
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: "Output table"
    inputBinding:
      position: 2
  - id: sort_by
    type: string
    doc: "Name of the column used for sorting"
    inputBinding:
      position: 3
  - id: decoy_name
    type: string
    doc: "Text that marks decoy rows (searched in all cells)"
    inputBinding:
      position: 4
  - id: fdr_cutoff
    type: float
    doc: "FDR cutoff"
    inputBinding:
      position: 5
  - id: reverse
    type: {type: enum, symbols: ['TRUE', 'FALSE']}
    doc: "Sort in descending order (TRUE) or ascending order (FALSE)"
    inputBinding:
      position: 6
  - id: use_fdr_score
    type: {type: enum, symbols: ['TRUE', 'FALSE']}
    doc: "Use the sort column directly as FDR (TRUE) or estimate it from decoys (FALSE)"
    inputBinding:
      position: 7
outputs:
  - id: output
    type: File
    doc: "Filtered table with an added FDREstimate column"
    outputBinding:
      glob: "$(inputs.output_path)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
stdout: msproteomicstools_fdr_cutoff.py.out
