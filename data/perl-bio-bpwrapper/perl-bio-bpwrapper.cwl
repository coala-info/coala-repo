cwlVersion: v1.2
class: CommandLineTool
baseCommand: bpwrapper
label: perl-bio-bpwrapper
doc: "The provided text does not contain help information or usage instructions. It
  consists of system error messages related to a failed container build (no space
  left on device) while attempting to fetch the perl-bio-bpwrapper image.\n\nTool
  homepage: http://metacpan.org/pod/Bio::BPWrapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-bpwrapper:1.15--pl5321hdfd78af_0
stdout: perl-bio-bpwrapper.out
