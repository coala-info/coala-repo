cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio-search
label: perl-bio-bpwrapper_bio-search
doc: "A tool from the Bio-BPWrapper suite. Note: The provided help text contains only
  system error messages regarding a failed container build (no space left on device)
  and does not list command-line arguments.\n\nTool homepage: http://metacpan.org/pod/Bio::BPWrapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-bpwrapper:1.15--pl5321hdfd78af_0
stdout: perl-bio-bpwrapper_bio-search.out
