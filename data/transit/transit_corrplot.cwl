cwlVersion: v1.2
class: CommandLineTool
baseCommand: transit_corrplot
label: transit_corrplot
doc: "Generates a correlation plot using R and rpy2.\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: r_version
    type:
      - 'null'
      - string
    doc: Required R version. Currently requires R and rpy2 (~= 3.0).
    inputBinding:
      position: 101
  - id: rpy2_install_command
    type:
      - 'null'
      - string
    doc: "Command to install rpy2. Example: 'pip install \"rpy2~=3.0\"'"
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
stdout: transit_corrplot.out
