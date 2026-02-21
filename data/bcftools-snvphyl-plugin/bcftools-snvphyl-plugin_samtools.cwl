cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcftools-snvphyl-plugin_samtools
label: bcftools-snvphyl-plugin_samtools
doc: "The provided text does not contain help documentation for the tool, but appears
  to be an error log from a container runtime (Apptainer/Singularity) indicating a
  failure to build an image due to insufficient disk space.\n\nTool homepage: https://github.com/phac-nml/snvphyl-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools-snvphyl-plugin:1.9--h34584cc_4
stdout: bcftools-snvphyl-plugin_samtools.out
