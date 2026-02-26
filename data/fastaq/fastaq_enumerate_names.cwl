cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq enumerate_names
label: fastaq_enumerate_names
doc: "Renames sequences in a file, calling them 1,2,3... etc\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of fasta/q file to be read
    inputBinding:
      position: 1
  - id: keep_suffix
    type:
      - 'null'
      - boolean
    doc: Use this to keep a /1 or /2 suffix at the end of each name
    inputBinding:
      position: 102
      prefix: --keep_suffix
  - id: rename_file
    type:
      - 'null'
      - File
    doc: If used, will write a file of old name to new name
    inputBinding:
      position: 102
      prefix: --rename_file
  - id: start_index
    type:
      - 'null'
      - int
    doc: Starting number
    default: 1
    inputBinding:
      position: 102
      prefix: --start_index
  - id: suffix
    type:
      - 'null'
      - string
    doc: Add the given string to the end of every name
    inputBinding:
      position: 102
      prefix: --suffix
outputs:
  - id: outfile
    type: File
    doc: Name of output fasta/q file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
