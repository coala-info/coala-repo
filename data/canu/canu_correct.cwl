cwlVersion: v1.2
class: CommandLineTool
baseCommand: canu
label: canu_correct
doc: "To restrict canu to only a specific stage, use:\n    -haplotype     - generate
  haplotype-specific reads\n    -correct       - generate corrected reads\n    -trim\
  \          - generate trimmed reads\n    -assemble      - generate an assembly\n\
  \    -trim-assemble - generate trimmed reads and then assemble them\n\nTool homepage:
  https://github.com/marbl/canu"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input files (FASTA or FASTQ format, uncompressed, or compressed with 
      gz, bz2 or xz)
    inputBinding:
      position: 1
  - id: haplotype_illumina_files
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
      prefix: -assemble
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
      position: 103
  - id: corrected_reads
    type:
      - 'null'
      - boolean
    doc: Indicates corrected reads
    inputBinding:
      position: 103
      prefix: -corrected
  - id: genome_size
    type: string
    doc: "The genome size should be your best guess of the haploid genome size of
      what is being assembled. It is used primarily to estimate coverage in reads,
      NOT as the desired assembly size. Fractional values are allowed: '4.7m' equals
      '4700k' equals '4700000'"
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
      prefix: -haplotype
  - id: haplotype_name
    type:
      - 'null'
      - string
    doc: Haplotype name for TrioCanu
    inputBinding:
      position: 103
      prefix: -haplotype{NAME}
  - id: min_overlap_length
    type:
      - 'null'
      - int
    doc: Ignore read-to-read overlaps shorter than 'number' bases long.
    inputBinding:
      position: 103
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Ignore reads shorter than 'number' bases long.
    inputBinding:
      position: 103
  - id: nanopore
    type:
      - 'null'
      - boolean
    doc: Specify Nanopore technology
    inputBinding:
      position: 103
      prefix: -nanopore
  - id: pacbio
    type:
      - 'null'
      - boolean
    doc: Specify PacBio technology
    inputBinding:
      position: 103
      prefix: -pacbio
  - id: pacbio_hifi
    type:
      - 'null'
      - boolean
    doc: Specify PacBio HiFi technology
    inputBinding:
      position: 103
      prefix: -pacbio-hifi
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
      prefix: -trim-assemble
  - id: trim_mode
    type:
      - 'null'
      - boolean
    doc: Generate trimmed reads
    inputBinding:
      position: 103
      prefix: -trim
  - id: trimmed_reads
    type:
      - 'null'
      - boolean
    doc: Indicates trimmed reads
    inputBinding:
      position: 103
      prefix: -trimmed
  - id: use_grid
    type:
      - 'null'
      - string
    doc: Run under grid control (true), locally (false), or set up for grid 
      control but don't submit any jobs (remote)
    inputBinding:
      position: 103
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/canu:2.3--h3fb4750_2
stdout: canu_correct.out
