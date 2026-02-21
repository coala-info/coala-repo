cwlVersion: v1.2
class: CommandLineTool
baseCommand: ipig_eval.sh
label: ipig_eval.sh
doc: "The provided text contains error logs related to a container execution failure
  (no space left on device) rather than the help documentation for ipig_eval.sh. As
  a result, no arguments could be extracted.\n\nTool homepage: https://github.com/Greysahy/ipiguard"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ipig:v0.0.r5-3-deb_cv1
stdout: ipig_eval.sh.out
