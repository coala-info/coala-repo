cwlVersion: v1.2
class: CommandLineTool
baseCommand: simug_vcf2model.pl
label: simug_vcf2model.pl
doc: "A tool to convert VCF files to a model for simUG. (Note: The provided text contains
  container runtime logs and a fatal error rather than the tool's help documentation;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/yjx1217/simuG"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simug:1.0.1--hdfd78af_0
stdout: simug_vcf2model.pl.out
