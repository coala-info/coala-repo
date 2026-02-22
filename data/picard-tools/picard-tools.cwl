cwlVersion: v1.2
class: CommandLineTool
baseCommand: picard
label: picard-tools
doc: "The provided text does not contain help information or documentation for picard-tools;
  it is an error log indicating a failure to pull or convert a container image due
  to insufficient disk space ('no space left on device').\n\nTool homepage: http://broadinstitute.github.io/picard/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/picard-tools:v2.18.25dfsg-2-deb_cv1
stdout: picard-tools.out
