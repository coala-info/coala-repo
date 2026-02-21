cwlVersion: v1.2
class: CommandLineTool
baseCommand: ffindex_apply
label: ffindex_ffindex_apply
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime (Apptainer/Singularity)
  failure.\n\nTool homepage: https://github.com/soedinglab/ffindex_soedinglab"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ffindex:0.98--h9948957_5
stdout: ffindex_ffindex_apply.out
