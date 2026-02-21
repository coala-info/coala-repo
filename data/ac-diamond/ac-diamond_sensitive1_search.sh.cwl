cwlVersion: v1.2
class: CommandLineTool
baseCommand: ac-diamond_sensitive1_search.sh
label: ac-diamond_sensitive1_search.sh
doc: "The provided text does not contain help information for the tool. It consists
  of system logs and a fatal error message indicating a failure to build or extract
  a Singularity/Apptainer container image due to insufficient disk space.\n\nTool
  homepage: https://github.com/Maihj/AC-DIAMOND"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ac-diamond:1.0--boost1.64_0
stdout: ac-diamond_sensitive1_search.sh.out
