cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atlas
label: atlas_printglf
doc: "Printing a GLF file to screen\n\nTool homepage: https://bitbucket.org/wegmannlab/atlas/wiki/Home"
inputs:
  - id: input_glf_file
    type: File
    doc: GLF file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas:2.0.1--hadca570_0
stdout: atlas_printglf.out
