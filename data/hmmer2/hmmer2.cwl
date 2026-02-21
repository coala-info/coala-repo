cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmmer2
label: hmmer2
doc: "The provided text does not contain help information or documentation for the
  tool. It is an error log indicating a failure to build or run a container due to
  insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/sestaton/HMMER2GO"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hmmer2:v2.3.2-13-deb_cv1
stdout: hmmer2.out
