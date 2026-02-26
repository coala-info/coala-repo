cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq_to_mira_xml
label: fastaq_to_mira_xml
doc: "Create an xml file from a file of reads, for use with Mira assembler\n\nTool
  homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of input fasta/q file
    inputBinding:
      position: 1
outputs:
  - id: xml_out
    type: File
    doc: Name of output xml file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
