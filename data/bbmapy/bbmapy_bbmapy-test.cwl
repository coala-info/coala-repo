cwlVersion: v1.2
class: CommandLineTool
baseCommand: bbmapy
label: bbmapy_bbmapy-test
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  indicating a failure to build or extract the container image due to insufficient
  disk space. It does not contain help text or usage information for the tool.\n\n
  Tool homepage: https://github.com/urineri/bbmapy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bbmapy:0.0.51--pyhdfd78af_0
stdout: bbmapy_bbmapy-test.out
