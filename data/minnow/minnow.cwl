cwlVersion: v1.2
class: CommandLineTool
baseCommand: minnow
label: minnow
doc: "The provided text is an error message from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for the 'minnow' tool. As
  a result, no arguments could be extracted.\n\nTool homepage: https://github.com/COMBINE-lab/minnow"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minnow:1.2--h86b0361_0
stdout: minnow.out
