cwlVersion: v1.2
class: CommandLineTool
baseCommand: ffindex_unpack
label: ffindex_ffindex_unpack
doc: "Unpack all entries of an ffindex into files in an output directory.\n\nTool\
  \ homepage: https://github.com/soedinglab/ffindex_soedinglab"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.out_dir)
        entry: '$({class: "Directory", listing: []})'
        writable: true
inputs:
  - id: data_file
    type: File
    doc: ffindex data file
    inputBinding:
      position: 1
  - id: index_file
    type: File
    doc: ffindex index file
    inputBinding:
      position: 2
  - id: out_dir
    type: string
    doc: Name of the output directory
    inputBinding:
      position: 3
outputs:
  - id: unpacked
    type: Directory
    doc: Directory with one file per ffindex entry
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ffindex:0.98--h9948957_5
