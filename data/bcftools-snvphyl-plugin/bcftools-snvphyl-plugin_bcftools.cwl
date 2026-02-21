cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcftools
label: bcftools-snvphyl-plugin_bcftools
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or extract a Singularity/Apptainer container due
  to insufficient disk space.\n\nTool homepage: https://github.com/phac-nml/snvphyl-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools-snvphyl-plugin:1.9--h34584cc_4
stdout: bcftools-snvphyl-plugin_bcftools.out
