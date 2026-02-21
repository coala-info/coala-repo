cwlVersion: v1.2
class: CommandLineTool
baseCommand: progressiveMauve
label: mauve_progressiveMauve
doc: "The provided text does not contain help information for the tool. It appears
  to be an error log from a container runtime (Apptainer/Singularity) indicating a
  failure to pull or convert the Docker image due to insufficient disk space.\n\n
  Tool homepage: http://darlinglab.org/mauve/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mauve:2.4.0.snapshot_2015_02_13--h2688d6d_0
stdout: mauve_progressiveMauve.out
