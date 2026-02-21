cwlVersion: v1.2
class: CommandLineTool
baseCommand: ffindex_build
label: ffindex_ffindex_build
doc: "Build a file index (ffindex) from files in a directory or a list of files.\n
  \nTool homepage: https://github.com/soedinglab/ffindex_soedinglab"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Individual files to be added to the index (alternative to -d or -f).
    inputBinding:
      position: 1
  - id: append
    type:
      - 'null'
      - boolean
    doc: Append to existing index and data files.
    inputBinding:
      position: 102
      prefix: -a
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing the files to be indexed.
    inputBinding:
      position: 102
      prefix: -d
  - id: file_list
    type:
      - 'null'
      - File
    doc: File containing a list of filenames to include in the index.
    inputBinding:
      position: 102
      prefix: -f
  - id: sort
    type:
      - 'null'
      - boolean
    doc: Sort the index file by name.
    inputBinding:
      position: 102
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose progress information.
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: data_filename
    type: File
    doc: The output data file containing the concatenated file contents.
    outputBinding:
      glob: '*.out'
  - id: index_filename
    type: File
    doc: The output index file containing the offsets and lengths.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ffindex:0.98--h9948957_5
