cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-btlib
label: perl-btlib
doc: "The provided text does not contain help documentation for 'perl-btlib'. It appears
  to be a log of an Apptainer/Singularity container build process that failed because
  the executable 'perl-btlib' was not found in the system PATH.\n\nTool homepage:
  https://github.com/BICC-UNIL-EPFL/perl-BTLib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-btlib:0.19--0
stdout: perl-btlib.out
