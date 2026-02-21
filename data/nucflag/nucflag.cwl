cwlVersion: v1.2
class: CommandLineTool
baseCommand: nucflag
label: nucflag
doc: "The provided text does not contain help information for nucflag. It appears
  to be an error log from a container runtime (Apptainer/Singularity) indicating a
  failure to build the container image due to insufficient disk space.\n\nTool homepage:
  https://github.com/logsdon-lab/NucFlag"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nucflag:0.3.8--pyhdfd78af_0
stdout: nucflag.out
