cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - xml
  - ed
label: xmlstarlet_ed
doc: "Edit or update XML document(s) using XPath actions\n\nTool homepage: http://xmlstar.sourceforge.net/"
inputs:
  - id: preserve_whitespace
    type:
      - 'null'
      - boolean
    doc: 'Preserve whitespace nodes (space between attributes is not preserved).'
    inputBinding:
      position: 1
      prefix: -P
  - id: omit_decl
    type:
      - 'null'
      - boolean
    doc: 'Omit XML declaration.'
    inputBinding:
      position: 1
      prefix: -O
  - id: net
    type:
      - 'null'
      - boolean
    doc: 'Allow network access.'
    inputBinding:
      position: 1
      prefix: --net
  - id: namespaces
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -N
    doc: 'Predefine namespaces as name=value (without xmlns:). Each item gets its own -N. -N options must be the last global options.'
    inputBinding:
      position: 2
  - id: actions
    type:
      type: array
      items: string
    doc: 'Actions in order, for example -u //a/@b -v newvalue. Actions: -d/--delete xpath, --var name xpath, -i/--insert xpath -t elem|text|attr -n name [-v value], -a/--append, -s/--subnode, -m/--move xpath1 xpath2, -r/--rename xpath -v new-name, -u/--update xpath -v value or -x xpath.'
    inputBinding:
      position: 3
  - id: xml_files
    type:
      type: array
      items: File
    doc: 'Input XML document file(s) or URI (stdin otherwise).'
    inputBinding:
      position: 4
outputs:
  - id: output
    type: stdout
    doc: Standard output of xml ed.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xmlstarlet:1.6.1
stdout: xmlstarlet_ed.out
