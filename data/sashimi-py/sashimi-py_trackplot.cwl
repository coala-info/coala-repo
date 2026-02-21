cwlVersion: v1.2
class: CommandLineTool
baseCommand: trackplot
label: sashimi-py_trackplot
doc: "The provided text does not contain help information for the tool, but appears
  to be a log of a failed container build process. No arguments could be extracted.\n
  \nTool homepage: https://github.com/ygidtu/sashimi.py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sashimi-py:0.1.5--pyh7cba7a3_0
stdout: sashimi-py_trackplot.out
