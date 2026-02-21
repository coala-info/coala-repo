cwlVersion: v1.2
class: CommandLineTool
baseCommand: t_coffee
label: perl-bio-tools-run-alignment-tcoffee_t-coffee
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or run a Singularity/Apptainer container due to
  insufficient disk space ('no space left on device').\n\nTool homepage: https://metacpan.org/release/Bio-Tools-Run-Alignment-TCoffee"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-tools-run-alignment-tcoffee:1.7.4--pl526_0
stdout: perl-bio-tools-run-alignment-tcoffee_t-coffee.out
