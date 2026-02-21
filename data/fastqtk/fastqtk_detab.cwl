cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastqtk
  - detab
label: fastqtk_detab
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  due to lack of disk space.\n\nTool homepage: https://github.com/ndaniel/fastqtk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqtk:0.28--h5ca1c30_0
stdout: fastqtk_detab.out
