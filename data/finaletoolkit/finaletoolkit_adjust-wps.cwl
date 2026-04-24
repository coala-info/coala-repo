cwlVersion: v1.2
class: CommandLineTool
baseCommand: finaletoolkit-adjust-wps
label: finaletoolkit_adjust-wps
doc: "Adjusts raw Windowed Protection Score (WPS) by applying a median filter and
  Savitsky-Golay filter.\n\nTool homepage: https://github.com/epifluidlab/FinaleToolkit"
inputs:
  - id: input_file
    type: File
    doc: A bigWig file containing the WPS results over the intervals specified 
      in interval file.
    inputBinding:
      position: 1
  - id: interval_file
    type: File
    doc: Path to a BED file containing intervals to WPS was calculated over.
    inputBinding:
      position: 2
  - id: chrom_sizes
    type: File
    doc: A .chrom.sizes file containing chromosome names and sizes.
    inputBinding:
      position: 3
  - id: edge_size
    type:
      - 'null'
      - int
    doc: size of the edge subtracted from ends of window when --subtract-edges 
      is set.
    inputBinding:
      position: 104
      prefix: --edge-size
  - id: exclude_savgol
    type:
      - 'null'
      - boolean
    doc: Do not perform Savitsky-Golay filteringscores.
    inputBinding:
      position: 104
      prefix: --exclude-savgol
  - id: interval_size
    type:
      - 'null'
      - int
    doc: Size in bp of each interval in the interval file.
    inputBinding:
      position: 104
      prefix: --interval_size
  - id: mean
    type:
      - 'null'
      - boolean
    doc: A mean filter is used instead of median.
    inputBinding:
      position: 104
      prefix: --mean
  - id: median_window_size
    type:
      - 'null'
      - int
    doc: Size of the median filter or mean filter window used to adjust WPS 
      scores.
    inputBinding:
      position: 104
      prefix: --median-window-size
  - id: savgol_poly_deg
    type:
      - 'null'
      - int
    doc: Degree polynomial for Savitsky-Golay filter.
    inputBinding:
      position: 104
      prefix: --savgol-poly-deg
  - id: savgol_window_size
    type:
      - 'null'
      - int
    doc: Size of the Savitsky-Golay filter window used to adjust WPS scores.
    inputBinding:
      position: 104
      prefix: --savgol-window-size
  - id: subtract_edges
    type:
      - 'null'
      - boolean
    doc: Take the median of the first and last 500 bases in a window and 
      subtract from the whole interval.
    inputBinding:
      position: 104
      prefix: --subtract-edges
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose mode to display detailed processing information.
    inputBinding:
      position: 104
      prefix: --verbose
  - id: workers
    type:
      - 'null'
      - int
    doc: Number of worker processes.
    inputBinding:
      position: 104
      prefix: --workers
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: A bigWig file containing the adjusted WPS results over the intervals 
      specified in interval file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
