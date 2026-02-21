cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyomero-upload
label: pyomero-upload
doc: "A tool for uploading images to an OMERO server.\n\nTool homepage: http://www.synthsys.ed.ac.uk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyomero-upload:5.6.2_2.2.0--py_0
stdout: pyomero-upload.out
