cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpsift
label: snpsift
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  attempting to fetch the SnpSift image.\n\nTool homepage: http://snpeff.sourceforge.net/SnpSift.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpsift:5.4.0a--hdfd78af_0
stdout: snpsift.out
