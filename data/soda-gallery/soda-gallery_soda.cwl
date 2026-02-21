cwlVersion: v1.2
class: CommandLineTool
baseCommand: soda
label: soda-gallery_soda
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log from a container runtime (Apptainer/Singularity)
  failing to pull or build the image 'soda-gallery'.\n\nTool homepage: https://github.com/alexpreynolds/soda"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/soda-gallery:1.2.0--pyhdfd78af_0
stdout: soda-gallery_soda.out
