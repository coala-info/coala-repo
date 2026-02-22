cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-text-parsewords
label: perl-text-parsewords
doc: "The provided text contains system error messages related to a container runtime
  (Singularity/Apptainer) failing to pull the image due to lack of disk space. It
  does not contain help text or usage information for the tool itself.\n\nTool homepage:
  http://metacpan.org/pod/Text::ParseWords"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-text-parsewords:3.31--pl5321hdfd78af_0
stdout: perl-text-parsewords.out
