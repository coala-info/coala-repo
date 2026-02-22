cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-business-isbn-data
label: perl-business-isbn-data
doc: "The perl-business-isbn-data package provides data for the Business::ISBN Perl
  module, which is used to work with International Standard Book Numbers.\n\nTool
  homepage: https://github.com/briandfoy/business-isbn-data"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-business-isbn-data:20210112.006--pl5321hdfd78af_0
stdout: perl-business-isbn-data.out
