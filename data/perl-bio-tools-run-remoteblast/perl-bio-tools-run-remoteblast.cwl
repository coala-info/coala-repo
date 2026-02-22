cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-tools-run-remoteblast
label: perl-bio-tools-run-remoteblast
doc: "The provided text does not contain help information or documentation for the
  tool. It consists of system error messages related to container runtime and disk
  space issues.\n\nTool homepage: https://metacpan.org/release/Bio-Tools-Run-RemoteBlast"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-bio-tools-run-remoteblast:1.7.3--pl5321hdfd78af_0
stdout: perl-bio-tools-run-remoteblast.out
