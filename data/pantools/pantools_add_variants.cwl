cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - add_variants
label: pantools_add_variants
doc: "Add variant data to the pangenome. Required software: bcftools, tabix.\n\nTool\
  \ homepage: https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool changes it) and returned as the output.
    inputBinding:
      position: 1
  - id: vcf_locations_file
    type: File
    doc: A text file with on each line a genome number and the file name of the corresponding
      VCF file, separated by a space.
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: vcf_files
    type:
      - 'null'
      - type: array
        items: File
    doc: The VCF files named in the list file. Files without a tabix index are indexed
      in the working directory. They are staged in the working directory, so the list
      file can name them by file name.
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
  - id: keep_intermediate_files
    type:
      - 'null'
      - boolean
    doc: Do not delete intermediate files.
    inputBinding:
      position: 102
      prefix: --keep-intermediate-files
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
      - entry: $(inputs.vcf_locations_file)
        writable: true
      - $(inputs.vcf_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
stdout: pantools_add_variants.log
