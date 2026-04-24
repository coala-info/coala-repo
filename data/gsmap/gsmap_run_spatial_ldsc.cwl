cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsmap_run_spatial_ldsc
label: gsmap_run_spatial_ldsc
doc: "Run spatial LDSC analysis\n\nTool homepage: https://github.com/LeonSong1995/gsMap"
inputs:
  - id: chisq_max
    type:
      - 'null'
      - float
    doc: Maximum chi-square value for filtering SNPs.
    inputBinding:
      position: 101
      prefix: --chisq_max
  - id: chunk_range_end
    type:
      - 'null'
      - int
    doc: "Range of chunks to run in this batch, omit to run all\n                \
      \        chunks"
    inputBinding:
      position: 101
      prefix: --chunk_range
  - id: chunk_range_start
    type:
      - 'null'
      - int
    doc: "Range of chunks to run in this batch, omit to run all\n                \
      \        chunks"
    inputBinding:
      position: 101
      prefix: --chunk_range
  - id: n_blocks
    type:
      - 'null'
      - int
    doc: Number of blocks for jackknife resampling.
    inputBinding:
      position: 101
      prefix: --n_blocks
  - id: num_processes
    type:
      - 'null'
      - int
    doc: Number of processes for parallel computing.
    inputBinding:
      position: 101
      prefix: --num_processes
  - id: sample_name
    type: string
    doc: Name of the sample.
    inputBinding:
      position: 101
      prefix: --sample_name
  - id: sumstats_file
    type: File
    doc: Path to GWAS summary statistics file.
    inputBinding:
      position: 101
      prefix: --sumstats_file
  - id: trait_name
    type: string
    doc: Name of the trait being analyzed.
    inputBinding:
      position: 101
      prefix: --trait_name
  - id: use_additional_baseline_annotation
    type:
      - 'null'
      - boolean
    doc: Use additional baseline annotations when provided
    inputBinding:
      position: 101
      prefix: --use_additional_baseline_annotation
  - id: w_file
    type:
      - 'null'
      - File
    doc: "Path to regression weight file. If not provided, will\n                \
      \        use weights generated in the generate_ldscore step."
    inputBinding:
      position: 101
      prefix: --w_file
  - id: workdir
    type: Directory
    doc: Path to the working directory.
    inputBinding:
      position: 101
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gsmap:1.73.7--pyhdfd78af_0
stdout: gsmap_run_spatial_ldsc.out
