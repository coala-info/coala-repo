cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdptools
label: rdptools
doc: "The provided text does not contain help information for rdptools; it contains
  error logs from a container runtime (Apptainer/Singularity) failing to pull the
  tool's image.\n\nTool homepage: http://rdp.cme.msu.edu/misc/resources.jsp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rdptools:2.0.3--hdfd78af_1
stdout: rdptools.out
