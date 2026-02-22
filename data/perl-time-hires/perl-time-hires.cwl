cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-time-hires
label: perl-time-hires
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log indicating a failure to pull or build a container
  image due to insufficient disk space ('no space left on device').\n\nTool homepage:
  http://metacpan.org/pod/Time::HiRes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-time-hires:1.9764--pl5321h7b50bb2_6
stdout: perl-time-hires.out
