cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - vcfstats
label: rtg-tools_rtg_vcfstats
doc: 'Display statistics from a set of VCF files. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: known
    type:
      - 'null'
      - boolean
    doc: 'only calculate statistics for known variants (Default is to ignore known/novel status)'
    inputBinding:
      position: 101
      prefix: --known
  - id: novel
    type:
      - 'null'
      - boolean
    doc: 'only calculate statistics for novel variants (Default is to ignore known/novel status)'
    inputBinding:
      position: 101
      prefix: --novel
  - id: sample
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --sample
    doc: 'only calculate statistics for the specified sample (Default is to include all samples). May be specified 0 or more times'
    inputBinding:
      position: 101
  - id: allele_lengths
    type:
      - 'null'
      - boolean
    doc: 'output variant length histogram'
    inputBinding:
      position: 101
      prefix: --allele-lengths
  - id: vcf_files
    type:
      type: array
      items: File
    doc: 'input VCF files from which to derive statistics'
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_vcfstats.out
