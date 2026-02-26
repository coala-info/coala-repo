cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcftools
label: bcftools-snvphyl-plugin_bcftools
doc: "Tools for variant calling and manipulating VCFs and BCFs\n\nTool homepage: https://github.com/phac-nml/snvphyl-tools"
inputs:
  - id: command
    type: string
    doc: The command to execute
    inputBinding:
      position: 1
  - id: argument
    type: string
    doc: Arguments for the command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools-snvphyl-plugin:1.9--h4da6232_0
stdout: bcftools-snvphyl-plugin_bcftools.out
