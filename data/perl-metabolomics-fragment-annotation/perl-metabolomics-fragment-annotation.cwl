cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-metabolomics-fragment-annotation
label: perl-metabolomics-fragment-annotation
doc: "A tool for metabolomics fragment annotation. Note: The provided text contains
  system error logs regarding a container build failure ('no space left on device')
  rather than the tool's help documentation, so no arguments could be extracted.\n
  \nTool homepage: https://metacpan.org/pod/Metabolomics::Fragment::Annotation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-metabolomics-fragment-annotation:0.6.9--pl5321hdfd78af_0
stdout: perl-metabolomics-fragment-annotation.out
