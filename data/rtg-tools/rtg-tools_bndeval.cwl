cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - bndeval
label: rtg-tools_bndeval
doc: "The provided text does not contain help information for the tool. It appears
  to be a system log showing a fatal error during a container build process.\n\nTool
  homepage: https://github.com/RealTimeGenomics/rtg-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_bndeval.out
