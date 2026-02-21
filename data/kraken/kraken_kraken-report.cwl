cwlVersion: v1.2
class: CommandLineTool
baseCommand: kraken-report
label: kraken_kraken-report
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failure
  due to insufficient disk space.\n\nTool homepage: http://ccb.jhu.edu/software/kraken/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/kraken:v1.1-3-deb_cv1
stdout: kraken_kraken-report.out
