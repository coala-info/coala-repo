cwlVersion: v1.2
class: CommandLineTool
baseCommand: ffindex_modify
label: ffindex_ffindex_modify
doc: "Modify an ffindex index file: sort it or unlink entries (remove them from the\
  \ index only).\n\nTool homepage: https://github.com/soedinglab/ffindex_soedinglab"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.index_file)
        writable: true
      - entry: $(inputs.file_lists)
inputs:
  - id: index_file
    type: File
    doc: ffindex index file; a modified copy is returned
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: entry_names
    type:
      - 'null'
      - type: array
        items: string
    doc: Entry names to modify (to unlink with -u)
    inputBinding:
      position: 3
  - id: sort
    type:
      - 'null'
      - boolean
    doc: sort index file
    inputBinding:
      position: 1
      prefix: -s
  - id: unlink
    type:
      - 'null'
      - boolean
    doc: unlink entry (remove from index only)
    inputBinding:
      position: 1
      prefix: -u
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
      position: 1
outputs:
  - id: modified_index
    type: File
    doc: The modified index file
    outputBinding:
      glob: $(inputs.index_file.basename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ffindex:0.98--h9948957_5
