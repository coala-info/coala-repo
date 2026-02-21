cwlVersion: v1.2
class: CommandLineTool
baseCommand: cgat-scripts
label: cgat-scripts
doc: "The provided text does not contain help documentation for the tool. It is a
  system error log indicating a failure to build or extract a container image due
  to insufficient disk space ('no space left on device').\n\nTool homepage: https://www.cgat.org/downloads/public/cgat/documentation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cgat-scripts:0.3.2--py36h355e19c_2
stdout: cgat-scripts.out
