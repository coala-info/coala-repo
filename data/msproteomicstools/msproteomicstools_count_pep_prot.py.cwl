cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - count_pep_prot.py
label: msproteomicstools_count_pep_prot.py
doc: "Count precursors, peptides and proteins (single and multiple hits) in a tab-delimited result table with columns Sequence and ProteinName.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: input_tsv
    type: File
    doc: "Tab-delimited table with columns Sequence and ProteinName"
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
stdout: msproteomicstools_count_pep_prot.py.out
