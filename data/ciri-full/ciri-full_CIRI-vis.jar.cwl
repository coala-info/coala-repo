cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - CIRI-vis.jar
label: ciri-full_CIRI-vis.jar
doc: "The provided text does not contain help information for the tool. It contains
  system logs indicating a failure to build or extract a container image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://ciri-cookbook.readthedocs.io/en/latest/CIRI-full.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ciri-full:2.1.2--hdfd78af_1
stdout: ciri-full_CIRI-vis.jar.out
