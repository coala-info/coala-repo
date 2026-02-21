cwlVersion: v1.2
class: CommandLineTool
baseCommand: SnpSift.jar
label: snpsift_SnpSift.jar
doc: "SnpSift is a toolbox to filter and manipulate VCF files. (Note: The provided
  text appears to be a container runtime error log rather than the tool's help text;
  therefore, no arguments could be extracted.)\n\nTool homepage: http://snpeff.sourceforge.net/SnpSift.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpsift:5.4.0a--hdfd78af_0
stdout: snpsift_SnpSift.jar.out
