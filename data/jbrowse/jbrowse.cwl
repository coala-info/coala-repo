cwlVersion: v1.2
class: CommandLineTool
baseCommand: jbrowse
label: jbrowse
doc: "The provided text is an error message from a container runtime (Apptainer/Singularity)
  and does not contain help documentation or argument definitions for the jbrowse
  tool.\n\nTool homepage: https://jbrowse.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jbrowse:1.16.11--pl5321h9f5acd7_5
stdout: jbrowse.out
