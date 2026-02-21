cwlVersion: v1.2
class: CommandLineTool
baseCommand: gimmemotifs-minimal_genomepy
label: gimmemotifs-minimal_genomepy
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull an image due to lack of disk space.\n\nTool homepage: https://github.com/vanheeringen-lab/gimmemotifs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
stdout: gimmemotifs-minimal_genomepy.out
