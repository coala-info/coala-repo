cwlVersion: v1.2
class: CommandLineTool
baseCommand: sracat
label: sracat
doc: "The provided text does not contain help information or usage instructions for
  'sracat'. It appears to be an error log from a container runtime (Apptainer/Singularity)
  failing to fetch the OCI image.\n\nTool homepage: https://github.com/lanl/sracat"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sracat:0.2--h077b44d_3
stdout: sracat.out
