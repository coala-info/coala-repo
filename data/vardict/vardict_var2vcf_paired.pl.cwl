cwlVersion: v1.2
class: CommandLineTool
baseCommand: vardict_var2vcf_paired.pl
label: vardict_var2vcf_paired.pl
doc: "The provided text does not contain help documentation or usage instructions.
  It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to fetch or build the OCI image.\n\nTool homepage: https://github.com/AstraZeneca-NGS/VarDict"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vardict:2019.06.04--pl526_0
stdout: vardict_var2vcf_paired.pl.out
