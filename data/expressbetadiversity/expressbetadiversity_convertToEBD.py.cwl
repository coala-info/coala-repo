cwlVersion: v1.2
class: CommandLineTool
baseCommand: convertToEBD.py
label: expressbetadiversity_convertToEBD.py
doc: "Convert UniFrac environment files for use with EBD.\n\nTool homepage: https://github.com/dparks1134/ExpressBetaDiversity"
inputs:
  - id: input_file
    type: File
    doc: Input OTU table in sparse or dense UniFrac format.
    inputBinding:
      position: 1
  - id: output_file_name
    type: string
    doc: Output OTU table in EBD format. (file name to write)
    inputBinding:
      position: 2
outputs:
  - id: output_file
    type: File
    doc: Output OTU table in EBD format.
    outputBinding:
      glob: $(inputs.output_file_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expressbetadiversity:1.0.10--h9948957_6
