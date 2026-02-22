cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-class-xsaccessor
label: perl-class-xsaccessor
doc: "The provided text does not contain help information or documentation for the
  tool. It consists of error messages related to a failed Singularity/OCI container
  build process caused by insufficient disk space ('no space left on device').\n\n\
  Tool homepage: http://metacpan.org/pod/Class::XSAccessor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-class-xsaccessor:1.19--pl5321h7b50bb2_8
stdout: perl-class-xsaccessor.out
