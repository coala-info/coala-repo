cwlVersion: v1.2
class: CommandLineTool
baseCommand: canu
label: canu_haplotype
doc: "Canu is a de novo assembler for highly accurate long-read sequencing data. It
  is particularly well-suited for PacBio and Nanopore sequencing data, and can also
  be used for shorter reads. This command is specifically for generating haplotype-specific
  reads.\n\nTool homepage: https://github.com/marbl/canu"
inputs:
  - id: haplotype_illumina_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: Haplotype-specific Illumina read files (FASTA/FASTQ, compressed with 
      gz, bz2 or xz)
    inputBinding:
      position: 1
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input read files (FASTA/FASTQ, compressed with gz, bz2 or xz)
    inputBinding:
      position: 2
  - id: nanopore_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: Nanopore reads (FASTA/FASTQ, compressed with gz, bz2 or xz)
    inputBinding:
      position: 3
  - id: pacbio_hifi_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: PacBio HiFi reads (FASTA/FASTQ, compressed with gz, bz2 or xz)
    inputBinding:
      position: 4
  - id: pacbio_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: PacBio reads (FASTA/FASTQ, compressed with gz, bz2 or xz)
    inputBinding:
      position: 5
  - id: assemble_mode
    type:
      - 'null'
      - boolean
    doc: Generate an assembly
    inputBinding:
      position: 106
      prefix: -assemble
  - id: assembly_directory
    type: Directory
    doc: Assembly directory where output files will be placed
    inputBinding:
      position: 106
      prefix: -d
  - id: assembly_prefix
    type: string
    doc: Assembly prefix for output files
    inputBinding:
      position: 106
      prefix: -p
  - id: assembly_specifications_file
    type:
      - 'null'
      - File
    doc: Assembly specifications file
    inputBinding:
      position: 106
      prefix: -s
  - id: correct_mode
    type:
      - 'null'
      - boolean
    doc: Generate corrected reads
    inputBinding:
      position: 106
      prefix: -correct
  - id: corrected_error_rate
    type:
      - 'null'
      - float
    doc: The allowed difference in an overlap between two corrected reads. 
      Assemblies of low coverage or data with biological differences will 
      benefit from a slight increase in this. Defaults are 0.045 for PacBio 
      reads and 0.144 for Nanopore reads.
    inputBinding:
      position: 106
  - id: corrected_reads_flag
    type:
      - 'null'
      - boolean
    doc: Use corrected reads
    inputBinding:
      position: 106
      prefix: -corrected
  - id: genome_size
    type: string
    doc: Estimated haploid genome size (e.g., 1g, 4.7m, 4700000)
    inputBinding:
      position: 106
  - id: grid_options
    type:
      - 'null'
      - string
    doc: Pass string to the command used to submit jobs to the grid. Can be used
      to set maximum run time limits. Should NOT be used to set memory limits; 
      Canu will do that for you.
    inputBinding:
      position: 106
  - id: haplotype_mode
    type:
      - 'null'
      - boolean
    doc: Generate haplotype-specific reads
    inputBinding:
      position: 106
      prefix: -haplotype
  - id: haplotype_name
    type:
      - 'null'
      - string
    doc: Name for the haplotype (letters and numbers only)
    inputBinding:
      position: 106
      prefix: -haplotype{NAME}
  - id: min_overlap_length
    type:
      - 'null'
      - int
    doc: Ignore read-to-read overlaps shorter than 'number' bases long.
    inputBinding:
      position: 106
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Ignore reads shorter than 'number' bases long.
    inputBinding:
      position: 106
  - id: raw_error_rate
    type:
      - 'null'
      - float
    doc: The allowed difference in an overlap between two raw uncorrected reads.
      For lower quality reads, use a higher number. Defaults are 0.300 for 
      PacBio reads and 0.500 for Nanopore reads.
    inputBinding:
      position: 106
  - id: trim_assemble_mode
    type:
      - 'null'
      - boolean
    doc: Generate trimmed reads and then assemble them
    inputBinding:
      position: 106
      prefix: -trim-assemble
  - id: trim_mode
    type:
      - 'null'
      - boolean
    doc: Generate trimmed reads
    inputBinding:
      position: 106
      prefix: -trim
  - id: trimmed_reads_flag
    type:
      - 'null'
      - boolean
    doc: Use trimmed reads
    inputBinding:
      position: 106
      prefix: -trimmed
  - id: use_grid
    type:
      - 'null'
      - string
    doc: Run under grid control (true), locally (false), or set up for grid 
      control but don't submit any jobs (remote)
    inputBinding:
      position: 106
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/canu:2.3--h3fb4750_2
stdout: canu_haplotype.out
