cwlVersion: v1.2
class: CommandLineTool
baseCommand: vardict_splitBed.pl
label: vardict_splitBed.pl
doc: "The provided text does not contain help information for the tool, but rather
  a fatal error log from a container runtime (Apptainer/Singularity) failing to fetch
  the OCI image.\n\nTool homepage: https://github.com/AstraZeneca-NGS/VarDict"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vardict:2019.06.04--pl526_0
stdout: vardict_splitBed.pl.out
