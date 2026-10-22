cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - stripepy
  - call
label: stripepy-hic_call
doc: "Recognize stripes in a contact map (.hic, .mcool, .cool) in four steps: pre-processing, recognition of seeds, shape analysis and signal analysis. Writes an HDF5 file.\n\nTool homepage: https://github.com/paulsengroup/StripePy"
inputs:
  - id: contact_map
    type: File
    doc: Path to a .cool, .mcool, or .hic file for input.
    inputBinding:
      position: 101
  - id: resolution
    type: int
    doc: Resolution (in bp).
    inputBinding:
      position: 102
  - id: normalization
    type:
      - 'null'
      - string
    doc: Normalization to fetch
    inputBinding:
      position: 1
      prefix: --normalization
  - id: genomic_belt
    type:
      - 'null'
      - int
    doc: Radius of the band, centred around the diagonal, where the search is restricted to (in bp, default 5000000)
    inputBinding:
      position: 1
      prefix: --genomic-belt
  - id: roi
    type:
      - 'null'
      - string
    doc: Criterion used to select a region from each chromosome used to generate diagnostic plots (middle or start); requires --plot-dir
    inputBinding:
      position: 1
      prefix: --roi
  - id: output_file
    type: string
    doc: Path where to store the output HDF5 file
    inputBinding:
      position: 1
      prefix: --output-file
  - id: log_file
    type:
      - 'null'
      - string
    doc: Path where to store the log file
    inputBinding:
      position: 1
      prefix: --log-file
  - id: plot_dir
    type:
      - 'null'
      - string
    doc: Path where to store the output plots; required when --roi is specified; created if missing
    inputBinding:
      position: 1
      prefix: --plot-dir
  - id: max_width
    type:
      - 'null'
      - int
    doc: Maximum stripe width, in bp (default 100000)
    inputBinding:
      position: 1
      prefix: --max-width
  - id: glob_pers_min
    type:
      - 'null'
      - float
    doc: Threshold value between 0 and 1 to filter persistence maxima points and identify seeds (default 0.04)
    inputBinding:
      position: 1
      prefix: --glob-pers-min
  - id: k_neighbour
    type:
      - 'null'
      - int
    doc: k for the k-neighbour, number of bins adjacent to the stripe boundaries on both sides (default 3)
    inputBinding:
      position: 1
      prefix: -k
  - id: loc_pers_min
    type:
      - 'null'
      - float
    doc: Threshold between 0 and 1 to find peaks in signal in a horizontal domain while estimating the height of a stripe (default 0.33)
    inputBinding:
      position: 1
      prefix: --loc-pers-min
  - id: loc_trend_min
    type:
      - 'null'
      - float
    doc: Threshold between 0 and 1 to estimate the height of a stripe (default 0.25)
    inputBinding:
      position: 1
      prefix: --loc-trend-min
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing file(s)
    inputBinding:
      position: 1
      prefix: --force
  - id: verbosity
    type:
      - 'null'
      - string
    doc: Set verbosity of output to the console (debug, info, warning, error, critical; default info)
    inputBinding:
      position: 1
      prefix: --verbosity
  - id: nproc
    type:
      - 'null'
      - int
    doc: Maximum number of parallel processes to use (default 1)
    inputBinding:
      position: 1
      prefix: --nproc
  - id: low_memory
    type:
      - 'null'
      - boolean
    doc: Minimize memory usage when fetching interactions from files
    inputBinding:
      position: 1
      prefix: --low-memory
  - id: min_chrom_size
    type:
      - 'null'
      - int
    doc: Minimum size, in bp, for a chromosome to be analysed (default 2000000)
    inputBinding:
      position: 1
      prefix: --min-chrom-size
outputs:
  - id: stripes_hdf5
    type: File
    doc: HDF5 file with the detected stripes
    outputBinding:
      glob: $(inputs.output_file)
  - id: log_out
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: $(inputs.log_file)
  - id: plots
    type:
      - 'null'
      - Directory
    doc: Diagnostic plots
    outputBinding:
      glob: $(inputs.plot_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stripepy-hic:1.3.0--pyh2a3209d_1
