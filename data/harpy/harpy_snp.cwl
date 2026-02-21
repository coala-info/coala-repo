cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - snp
label: harpy_snp
doc: "Call SNPs and small indels from alignments. Provide an additional subcommand
  mpileup or freebayes to get more information on using those variant callers. They
  are both robust variant callers, but freebayes is recommended when ploidy is greater
  than 2.\n\nTool homepage: https://github.com/pdimens/harpy/"
inputs:
  - id: command
    type: string
    doc: "The subcommand to execute: 'freebayes' (Call variants using freebayes) or
      'mpileup' (Call variants from using bcftools mpileup)"
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments passed to the selected subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
stdout: harpy_snp.out
