cwlVersion: v1.2
class: CommandLineTool
baseCommand: replidec
label: replidec
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container execution environment (Apptainer/Singularity)
  indicating a failure to fetch the OCI image.\n\nTool homepage: https://github.com/deng-lab/Replidec"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/replidec:0.3.5--pyhdfd78af_0
stdout: replidec.out
