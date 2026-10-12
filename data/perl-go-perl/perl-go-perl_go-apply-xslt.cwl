cwlVersion: v1.2
class: CommandLineTool
baseCommand: go-apply-xslt
label: perl-go-perl_go-apply-xslt
doc: "Processes Obo-XML files through an XSLT transform (for example oboxml_to_owl) using xsltproc\n\nTool homepage: http://metacpan.org/pod/go-perl"
inputs:
  - id: xslt_name
    type: string
    doc: "Logical name of the XSLT (for example oboxml_to_owl)"
    inputBinding:
      position: 1
  - id: xml_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Obo-XML file(s) to process (standard input when omitted)"
    inputBinding:
      position: 2
  - id: xsltproc_options
    type:
      - 'null'
      - type: array
        items: string
    doc: "Extra options passed to xsltproc"
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-go-perl:0.15--pl526_3
stdout: perl-go-perl_go-apply-xslt.out
