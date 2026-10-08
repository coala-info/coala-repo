cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - blast
label: pantools_blast
doc: "Search sequences in the database using BLAST. Required software: BLAST suite.\n\
  \nTool homepage: https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool changes it) and returned as the output.
    inputBinding:
      position: 1
  - id: fasta_file
    type: File
    doc: A (multi) FASTA file with nucleotide or protein sequences.
    inputBinding:
      position: 2
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel working threads, default is the number of cores or 8,
      whichever is lower.
    inputBinding:
      position: 102
      prefix: --threads=
      separate: false
  - id: selection_file
    type:
      - 'null'
      - File
    doc: Text file with rules to use a specific set of genomes and sequences. This
      automatically lowers the threshold for core genes.
    inputBinding:
      position: 102
      prefix: --selection-file=
      separate: false
  - id: include
    type:
      - 'null'
      - string
    doc: Only include a selection of genomes (for example 1,2).
    inputBinding:
      position: 102
      prefix: --include=
      separate: false
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude a selection of genomes (for example 3,4).
    inputBinding:
      position: 102
      prefix: --exclude=
      separate: false
  - id: alignment_threshold
    type:
      - 'null'
      - int
    doc: Minimum required alignment length as compared to the input query. Range 1-100.
    inputBinding:
      position: 102
      prefix: --alignment-threshold=
      separate: false
  - id: minimum_identity
    type:
      - 'null'
      - int
    doc: Minimum required sequence identity. Range 1-100.
    inputBinding:
      position: 102
      prefix: --minimum-identity=
      separate: false
  - id: rebuild
    type:
      - 'null'
      - boolean
    doc: Rebuild the BLAST databases.
    inputBinding:
      position: 102
      prefix: --rebuild
  - id: mode
    type:
      - 'null'
      - string
    doc: BLAST mode (BLASTN, BLASTP, BLASTX, TBLASTX or TBLASTN). Without it, BLASTN
      or BLASTP is used depending on the input sequences.
    inputBinding:
      position: 102
      prefix: --mode=
      separate: false
outputs:
  - id: database
    type: Directory
    doc: The pangenome database, with the results written inside it.
    outputBinding:
      glob: $(inputs.database_directory.basename)
  - id: log
    type: stdout
    doc: Standard output (run log)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database_directory)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
stdout: pantools_blast.log
