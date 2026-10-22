cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sketchlib
  - delete
label: sketchlib_delete
doc: "Delete genome(s) from a database (input: one id per line)\n\nTool homepage: https://github.com/bacpop/sketchlib.rust"
inputs:
  - id: db
    type: File
    secondaryFiles:
      - ^.skd
    doc: Sketching database (.skm file with its .skd file beside it); the tool takes the basename, so the .skm suffix is removed on the command line.
    inputBinding:
      position: 1
      valueFrom: $(self.path.replace(/\.skm$/, ''))
  - id: samples
    type: File
    doc: Input file with IDs to delete (one ID per line)
    inputBinding:
      position: 2
  - id: output_file
    type: string
    doc: Output file name (prefix of the new .skm and .skd files)
    inputBinding:
      position: 3
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't show any messages
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show progress messages
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      type: array
      items: File
    doc: Sketch files (.skm and .skd) of the database without the deleted samples
    outputBinding:
      glob: $(inputs.output_file)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sketchlib:0.2.4--h4349ce8_0
