cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_isoncorrect
label: isoncorrect_run_isoncorrect
doc: "The provided text is a system error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or argument definitions for the tool.
  As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/ksahlin/isONcorrect"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoncorrect:0.1.3.5--pyhdfd78af_0
stdout: isoncorrect_run_isoncorrect.out
