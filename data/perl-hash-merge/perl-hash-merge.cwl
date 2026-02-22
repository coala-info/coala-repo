cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-hash-merge
label: perl-hash-merge
doc: "The provided text does not contain help information for the tool. It consists
  of system error messages related to a lack of disk space during a container build
  process.\n\nTool homepage: http://metacpan.org/pod/Hash::Merge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-hash-merge:0.302--pl5321hdfd78af_1
stdout: perl-hash-merge.out
