cwlVersion: v1.2
class: CommandLineTool
baseCommand: minc_modify_header
label: minc-tools_minc_modify_header
doc: "Modify the header of a MINC file. (Note: The provided help text contained container
  execution errors; arguments are based on standard tool documentation).\n\nTool homepage:
  https://github.com/BIC-MNI/minc"
inputs:
  - id: input_file
    type: File
    doc: Input MINC file to modify
    inputBinding:
      position: 1
  - id: dappend
    type:
      - 'null'
      - type: array
        items: string
    doc: "Append to a double precision attribute: -dappend 'var:attr=value'"
    inputBinding:
      position: 102
      prefix: -dappend
  - id: delete
    type:
      - 'null'
      - type: array
        items: string
    doc: "Delete an attribute: -delete 'var:attr'"
    inputBinding:
      position: 102
      prefix: -delete
  - id: dinsert
    type:
      - 'null'
      - type: array
        items: string
    doc: "Insert a double precision attribute: -dinsert 'var:attr=value'"
    inputBinding:
      position: 102
      prefix: -dinsert
  - id: sappend
    type:
      - 'null'
      - type: array
        items: string
    doc: "Append to a string attribute: -sappend 'var:attr=value'"
    inputBinding:
      position: 102
      prefix: -sappend
  - id: sinsert
    type:
      - 'null'
      - type: array
        items: string
    doc: "Insert a string attribute: -sinsert 'var:attr=value'"
    inputBinding:
      position: 102
      prefix: -sinsert
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/minc-tools:v2.3.00dfsg-1.1b1-deb_cv1
stdout: minc-tools_minc_modify_header.out
