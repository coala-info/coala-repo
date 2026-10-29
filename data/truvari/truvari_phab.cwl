cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - truvari
  - phab
label: truvari_phab
doc: "Wrapper around MAFFT and other tools to harmonize phased variants\n\nTool homepage: https://github.com/ACEnglish/truvari"
inputs:
  - id: region
    type: string
    doc: Bed filename or comma-separated list of chrom:start-end regions to process
    inputBinding:
      position: 1
      prefix: "-r"
  - id: reference
    type: File
    secondaryFiles:
      - .fai
    doc: Reference
    inputBinding:
      position: 1
      prefix: "-f"
  - id: output
    type:
      - 'null'
      - string
    default: phab_out.vcf.gz
    doc: Output VCF (phab_out.vcf.gz; must end with .vcf.gz)
    inputBinding:
      position: 1
      prefix: "-o"
  - id: maxsize
    type:
      - 'null'
      - int
    doc: Maximum size of variant to incorporate into haplotypes (50000)
    inputBinding:
      position: 1
      prefix: "--maxsize"
  - id: passonly
    type:
      - 'null'
      - boolean
    doc: Only incorporate passing variants (False)
    inputBinding:
      position: 1
      prefix: "--passonly"
  - id: no_dedup
    type:
      - 'null'
      - boolean
    doc: Don't dedupicate haplotypes before MSA
    inputBinding:
      position: 1
      prefix: "--no-dedup"
  - id: buffer
    type:
      - 'null'
      - int
    doc: Number of reference bases before/after region to add to MSA (100)
    inputBinding:
      position: 1
      prefix: "--buffer"
  - id: align
    type:
      - 'null'
      - type: enum
        symbols:
          - mafft
          - wfa
          - poa
    doc: Alignment method (poa)
    inputBinding:
      position: 1
      prefix: "--align"
  - id: mafft_params
    type:
      - 'null'
      - string
    doc: Parameters for mafft, wrap in a single quote (--auto --thread 1)
    inputBinding:
      position: 1
      prefix: "--mafft-params"
  - id: samples
    type:
      - 'null'
      - string
    doc: Subset of samples to MSA
    inputBinding:
      position: 1
      prefix: "--samples"
  - id: lowmem
    type:
      - 'null'
      - boolean
    doc: For harmonizing many samples
    inputBinding:
      position: 1
      prefix: "--lowmem"
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (1)
    inputBinding:
      position: 1
      prefix: "--threads"
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Verbose logging
    inputBinding:
      position: 1
      prefix: "--debug"
  - id: input
    type:
      type: array
      items: File
    secondaryFiles:
      - .tbi
    doc: Input VCFs to harmonize (bgzipped, with .tbi index)
    inputBinding:
      position: 2
outputs:
  - id: output_vcf
    type: File
    doc: Harmonized VCF (bgzipped)
    outputBinding:
      glob: "$(inputs.output)"
  - id: output_index
    type:
      - 'null'
      - File
    doc: Index of the harmonized VCF
    outputBinding:
      glob: "$(inputs.output).tbi"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
