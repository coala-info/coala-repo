cwlVersion: v1.2
class: CommandLineTool
baseCommand: clusterpicker
label: clusterpicker_ClusterPicker.jar
doc: "The provided text does not contain help information for the tool, but rather
  a system error log indicating a failure to build or run the container image due
  to lack of disk space ('no space left on device'). No command-line arguments could
  be extracted from this text.\n\nTool homepage: http://hiv.bio.ed.ac.uk/software.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clusterpicker:1.2.5--hdfd78af_1
stdout: clusterpicker_ClusterPicker.jar.out
