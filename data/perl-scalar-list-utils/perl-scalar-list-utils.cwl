cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-scalar-list-utils
label: perl-scalar-list-utils
doc: "A Perl module providing a selection of general-utility scalar and list subroutines.
  (Note: The provided text contains only system error messages and no CLI usage information.)\n\
  \nTool homepage: http://metacpan.org/pod/Scalar-List-Utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-scalar-list-utils:1.62--pl5321hec16e2b_1
stdout: perl-scalar-list-utils.out
