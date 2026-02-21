cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2maf-umccr
label: vcf2maf-umccr
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a container runtime error log (Apptainer/Singularity) indicating a
  failure to fetch or build the OCI image.\n\nTool homepage: https://github.com/umccr/vcf2maf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2maf-umccr:1.6.21.20230511--hdfd78af_0
stdout: vcf2maf-umccr.out
