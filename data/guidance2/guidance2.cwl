cwlVersion: v1.2
class: CommandLineTool
baseCommand: guidance2
label: guidance2
doc: "The provided text does not contain help information for the tool. It consists
  of system log messages and a fatal error regarding a container build failure (no
  space left on device).\n\nTool homepage: https://github.com/Streamlit-Guide-Web-App-Development/guidance2streamlit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/guidance2:v2.02_cv1
stdout: guidance2.out
