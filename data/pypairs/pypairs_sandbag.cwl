cwlVersion: v1.2
class: CommandLineTool
baseCommand: sandbag
label: pypairs_sandbag
doc: "Sandbag identifies marker gene pairs for each cell cycle class from a 
  training data matrix and an annotation file.\n\nTool homepage: 
  https://github.com/rfechtner/pypairs"
inputs:
  - id: data
    type: File
    doc: Path to the data matrix where rows correspond to cells and columns to 
      genes.
    inputBinding:
      position: 1
      prefix: --data
  - id: sep
    type: ['null', string]
    doc: 'Seperator used for data (default: ",")'
    inputBinding:
      position: 2
      prefix: --sep
  - id: transpose
    type: ['null', boolean]
    doc: Set flag to transpose matrix
    inputBinding:
      position: 3
      prefix: --transpose
  - id: out
    type: ['null', string]
    doc: Store marker pairs to json
    inputBinding:
      position: 4
      prefix: --out
  - id: annotation
    type: File
    doc: 'Path to annotation csv. CSV containing at least two columns: Name and 
      Class'
    inputBinding:
      position: 5
      prefix: --annotation
  - id: ann_sep
    type: ['null', string]
    doc: 'Seperator used in annotation csv (default: ",")'
    inputBinding:
      position: 6
      prefix: --ann_sep
  - id: ann_idx_name
    type: ['null', int]
    doc: 'Index of name column in annotation csv (default: 0)'
    inputBinding:
      position: 7
      prefix: --ann_idx_name
  - id: ann_idx_class
    type: ['null', int]
    doc: 'Index of class column in annotation csv (default: 1)'
    inputBinding:
      position: 8
      prefix: --ann_idx_class
  - id: ann_no_header
    type: ['null', boolean]
    doc: Set when the annotation csv has no header line (default is a header 
      line, --ann_header)
    inputBinding:
      position: 9
      prefix: --ann_no_header
  - id: fraction
    type: ['null', float]
    doc: 'Fraction of cells per category where marker criteria must be satisfied
      (default: 0.65).'
    inputBinding:
      position: 10
      prefix: --fraction
  - id: verbosity
    type: ['null', int]
    doc: 'Set level of verbosity from 1 to 4. Where 1 is minimal and 4 most 
      (default: 3).'
    inputBinding:
      position: 11
      prefix: --verbosity
outputs:
  - id: marker_pairs_json
    type: ['null', File]
    doc: Marker pairs written to the --out file
    outputBinding:
      glob: $(inputs.out)
  - id: stdout_marker_pairs
    type: stdout
    doc: Marker pairs printed to standard output when --out is not given
stdout: sandbag_stdout.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypairs:3.2.3--py_0
