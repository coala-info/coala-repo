cwlVersion: v1.2
class: CommandLineTool
baseCommand: decom
label: decom
doc: "The provided text does not contain help information or a description for the
  tool 'decom'. It appears to be an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build a SIF image due to lack of disk space.\n\nTool homepage:
  https://github.com/CamilaDuitama/decOM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/decom:0.0.32--pyhdfd78af_2
stdout: decom.out
