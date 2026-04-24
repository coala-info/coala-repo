cwlVersion: v1.2
class: CommandLineTool
baseCommand: scanpy_settings
label: scanpy_settings
doc: "Scanpy configuration settings.\n\nTool homepage: https://scanpy.readthedocs.io/en/latest/"
inputs:
  - id: autosave
    type:
      - 'null'
      - boolean
    doc: Whether to automatically save the AnnData object.
    inputBinding:
      position: 101
  - id: autoshow
    type:
      - 'null'
      - boolean
    doc: Whether to automatically show plots.
    inputBinding:
      position: 101
  - id: cache_compression
    type:
      - 'null'
      - string
    doc: Compression method for the cache.
    inputBinding:
      position: 101
  - id: cachedir
    type:
      - 'null'
      - Directory
    doc: Directory for caching data.
    inputBinding:
      position: 101
  - id: categories_to_ignore
    type:
      - 'null'
      - type: array
        items: string
    doc: List of categories to ignore.
      - N/A
      - dontknow
      - no_gate
      - '?'
    inputBinding:
      position: 101
  - id: datasetdir
    type:
      - 'null'
      - Directory
    doc: Directory where datasets are located.
    inputBinding:
      position: 101
  - id: figdir
    type:
      - 'null'
      - Directory
    doc: Directory for saving figures.
    inputBinding:
      position: 101
  - id: file_format_data
    type:
      - 'null'
      - string
    doc: Default file format for data files.
    inputBinding:
      position: 101
  - id: file_format_figs
    type:
      - 'null'
      - string
    doc: Default file format for figure files.
    inputBinding:
      position: 101
  - id: logfile
    type:
      - 'null'
      - File
    doc: File object for logging.
    inputBinding:
      position: 101
  - id: logpath
    type:
      - 'null'
      - File
    doc: Path to the log file.
    inputBinding:
      position: 101
  - id: max_memory
    type:
      - 'null'
      - int
    doc: Maximum memory to use in GB.
    inputBinding:
      position: 101
  - id: n_jobs
    type:
      - 'null'
      - int
    doc: Number of parallel jobs to run.
    inputBinding:
      position: 101
  - id: n_pcs
    type:
      - 'null'
      - int
    doc: Number of principal components to compute.
    inputBinding:
      position: 101
  - id: plot_suffix
    type:
      - 'null'
      - string
    doc: Suffix to append to plot filenames.
    inputBinding:
      position: 101
  - id: set_figure_params
    type:
      - 'null'
      - string
    doc: Function to set figure parameters.
    inputBinding:
      position: 101
  - id: verbosity
    type:
      - 'null'
      - string
    doc: Verbosity level for logging.
    inputBinding:
      position: 101
  - id: writedir
    type:
      - 'null'
      - Directory
    doc: Directory for writing output files.
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scanpy:1.7.2--pyhdfd78af_0
stdout: scanpy_settings.out
