cwlVersion: v1.2
class: CommandLineTool
baseCommand: agat_agat_sp_add_introns.pl
label: agat_agat_sp_add_introns.pl
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build or extract a Singularity/Apptainer
  container image due to insufficient disk space ('no space left on device').\n\n
  Tool homepage: https://github.com/NBISweden/AGAT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agat:1.6.1--pl5321hdfd78af_1
stdout: agat_agat_sp_add_introns.pl.out
