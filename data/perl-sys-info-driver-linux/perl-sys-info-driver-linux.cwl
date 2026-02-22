cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-sys-info-driver-linux
label: perl-sys-info-driver-linux
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of error messages related to a failed container build (Singularity/Apptainer)
  due to insufficient disk space.\n\nTool homepage: http://metacpan.org/pod/Sys::Info::Driver::Linux"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-sys-info-driver-linux:0.7911--pl5321hdfd78af_0
stdout: perl-sys-info-driver-linux.out
