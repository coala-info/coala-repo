cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio-vcf
label: bio-vcf
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for bio-vcf. As
  a result, no arguments could be extracted.\n\nTool homepage: https://github.com/vcflib/bio-vcf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio-vcf:0.9.5--hdfd78af_0
stdout: bio-vcf.out
