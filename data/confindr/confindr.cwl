cwlVersion: v1.2
class: CommandLineTool
baseCommand: confindr
label: confindr
doc: "Check for contamination in fastq files.\n\nTool homepage: https://github.com/lowandrew/ConFindr"
inputs:
  - id: base_cutoff
    type:
      - 'null'
      - int
    doc: Number of bases necessary to support a multiple allele call, and 
      automatically increments based upon gene-specific quality score, length 
      and depth of coverage. Default is 3.
    default: 3
    inputBinding:
      position: 101
      prefix: --base_cutoff
  - id: base_fraction_cutoff
    type:
      - 'null'
      - float
    doc: Fraction of bases necessary to support a multiple allele call. 
      Particularly useful when dealing with very high coverage samples. Default 
      is 0.05.
    default: 0.05
    inputBinding:
      position: 101
      prefix: --base_fraction_cutoff
  - id: cgmlst_database
    type:
      - 'null'
      - File
    doc: Path to a cgMLST database to use for contamination detection instead of
      using the default rMLST database. Sequences in this file should have 
      headers in format >genename_allelenumber. To speed up ConFindr runs, 
      clustering the cgMLST database with CD-HIT before running ConFindr is 
      recommended. This is highly experimental, results should be interpreted 
      with great care.
    inputBinding:
      position: 101
      prefix: --cgmlst
  - id: data_type
    type:
      - 'null'
      - string
    doc: Type of input data. Default is Illumina, but can be used for Nanopore 
      too. No PacBio support (yet).
    default: Illumina
    inputBinding:
      position: 101
      prefix: --data_type
  - id: databases
    type:
      - 'null'
      - Directory
    doc: Databases folder. To download these, you will need to get access to the
      rMLST databases. For complete instructions on how to do this, please see 
      https://olc-bioinformatics.github.io/ConFindr/install/#downloading-confindr-databases
    inputBinding:
      position: 101
      prefix: --databases
  - id: error_cutoff
    type:
      - 'null'
      - float
    doc: Value to use for the calculated error cutoff when setting the base 
      cutoff value. Default is 1.0%.
    default: 1.0
    inputBinding:
      position: 101
      prefix: --error_cutoff
  - id: forward_id
    type:
      - 'null'
      - string
    doc: Identifier for forward reads.
    inputBinding:
      position: 101
      prefix: --forward_id
  - id: input_directory
    type: Directory
    doc: Folder that contains fastq files you want to check for contamination. 
      Will find any file that contains .fq or .fastq in the filename.
    inputBinding:
      position: 101
      prefix: --input_directory
  - id: jvm_memory
    type:
      - 'null'
      - string
    doc: Very occasionally, parts of the pipeline that use the BBMap suite will 
      have their memory reservation fail and request not enough, or sometimes 
      negative, memory. If this happens to you, you can use this flag to 
      override automatic memory reservation and use an amount of memory 
      requested by you. -Xmx 20g will specify 20 gigs of RAM, and -Xmx 800m will
      specify 800 megs.
    inputBinding:
      position: 101
      prefix: --Xmx
  - id: keep_files
    type:
      - 'null'
      - boolean
    doc: By default, intermediate files are deleted. Activate this flag to keep 
      intermediate files.
    inputBinding:
      position: 101
      prefix: --keep_files
  - id: min_matching_hashes
    type:
      - 'null'
      - int
    doc: Minimum number of matching hashes in a MASH screen in order for a genus
      to be considered present in a sample. Default is 150
    default: 150
    inputBinding:
      position: 101
      prefix: --min_matching_hashes
  - id: output_name
    type: string
    doc: Base name for output/temporary directories.
    inputBinding:
      position: 101
      prefix: --output_name
  - id: prefer_rmlst
    type:
      - 'null'
      - boolean
    doc: Activate to prefer using rMLST databases over core-gene derived 
      databases. By default,ConFindr will use core-gene derived databases where 
      available.
    inputBinding:
      position: 101
      prefix: --rmlst
  - id: quality_cutoff
    type:
      - 'null'
      - int
    doc: Base quality needed to support a multiple allele call. Defaults to 20.
    default: 20
    inputBinding:
      position: 101
      prefix: --quality_cutoff
  - id: reverse_id
    type:
      - 'null'
      - string
    doc: Identifier for reverse reads.
    inputBinding:
      position: 101
      prefix: --reverse_id
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to run analysis with.
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp_directory
    type:
      - 'null'
      - Directory
    doc: If your ConFindr databases are in a location you don't have write 
      access to, you can enter this option to specify a temporary directory to 
      put genus-specific databases to.
    inputBinding:
      position: 101
      prefix: --tmp
  - id: use_fasta
    type:
      - 'null'
      - boolean
    doc: If activated, will look for FASTA files instead of FASTQ for unpaired 
      reads.
    inputBinding:
      position: 101
      prefix: --fasta
  - id: verbosity
    type:
      - 'null'
      - string
    doc: Amount of output you want printed to the screen. Defaults to info, 
      which should be good for most users.
    default: info
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/confindr:0.8.2--pyhdfd78af_0
stdout: confindr.out
