cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - mendelian
label: rtg-tools_rtg_mendelian
doc: 'Check a multi-sample VCF for Mendelian consistency. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input
    type: File
    doc: 'VCF file containing multi-sample variant calls'
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type:
      - 'null'
      - string
    doc: 'if set, output annotated calls to this VCF file'
    inputBinding:
      position: 101
      prefix: --output
  - id: output_consistent
    type:
      - 'null'
      - string
    doc: 'if set, output only consistent calls to this VCF file'
    inputBinding:
      position: 101
      prefix: --output-consistent
  - id: output_inconsistent
    type:
      - 'null'
      - string
    doc: 'if set, output only non-Mendelian calls to this VCF file'
    inputBinding:
      position: 101
      prefix: --output-inconsistent
  - id: template
    type: Directory
    doc: 'SDF containing the reference genome'
    inputBinding:
      position: 101
      prefix: --template
  - id: all_records
    type:
      - 'null'
      - boolean
    doc: 'use all records, regardless of filters (Default is to only process records where FILTER is "." or "PASS")'
    inputBinding:
      position: 101
      prefix: --all-records
  - id: lenient
    type:
      - 'null'
      - boolean
    doc: 'allow homozygous diploid calls in place of haploid calls and assume missing values are equal to the reference'
    inputBinding:
      position: 101
      prefix: --lenient
  - id: min_concordance
    type:
      - 'null'
      - float
    doc: 'percentage concordance required for consistent parentage (Default is 99.0)'
    inputBinding:
      position: 101
      prefix: --min-concordance
  - id: pedigree
    type:
      - 'null'
      - File
    doc: 'genome relationships PED file (Default is to extract pedigree information from VCF header fields)'
    inputBinding:
      position: 101
      prefix: --pedigree
  - id: no_gzip
    type:
      - 'null'
      - boolean
    doc: 'do not gzip the output'
    inputBinding:
      position: 101
      prefix: --no-gzip
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_files
    type:
      type: array
      items: File
    doc: 'Annotated VCF'
    outputBinding:
      glob: "$(inputs.output ? inputs.output+'*' : [])"
  - id: consistent_files
    type:
      type: array
      items: File
    doc: 'Consistent calls'
    outputBinding:
      glob: "$(inputs.output_consistent ? inputs.output_consistent+'*' : [])"
  - id: inconsistent_files
    type:
      type: array
      items: File
    doc: 'Non-Mendelian calls'
    outputBinding:
      glob: "$(inputs.output_inconsistent ? inputs.output_inconsistent+'*' : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_mendelian.out
