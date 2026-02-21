cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-file-tee
label: perl-file-tee
doc: "The provided text does not contain help information or usage instructions; it
  is an error log indicating that the executable 'perl-file-tee' was not found in
  the system path.\n\nTool homepage: http://metacpan.org/pod/File::Tee"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-tee:0.07--pl5.22.0_0
stdout: perl-file-tee.out
