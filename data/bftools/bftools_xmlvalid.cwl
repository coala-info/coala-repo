cwlVersion: v1.2
class: CommandLineTool
baseCommand: bftools_xmlvalid
label: bftools_xmlvalid
doc: "Validates an XML file against a schema.\n\nTool homepage: https://docs.openmicroscopy.org/bio-formats/5.7.1/users/comlinetools/index.html"
inputs:
  - id: schema_path
    type: File
    doc: Path to the XML schema file
    inputBinding:
      position: 1
  - id: input_file
    type: File
    doc: Path to the XML file to validate
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bftools:8.0.0--hdfd78af_0
stdout: bftools_xmlvalid.out
