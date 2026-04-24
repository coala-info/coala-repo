cwlVersion: v1.2
class: CommandLineTool
baseCommand: tracs_align
label: tracs_align
doc: "Uses sourmash to identify reference genomes within a read set and then aligns
  reads to each reference using minimap2\n\nTool homepage: https://github.com/gtonkinhill/tracs"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: path to query signature
    inputBinding:
      position: 1
  - id: consensus
    type:
      - 'null'
      - boolean
    doc: Turns on consensus mode. Only the most common allele at each site will 
      be reported and all other filters will be ignored.
    inputBinding:
      position: 102
      prefix: --consensus
  - id: database
    type:
      - 'null'
      - File
    doc: path to database signatures
    inputBinding:
      position: 102
      prefix: --database
  - id: either_strand
    type:
      - 'null'
      - boolean
    doc: turns off the requirement that a variant is supported by both strands
    inputBinding:
      position: 102
      prefix: --either-strand
  - id: error_threshold
    type:
      - 'null'
      - float
    doc: Threshold to exclude likely erroneous variants.
    inputBinding:
      position: 102
      prefix: --error-perc
  - id: keep_all
    type:
      - 'null'
      - boolean
    doc: turns on filtering of variants with support below the posterior 
      frequency threshold
    inputBinding:
      position: 102
      prefix: --keep-all
  - id: keep_cov_outliers
    type:
      - 'null'
      - boolean
    doc: Turns off filtering of genome regions with unusual coverage. Useful if 
      no gene gain/loss is expected.
    inputBinding:
      position: 102
      prefix: --keep-cov-outliers
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set the logging threshold.
    inputBinding:
      position: 102
      prefix: --loglevel
  - id: max_div
    type:
      - 'null'
      - float
    doc: ignore queries with per-base divergence > max_div
    inputBinding:
      position: 102
      prefix: --max_div
  - id: min_base_qual
    type:
      - 'null'
      - int
    doc: minimum base quality
    inputBinding:
      position: 102
      prefix: --min_base_qual
  - id: min_cov
    type:
      - 'null'
      - int
    doc: Minimum read coverage
    inputBinding:
      position: 102
      prefix: --min-cov
  - id: min_map_qual
    type:
      - 'null'
      - int
    doc: minimum mapping quality
    inputBinding:
      position: 102
      prefix: --min_map_qual
  - id: min_query_len
    type:
      - 'null'
      - int
    doc: minimum query length
    inputBinding:
      position: 102
      prefix: --min_query_len
  - id: minimap_preset
    type:
      - 'null'
      - string
    doc: minimap preset to use - one of 'sr' (default), 'map-ont' or 'map-pb'
    inputBinding:
      position: 102
      prefix: --minimap_preset
  - id: n_cpu
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix to describe the input sample read files
    inputBinding:
      position: 102
      prefix: --prefix
  - id: refseqs
    type:
      - 'null'
      - File
    doc: path to reference fasta files
    inputBinding:
      position: 102
      prefix: --refseqs
  - id: trim
    type:
      - 'null'
      - int
    doc: ignore bases within TRIM-bp from either end of a read
    inputBinding:
      position: 102
      prefix: --trim
outputs:
  - id: output_dir
    type: Directory
    doc: location of an output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracs:1.0.1--py312h43eeafb_1
