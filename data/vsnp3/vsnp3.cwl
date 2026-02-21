cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3
label: vsnp3
doc: "The provided text is a container engine log (Singularity/Apptainer) indicating
  a failure to fetch the vsnp3 image, rather than the tool's help text. Consequently,
  no arguments or descriptions could be extracted.\n\nTool homepage: https://github.com/USDA-VS/vsnp3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.32--hdfd78af_0
stdout: vsnp3.out
