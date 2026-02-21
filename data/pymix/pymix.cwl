cwlVersion: v1.2
class: CommandLineTool
baseCommand: pymix
label: pymix
doc: "The provided text appears to be a container build log (Apptainer/Singularity)
  rather than CLI help text. As a result, no command-line arguments, descriptions,
  or usage patterns could be extracted.\n\nTool homepage: https://github.com/csteinmetz1/pymixconsole"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymix:0.8--py27hcb787e7_1
stdout: pymix.out
