cwlVersion: v1.2
class: CommandLineTool
baseCommand: gnuvid
label: gnuvid
doc: "Gnuvid is a tool for the detection of viral integration. (Note: The provided
  text contains container runtime error messages rather than command-line help documentation;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/ahmedmagds/GNUVID"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gnuvid:2.4--hdfd78af_0
stdout: gnuvid.out
