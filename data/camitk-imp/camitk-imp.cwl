cwlVersion: v1.2
class: CommandLineTool
baseCommand: camitk-imp
label: camitk-imp
doc: "camitk-imp is a medical image analysis and modeling software. This is the flagship
  GUI application of a larger framework called CamiTK (Computer Assisted Medical Interventions
  Tool Kit) designed to ease the collaborative work of a research team.\nThe targeted
  users are in R&D departments or laboratories. camitk-imp provides an easy and interactive
  access to all your data and algorithm parameters.\ncamitk-imp can visualize medical
  images from a lot of different (standard) formats, offers image processing and segmentation
  algorithms to reconstruct a mesh geometry and run a biomechanical simulation."
inputs:
  - id: file
    type:
      type: array
      items: File
    doc: Document(s) to open
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/camitk-imp:v4.1.2-3-deb_cv1
stdout: camitk-imp.out
