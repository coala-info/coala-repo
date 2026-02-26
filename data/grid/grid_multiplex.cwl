cwlVersion: v1.2
class: CommandLineTool
baseCommand: grid multiplex
label: grid_multiplex
doc: "Multiplexing tool for grid data.\n\nTool homepage: https://github.com/ohlab/GRiD"
inputs:
  - id: coverage_cutoff
    type:
      - 'null'
      - float
    doc: Coverage cutoff (>= 0.2)
    default: 1.0
    inputBinding:
      position: 101
      prefix: -c
  - id: enable_pathoscope2_reassignment
    type:
      - 'null'
      - boolean
    doc: Enable reassignment of ambiguous reads using Pathoscope2
    inputBinding:
      position: 101
      prefix: -p
  - id: grid_database_directory
    type: Directory
    doc: GRiD database directory
    inputBinding:
      position: 101
      prefix: -d
  - id: merge_tables
    type:
      - 'null'
      - boolean
    doc: merge output tables into a single matrix file
    inputBinding:
      position: 101
      prefix: -m
  - id: output_directory
    type: Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: -o
  - id: reads_subset_file
    type:
      - 'null'
      - File
    doc: Path to file listing a subset of reads for analysis [default = analyze 
      all samples in reads directory]
    inputBinding:
      position: 101
      prefix: -l
  - id: sample_extension
    type:
      - 'null'
      - string
    doc: Sample filename extension (fq, fastq, fastq.gz)
    default: fastq
    inputBinding:
      position: 101
      prefix: -e
  - id: samples_directory
    type: Directory
    doc: Samples directory (single end reads)
    inputBinding:
      position: 101
      prefix: -r
  - id: theta_prior
    type:
      - 'null'
      - int
    doc: Theta prior for reads reassignment. Requires the -p flag
    default: 0
    inputBinding:
      position: 101
      prefix: -t
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: -n
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grid:1.3--0
stdout: grid_multiplex.out
