cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-moosex-app
label: perl-moosex-app
doc: "The provided text does not contain help information or usage instructions. It
  is an error log from an Apptainer/Singularity environment indicating that the executable
  'perl-moosex-app' was not found in the system PATH.\n\nTool homepage: http://metacpan.org/pod/MooseX::App"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-moosex-app:1.3701--pl526_0
stdout: perl-moosex-app.out
