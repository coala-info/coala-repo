cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-mime-tools
label: perl-mime-tools
doc: "The provided text does not contain help information or usage instructions. It
  is an error log from a container runtime (Singularity/Apptainer) indicating a failure
  to pull or build the container image due to insufficient disk space ('no space left
  on device').\n\nTool homepage: https://metacpan.org/pod/MIME-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-mime-tools:5.515--pl5321hdfd78af_0
stdout: perl-mime-tools.out
