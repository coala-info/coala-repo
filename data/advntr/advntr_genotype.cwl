cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - advntr
  - genotype
label: advntr_genotype
doc: "Genotype VNTRs from sequencing data\n\nTool homepage: https://github.com/mehrdadbakhtiari/adVNTR"
inputs:
  - id: alignment_file
    type:
      - 'null'
      - File
    doc: alignment file in SAM/BAM/CRAM format
    inputBinding:
      position: 101
      prefix: --alignment_file
  - id: coverage
    type:
      - 'null'
      - float
    doc: average sequencing coverage in PCR-free sequencing
    inputBinding:
      position: 101
      prefix: --coverage
  - id: disable_logging
    type:
      - 'null'
      - boolean
    doc: set this flag to stop writing to log file except for critical errors.
    inputBinding:
      position: 101
      prefix: --disable_logging
  - id: expansion
    type:
      - 'null'
      - boolean
    doc: set this flag to determine long expansion from PCR-free data
    inputBinding:
      position: 101
      prefix: --expansion
  - id: fasta
    type:
      - 'null'
      - File
    doc: Fasta file containing raw reads
    inputBinding:
      position: 101
      prefix: --fasta
  - id: frameshift
    type:
      - 'null'
      - boolean
    doc: 'set this flag to search for frameshifts in VNTR instead of copy number.
      Supported VNTR IDs: [25561, 519759]'
    inputBinding:
      position: 101
      prefix: --frameshift
  - id: haploid
    type:
      - 'null'
      - boolean
    doc: set this flag if the organism is haploid
    inputBinding:
      position: 101
      prefix: --haploid
  - id: log_pacbio_reads
    type:
      - 'null'
      - boolean
    doc: set this flag to store the PacBio read information for genotyping in 
      the log files. Note that it might lead to very large log files due to the 
      length of the PacBio reads.
    inputBinding:
      position: 101
      prefix: --log_pacbio_reads
  - id: models
    type:
      - 'null'
      - File
    doc: VNTR models file
    inputBinding:
      position: 101
      prefix: --models
  - id: naive
    type:
      - 'null'
      - boolean
    doc: use naive approach for PacBio reads
    inputBinding:
      position: 101
      prefix: --naive
  - id: nanopore
    type:
      - 'null'
      - boolean
    doc: set this flag if input file contains Nanopore MinION reads instead of 
      Illumina
    inputBinding:
      position: 101
      prefix: --nanopore
  - id: outfmt
    type:
      - 'null'
      - string
    doc: output format. Allowed values are {text, bed, vcf}
    inputBinding:
      position: 101
      prefix: --outfmt
  - id: pacbio
    type:
      - 'null'
      - boolean
    doc: set this flag if input file contains PacBio reads instead of Illumina 
      reads
    inputBinding:
      position: 101
      prefix: --pacbio
  - id: reference_filename
    type:
      - 'null'
      - File
    doc: path to a FASTA-formatted reference file for CRAM files. It overrides 
      filename specified in header, which is normally used to find the reference
    inputBinding:
      position: 101
      prefix: --reference_filename
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: update
    type:
      - 'null'
      - boolean
    doc: set this flag to iteratively update the model
    inputBinding:
      position: 101
      prefix: --update
  - id: vntr_id
    type:
      - 'null'
      - type: array
        items: string
    doc: comma-separated list of VNTR IDs
    inputBinding:
      position: 101
      prefix: --vntr_id
  - id: working_directory
    type:
      - 'null'
      - Directory
    doc: working directory for creating temporary files needed for computation
    inputBinding:
      position: 101
      prefix: --working_directory
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: file to write results. adVNTR writes output to stdout if oufile is not 
      specified.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/advntr:1.5.0--py310ha6711e0_1
