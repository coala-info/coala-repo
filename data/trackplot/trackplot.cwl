cwlVersion: v1.2
class: CommandLineTool
baseCommand: trackplot
label: trackplot
doc: "The provided text is an error log from a failed container build process and
  does not contain help information or argument definitions for the 'trackplot' tool.\n
  \nTool homepage: https://github.com/ygidtu/trackplot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trackplot:0.5.7--pyhdfd78af_0
stdout: trackplot.out
