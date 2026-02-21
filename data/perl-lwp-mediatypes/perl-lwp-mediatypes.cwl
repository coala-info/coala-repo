cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-lwp-mediatypes
label: perl-lwp-mediatypes
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating that the executable 'perl-lwp-mediatypes' was not found in the system
  PATH during an Apptainer/Singularity build process.\n\nTool homepage: http://metacpan.org/pod/LWP::MediaTypes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-lwp-mediatypes:6.04--pl526_0
stdout: perl-lwp-mediatypes.out
