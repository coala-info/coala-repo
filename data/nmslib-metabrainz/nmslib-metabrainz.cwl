cwlVersion: v1.2
class: CommandLineTool
baseCommand: nmslib-metabrainz
label: nmslib-metabrainz
doc: "The provided text does not contain help information or a description of the
  tool. It contains error logs related to a container runtime (Apptainer/Singularity)
  failing to build an image due to insufficient disk space.\n\nTool homepage: https://github.com/nmslib/nmslib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nmslib-metabrainz:2.1.3--py310ha6711e0_0
stdout: nmslib-metabrainz.out
