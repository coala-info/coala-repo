cwlVersion: v1.2
class: CommandLineTool
baseCommand: macsy_merge
label: macsyfinder_macsy_merge
doc: "The provided text does not contain help information for macsyfinder_macsy_merge.
  It contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to pull an image due to insufficient disk space.\n\nTool homepage: https://github.com/gem-pasteur/macsyfinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macsyfinder:2.1.6--pyhdfd78af_0
stdout: macsyfinder_macsy_merge.out
