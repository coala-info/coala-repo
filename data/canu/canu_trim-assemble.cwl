cwlVersion: v1.2
class: CommandLineTool
baseCommand: canu
label: canu_trim-assemble
doc: "Canu is a de novo assembler for long, noisy reads. It is designed to assemble
  genomes from PacBio, Nanopore, and other long-read technologies. It can also be
  used to assemble genomes from short reads, but it is not as efficient as other short-read
  assemblers.\n\nTool homepage: https://github.com/marbl/canu"
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
    doc: Haplotype-specific Illumina read files
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
    doc: Assembly directory
    inputBinding:
      position: 103
      prefix: -d
  - id: assembly_prefix
    type: string
    doc: Assembly prefix
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
      Assemblies of low coverage or data with biological differences will 
      benefit from a slight increase in this. Defaults are 0.045 for PacBio 
      reads and 0.144 for Nanopore reads.
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
    doc: Genome size (e.g., 1g, 4.7m, 4700000)
    inputBinding:
      position: 103
  - id: grid_options
    type:
      - 'null'
      - string
    doc: Pass string to the command used to submit jobs to the grid. Can be used
      to set maximum run time limits. Should NOT be used to set memory limits; 
      Canu will do that for you.
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
    doc: Name for the haplotype (letters and numbers only)
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
  - id: nanopore_reads
    type:
      - 'null'
      - boolean
    doc: Use Nanopore reads
    inputBinding:
      position: 103
  - id: pacbio_hifi_reads
    type:
      - 'null'
      - boolean
    doc: Use PacBio HiFi reads
    inputBinding:
      position: 103
  - id: pacbio_reads
    type:
      - 'null'
      - boolean
    doc: Use PacBio reads
    inputBinding:
      position: 103
  - id: raw_error_rate
    type:
      - 'null'
      - float
    doc: The allowed difference in an overlap between two raw uncorrected reads.
      For lower quality reads, use a higher number. The defaults are 0.300 for 
      PacBio reads and 0.500 for Nanopore reads.
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
stdout: canu_trim-assemble.out
