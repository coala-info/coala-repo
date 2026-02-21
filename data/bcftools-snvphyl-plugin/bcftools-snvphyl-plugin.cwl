cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcftools-snvphyl-plugin
label: bcftools-snvphyl-plugin
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or extract the image due to insufficient disk space.\n
  \nTool homepage: https://github.com/phac-nml/snvphyl-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools-snvphyl-plugin:1.9--h34584cc_4
stdout: bcftools-snvphyl-plugin.out
