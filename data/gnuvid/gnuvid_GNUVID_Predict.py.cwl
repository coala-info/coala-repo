cwlVersion: v1.2
class: CommandLineTool
baseCommand: gnuvid_GNUVID_Predict.py
label: gnuvid_GNUVID_Predict.py
doc: "GNUVID Predict tool (Note: The provided help text contains only container runtime
  error messages and no usage information).\n\nTool homepage: https://github.com/ahmedmagds/GNUVID"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gnuvid:2.4--hdfd78af_0
stdout: gnuvid_GNUVID_Predict.py.out
