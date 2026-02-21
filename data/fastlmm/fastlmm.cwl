cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastlmm
label: fastlmm
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container image conversion and disk
  space.\n\nTool homepage: http://research.microsoft.com/en-us/um/redmond/projects/mscompbio/fastlmm/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastlmm:0.2.32--py27h95a95ce_5
stdout: fastlmm.out
