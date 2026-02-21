cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio-tree
label: perl-bio-bpwrapper_bio-tree
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build or fetch a container image
  due to insufficient disk space ('no space left on device').\n\nTool homepage: http://metacpan.org/pod/Bio::BPWrapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-bpwrapper:1.15--pl5321hdfd78af_0
stdout: perl-bio-bpwrapper_bio-tree.out
