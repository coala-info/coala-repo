cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-version
label: perl-version
doc: "The provided text does not contain help information for 'perl-version'. It appears
  to be an error log from a container runtime (Apptainer/Singularity) indicating that
  the executable was not found in the system PATH.\n\nTool homepage: http://metacpan.org/pod/version"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-version:0.9924--pl526_0
stdout: perl-version.out
