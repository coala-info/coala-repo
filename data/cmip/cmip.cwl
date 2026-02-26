cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmip
label: cmip
doc: "Classical Molecular Interaction Potentials (CMIP). Code for ASA (Accessible
  Surface Area) calculation.\n\nTool homepage: http://mmb.irbbarcelona.org/gitlab/gelpi/CMIP"
inputs:
  - id: parameter_file
    type: File
    doc: Parameter file for the calculation (defaults to 'param' if not 
      specified)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmip:2.7.0--h8c3ec31_0
stdout: cmip.out
