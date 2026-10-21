cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - samplesim
label: rtg-tools_rtg_samplesim
doc: 'Generates a VCF containing a genotype simulated from population variants according to allele frequency. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input
    type: File
    doc: 'input VCF containing population variants'
    secondaryFiles:
      - pattern: .tbi
        required: false
    inputBinding:
      position: 101
      prefix: --input
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
    doc: 'name for sample'
    inputBinding:
      position: 101
      prefix: --sample
  - id: allow_missing_af
    type:
      - 'null'
      - boolean
    doc: 'if set, treat variants without allele frequency annotation as uniformly likely'
    inputBinding:
      position: 101
      prefix: --allow-missing-af
  - id: no_gzip
    type:
      - 'null'
      - boolean
    doc: 'do not gzip the output'
    inputBinding:
      position: 101
      prefix: --no-gzip
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
  - id: sex
    type:
      - 'null'
      - string
    doc: 'sex of individual. Allowed values are [male, female, either] (Default is either)'
    inputBinding:
      position: 101
      prefix: --sex
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
stdout: rtg-tools_rtg_samplesim.out
