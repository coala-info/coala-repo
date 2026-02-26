cwlVersion: v1.2
class: CommandLineTool
baseCommand: spectra-cluster-cli
label: spectra-cluster-cli
doc: "The PRIDE Cluster algorithm for clustering mass spectrometry spectra.\n\nTool
  homepage: https://github.com/spectra-cluster/spectra-cluster-cli"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input spectrum files (e.g., .mgf files)
    inputBinding:
      position: 1
  - id: binary_directory
    type:
      - 'null'
      - Directory
    doc: Directory used to store intermediate binary files
    inputBinding:
      position: 102
      prefix: -binary_directory
  - id: clustering_rounds
    type:
      - 'null'
      - int
    doc: Number of clustering rounds to perform
    default: 3
    inputBinding:
      position: 102
      prefix: -clustering_rounds
  - id: fast_mode
    type:
      - 'null'
      - boolean
    doc: If used, the fast mode of the clustering algorithm is used
    inputBinding:
      position: 102
      prefix: -fast_mode
  - id: fragment_tolerance
    type:
      - 'null'
      - float
    doc: Fragment ion tolerance in Da
    default: 0.5
    inputBinding:
      position: 102
      prefix: -fragment_tolerance
  - id: precursor_tolerance
    type:
      - 'null'
      - float
    doc: Precursor ion tolerance
    default: 2.0
    inputBinding:
      position: 102
      prefix: -precursor_tolerance
  - id: precursor_tolerance_unit
    type:
      - 'null'
      - string
    doc: Unit of the precursor ion tolerance (da or ppm)
    default: da
    inputBinding:
      position: 102
      prefix: -precursor_tolerance_unit
  - id: threshold
    type:
      - 'null'
      - float
    doc: Clustering threshold to use
    inputBinding:
      position: 102
      prefix: -threshold
outputs:
  - id: output_path
    type: Directory
    doc: Path to the output directory where results will be stored
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spectra-cluster-cli:1.1.2--0
