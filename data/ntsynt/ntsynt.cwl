cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntsynt
label: ntsynt
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to pull or build the ntsynt container image due to insufficient
  disk space. It does not contain the tool's help text or argument definitions.\n\n
  Tool homepage: https://github.com/bcgsc/ntsynt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntsynt:1.0.4--py39h2de1943_0
stdout: ntsynt.out
