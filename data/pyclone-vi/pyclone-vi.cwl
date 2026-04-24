cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyclone-vi
label: pyclone-vi
doc: "PyClone-VI is a Bayesian model for inferring clonal population structure from
  deep sequencing data.\n\nTool homepage: https://github.com/Roth-Lab/pyclone-vi"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to run (e.g., fit, write-results, version)
    inputBinding:
      position: 1
  - id: density
    type:
      - 'null'
      - string
    doc: Density model to use (e.g., binomial, beta-binomial).
    inputBinding:
      position: 102
      prefix: --density
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file containing mutation data (usually in TSV format).
    inputBinding:
      position: 102
      prefix: --input
  - id: max_iters
    type:
      - 'null'
      - int
    doc: Maximum number of iterations for the optimization.
    inputBinding:
      position: 102
      prefix: --max-iters
  - id: num_clusters
    type:
      - 'null'
      - int
    doc: Number of clusters to use in the variational approximation.
    inputBinding:
      position: 102
      prefix: --clusters
  - id: num_restarts
    type:
      - 'null'
      - int
    doc: Number of restarts for the optimization.
    inputBinding:
      position: 102
      prefix: --num-restarts
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for reproducibility.
    inputBinding:
      position: 102
      prefix: --seed
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file to write the results (usually an HDF5 file).
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyclone-vi:0.2.0--pyhdfd78af_0
