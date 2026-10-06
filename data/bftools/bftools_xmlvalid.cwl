cwlVersion: v1.2
class: CommandLineTool
baseCommand: xmlvalid
label: bftools_xmlvalid
requirements:
  - class: NetworkAccess
    networkAccess: true
doc: "Validates XML files (e.g. OME-XML) against the schema they declare.\n\nTool homepage: https://docs.openmicroscopy.org/bio-formats/5.7.1/users/comlinetools/index.html"
inputs:
  - id: xml_files
    type:
      type: array
      items: File
    doc: XML file(s) to validate against the schema named in each file (e.g. OME-XML)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bftools:8.0.0--hdfd78af_0
stdout: bftools_xmlvalid.out
