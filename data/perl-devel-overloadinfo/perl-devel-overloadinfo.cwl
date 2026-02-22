cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-devel-overloadinfo
label: perl-devel-overloadinfo
doc: "The provided text does not contain help information or a description for the
  tool; it is an error log related to a container execution failure due to insufficient
  disk space.\n\nTool homepage: http://metacpan.org/pod/Devel::OverloadInfo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-devel-overloadinfo:0.007--pl5321hdfd78af_0
stdout: perl-devel-overloadinfo.out
