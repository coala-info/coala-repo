cwlVersion: v1.2
class: CommandLineTool
baseCommand: genometools
label: genometools
doc: "The provided text does not contain help information for genometools; it contains
  error messages from a container runtime (Apptainer/Singularity) indicating a failure
  to pull the image due to lack of disk space.\n\nTool homepage: https://github.com/genometools/genometools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/genometools:v1.5.9ds-4-deb-py2_cv1
stdout: genometools.out
