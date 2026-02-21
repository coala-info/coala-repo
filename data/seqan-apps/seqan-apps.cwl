cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqan-apps
label: seqan-apps
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage instructions for the tool. As a result,
  no arguments could be extracted.\n\nTool homepage: http://www.seqan.de/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seqan-apps:v2.4.0dfsg-11-deb_cv1
stdout: seqan-apps.out
