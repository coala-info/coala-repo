cwlVersion: v1.2
class: CommandLineTool
baseCommand: canu
label: canu_assemble
doc: "Canu is a de novo assembler for long-read sequencing data. It is designed to
  produce high-quality assemblies from PacBio, Nanopore, and other long-read technologies.\n\
  \nTool homepage: https://github.com/marbl/canu"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input read files (FASTA or FASTQ, compressed or uncompressed)
    inputBinding:
      position: 1
  - id: haplotype_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: Haplotype-specific read files (e.g., illumina.fastq.gz)
    inputBinding:
      position: 2
  - id: assemble_mode
    type:
      - 'null'
      - boolean
    doc: Generate an assembly
    inputBinding:
      position: 103
  - id: assembly_directory
    type: Directory
    doc: Assembly directory for output files
    inputBinding:
      position: 103
      prefix: -d
  - id: assembly_prefix
    type: string
    doc: Assembly prefix for output files
    inputBinding:
      position: 103
      prefix: -p
  - id: assembly_specifications_file
    type:
      - 'null'
      - File
    doc: Assembly specifications file
    inputBinding:
      position: 103
      prefix: -s
  - id: correct_mode
    type:
      - 'null'
      - boolean
    doc: Generate corrected reads
    inputBinding:
      position: 103
  - id: corrected_error_rate
    type:
      - 'null'
      - float
    doc: The allowed difference in an overlap between two corrected reads. 
      Defaults are 0.045 for PacBio reads and 0.144 for Nanopore reads.
    inputBinding:
      position: 103
  - id: corrected_reads
    type:
      - 'null'
      - boolean
    doc: Use corrected reads
    inputBinding:
      position: 103
  - id: genome_size
    type: string
    doc: Estimated haploid genome size (e.g., 1g, 4.7m, 4700000)
    inputBinding:
      position: 103
  - id: grid_options
    type:
      - 'null'
      - string
    doc: Pass string to the command used to submit jobs to the grid.
    inputBinding:
      position: 103
  - id: haplotype_mode
    type:
      - 'null'
      - boolean
    doc: Generate haplotype-specific reads
    inputBinding:
      position: 103
  - id: haplotype_name
    type:
      - 'null'
      - string
    doc: Name for haplotype-specific reads
    inputBinding:
      position: 103
  - id: min_overlap_length
    type:
      - 'null'
      - int
    doc: Ignore read-to-read overlaps shorter than 'number' bases long.
    default: 500
    inputBinding:
      position: 103
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Ignore reads shorter than 'number' bases long.
    default: 1000
    inputBinding:
      position: 103
  - id: nanopore
    type:
      - 'null'
      - boolean
    doc: Use Nanopore reads
    inputBinding:
      position: 103
  - id: pacbio
    type:
      - 'null'
      - boolean
    doc: Use PacBio reads
    inputBinding:
      position: 103
  - id: pacbio_hifi
    type:
      - 'null'
      - boolean
    doc: Use PacBio HiFi reads
    inputBinding:
      position: 103
  - id: raw_error_rate
    type:
      - 'null'
      - float
    doc: The allowed difference in an overlap between two raw uncorrected reads.
      Defaults are 0.300 for PacBio reads and 0.500 for Nanopore reads.
    inputBinding:
      position: 103
  - id: trim_assemble_mode
    type:
      - 'null'
      - boolean
    doc: Generate trimmed reads and then assemble them
    inputBinding:
      position: 103
  - id: trim_mode
    type:
      - 'null'
      - boolean
    doc: Generate trimmed reads
    inputBinding:
      position: 103
  - id: trimmed_reads
    type:
      - 'null'
      - boolean
    doc: Use trimmed reads
    inputBinding:
      position: 103
  - id: use_grid
    type:
      - 'null'
      - string
    doc: Run under grid control (true), locally (false), or set up for grid 
      control but don't submit any jobs (remote)
    default: 'false'
    inputBinding:
      position: 103
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/canu:2.3--h3fb4750_2
stdout: canu_assemble.out
