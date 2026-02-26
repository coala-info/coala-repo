cwlVersion: v1.2
class: CommandLineTool
baseCommand: pool.py
label: catch_pool.py
doc: "Optimizes parameter values for probe design based on probe counts and constraints.\n\
  \nTool homepage: https://github.com/broadinstitute/catch"
inputs:
  - id: probe_count_tsv
    type: File
    doc: Path to TSV file that contains probe counts for each dataset and 
      combination of parameters; the first row must be a header, the first 
      column must give a dataset ('dataset'), the last column must list a number
      of probes ('num_probes'), and the intermediary columns give parameter 
      values
    inputBinding:
      position: 1
  - id: target_probe_count
    type: int
    doc: Constraint on the total number of probes in the design; generally, 
      parameters will be selected such that the number of probes, when pooled 
      across datasets, is just below this number
    inputBinding:
      position: 2
  - id: dataset_weights_tsv
    type:
      - 'null'
      - File
    doc: Path to TSV file that contains a weight for each dataset to use in the 
      loss function. The first row must be a header, the first column must 
      provide the dataset ('dataset') and the second column must provide the 
      weight of the dataset ('weight'). If not provided, the default is a weight
      of 1 for each dataset.
    inputBinding:
      position: 103
      prefix: --dataset-weights
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug output
    inputBinding:
      position: 103
      prefix: --debug
  - id: loss_coeffs
    type:
      - 'null'
      - type: array
        items: float
    doc: Coefficients on parameters in the loss function. These must be 
      specified in the same order as the parameter columns in the input table. 
      Default is 1 for mismatches and 1/100 for cover_extension (or, when 
      --use-nd is specified, 1 for all parameters).
    inputBinding:
      position: 103
      prefix: --loss-coeffs
  - id: round_params
    type:
      - 'null'
      - type: array
        items: string
    doc: <m> <e>; round mismatches parameter to the nearest multiple of m and 
      cover_extension parameter to the nearest multiple of e
    inputBinding:
      position: 103
      prefix: --round-params
  - id: use_nd
    type:
      - 'null'
      - boolean
    doc: Use the higher dimensional (n > 2) interpolation and search functions 
      for optimizing parameters. This is required if the input table of probe 
      counts contains more than 2 parameters. This does not round parameters to 
      integers or to be placed on a grid -- i.e., they will be output as 
      fractional values (from which probe counts were interpolated). When using 
      this, --loss-coeffs should also be set (default is 1 for all parameters).
    inputBinding:
      position: 103
      prefix: --use-nd
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: param_vals_tsv
    type: File
    doc: Path to TSV file in which to output optimal parameter values
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/catch:1.5.2--pyhdfd78af_0
