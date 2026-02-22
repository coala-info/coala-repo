cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-ipc-sharelite
label: perl-ipc-sharelite
doc: "A Perl module that provides a simple interface to shared memory (IPC). Note:
  The provided text contains system error messages regarding container image retrieval
  and does not contain CLI help documentation.\n\nTool homepage: http://metacpan.org/pod/IPC::ShareLite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-ipc-sharelite:0.17--pl5321h9948957_7
stdout: perl-ipc-sharelite.out
