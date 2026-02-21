cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphviz_dot
label: perl-graphviz_dot
doc: "The provided text does not contain help information or usage instructions for
  the tool. It is an error log from a container build process (Apptainer/Singularity)
  indicating a 'no space left on device' failure.\n\nTool homepage: https://metacpan.org/pod/GraphViz"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-graphviz:2.26--pl5321h46c88eb_0
stdout: perl-graphviz_dot.out
