cwlVersion: v1.2
class: CommandLineTool
baseCommand: chemfp_simarray
label: chemfp_simarray
doc: "The provided text does not contain help information or usage instructions for
  chemfp_simarray. It appears to be a system error log from a container runtime (Singularity/Apptainer)
  indicating a failure to build or fetch the image due to insufficient disk space.\n
  \nTool homepage: https://chemfp.com"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chemfp:1.6.1--py27h9801fc8_2
stdout: chemfp_simarray.out
