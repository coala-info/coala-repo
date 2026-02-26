cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clam
  - stat
label: clam_stat
doc: "Calculate population genetic statistics from VCF\n\nTool homepage: https://github.com/cademirch/clam"
inputs:
  - id: vcf
    type: File
    doc: Path to input VCF file (bgzipped and indexed)
    inputBinding:
      position: 1
  - id: callable
    type:
      - 'null'
      - File
    doc: Path to callable sites zarr array (from clam loci)
    inputBinding:
      position: 102
      prefix: --callable
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Chunk size for parallel processing (base pairs)
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
  - id: population_file
    type:
      - 'null'
      - File
    doc: "[DEPRECATED: use --samples] Path to file that defines populations. Tab separated:
      sample\tpopulation_name"
    inputBinding:
      position: 102
      prefix: --population-file
  - id: regions_file
    type:
      - 'null'
      - File
    doc: BED file specifying regions to calculate statistics for
    inputBinding:
      position: 102
      prefix: --regions-file
  - id: roh
    type:
      - 'null'
      - File
    doc: Path to ROH regions BED file (sample name in 4th column)
    inputBinding:
      position: 102
      prefix: --roh
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
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size in base pairs
    inputBinding:
      position: 102
      prefix: --window-size
outputs:
  - id: outdir
    type: Directory
    doc: Output directory for statistics files
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clam:1.1.3--h79ce301_0
