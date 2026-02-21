cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jvarkit
  - vcf2bam
label: jvarkit_vcf2bam
doc: "Convert VCF to BAM (Note: The provided text is a system error log and does not
  contain usage or argument information).\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
stdout: jvarkit_vcf2bam.out
