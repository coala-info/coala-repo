cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - xml
  - tr
label: xmlstarlet_tr
doc: "Transform XML document(s) using an XSLT stylesheet\n\nTool homepage: http://xmlstar.sourceforge.net/"
inputs:
  - id: omit_decl
    type:
      - 'null'
      - boolean
    doc: 'Omit xml declaration.'
    inputBinding:
      position: 1
      prefix: --omit-decl
  - id: embed
    type:
      - 'null'
      - boolean
    doc: 'Allow applying embedded stylesheet.'
    inputBinding:
      position: 1
      prefix: --embed
  - id: show_ext
    type:
      - 'null'
      - boolean
    doc: 'Show list of extensions.'
    inputBinding:
      position: 1
      prefix: --show-ext
  - id: val
    type:
      - 'null'
      - boolean
    doc: 'Allow validating against DTDs or schemas.'
    inputBinding:
      position: 1
      prefix: --val
  - id: net
    type:
      - 'null'
      - boolean
    doc: 'Allow fetching DTDs or entities over the network.'
    inputBinding:
      position: 1
      prefix: --net
  - id: xinclude
    type:
      - 'null'
      - boolean
    doc: 'Do XInclude processing on document input.'
    inputBinding:
      position: 1
      prefix: --xinclude
  - id: maxdepth
    type:
      - 'null'
      - int
    doc: 'Increase the maximum depth.'
    inputBinding:
      position: 1
      prefix: --maxdepth
  - id: html
    type:
      - 'null'
      - boolean
    doc: 'Input document(s) are in HTML format.'
    inputBinding:
      position: 1
      prefix: --html
  - id: xsl_file
    type: File
    doc: 'Main XSLT stylesheet for transformation.'
    inputBinding:
      position: 2
  - id: param_xpath
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -p
    doc: 'Stylesheet parameters whose value is an XPath expression, as name=value (quote strings as "''string''"). Each item gets its own -p.'
    inputBinding:
      position: 3
  - id: param_string
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -s
    doc: 'Stylesheet parameters whose value is a string literal, as name=value. Each item gets its own -s.'
    inputBinding:
      position: 3
  - id: xml_files
    type:
      type: array
      items: File
    doc: 'Input XML document file(s) or URL (stdin is used if missing).'
    inputBinding:
      position: 4
outputs:
  - id: output
    type: stdout
    doc: Standard output of xml tr.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xmlstarlet:1.6.1
stdout: xmlstarlet_tr.out
