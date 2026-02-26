cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tadtool
  - tads
label: tadtool_tads
doc: "Call TADs with pre-defined parameters\n\nTool homepage: https://github.com/vaquerizaslab/tadtool"
inputs:
  - id: matrix
    type: File
    doc: 'Square Hi-C Matrix as tab-delimited or .npy file (created with numpy.save)
      or sparse matrix format (each line: <row region index> <column region index>
      <matrix value>)'
    inputBinding:
      position: 1
  - id: regions
    type: File
    doc: BED file (no header) with regions corresponding to the number of rows 
      in the provided matrix. Fourth column, if present, denotes name field, 
      which is used as an identifier in sparse matrix notation.
    inputBinding:
      position: 2
  - id: window_size
    type: int
    doc: Window size in base pairs
    inputBinding:
      position: 3
  - id: cutoff
    type: float
    doc: Cutoff for TAD-calling algorithm at given window size.
    inputBinding:
      position: 4
  - id: algorithm
    type:
      - 'null'
      - string
    doc: 'TAD-calling algorithm. Options: insulation, ninsulation, directionality.'
    default: insulation
    inputBinding:
      position: 105
      prefix: --algorithm
  - id: normalisation_window
    type:
      - 'null'
      - int
    doc: Normalisation window in number of regions. Only affects ninsulation 
      algorithm. If not specified, window will be the whole chromosome.
    inputBinding:
      position: 105
      prefix: --normalisation-window
  - id: write_values
    type:
      - 'null'
      - boolean
    doc: Write index values to file instead of TADs.
    inputBinding:
      position: 105
      prefix: --write-values
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Optional output file to save TADs.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadtool:0.84--pyh7cba7a3_0
