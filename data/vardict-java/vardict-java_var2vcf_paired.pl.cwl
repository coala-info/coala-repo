cwlVersion: v1.2
class: CommandLineTool
baseCommand: vardict-java_var2vcf_paired.pl
label: vardict-java_var2vcf_paired.pl
doc: "The provided text does not contain help information for the tool. It contains
  container runtime log messages and a fatal error regarding an OCI image build failure.\n
  \nTool homepage: https://github.com/AstraZeneca-NGS/VarDictJava"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vardict-java:1.8.3--hdfd78af_0
stdout: vardict-java_var2vcf_paired.pl.out
