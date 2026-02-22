cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-digest-perl-md5
label: perl-digest-perl-md5
doc: "A Perl implementation of the MD5 algorithm. Note: The provided text appears
  to be a system error log regarding a failed container build/pull due to lack of
  disk space, rather than the tool's help documentation.\n\nTool homepage: http://metacpan.org/pod/Digest-Perl-MD5"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-digest-perl-md5:1.91--pl5321hdfd78af_0
stdout: perl-digest-perl-md5.out
