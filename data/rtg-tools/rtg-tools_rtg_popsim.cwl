cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - popsim
label: rtg-tools_rtg_popsim
doc: 'Generates a VCF containing simulated population variants. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: output
    type: string
    doc: 'output VCF file name'
    inputBinding:
      position: 101
      prefix: --output
  - id: reference
    type: Directory
    doc: 'SDF containing the reference genome'
    inputBinding:
      position: 101
      prefix: --reference
  - id: no_gzip
    type:
      - 'null'
      - boolean
    doc: 'do not gzip the output'
    inputBinding:
      position: 101
      prefix: --no-gzip
  - id: seed
    type:
      - 'null'
      - int
    doc: 'seed for the random number generator'
    inputBinding:
      position: 101
      prefix: --seed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: vcf
    type:
      type: array
      items: File
    doc: Output VCF file(s) (gzipped VCF and its tabix index unless --no-gzip is set)
    outputBinding:
      glob: $(inputs.output)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_popsim.out
