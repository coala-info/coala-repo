cwlVersion: v1.2
class: CommandLineTool
baseCommand: edit-bgen
label: bgen-cpp_edit-bgen
doc: "Edit bgen files.\n\nTool homepage: https://enkre.net/cgi-bin/code/bgen/"
inputs:
  - id: bgen_files
    type:
      type: array
      items: File
    doc: Path of bgen file(s) to edit.
    inputBinding:
      position: 101
      prefix: -g
  - id: really
    type:
      - 'null'
      - boolean
    doc: Really make changes (without this option a dry run is performed with no
      changes to files.)
    inputBinding:
      position: 101
      prefix: -really
  - id: remove_sample_identifiers
    type:
      - 'null'
      - boolean
    doc: Remove sample identifiers from the file. This zeroes out the sample ID 
      block, if present.
    inputBinding:
      position: 101
      prefix: -remove-sample-identifiers
  - id: set_free_data
    type:
      - 'null'
      - string
    doc: Set new 'free data' field. The argument must be a string with length 
      exactly equal to the length of the existing free data field in each edited
      file.
    inputBinding:
      position: 101
      prefix: -set-free-data
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bgen-cpp:1.1.7--h5ca1c30_0
stdout: bgen-cpp_edit-bgen.out
