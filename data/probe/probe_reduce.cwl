cwlVersion: v1.2
class: CommandLineTool
baseCommand: probe_reduce
label: probe_reduce
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build or execution attempt.\n
  \nTool homepage: http://kinemage.biochem.duke.edu/software/probe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/probe:2.18--h9948957_0
stdout: probe_reduce.out
