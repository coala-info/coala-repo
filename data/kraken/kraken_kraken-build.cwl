cwlVersion: v1.2
class: CommandLineTool
baseCommand: kraken-build
label: kraken_kraken-build
doc: "The provided text does not contain help information for kraken-build; it is
  an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build a SIF image due to lack of disk space.\n\nTool homepage: http://ccb.jhu.edu/software/kraken/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/kraken:v1.1-3-deb_cv1
stdout: kraken_kraken-build.out
