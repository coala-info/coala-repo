cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-eutilities
label: perl-bio-eutilities
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system error messages related to a Singularity/Apptainer
  container environment failing to pull or build an image due to insufficient disk
  space.\n\nTool homepage: https://metacpan.org/release/Bio-EUtilities"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-eutilities:1.77--pl5321hdfd78af_0
stdout: perl-bio-eutilities.out
