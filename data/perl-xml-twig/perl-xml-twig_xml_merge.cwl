cwlVersion: v1.2
class: CommandLineTool
baseCommand: xml_merge
label: perl-xml-twig_xml_merge
doc: "Merge XML files using the XML::Twig module.\n\nTool homepage: http://metacpan.org/pod/XML-Twig"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: XML files to be merged
    inputBinding:
      position: 1
  - id: in_place
    type:
      - 'null'
      - boolean
    doc: Edit files in place
    inputBinding:
      position: 102
      prefix: -i
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output results to this file instead of stdout
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-twig:3.52--pl526_1
