cwlVersion: v1.2
class: CommandLineTool
baseCommand: mauve-aligner
label: mauve-aligner
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding a container runtime (Apptainer/Singularity)
  failing to build an image due to lack of disk space.\n\nTool homepage: http://darlinglab.org/mauve/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mauve-aligner:v2.4.04736-1-deb_cv1
stdout: mauve-aligner.out
