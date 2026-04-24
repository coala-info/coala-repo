cwlVersion: v1.2
class: CommandLineTool
baseCommand: PyClone
label: pyclone_PyClone
doc: "PyClone is a tool for inferring clonal structure from tumor sequencing data.\n\
  \nTool homepage: https://github.com/Roth-Lab/pyclone/"
inputs:
  - id: input_file
    type: File
    doc: Input mutation data file (e.g., TSV format)
    inputBinding:
      position: 1
  - id: burn_in
    type:
      - 'null'
      - int
    doc: Number of burn-in samples to discard
    inputBinding:
      position: 102
      prefix: --burn-in
  - id: config_file
    type:
      - 'null'
      - File
    doc: Configuration file for PyClone
    inputBinding:
      position: 102
      prefix: --config-file
  - id: n_samples
    type:
      - 'null'
      - int
    doc: Number of samples to draw from the posterior distribution
    inputBinding:
      position: 102
      prefix: --n-samples
  - id: output_dir
    type: Directory
    doc: Directory to write results to
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: plot_clusters
    type:
      - 'null'
      - boolean
    doc: Generate plots of cluster assignments
    inputBinding:
      position: 102
      prefix: --plot-clusters
  - id: plot_tree
    type:
      - 'null'
      - boolean
    doc: Generate plots of the phylogenetic tree
    inputBinding:
      position: 102
      prefix: --plot-tree
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for reproducibility
    inputBinding:
      position: 102
      prefix: --seed
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyclone:0.13.1--py_0
stdout: pyclone_PyClone.out
