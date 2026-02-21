cwlVersion: v1.2
class: CommandLineTool
baseCommand: postmaster
label: postmaster
doc: "The provided text does not contain help information for the tool 'postmaster'.
  It appears to be a log of a failed container build/fetch process (Apptainer/Singularity).\n
  \nTool homepage: https://github.com/COMBINE-lab/postmaster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/postmaster:0.1.0--ha6fb395_1
stdout: postmaster.out
