cwlVersion: v1.2
class: CommandLineTool
baseCommand: egrep
label: grep_egrep
doc: "The provided text does not contain help information for the tool. It appears
  to be an error log from a container runtime (Apptainer/Singularity) indicating a
  failure to build a SIF format image due to insufficient disk space.\n\nTool homepage:
  https://www.gnu.org/software/grep/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: ubuntu:latest
stdout: grep_egrep.out
