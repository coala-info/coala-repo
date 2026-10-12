cwlVersion: v1.2
class: CommandLineTool
baseCommand: xml_pp
label: perl-xml-twig_xml_pp
doc: "XML pretty printer using XML::Twig. The in-place option (-i) is not wrapped;\
  \ the result goes to standard output.\n\nTool homepage: http://metacpan.org/pod/XML-Twig"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: XML files to pretty print
    inputBinding:
      position: 200
  - id: style
    type:
      - 'null'
      - string
    doc: The style to use for pretty printing - none, nsgmls, nice, indented, record, or
      record_c (default indented)
    inputBinding:
      position: 102
      prefix: -s
  - id: preserve_space_tags
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -p
    doc: Preserve white spaces in these tags (several can be given)
    inputBinding:
      position: 102
  - id: encoding
    type:
      - 'null'
      - string
    doc: Output encoding; the XML declaration is updated (by default the original
      encoding is preserved)
    inputBinding:
      position: 102
      prefix: -e
  - id: load_in_memory
    type:
      - 'null'
      - boolean
    doc: Load the documents in memory instead of outputting them as they are
      being parsed
    inputBinding:
      position: 102
      prefix: -l
  - id: file_list
    type:
      - 'null'
      - File
    doc: Read the list of files to process from this file, one per line
    inputBinding:
      position: 102
      prefix: -f
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose (list the current file being processed)
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Pretty printed XML
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-twig:3.52--pl526_1
stdout: perl-xml-twig_xml_pp.out
