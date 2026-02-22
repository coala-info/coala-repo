cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-db-swissprot
label: perl-bio-db-swissprot
doc: "The provided text does not contain help information or usage instructions; it
  consists of system error messages related to a container runtime (Singularity/Apptainer)
  failing due to insufficient disk space.\n\nTool homepage: https://metacpan.org/release/Bio-DB-SwissProt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-bio-db-swissprot:1.7.4--pl5321hdfd78af_0
stdout: perl-bio-db-swissprot.out
