cwlVersion: v1.2
class: CommandLineTool
baseCommand: dashing2
label: dashing2
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to lack of disk space. It does not contain
  the help text or usage information for the dashing2 tool.\n\nTool homepage: https://github.com/dnbaker/dashing2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dashing2:2.1.20--he9e5f93_0
stdout: dashing2.out
