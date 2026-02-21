cwlVersion: v1.2
class: CommandLineTool
baseCommand: samclip
label: samclip
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for the tool 'samclip'.
  As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/tseemann/samclip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samclip:0.4.0--hdfd78af_1
stdout: samclip.out
