cwlVersion: v1.2
class: CommandLineTool
baseCommand: vardict_var2vcf_valid.pl
label: vardict_var2vcf_valid.pl
doc: "The provided text does not contain help information for vardict_var2vcf_valid.pl;
  it is an error log from a container runtime (Singularity/Apptainer) failure.\n\n
  Tool homepage: https://github.com/AstraZeneca-NGS/VarDict"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vardict:2019.06.04--pl526_0
stdout: vardict_var2vcf_valid.pl.out
