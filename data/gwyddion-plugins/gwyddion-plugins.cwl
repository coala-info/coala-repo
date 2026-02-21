cwlVersion: v1.2
class: CommandLineTool
baseCommand: gwyddion-plugins
label: gwyddion-plugins
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to build an image due to lack of disk space.\n\nTool homepage: https://github.com/tuxu/gwyddion-plugins"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gwyddion-plugins:v2.52-1-deb_cv1
stdout: gwyddion-plugins.out
