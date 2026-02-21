cwlVersion: v1.2
class: CommandLineTool
baseCommand: glnexus_cli
label: glnexus_glnexus_cli
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log related to a container runtime (Apptainer/Singularity)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/dnanexus-rnd/GLnexus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glnexus:1.4.1--h17e8430_5
stdout: glnexus_glnexus_cli.out
