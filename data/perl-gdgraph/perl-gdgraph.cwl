cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-gdgraph
label: perl-gdgraph
doc: "The provided text does not contain help information or usage instructions for
  perl-gdgraph. It appears to be a log of a failed container build (Apptainer/Singularity)
  due to insufficient disk space.\n\nTool homepage: https://metacpan.org/pod/GDGraph"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-gdgraph:1.56--pl5321hdfd78af_0
stdout: perl-gdgraph.out
