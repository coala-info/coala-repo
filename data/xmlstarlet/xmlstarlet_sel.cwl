cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - xml
  - sel
label: xmlstarlet_sel
doc: "Select data or query XML document(s) using XPath\n\nTool homepage: http://xmlstar.sourceforge.net/"
inputs:
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'Do not write anything to standard output.'
    inputBinding:
      position: 1
      prefix: -Q
  - id: comp
    type:
      - 'null'
      - boolean
    doc: 'Display generated XSLT.'
    inputBinding:
      position: 1
      prefix: -C
  - id: root
    type:
      - 'null'
      - boolean
    doc: 'Print root element <xsl-select>.'
    inputBinding:
      position: 1
      prefix: -R
  - id: text
    type:
      - 'null'
      - boolean
    doc: 'Output is text (default is XML).'
    inputBinding:
      position: 1
      prefix: -T
  - id: indent
    type:
      - 'null'
      - boolean
    doc: 'Indent output.'
    inputBinding:
      position: 1
      prefix: -I
  - id: xml_decl
    type:
      - 'null'
      - boolean
    doc: 'Do not omit xml declaration line.'
    inputBinding:
      position: 1
      prefix: -D
  - id: noblanks
    type:
      - 'null'
      - boolean
    doc: 'Remove insignificant spaces from XML tree.'
    inputBinding:
      position: 1
      prefix: -B
  - id: encode
    type:
      - 'null'
      - string
    doc: 'Output in the given encoding (utf-8, unicode...).'
    inputBinding:
      position: 1
      prefix: -E
  - id: namespaces
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -N
    doc: 'Predefine namespaces as name=value (without xmlns:). Each item gets its own -N.'
    inputBinding:
      position: 1
  - id: net
    type:
      - 'null'
      - boolean
    doc: 'Allow fetching DTDs or entities over the network.'
    inputBinding:
      position: 1
      prefix: --net
  - id: template
    type:
      type: array
      items: string
    doc: 'Template options in order, for example -t -m //item -v @id -n. Options: -t/--template, -c/--copy-of xpath, -v/--value-of xpath, -o/--output string, -n/--nl, -f/--inp-name, -m/--match xpath, --var name=value, -i/--if xpath, --elif xpath, --else, -e/--elem name, -a/--attr name, -b/--break, -s/--sort op xpath.'
    inputBinding:
      position: 2
  - id: xml_files
    type:
      type: array
      items: File
    doc: 'Input XML document file(s) (stdin is used if missing).'
    inputBinding:
      position: 3
outputs:
  - id: output
    type: stdout
    doc: Standard output of xml sel.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xmlstarlet:1.6.1
stdout: xmlstarlet_sel.out
