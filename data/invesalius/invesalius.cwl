cwlVersion: v1.2
class: CommandLineTool
baseCommand: invesalius
label: invesalius
doc: "InVesalius is a 3D medical imaging reconstruction software used to generate
  3D medical imaging structures based on a sequence of 2D DICOM files acquired with
  CT or MRI equipment.\n\nTool homepage: https://github.com/invesalius/invesalius3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/invesalius:v3.1.99992-3-deb_cv1
stdout: invesalius.out
