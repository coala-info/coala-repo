cwlVersion: v1.2
class: CommandLineTool
baseCommand: snvphyl-tools_vcf2core.pl
label: snvphyl-tools_vcf2core.pl
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) failing
  to pull the docker image.\n\nTool homepage: https://github.com/phac-nml/snvphyl-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snvphyl-tools:1.8.2--pl5321h7b50bb2_9
stdout: snvphyl-tools_vcf2core.pl.out
