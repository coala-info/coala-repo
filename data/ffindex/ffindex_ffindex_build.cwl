cwlVersion: v1.2
class: CommandLineTool
baseCommand: ffindex_build
label: ffindex_ffindex_build
doc: "Build a file index (ffindex): store many small files in one data file and write\
  \ a text index with name, offset and length of each file.\n\nTool homepage: https://github.com/soedinglab/ffindex_soedinglab"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.existing_data)
        entryname: $(inputs.out_data_file)
        writable: true
      - entry: $(inputs.existing_index)
        entryname: $(inputs.out_index_file)
        writable: true
      - entry: $(inputs.input_files)
      - entry: $(inputs.input_directories)
      - entry: $(inputs.file_lists)
      - entry: $(inputs.second_data)
      - entry: $(inputs.second_index)
inputs:
  - id: out_data_file
    type: string
    doc: Name of the output data file (OUT_DATA_FILE)
    inputBinding:
      position: 1
  - id: out_index_file
    type: string
    doc: Name of the output index file (OUT_INDEX_FILE)
    inputBinding:
      position: 2
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to add to the index; they are staged in the working directory
      and indexed by their file names
    inputBinding:
      position: 103
      valueFrom: |
        $(self.map(function(f) { return f.basename; }))
  - id: input_directories
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Directories whose files are added to the index; they are staged in the
      working directory
    inputBinding:
      position: 104
      valueFrom: |
        $(self.map(function(f) { return f.basename; }))
  - id: append
    type:
      - 'null'
      - boolean
    doc: append files/indexes, also needed for sorting an already existing ffindex
    inputBinding:
      position: 101
      prefix: -a
  - id: sort
    type:
      - 'null'
      - boolean
    doc: sort index file, so that the index can be queried
    inputBinding:
      position: 101
      prefix: -s
  - id: file_lists
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -f
          valueFrom: $(self.basename)
    doc: file each line containing a filename (-f can be given several times);
      the listed files must be given as input files
    inputBinding:
      position: 101
  - id: second_data
    type:
      - 'null'
      - File
    doc: a second ffindex data file for inserting/appending
    inputBinding:
      position: 102
      prefix: -d
      valueFrom: $(self.basename)
  - id: second_index
    type:
      - 'null'
      - File
    doc: a second ffindex index file for inserting/appending
    inputBinding:
      position: 102
      prefix: -i
      valueFrom: $(self.basename)
  - id: existing_data
    type:
      - 'null'
      - File
    doc: Existing data file to extend or sort (used with append); it is copied
      to out_data_file
  - id: existing_index
    type:
      - 'null'
      - File
    doc: Existing index file to extend or sort (used with append); it is copied
      to out_index_file
outputs:
  - id: data_file
    type: File
    doc: The output data file with the concatenated file contents
    outputBinding:
      glob: $(inputs.out_data_file)
  - id: index_file
    type: File
    doc: The output index file with names, offsets and lengths
    outputBinding:
      glob: $(inputs.out_index_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ffindex:0.98--h9948957_5
