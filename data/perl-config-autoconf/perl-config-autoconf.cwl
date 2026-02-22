cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-config-autoconf
label: perl-config-autoconf
doc: "The provided text does not contain help information for the tool; it is an error
  log indicating a failure to pull a Singularity container due to insufficient disk
  space.\n\nTool homepage: https://metacpan.org/release/Config-AutoConf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-config-autoconf:0.320--pl5321h7b50bb2_4
stdout: perl-config-autoconf.out
