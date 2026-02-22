cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-text-tabs-wrap
label: perl-text-tabs-wrap
doc: "The provided text does not contain help documentation. It consists of system
  error messages indicating a failure to build or run a Singularity/Docker container
  due to insufficient disk space ('no space left on device').\n\nTool homepage: http://metacpan.org/pod/Text::Tabs+Wrap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-text-tabs-wrap:2021.0814--pl5321hdfd78af_0
stdout: perl-text-tabs-wrap.out
