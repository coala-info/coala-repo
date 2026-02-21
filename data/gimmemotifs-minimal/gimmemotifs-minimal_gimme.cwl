cwlVersion: v1.2
class: CommandLineTool
baseCommand: gimme
label: gimmemotifs-minimal_gimme
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Singularity/Apptainer) failing
  to pull a Docker image due to lack of disk space.\n\nTool homepage: https://github.com/vanheeringen-lab/gimmemotifs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
stdout: gimmemotifs-minimal_gimme.out
