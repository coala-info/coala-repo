cwlVersion: v1.2
class: CommandLineTool
baseCommand: mss_joint_fitter
label: hyphy_mss
doc: "Performs a joint MSS model fit to several genes jointly.\n\nTool homepage: http://hyphy.org/"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: List of files to include in this analysis
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
stdout: hyphy_mss.out
