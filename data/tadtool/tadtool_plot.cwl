cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadtool plot
label: tadtool_plot
doc: "Main interactive TADtool plotting window\n\nTool homepage: https://github.com/vaquerizaslab/tadtool"
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
  - id: plotting_region
    type: string
    doc: 'Region of the Hi-C matrix to display in plot. Format: <chromosome>:<start>-<end>,
      e.g. chr12:31000000-33000000'
    inputBinding:
      position: 3
  - id: algorithm
    type:
      - 'null'
      - string
    doc: 'TAD-calling algorithm. Options: insulation, ninsulation, directionality.'
    inputBinding:
      position: 104
      prefix: --algorithm
  - id: data
    type:
      - 'null'
      - File
    doc: Matrix with index data. Rows correspond to window sizes, columns to 
      Hi-C matrix bins. If provided, suppresses inbuilt index calculation.
    inputBinding:
      position: 104
      prefix: --data
  - id: max_distance
    type:
      - 'null'
      - int
    doc: Maximum distance in base-pairs away from the diagonal to be shown in 
      Hi-C plot. Defaults to half the plotting window.
    inputBinding:
      position: 104
      prefix: --max-distance
  - id: normalisation_window
    type:
      - 'null'
      - int
    doc: Normalisation window in number of regions. Only affects ninsulation 
      algorithm. If not specified, window will be the whole chromosome.
    inputBinding:
      position: 104
      prefix: --normalisation-window
  - id: window_sizes
    type:
      - 'null'
      - type: array
        items: int
    doc: Window sizes in base pairs used for TAD calculation. You can pass (1) a
      filename with whitespace-delimited window sizes, (2) three integers 
      denoting start, stop, and step size to generate a range of window sizes, 
      or (3) more than three integers to define window sizes directly. If left 
      at default, window sizes will be logarithmically spaced between 10**4 and 
      10**6, or 10**6.5 for the insulation and directionality index, 
      respectively.
    inputBinding:
      position: 104
      prefix: --window-sizes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadtool:0.84--pyh7cba7a3_0
stdout: tadtool_plot.out
