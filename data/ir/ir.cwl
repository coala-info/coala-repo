cwlVersion: v1.2
class: CommandLineTool
baseCommand: ir
label: ir
doc: "The provided text does not contain help information for the tool 'ir'. It consists
  of error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the container image due to lack of disk space.\n\nTool homepage: http://guanine.evolbio.mpg.de/cgi-bin/ir/ir.cgi.pl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ir:2.8.0--h7b50bb2_8
stdout: ir.out
