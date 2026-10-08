cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - retrieve_regions
label: pantools_retrieve_regions
doc: "Retrieve the sequence of genomic regions from the pangenome.\n\nTool homepage:\
  \ https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool writes its results inside it) and returned as the output.
    inputBinding:
      position: 1
  - id: regions_file
    type: File
    doc: 'A text file containing genome locations with on each line: a genome number,
      sequence number, begin and end position, separated by a space.'
    inputBinding:
      position: 2
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
stdout: pantools_retrieve_regions.log
