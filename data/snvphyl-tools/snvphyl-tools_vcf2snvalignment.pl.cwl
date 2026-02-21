cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2snvalignment.pl
label: snvphyl-tools_vcf2snvalignment.pl
doc: "The provided text is a container runtime error log and does not contain the
  help documentation for this tool. No arguments could be parsed.\n\nTool homepage:
  https://github.com/phac-nml/snvphyl-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snvphyl-tools:1.8.2--pl5321h7b50bb2_9
stdout: snvphyl-tools_vcf2snvalignment.pl.out
