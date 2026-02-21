cwlVersion: v1.2
class: CommandLineTool
baseCommand: edena
label: edena
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the container image due to lack of disk space. It
  does not contain the help text or usage information for the 'edena' tool.\n\nTool
  homepage: https://github.com/edenai/edenai-apis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/edena:3.131028--h9948957_8
stdout: edena.out
