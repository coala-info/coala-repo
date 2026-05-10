cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastpca
label: fastpca
doc: "Calculate principle components from large data files.\nInput data should be
  given as textfiles\nwith whitespace separated columns or, alternatively as GROMACS
  .xtc-files.\n\nTool homepage: https://github.com/lettis/FastPCA"
inputs:
  - id: buf
    type:
      - 'null'
      - int
    doc: 'max. allocatable RAM [Gb] (default: 2)'
    inputBinding:
      position: 101
      prefix: --buf
  - id: cov_in
    type:
      - 'null'
      - File
    doc: 'input (optional): file with already calculated covariance matrix'
    inputBinding:
      position: 101
      prefix: --cov-in
  - id: dynamic_shift
    type:
      - 'null'
      - boolean
    doc: 'use dynamic shifting for periodic projection correction. (default: fale,
      i.e. simply shift to region of lowest density)'
    inputBinding:
      position: 101
      prefix: --dynamic-shift
  - id: input_file
    type: File
    doc: 'input (required): either whitespace-separated ASCII or GROMACS xtc-file.'
    inputBinding:
      position: 101
      prefix: --file
  - id: norm
    type:
      - 'null'
      - boolean
    doc: 'if set, use correlation instead of covariance by normalizing input (default:
      false)'
    inputBinding:
      position: 101
      prefix: --norm
  - id: nthreads
    type:
      - 'null'
      - int
    doc: 'number of OpenMP threads to use. if set to zero, will use value of OMP_NUM_THREADS
      (default: 0)'
    inputBinding:
      position: 101
      prefix: --nthreads
  - id: periodic
    type:
      - 'null'
      - boolean
    doc: compute covariance and PCA on a torus (i.e. for periodic data like 
      dihedral angles)
    inputBinding:
      position: 101
      prefix: --periodic
  - id: stats_in
    type:
      - 'null'
      - File
    doc: 'input (optional): mean values, sigmas and boundary shifts (shifts only for
      periodic). Provide this, if you want to project new data onto a previously computed
      principal space. If you do not define the stats of the previous run, means,
      sigmas and shifts will be re-computed and the resulting projections will not
      be comparable to the previous ones.'
    inputBinding:
      position: 101
      prefix: --stats-in
  - id: vec_in
    type:
      - 'null'
      - File
    doc: 'input (optional): file with already computed eigenvectors'
    inputBinding:
      position: 101
      prefix: --vec-in
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'verbose mode (default: not set)'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: cov_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `cov_path`
    inputBinding:
      position: 102
      prefix: --cov
  - id: proj_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `proj_path`
    inputBinding:
      position: 103
      prefix: --proj
  - id: stats_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `stats_path`
    inputBinding:
      position: 104
      prefix: --stats
  - id: val_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `val_path`
    inputBinding:
      position: 105
      prefix: --val
  - id: vec_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `vec_path`
    inputBinding:
      position: 106
      prefix: --vec
outputs:
  - id: proj
    type:
      - 'null'
      - File
    doc: 'output (optional): file for projected data'
    outputBinding:
      glob: $(inputs.proj_path)
  - id: cov
    type:
      - 'null'
      - File
    doc: 'output (optional): file for covariance matrix'
    outputBinding:
      glob: $(inputs.cov_path)
  - id: vec
    type:
      - 'null'
      - File
    doc: 'output (optional): file for eigenvectors'
    outputBinding:
      glob: $(inputs.vec_path)
  - id: stats
    type:
      - 'null'
      - File
    doc: 'output (optional): mean values, sigmas and boundary shifts (shifts only
      for periodic)'
    outputBinding:
      glob: $(inputs.stats_path)
  - id: val
    type:
      - 'null'
      - File
    doc: 'output (optional): file for eigenvalues'
    outputBinding:
      glob: $(inputs.val_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastpca:0.9.1
