cwlVersion: v1.2
class: CommandLineTool
baseCommand: falcon
label: falcon-ms_falcon
doc: "falcon: Fast spectrum clustering using nearest neighbor searching. Clusters MS/MS
  spectra from mzML, mzXML or MGF files and writes the cluster assignments.\n\nTool
  homepage: https://github.com/bittremieux/falcon"
inputs:
  - id: input_filenames
    type: File[]
    doc: Input peak files (supported formats .mzML, .mzXML, .MGF).
    inputBinding:
      position: 100
  - id: output_filename
    type: string
    doc: Output file name (falcon appends .csv to it).
    inputBinding:
      position: 101
  - id: config_file
    type: ['null', File]
    doc: Config file path.
    inputBinding:
      prefix: --config
  - id: work_dir
    type: ['null', string]
    doc: Working directory (default is a temporary directory).
    inputBinding:
      prefix: --work_dir
  - id: overwrite
    type: ['null', boolean]
    doc: Overwrite existing results (default is not to overwrite).
    inputBinding:
      prefix: --overwrite
  - id: export_representatives
    type: ['null', boolean]
    doc: Export cluster representatives to an MGF file (default is no export).
    inputBinding:
      prefix: --export_representatives
  - id: export_include_singletons
    type: ['null', boolean]
    doc: Include singletons in the cluster representatives MGF file (default is not
      to include them).
    inputBinding:
      prefix: --export_include_singletons
  - id: usi_pxd
    type: ['null', string]
    doc: ProteomeXchange dataset identifier used for Universal Spectrum Identifier
      references (default USI000000).
    inputBinding:
      prefix: --usi_pxd
  - id: precursor_tol
    type:
      - 'null'
      - type: array
        items: string
    doc: Precursor tolerance mass and mode, two values such as "20 ppm". Mode is
      "ppm" or "Da" (default 20 ppm).
    inputBinding:
      prefix: --precursor_tol
  - id: rt_tol
    type: ['null', float]
    doc: Retention time tolerance (default is no retention time filtering).
    inputBinding:
      prefix: --rt_tol
  - id: fragment_tol
    type: ['null', float]
    doc: Fragment mass tolerance in m/z (default 0.05).
    inputBinding:
      prefix: --fragment_tol
  - id: eps
    type: ['null', float]
    doc: The eps parameter (cosine distance) for DBSCAN clustering (default 0.1).
      Useful thresholds are between 0.05 and 0.30.
    inputBinding:
      prefix: --eps
  - id: min_samples
    type: ['null', int]
    doc: The min_samples parameter for DBSCAN clustering (default 2).
    inputBinding:
      prefix: --min_samples
  - id: mz_interval
    type: ['null', float]
    doc: Precursor m/z interval (centered around x.5 Da) to process spectra
      simultaneously (default 1).
    inputBinding:
      prefix: --mz_interval
  - id: hash_len
    type: ['null', int]
    doc: Hashed vector length (default 800).
    inputBinding:
      prefix: --hash_len
  - id: n_neighbors
    type: ['null', int]
    doc: Number of neighbors in the pairwise distance matrix for each spectrum
      (default 64).
    inputBinding:
      prefix: --n_neighbors
  - id: n_neighbors_ann
    type: ['null', int]
    doc: Number of neighbors retrieved from the nearest neighbor indexes before
      precursor tolerance filtering (default 128).
    inputBinding:
      prefix: --n_neighbors_ann
  - id: batch_size
    type: ['null', int]
    doc: Number of spectra to process simultaneously (default 65536).
    inputBinding:
      prefix: --batch_size
  - id: n_probe
    type: ['null', int]
    doc: Maximum number of lists in the inverted index to inspect during querying
      (default 32).
    inputBinding:
      prefix: --n_probe
  - id: min_peaks
    type: ['null', int]
    doc: Discard spectra with fewer than this number of peaks (default 5).
    inputBinding:
      prefix: --min_peaks
  - id: min_mz_range
    type: ['null', float]
    doc: Discard spectra with a smaller mass range (default 250.0 m/z).
    inputBinding:
      prefix: --min_mz_range
  - id: min_mz
    type: ['null', float]
    doc: Minimum peak m/z value, inclusive (default 101.0).
    inputBinding:
      prefix: --min_mz
  - id: max_mz
    type: ['null', float]
    doc: Maximum peak m/z value, inclusive (default 1500.0).
    inputBinding:
      prefix: --max_mz
  - id: remove_precursor_tol
    type: ['null', float]
    doc: Window around the precursor mass to remove peaks (default 1.5 m/z).
    inputBinding:
      prefix: --remove_precursor_tol
  - id: min_intensity
    type: ['null', float]
    doc: Remove peaks with a lower intensity relative to the base intensity
      (default 0.01).
    inputBinding:
      prefix: --min_intensity
  - id: max_peaks_used
    type: ['null', int]
    doc: Only use this number of the most intense peaks in the spectra (default 50).
    inputBinding:
      prefix: --max_peaks_used
  - id: scaling
    type:
      - 'null'
      - type: enum
        symbols:
          - 'off'
          - root
          - log
          - rank
    doc: Peak scaling method used to reduce the influence of very intense peaks
      (default off).
    inputBinding:
      prefix: --scaling
outputs:
  - id: clusters
    type: ['null', File]
    doc: Cluster assignment table written by falcon.
    outputBinding:
      glob: $(inputs.output_filename).csv
  - id: representatives
    type: ['null', File]
    doc: Cluster representatives in MGF format (with --export_representatives).
    outputBinding:
      glob: $(inputs.output_filename).mgf
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/falcon-ms:v0.1.3_cv1
