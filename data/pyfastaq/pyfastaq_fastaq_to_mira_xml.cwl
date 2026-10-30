cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - to_mira_xml
label: pyfastaq_fastaq_to_mira_xml
doc: "Create an xml file from a file of reads, for use with Mira assembler\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: "Name of input fasta/q file"
    inputBinding:
      position: 20
  - id: xml_out
    type: string
    doc: "Name of output xml file"
    inputBinding:
      position: 21
outputs:
  - id: xml_output
    type: File
    doc: "Name of output xml file"
    outputBinding:
      glob: $(inputs.xml_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
