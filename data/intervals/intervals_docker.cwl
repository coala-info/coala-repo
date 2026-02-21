cwlVersion: v1.2
class: CommandLineTool
baseCommand: intervals
label: intervals_docker
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  and does not contain help text, usage instructions, or argument definitions for
  the 'intervals' tool.\n\nTool homepage: https://github.com/easychen/CookieCloud"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/intervals:0.6.0--py36_0
stdout: intervals_docker.out
