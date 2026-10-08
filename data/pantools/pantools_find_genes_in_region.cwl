cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - find_genes_in_region
label: pantools_find_genes_in_region
doc: "Find genes in a given genomic region.\n\nTool homepage: https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool changes it) and returned as the output.
    inputBinding:
      position: 1
  - id: regions_file
    type: File
    doc: 'A text file containing genome locations with on each line: a genome number,
      sequence number, begin and end position, separated by a space.'
    inputBinding:
      position: 2
  - id: partial
    type:
      - 'null'
      - boolean
    doc: Also retrieve genes that only partially overlap the input regions.
    inputBinding:
      position: 102
      prefix: --partial
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
stdout: pantools_find_genes_in_region.log
