cwlVersion: v1.2
class: CommandLineTool
baseCommand: ktImportXML
label: krona_ktImportXML
doc: 'Creates a Krona chart from xml data describing each node and how the chart should
  look.


  Tool homepage: https://github.com/marbl/Krona'
inputs:
  - id: xml_file
    type: File
    doc: 'A file containing XML tags that specify chart attributes and describe the
      node hierarchy. An XML header is not necessary. For a complete description of
      XML tags, see: https://sourceforge.net/p/krona/wiki/KronaTools/'
    inputBinding:
      position: 1
  - id: krona_resources_url
    type:
      - 'null'
      - string
    doc: URL of Krona resources to use instead of bundling them with the chart (e.g.
      "http://krona.sourceforge.net"). Reduces size of charts and allows updates,
      though charts will not work without access to this URL.
    inputBinding:
      position: 102
      prefix: -u
  - id: output_file_path
    type: string
    default: xml.krona.html
    doc: Output file name
    inputBinding:
      position: 103
      prefix: -o
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name.
    outputBinding:
      glob: $(inputs.output_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
