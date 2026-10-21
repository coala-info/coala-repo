cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - denovosim
label: rtg-tools_rtg_denovosim
doc: 'Generates a VCF containing a derived genotype containing de novo variants. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input
    type: File
    doc: 'input VCF containing genotype of original sample'
    secondaryFiles:
      - pattern: .tbi
        required: false
    inputBinding:
      position: 101
      prefix: --input
  - id: original
    type: string
    doc: 'name of the existing sample to use as the original genotype'
    inputBinding:
      position: 101
      prefix: --original
  - id: output
    type: string
    doc: 'output VCF file name'
    inputBinding:
      position: 101
      prefix: --output
  - id: output_sdf
    type:
      - 'null'
      - string
    doc: 'if set, output an SDF containing the sample genome'
    inputBinding:
      position: 101
      prefix: --output-sdf
  - id: reference
    type: Directory
    doc: 'SDF containing the reference genome'
    inputBinding:
      position: 101
      prefix: --reference
  - id: sample
    type: string
    doc: 'name for new derived sample'
    inputBinding:
      position: 101
      prefix: --sample
  - id: no_gzip
    type:
      - 'null'
      - boolean
    doc: 'do not gzip the output'
    inputBinding:
      position: 101
      prefix: --no-gzip
  - id: num_mutations
    type:
      - 'null'
      - int
    doc: 'expected number of de novo mutations per genome (Default is 70)'
    inputBinding:
      position: 101
      prefix: --num-mutations
  - id: ploidy
    type:
      - 'null'
      - string
    doc: 'ploidy to use. Allowed values are [auto, diploid, haploid] (Default is auto)'
    inputBinding:
      position: 101
      prefix: --ploidy
  - id: seed
    type:
      - 'null'
      - int
    doc: 'seed for the random number generator'
    inputBinding:
      position: 101
      prefix: --seed
  - id: show_mutations
    type:
      - 'null'
      - boolean
    doc: 'if set, display information regarding de novo mutation points'
    inputBinding:
      position: 101
      prefix: --show-mutations
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
  - id: sample_sdf
    type:
      - 'null'
      - Directory
    doc: Output SDF containing the sample genome (when output_sdf is set)
    outputBinding:
      glob: "$(inputs.output_sdf ? inputs.output_sdf : '__no_such_output__')"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_denovosim.out
