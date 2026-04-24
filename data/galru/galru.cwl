cwlVersion: v1.2
class: CommandLineTool
baseCommand: galru
label: galru
doc: "Spoligotyping from uncorrected long reads\n\nTool homepage: https://github.com/quadram-institute-bioscience/galru"
inputs:
  - id: input_file
    type: File
    doc: Input FASTQ file of uncorrected long reads (optionally gzipped)
    inputBinding:
      position: 1
  - id: cas_fasta
    type:
      - 'null'
      - File
    doc: Cas gene FASTA file (optionally gzipped), defaults to bundled
    inputBinding:
      position: 102
      prefix: --cas_fasta
  - id: db_dir
    type:
      - 'null'
      - Directory
    doc: Base directory for species databases, defaults to bundled
    inputBinding:
      position: 102
      prefix: --db_dir
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Turn on debugging and save intermediate files
    inputBinding:
      position: 102
      prefix: --debug
  - id: extended_results
    type:
      - 'null'
      - boolean
    doc: Output extended results
    inputBinding:
      position: 102
      prefix: --extended_results
  - id: gene_start_offset
    type:
      - 'null'
      - int
    doc: Only count CRISPR reads which cover this base
    inputBinding:
      position: 102
      prefix: --gene_start_offset
  - id: min_bitscore
    type:
      - 'null'
      - int
    doc: Minimum blast bitscore
    inputBinding:
      position: 102
      prefix: --min_bitscore
  - id: min_identity
    type:
      - 'null'
      - int
    doc: Minimum blast identity
    inputBinding:
      position: 102
      prefix: --min_identity
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality score
    inputBinding:
      position: 102
      prefix: --min_mapping_quality
  - id: qcov_margin
    type:
      - 'null'
      - int
    doc: Maximum perc coverage difference between CRISPR and read
    inputBinding:
      position: 102
      prefix: --qcov_margin
  - id: species
    type:
      - 'null'
      - string
    doc: Species name, use galru_species to see all available
    inputBinding:
      position: 102
      prefix: --species
  - id: technology
    type:
      - 'null'
      - string
    doc: Sequencing technology
    inputBinding:
      position: 102
      prefix: --technology
  - id: threads
    type:
      - 'null'
      - int
    doc: No. of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turn on verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output filename, defaults to STDOUT
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galru:1.0.0--py_0
