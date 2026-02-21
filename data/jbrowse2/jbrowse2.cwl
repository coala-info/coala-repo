cwlVersion: v1.2
class: CommandLineTool
baseCommand: jbrowse2
label: jbrowse2
doc: "The provided text does not contain help information for jbrowse2; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  a SIF image due to lack of disk space.\n\nTool homepage: https://jbrowse.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jbrowse2:4.1.3--h71b9176_0
stdout: jbrowse2.out
