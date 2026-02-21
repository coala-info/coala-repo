cwlVersion: v1.2
class: CommandLineTool
baseCommand: reapr_flutter_with_commit.sh
label: reapr_flutter_with_commit.sh
doc: "A tool related to REAPR (Recognition of Errors in Assemblies using Paired Reads).
  Note: The provided text appears to be a container runtime error log rather than
  help text, so no arguments could be extracted.\n\nTool homepage: https://github.com/tadelv/reaprime"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/reapr:v1.0.18dfsg-4-deb_cv1
stdout: reapr_flutter_with_commit.sh.out
