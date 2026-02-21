cwlVersion: v1.2
class: CommandLineTool
baseCommand: cgat-daisy
label: cgat-daisy
doc: "The provided text does not contain help information or usage instructions for
  cgat-daisy. It appears to be a system error log from a container runtime (Singularity/Apptainer)
  indicating a failure to build or extract the container image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://github.com/cgat-developers/cgat-daisy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cgat-daisy:0.1.12--pyh5e36f6f_0
stdout: cgat-daisy.out
