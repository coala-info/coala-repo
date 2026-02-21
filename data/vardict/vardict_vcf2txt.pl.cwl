cwlVersion: v1.2
class: CommandLineTool
baseCommand: vardict_vcf2txt.pl
label: vardict_vcf2txt.pl
doc: "The provided text does not contain help information for the tool. It contains
  system logs and a fatal error related to a container runtime (Singularity/Apptainer)
  failing to fetch a Docker image.\n\nTool homepage: https://github.com/AstraZeneca-NGS/VarDict"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vardict:2019.06.04--pl526_0
stdout: vardict_vcf2txt.pl.out
