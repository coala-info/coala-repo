cwlVersion: v1.2
class: CommandLineTool
baseCommand: go2fmt.pl
label: perl-go-perl_go2fmt.pl
doc: "Note: The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or run the container due to insufficient disk space.
  It does not contain the actual help text or usage instructions for the tool.\n\n
  Tool homepage: http://metacpan.org/pod/go-perl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-go-perl:0.15--pl526_3
stdout: perl-go-perl_go2fmt.pl.out
