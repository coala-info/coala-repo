cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - add_pavs
label: pantools_add_pavs
doc: "Add PAV data to the pangenome.\n\nTool homepage: https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool changes it) and returned as the output.
    inputBinding:
      position: 1
  - id: pav_locations_file
    type: File
    doc: A text file with on each line a genome number and the file name of the corresponding
      PAV file, separated by a space.
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: pav_files
    type:
      - 'null'
      - type: array
        items: File
    doc: The PAV files named in the list file. They are staged in the working directory,
      so the list file can name them by file name.
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
      - entry: $(inputs.pav_locations_file)
        writable: true
      - $(inputs.pav_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
stdout: pantools_add_pavs.log
