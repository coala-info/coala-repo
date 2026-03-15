cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - snp
label: harpy_snp
doc: Call SNPs and small indels from alignments. Provide an additional 
  subcommand mpileup or freebayes to get more information on using those variant
  callers. They are both robust variant callers, but freebayes is recommended 
  when ploidy is greater than 2.
inputs:
  - id: command
    type: string
    doc: The variant caller subcommand to use (freebayes or mpileup)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments passed to the subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
stdout: harpy_snp.out
s:url: https://github.com/pdimens/harpy/
$namespaces:
  s: https://schema.org/
