cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cooler
  - balance
label: cooler_balance
doc: "Out-of-core matrix balancing.\n\nTool homepage: https://github.com/open2c/cooler"
inputs:
  - id: cool_path
    type: File
    doc: Path to a COOL file.
    inputBinding:
      position: 1
  - id: blacklist
    type:
      - 'null'
      - File
    doc: Path to a 3-column BED file containing genomic regions to mask out 
      during the balancing procedure, e.g. sequence gaps or regions of poor 
      mappability.
    inputBinding:
      position: 102
      prefix: --blacklist
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check whether a data column 'weight' already exists.
    inputBinding:
      position: 102
      prefix: --check
  - id: chunksize
    type:
      - 'null'
      - int
    doc: Control the number of pixels handled by each worker process at a time.
    default: 10000000
    inputBinding:
      position: 102
      prefix: --chunksize
  - id: cis_only
    type:
      - 'null'
      - boolean
    doc: Calculate weights against intra-chromosomal data only instead of 
      genome-wide.
    inputBinding:
      position: 102
      prefix: --cis-only
  - id: convergence_policy
    type:
      - 'null'
      - string
    doc: "What to do with weights when balancing doesn't converge in max_iters. 'store_final':
      Store the final result, regardless of whether the iterations converge to the
      specified tolerance; 'store_nan': Store a vector of NaN values to indicate that
      the matrix failed to converge; 'discard': Store nothing and exit gracefully;
      'error': Abort with non-zero exit status."
    default: store_final
    inputBinding:
      position: 102
      prefix: --convergence-policy
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite the target dataset, 'weight', if it already exists.
    inputBinding:
      position: 102
      prefix: --force
  - id: ignore_diags
    type:
      - 'null'
      - int
    doc: Number of diagonals of the contact matrix to ignore, including the main
      diagonal.
    default: 2
    inputBinding:
      position: 102
      prefix: --ignore-diags
  - id: ignore_dist
    type:
      - 'null'
      - int
    doc: Distance from the diagonal in bp to ignore. The maximum of the 
      corresponding number of diagonals and `--ignore-diags` will be used.
    inputBinding:
      position: 102
      prefix: --ignore-dist
  - id: mad_max
    type:
      - 'null'
      - int
    doc: "Ignore bins from the contact matrix using the 'MAD-max' filter: bins whose
      log marginal sum is less than ``mad-max`` median absolute deviations below the
      median log marginal sum of all the bins in the same chromosome."
    default: 5
    inputBinding:
      position: 102
      prefix: --mad-max
  - id: max_iters
    type:
      - 'null'
      - int
    doc: Maximum number of iterations to perform if convergence is not achieved.
    default: 200
    inputBinding:
      position: 102
      prefix: --max-iters
  - id: min_count
    type:
      - 'null'
      - int
    doc: Ignore bins from the contact matrix whose marginal count is less than 
      this number.
    default: 0
    inputBinding:
      position: 102
      prefix: --min-count
  - id: min_nnz
    type:
      - 'null'
      - int
    doc: Ignore bins from the contact matrix whose marginal number of nonzeros 
      is less than this number.
    default: 10
    inputBinding:
      position: 102
      prefix: --min-nnz
  - id: name
    type:
      - 'null'
      - string
    doc: Name of column to write to.
    default: weight
    inputBinding:
      position: 102
      prefix: --name
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of processes to split the work between.
    default: 8
    inputBinding:
      position: 102
      prefix: --nproc
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Print weight column to stdout instead of saving to file.
    inputBinding:
      position: 102
      prefix: --stdout
  - id: tol
    type:
      - 'null'
      - float
    doc: Threshold value of variance of the marginals for the algorithm to 
      converge.
    default: 1e-05
    inputBinding:
      position: 102
      prefix: --tol
  - id: trans_only
    type:
      - 'null'
      - boolean
    doc: Calculate weights against inter-chromosomal data only instead of 
      genome-wide.
    inputBinding:
      position: 102
      prefix: --trans-only
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
stdout: cooler_balance.out
