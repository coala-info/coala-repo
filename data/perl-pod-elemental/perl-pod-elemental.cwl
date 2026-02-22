cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-pod-elemental
label: perl-pod-elemental
doc: "The provided text does not contain help documentation for the tool. It contains
  system error messages related to a failed container image pull (Singularity/Apptainer)
  due to insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/rjbs/Pod-Elemental"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-pod-elemental:0.103006--pl5321h7b50bb2_2
stdout: perl-pod-elemental.out
