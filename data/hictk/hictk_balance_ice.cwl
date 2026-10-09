cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hictk
  - balance
  - ice
label: hictk_balance_ice
doc: 'Balance Hi-C files using ICE.


  Tool homepage: https://github.com/paulsengroup/hictk'
inputs:
  - id: input
    type: File
    doc: The .hic, .cool or .mcool file to be balanced. The file is staged writable
      and the weights are written into it.
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Balance matrix using: genome-wide interactions (gw), trans-only interactions
      (trans) or cis-only interactions (cis). [default: gw]'
    inputBinding:
      position: 2
      prefix: --mode
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: Path to a folder where to store temporary data.
    inputBinding:
      position: 2
      prefix: --tmpdir
  - id: ignore_diags
    type:
      - 'null'
      - int
    doc: 'Number of diagonals (including the main diagonal) to mask before balancing.
      [default: 2]'
    inputBinding:
      position: 2
      prefix: --ignore-diags
  - id: mad_max
    type:
      - 'null'
      - float
    doc: 'Mask bins using the MAD-max filter. Bins whose log marginal sum is less
      than --mad-max median absolute deviations below the median log marginal sum
      of all the bins in the same chromosome. [default: 5]'
    inputBinding:
      position: 2
      prefix: --mad-max
  - id: min_nnz
    type:
      - 'null'
      - int
    doc: 'Mask rows with fewer than --min-nnz non-zero entries. [default: 10]'
    inputBinding:
      position: 2
      prefix: --min-nnz
  - id: min_count
    type:
      - 'null'
      - int
    doc: 'Mask rows with fewer than --min-count interactions. [default: 0]'
    inputBinding:
      position: 2
      prefix: --min-count
  - id: tolerance
    type:
      - 'null'
      - float
    doc: 'Threshold of the variance of marginals used to determine whether the algorithm
      has converged. [default: 1e-05]'
    inputBinding:
      position: 2
      prefix: --tolerance
  - id: max_iters
    type:
      - 'null'
      - int
    doc: 'Maximum number of iterations. [default: 500]'
    inputBinding:
      position: 2
      prefix: --max-iters
  - id: rescale_weights
    type:
      - 'null'
      - boolean
    doc: Rescale weights such that rows sum approximately to 2.
    inputBinding:
      position: 2
      prefix: --rescale-weights
  - id: no_rescale_weights
    type:
      - 'null'
      - boolean
    doc: Do not rescale the weights.
    inputBinding:
      position: 2
      prefix: --no-rescale-weights
  - id: name
    type:
      - 'null'
      - string
    doc: Name to use when writing weights to file. Defaults to ICE, INTER_ICE and
      GW_ICE when --mode is cis, trans and gw, respectively.
    inputBinding:
      position: 2
      prefix: --name
  - id: create_weight_link
    type:
      - 'null'
      - boolean
    doc: Create a symbolic link to the balancing weights at clr::/bins/weight. Ignored
      when balancing .hic files.
    inputBinding:
      position: 2
      prefix: --create-weight-link
  - id: no_create_weight_link
    type:
      - 'null'
      - boolean
    doc: Do not create the symbolic link to the balancing weights.
    inputBinding:
      position: 2
      prefix: --no-create-weight-link
  - id: in_memory
    type:
      - 'null'
      - boolean
    doc: Store all interactions in memory (greatly improves performance).
    inputBinding:
      position: 2
      prefix: --in-memory
  - id: stdout_weights
    type:
      - 'null'
      - boolean
    doc: Write balancing weights to stdout instead of writing them to the input file.
    inputBinding:
      position: 2
      prefix: --stdout
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: 'Number of interactions to process at once. Ignored when using --in-memory.
      [default: 10000000]'
    inputBinding:
      position: 2
      prefix: --chunk-size
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Maximum number of parallel threads to spawn. [default: 1]'
    inputBinding:
      position: 2
      prefix: --threads
  - id: compression_lvl
    type:
      - 'null'
      - int
    doc: 'Compression level used to compress temporary files using ZSTD. [default:
      3]'
    inputBinding:
      position: 2
      prefix: --compression-lvl
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Set verbosity of output to the console. [default: 3]'
    inputBinding:
      position: 2
      prefix: --verbosity
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files and datasets (if any).
    inputBinding:
      position: 2
      prefix: --force
outputs:
  - id: balanced_file
    type: File
    doc: The input file with the balancing weights added.
    outputBinding:
      glob: $(inputs.input.basename)
  - id: stdout
    type: stdout
    doc: Balancing weights when --stdout is used.
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hictk:2.2.0--h75fee6f_0
stdout: hictk_balance_ice.out
