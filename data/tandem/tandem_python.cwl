cwlVersion: v1.2
class: CommandLineTool
baseCommand: tandem_python
label: tandem_python
doc: "The provided text contains system logs and a fatal error message related to
  a container build process (Apptainer/Singularity) rather than the help text for
  the tool itself. As a result, no command-line arguments could be extracted.\n\n
  Tool homepage: https://github.com/tum-vision/tandem"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tandem:v17-02-01-4_cv4
stdout: tandem_python.out
