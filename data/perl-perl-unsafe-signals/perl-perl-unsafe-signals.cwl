cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl
label: perl-perl-unsafe-signals
doc: "The provided text does not contain help documentation or usage instructions.
  It appears to be an error log from a Singularity/Docker container execution failure
  due to insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/pld-linux/perl-Perl-Unsafe-Signals"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-perl-unsafe-signals:0.03--pl5321h9948957_9
stdout: perl-perl-unsafe-signals.out
