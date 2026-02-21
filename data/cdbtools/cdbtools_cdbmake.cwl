cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdbmake
label: cdbtools_cdbmake
doc: "A tool for creating constant databases (cdb). It reads a series of encoded records
  from standard input and writes a constant database to a specified output file.\n
  \nTool homepage: https://github.com/philpennock/cdbtools"
inputs:
  - id: temp_file
    type: File
    doc: A temporary file used during the creation of the database; it will be renamed
      to the output_file upon completion.
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type: File
    doc: The name of the constant database file to be created.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdbtools:0.99--h077b44d_12
