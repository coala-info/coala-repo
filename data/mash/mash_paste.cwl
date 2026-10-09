cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mash
  - paste
label: mash_paste
doc: "Create a single sketch file from multiple sketch files.\n\nTool homepage: https://github.com/marbl/Mash"
inputs:
  - id: out_prefix
    type: string
    doc: Output sketch prefix
    inputBinding:
      position: 1
  - id: sketch
    type:
      type: array
      items: File
    doc: Input sketch file(s)
    inputBinding:
      position: 2
  - id: input_lists
    type:
      - 'null'
      - boolean
    doc: Input files are lists of file names.
    inputBinding:
      position: 103
      prefix: -l
outputs:
  - id: pasted_sketch
    type:
      - 'null'
      - File
    doc: Pasted sketch file (<out_prefix>.msh)
    outputBinding:
      glob: $(inputs.out_prefix).msh
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mash:2.3--hb105d93_10
stdout: mash_paste.out
