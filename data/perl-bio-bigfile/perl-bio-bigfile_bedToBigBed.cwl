cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedToBigBed
label: perl-bio-bigfile_bedToBigBed
doc: "The provided text is an error log indicating a failure to build or run the container
  (no space left on device) and does not contain the help text or usage information
  for the tool. As a result, no arguments could be extracted.\n\nTool homepage: https://metacpan.org/pod/Bio::DB::BigFile"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-bigfile:1.07--pl5321h41f7678_7
stdout: perl-bio-bigfile_bedToBigBed.out
