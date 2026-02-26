cwlVersion: v1.2
class: CommandLineTool
baseCommand: clam collect
label: clam_collect
doc: "Collect depth from multiple files into a Zarr store\n\nTool homepage: https://github.com/cademirch/clam"
inputs:
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: Input depth files (not needed when using --samples)
    inputBinding:
      position: 1
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Chunk size for processing (base pairs)
    default: 1000000
    inputBinding:
      position: 102
      prefix: --chunk-size
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma separated list of chromosomes to exclude
    inputBinding:
      position: 102
      prefix: --exclude
  - id: exclude_file
    type:
      - 'null'
      - File
    doc: Path to file with chromosomes to exclude, one per line
    inputBinding:
      position: 102
      prefix: --exclude-file
  - id: force_samples
    type:
      - 'null'
      - boolean
    doc: Only warn about samples not in population file; exclude them from 
      analysis (only supported for 'stat' command)
    inputBinding:
      position: 102
      prefix: --force-samples
  - id: include
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma separated list of chromosomes to include (restrict analysis to)
    inputBinding:
      position: 102
      prefix: --include
  - id: include_file
    type:
      - 'null'
      - File
    doc: Path to file with chromosomes to include, one per line
    inputBinding:
      position: 102
      prefix: --include-file
  - id: min_gq
    type:
      - 'null'
      - int
    doc: Minimum gq to count depth (GVCF input only)
    inputBinding:
      position: 102
      prefix: --min-gq
  - id: population_file
    type:
      - 'null'
      - File
    doc: "[DEPRECATED: use --samples] Path to file that defines populations. Tab separated:
      sample\tpopulation_name"
    inputBinding:
      position: 102
      prefix: --population-file
  - id: samples
    type:
      - 'null'
      - File
    doc: 'Path to samples TSV file (with header). Columns: sample_name (required),
      file_path (required for collect; optional for loci with zarr input), population
      (optional). For loci/collect: input files are read from the TSV instead of positional
      arguments (unless input is a zarr store, in which case --samples provides population
      assignments only). For stat: provides population assignments (file_path column
      is not used)'
    inputBinding:
      position: 102
      prefix: --samples
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel processing
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output
    type: File
    doc: Output path for callable sites zarr array
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clam:1.1.3--h79ce301_0
