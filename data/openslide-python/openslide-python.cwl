cwlVersion: v1.2
class: CommandLineTool
baseCommand: openslide-python
label: openslide-python
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull or build the image due to insufficient disk space.\n\nTool homepage: http://openslide.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/openslide-python:1.1.1--py36h470a237_0
stdout: openslide-python.out
