cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-moosex-nonmoose
label: perl-moosex-nonmoose
doc: "MooseX::NonMoose is a Perl module that allows for easy subclassing of non-Moose
  classes. Note: The provided text appears to be a system error log (Singularity/OCI
  conversion failure) rather than the tool's help documentation.\n\nTool homepage:
  https://github.com/moose/MooseX-NonMoose"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-moosex-nonmoose:0.27--pl5321hdfd78af_0
stdout: perl-moosex-nonmoose.out
