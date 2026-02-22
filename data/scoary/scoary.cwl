cwlVersion: v1.2
class: CommandLineTool
baseCommand: scoary
label: scoary
doc: "The provided text is an error log indicating a failure to pull or convert the
  Singularity/Docker container due to lack of disk space, rather than the help text
  for the tool. As a result, no arguments or descriptions could be extracted from
  the input.\n\nTool homepage: https://github.com/AdmiralenOla/Scoary"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/scoary:v1.6.16-1-deb_cv1
stdout: scoary.out
