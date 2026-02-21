cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmer_counter
label: genometester_gmer_counter
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system error messages related to a container runtime (Apptainer/Singularity)
  failing due to insufficient disk space.\n\nTool homepage: https://github.com/bioinfo-ut/GenomeTester4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/genometester:v4.0git20180508.a9c14a6dfsg-1-deb_cv1
stdout: genometester_gmer_counter.out
