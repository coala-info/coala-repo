cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haplogrep3
  - annotation-index
label: haplogrep3_annotation-index
doc: "Build an index file for an annotation table.\n\nTool homepage: https://github.com/genepi/haplogrep3"
inputs:
  - id: file
    type: File
    doc: "file (the index is written next to it as <file>.index)"
    inputBinding:
      position: 101
      prefix: --file
  - id: start
    type: int
    doc: "start column"
    inputBinding:
      position: 101
      prefix: -s
  - id: skip
    type: int
    doc: "skip n lines"
    inputBinding:
      position: 101
      prefix: -S
outputs:
  - id: index
    type: File
    doc: "Index file (<file>.index)"
    outputBinding:
      glob: $(inputs.file.basename).index
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplogrep3:3.2.2--hdfd78af_1
