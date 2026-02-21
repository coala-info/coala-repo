cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/xpath
label: perl-xml-xpath_xpath
doc: "A tool to query XML files using XPath expressions. If no filenames are given,
  it reads XML from STDIN. Each supplementary query is done in order, with the previous
  query providing the context for the next.\n\nTool homepage: https://metacpan.org/pod/XML::XPath"
inputs:
  - id: filenames
    type:
      - 'null'
      - type: array
        items: File
    doc: XML files to query.
    inputBinding:
      position: 1
  - id: no_external_dtd
    type:
      - 'null'
      - boolean
    doc: Don't use an external DTD.
    inputBinding:
      position: 102
      prefix: -n
  - id: postfix
    type:
      - 'null'
      - string
    doc: use prefix instead of nothing.
    inputBinding:
      position: 102
      prefix: -p
  - id: query
    type:
      type: array
      items: string
    doc: XPath query to execute. At least one query must be provided.
    inputBinding:
      position: 102
      prefix: -e
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: quiet, only output the resulting PATH.
    inputBinding:
      position: 102
      prefix: -q
  - id: suffix
    type:
      - 'null'
      - string
    doc: use suffix instead of linefeed.
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-xpath:1.47--pl5321hdfd78af_0
stdout: perl-xml-xpath_xpath.out
