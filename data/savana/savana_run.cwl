cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - savana
  - run
label: savana_run
doc: "Savana is a tool for structural variant detection in cancer genomes.\n\nTool
  homepage: https://github.com/cortes-ciriano-lab/savana"
inputs:
  - id: buffer
    type:
      - 'null'
      - int
    doc: Buffer when clustering adjacent potential breakpoints, excepting 
      insertions
    default: 10
    inputBinding:
      position: 101
      prefix: --buffer
  - id: chunksize
    type:
      - 'null'
      - int
    doc: Chunksize to use when splitting genome for parallel analysis - used to 
      optimise memory
    default: 1000000
    inputBinding:
      position: 101
      prefix: --chunksize
  - id: contigs
    type:
      - 'null'
      - string
    doc: Contigs/chromosomes to consider. See example at 
      example/contigs.chr.hg38.txt (optional, default=All)
    inputBinding:
      position: 101
      prefix: --contigs
  - id: coverage_binsize
    type:
      - 'null'
      - int
    doc: Length used for coverage bins
    default: 5
    inputBinding:
      position: 101
      prefix: --coverage_binsize
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output extra debugging info and files
    inputBinding:
      position: 101
      prefix: --debug
  - id: end_buffer
    type:
      - 'null'
      - int
    doc: Buffer when clustering alternate edge of potential breakpoints, 
      excepting insertions
    default: 50
    inputBinding:
      position: 101
      prefix: --end_buffer
  - id: insertion_buffer
    type:
      - 'null'
      - int
    doc: Buffer when clustering adjacent potential insertion breakpoints
    default: 250
    inputBinding:
      position: 101
      prefix: --insertion_buffer
  - id: inv_artefact_distance
    type:
      - 'null'
      - int
    doc: Maximum distance between alignment start/end to be considered an 
      artefact when --keep_inv_artefact is not set
    default: 200
    inputBinding:
      position: 101
      prefix: --inv_artefact_distance
  - id: keep_inv_artefact
    type:
      - 'null'
      - boolean
    doc: Do not remove breakpoints with foldback-inversion artefact pattern
    inputBinding:
      position: 101
      prefix: --keep_inv_artefact
  - id: length
    type:
      - 'null'
      - int
    doc: Minimum length SV to consider
    default: 30
    inputBinding:
      position: 101
      prefix: --length
  - id: mapq
    type:
      - 'null'
      - int
    doc: Minimum MAPQ to consider a read mapped
    default: 5
    inputBinding:
      position: 101
      prefix: --mapq
  - id: min_reads_per_cluster
    type:
      - 'null'
      - int
    doc: In clustering step, discard clusters with fewer than n supporting reads
    default: 3
    inputBinding:
      position: 101
      prefix: --min_reads_per_cluster
  - id: min_support
    type:
      - 'null'
      - int
    doc: Minimum supporting reads for a PASS variant
    default: 3
    inputBinding:
      position: 101
      prefix: --min_support
  - id: normal
    type: File
    doc: Normal BAM file (must have index)
    inputBinding:
      position: 101
      prefix: --normal
  - id: outdir
    type: Directory
    doc: Output directory (can exist but must be empty)
    inputBinding:
      position: 101
      prefix: --outdir
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Use this flag to write to output directory even if files are present
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: ref
    type: File
    doc: Full path to reference genome
    inputBinding:
      position: 101
      prefix: --ref
  - id: ref_index
    type:
      - 'null'
      - File
    doc: Full path to reference genome fasta index (ref path + ".fai" by 
      default)
    inputBinding:
      position: 101
      prefix: --ref_index
  - id: sample
    type:
      - 'null'
      - string
    doc: Name to prepend to output files (default=tumour BAM filename without 
      extension)
    inputBinding:
      position: 101
      prefix: --sample
  - id: single_bnd
    type:
      - 'null'
      - boolean
    doc: Report single breakend variants in addition to standard types
    default: false
    inputBinding:
      position: 101
      prefix: --single_bnd
  - id: single_bnd_max_mapq
    type:
      - 'null'
      - int
    doc: Convert supplementary alignments below this threshold to single 
      breakend (default=5, must not exceed --mapq argument)
    default: 5
    inputBinding:
      position: 101
      prefix: --single_bnd_max_mapq
  - id: single_bnd_min_length
    type:
      - 'null'
      - int
    doc: Minimum length of single breakend to consider
    default: 100
    inputBinding:
      position: 101
      prefix: --single_bnd_min_length
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: max
    inputBinding:
      position: 101
      prefix: --threads
  - id: tumour
    type: File
    doc: Tumour BAM file (must have index)
    inputBinding:
      position: 101
      prefix: --tumour
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savana:1.3.6--pyhdfd78af_0
stdout: savana_run.out
