cwlVersion: v1.2
class: CommandLineTool
baseCommand: intervals
label: intervals
doc: "The provided text is a system error log from a container runtime (Apptainer/Singularity)
  and does not contain help documentation or usage information for the 'intervals'
  tool.\n\nTool homepage: https://github.com/easychen/CookieCloud"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/intervals:0.6.0--py36_0
stdout: intervals.out
