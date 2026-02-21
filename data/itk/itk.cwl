cwlVersion: v1.2
class: CommandLineTool
baseCommand: itk
label: itk
doc: "The Insight Toolkit (ITK) is an open-source, cross-platform system that provides
  developers with an extensive suite of software tools for image analysis.\n\nTool
  homepage: https://github.com/InsightSoftwareConsortium/ITK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/itk:4.10.1--py36_1
stdout: itk.out
