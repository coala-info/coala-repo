cwlVersion: v1.2
class: CommandLineTool
baseCommand: xml_split
label: perl-xml-twig_xml_split
doc: "Split an XML file into several smaller files\n\nTool homepage: http://metacpan.org/pod/XML-Twig"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: XML files to split
    inputBinding:
      position: 1
  - id: base
    type:
      - 'null'
      - string
    doc: Base name for the split files
    inputBinding:
      position: 102
      prefix: -b
  - id: cond
    type:
      - 'null'
      - string
    doc: Condition to split the XML
    inputBinding:
      position: 102
      prefix: -c
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug mode
    inputBinding:
      position: 102
      prefix: -d
  - id: ext
    type:
      - 'null'
      - string
    doc: Extension for the split files
    inputBinding:
      position: 102
      prefix: -e
  - id: in_place
    type:
      - 'null'
      - boolean
    doc: Split in place
    inputBinding:
      position: 102
      prefix: -i
  - id: level
    type:
      - 'null'
      - int
    doc: Level at which to split the XML
    inputBinding:
      position: 102
      prefix: -l
  - id: merge
    type:
      - 'null'
      - boolean
    doc: Merge mode
    inputBinding:
      position: 102
      prefix: -m
  - id: nb
    type:
      - 'null'
      - int
    doc: Number of digits in the split file names
    inputBinding:
      position: 102
      prefix: -n
  - id: nb_grouped
    type:
      - 'null'
      - int
    doc: Number of elements to group in each split file
    inputBinding:
      position: 102
      prefix: -g
  - id: plugin
    type:
      - 'null'
      - string
    doc: Plugin to use for splitting
    inputBinding:
      position: 102
      prefix: -p
  - id: plugin_dir
    type:
      - 'null'
      - Directory
    doc: Directory where plugins are located
    inputBinding:
      position: 102
      prefix: -I
  - id: size
    type:
      - 'null'
      - string
    doc: Size of the split files
    inputBinding:
      position: 102
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-twig:3.52--pl526_1
stdout: perl-xml-twig_xml_split.out
