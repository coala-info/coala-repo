cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - enumerate_names
label: pyfastaq_fastaq_enumerate_names
doc: "Renames sequences in a file, calling them 1,2,3... etc\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: start_index
    type:
      - 'null'
      - int
    doc: "Starting number [1]"
    inputBinding:
      position: 1
      prefix: --start_index
  - id: rename_file
    type:
      - 'null'
      - string
    doc: "If used, will write a file of old name to new name"
    inputBinding:
      position: 2
      prefix: --rename_file
  - id: keep_suffix
    type:
      - 'null'
      - boolean
    doc: "Use this to keep a /1 or /2 suffix at the end of each name"
    inputBinding:
      position: 3
      prefix: --keep_suffix
  - id: suffix
    type:
      - 'null'
      - string
    doc: "Add the given string to the end of every name"
    inputBinding:
      position: 4
      prefix: --suffix
  - id: infile
    type: File
    doc: "Name of fasta/q file to be read"
    inputBinding:
      position: 20
  - id: outfile
    type: string
    doc: "Name of output fasta/q file"
    inputBinding:
      position: 21
outputs:
  - id: rename_output
    type:
      - 'null'
      - File
    doc: "If used, will write a file of old name to new name"
    outputBinding:
      glob: $(inputs.rename_file)
  - id: output
    type: File
    doc: "Name of output fasta/q file"
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
