cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio-seq
label: perl-bio-bpwrapper_bio-seq
doc: "A tool from the Bio-BPWrapper suite. Note: The provided help text contains system
  error logs regarding a failed container build ('no space left on device') and does
  not contain usage information or argument definitions.\n\nTool homepage: http://metacpan.org/pod/Bio::BPWrapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-bpwrapper:1.15--pl5321hdfd78af_0
stdout: perl-bio-bpwrapper_bio-seq.out
