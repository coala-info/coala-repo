cwlVersion: v1.2
class: CommandLineTool
baseCommand: xml_merge
label: perl-xml-twig_xml_merge
doc: "Merge back XML files split with xml_split.\n\nTool homepage: http://metacpan.org/pod/XML-Twig"
inputs:
  - id: main_file
    type: File
    doc: The main document written by xml_split (the one ending in -00.xml)
    inputBinding:
      position: 200
  - id: parts
    type:
      - 'null'
      - type: array
        items: File
    doc: Sub files written by xml_split; staged next to the main file so the
      names in the merge instructions resolve
  - id: xinclude
    type:
      - 'null'
      - boolean
    doc: The files use XInclude instead of processing instructions (they were
      created using the -i option of xml_split)
    inputBinding:
      position: 102
      prefix: -i
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: -v
  - id: output_file_path
    type: string
    doc: Output file; unless this option is used the program output goes to STDOUT
    inputBinding:
      position: 103
      prefix: -o
outputs:
  - id: output_file
    type: File
    doc: Merged XML document
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.parts ? [inputs.main_file].concat(inputs.parts) : [inputs.main_file])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-twig:3.52--pl526_1
