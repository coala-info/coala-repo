cwlVersion: v1.2
class: CommandLineTool
baseCommand: joblib
label: joblib
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain CLI help information or argument definitions for the tool 'joblib'.\n
  \nTool homepage: https://github.com/joblib/joblib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/joblib:0.9.3--py36_0
stdout: joblib.out
