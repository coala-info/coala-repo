cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - panaln
  - index
label: panaln_index
doc: "Index a pan-genome file\n\nTool homepage: https://github.com/Lilu-guo/Panaln"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_pan)
        writable: true
inputs:
  - id: input_pan
    type: File
    doc: Input pan-genome file (<basename>.pan, with <basename>.aux beside it). The index files are written beside it.
    secondaryFiles:
      - pattern: ^.aux
        required: true
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: index_files
    type:
      type: array
      items: File
    doc: Index files (<basename>.1.idx to <basename>.9.idx)
    outputBinding:
      glob: $(inputs.input_pan.nameroot).*.idx
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panaln:2.09--h5ca1c30_0
stdout: panaln_index.out
