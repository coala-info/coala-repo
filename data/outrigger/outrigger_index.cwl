cwlVersion: v1.2
class: CommandLineTool
baseCommand: outrigger_index
label: outrigger_index
doc: "Build an index of alternative splicing events from splice junction data.\n\n\
  Tool homepage: https://yeolab.github.io/outrigger"
inputs:
  - id: bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Location of bam files to use for finding events.
    inputBinding:
      position: 101
      prefix: --bam
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'If given, print debugging logging information to standard out (Warning:
      LOTS of output. Not recommended unless you think something is going wrong)'
    inputBinding:
      position: 101
      prefix: --debug
  - id: force
    type:
      - 'null'
      - boolean
    doc: If the 'outrigger index' command was interrupted, there will be 
      intermediate files remaining. If you wish to restart outrigger and 
      overwrite them all, use this flag. If you want to continue from where you 
      left off, use the '--resume' flag. If neither is specified, the program 
      exits and complains to the user.
    inputBinding:
      position: 101
      prefix: --force
  - id: gffutils_db
    type:
      - 'null'
      - File
    doc: Name of the gffutils database file you want to use. The exon IDs 
      defined here will be used in the function when creating splicing event 
      names. Not required if you provide a gtf file with '--gtf-filename'
    inputBinding:
      position: 101
      prefix: --gffutils-db
  - id: gtf_filename
    type:
      - 'null'
      - File
    doc: Name of the gtf file you want to use. If a gffutils feature database 
      doesn't already exist at this location plus '.db' (e.g. if your gtf is 
      gencode.v19.annotation.gtf, then the database is inferred to be 
      gencode.v19.annotation.gtf.db), then a database will be auto-created. Not 
      required if you provide a pre-built database with '--gffutils-db'
    inputBinding:
      position: 101
      prefix: --gtf-filename
  - id: ignore_multimapping
    type:
      - 'null'
      - boolean
    doc: Applies to STAR SJ.out.tab files only. If this flag is used, then do 
      not include reads that mapped to multiple locations in the genome, not 
      uniquely to a locus, in the read count for a junction. If inputting "bam" 
      files, then this means that reads with a mapping quality (MAPQ) of less 
      than 255 are considered "multimapped." This is the same thing as what the 
      STAR aligner does. By default, this is off, and all reads are used.
    inputBinding:
      position: 101
      prefix: --ignore-multimapping
  - id: junction_reads_csv
    type:
      - 'null'
      - File
    doc: Name of the splice junction files to detect novel exons and build an 
      index of alternative splicing events from. Not required if you specify 
      SJ.out.tab file with '--sj-out-tab'
    inputBinding:
      position: 101
      prefix: --junction-reads-csv
  - id: low_memory
    type:
      - 'null'
      - boolean
    doc: If set, then use a smaller memory footprint. By default, this is off.
    inputBinding:
      position: 101
      prefix: --low-memory
  - id: max_de_novo_exon_length
    type:
      - 'null'
      - int
    doc: Maximum length of an exon detected *de novo* from the dataset. This is 
      to prevent multiple kilobase long exons from being accidentally created.
    inputBinding:
      position: 101
      prefix: --max-de-novo-exon-length
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Minimum number of reads per junction for that junction to count in 
      creating the index of splicing events
    inputBinding:
      position: 101
      prefix: --min-reads
  - id: n_jobs
    type:
      - 'null'
      - int
    doc: Number of threads to use when parallelizing exon finding and file 
      reading. Default is -1, which means to use as many threads as are 
      available.
    inputBinding:
      position: 101
      prefix: --n-jobs
  - id: resume
    type:
      - 'null'
      - boolean
    doc: If the 'outrigger index' command was interrupted, there will be 
      intermediate files remaining. If you want to continue from where you left 
      off, use this flag. The default action is to do nothing and ask the user 
      for input.
    inputBinding:
      position: 101
      prefix: --resume
  - id: sj_out_tab
    type:
      - 'null'
      - type: array
        items: File
    doc: SJ.out.tab files from STAR aligner output. Not required if you specify 
      "--compiled-junction-reads"
    inputBinding:
      position: 101
      prefix: --sj-out-tab
  - id: splice_types
    type:
      - 'null'
      - string
    doc: Which splice types to find. By default, "all" are used which at this 
      point is skipped exon (SE) and mutually exclusive exon (MXE) events. Can 
      also specify only one, e.g. "se" or both "se,mxe"
    inputBinding:
      position: 101
      prefix: --splice-types
outputs:
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Name of the folder where you saved the output from "outrigger index" 
      (default is ./outrigger_output, which is relative to the directory where 
      you called the program)". You will need this file for the next step, 
      "outrigger psi"
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/outrigger:1.1.1--py35_0
