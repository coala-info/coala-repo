cwlVersion: v1.2
class: CommandLineTool
baseCommand: minc_modify_header
label: minc-tools_minc_modify_header
doc: "Modify the attributes in the header of a MINC file in place. The input file\
  \ is copied to the working directory and the modified copy is returned.\n\nTool homepage:\
  \ https://github.com/BIC-MNI/minc-tools"
inputs:
  - id: sinsert
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -sinsert
    doc: Insert string attribute (<var>:<attr>=<value>).
    inputBinding:
      position: 1
  - id: dinsert
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -dinsert
    doc: Insert a double precision attribute (<var>:<attr>=<value>(,...)).
    inputBinding:
      position: 2
  - id: delete
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -delete
    doc: Delete an attribute (<var>:<attr>).
    inputBinding:
      position: 3
  - id: sappend
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -sappend
    doc: Append string attribute (<var>:<attr>=<value>).
    inputBinding:
      position: 4
  - id: dappend
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -dappend
    doc: Append a double precision attribute (<var>:<attr>=<value>(,...)).
    inputBinding:
      position: 5
  - id: input_file
    type: File
    doc: MINC file to modify (<file.mnc>); a writable copy is edited
    inputBinding:
      position: 10
      valueFrom: $(self.basename)
outputs:
  - id: output_file
    type: File
    doc: The modified MINC file
    outputBinding:
      glob: $(inputs.input_file.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/minc-tools:v2.3.00dfsg-1.1b1-deb_cv1
