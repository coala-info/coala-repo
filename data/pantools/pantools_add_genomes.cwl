cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - add_genomes
label: pantools_add_genomes
doc: "Add additional genomes to an existing pangenome. Required software: KMC 3.1.0\
  \ or higher.\n\nTool homepage: https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool changes it) and returned as the output.
    inputBinding:
      position: 1
  - id: genomes_file
    type: File
    doc: A text file containing paths to FASTA files of genomes to be added to the
      pangenome; each on a separate line.
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: genome_fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: The genome FASTA files named in the genomes file, and the FASTA files of
      the genomes already in the pangenome (the tool reads them again to update the
      database). They are staged in the working directory, so the list file can name
      them by file name.
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
  - id: scratch_directory
    type:
      - 'null'
      - string
    doc: Temporary directory for storing intermediate files.
    inputBinding:
      position: 102
      prefix: --scratch-directory=
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
      - entry: $(inputs.genomes_file)
        writable: true
      - $(inputs.genome_fasta_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
stdout: pantools_add_genomes.log
