cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - extract_matrix.py
label: msproteomicstools_extract_matrix.py
doc: "Generate a matrix with flexible columns from a featurealigner.tsv or featurealigner_requant.tsv file.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: infile
    type: File
    doc: "Feature aligner file"
    inputBinding:
      prefix: --in
  - id: output_path
    type: string
    doc: "Output matrix"
    inputBinding:
      prefix: --out
  - id: columns
    type: ['null', 'string[]']
    doc: "Which columns are written (default: Intensity RT m_score)"
    inputBinding:
      prefix: --columns
outputs:
  - id: matrix
    type: File
    doc: "Output matrix"
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
stdout: msproteomicstools_extract_matrix.py.out
