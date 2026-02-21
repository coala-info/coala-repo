cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jvarkit
  - dict2vcf
label: jvarkit_dict2vcf
doc: "A tool to convert a sequence dictionary to a VCF file. (Note: The provided help
  text contains system error messages regarding container execution and does not list
  specific command-line arguments.)\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
stdout: jvarkit_dict2vcf.out
