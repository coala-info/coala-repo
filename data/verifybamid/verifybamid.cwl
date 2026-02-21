cwlVersion: v1.2
class: CommandLineTool
baseCommand: verifybamid
label: verifybamid
doc: "VerifyBamID is a software tool to verify whether the reads in a BAM file match
  a known genotype call set, and/or to estimate the level of DNA contamination.\n\n
  Tool homepage: https://github.com/Griffan/VerifyBamID"
inputs:
  - id: bam
    type: File
    doc: BAM/SAM file to be verified
    inputBinding:
      position: 101
      prefix: --bam
  - id: best
    type:
      - 'null'
      - boolean
    doc: Find the best matching sample in the VCF
    inputBinding:
      position: 101
      prefix: --best
  - id: chip_none
    type:
      - 'null'
      - boolean
    doc: Do not use chip genotypes
    inputBinding:
      position: 101
      prefix: --chip-none
  - id: geno_error
    type:
      - 'null'
      - float
    doc: Genotype error rate
    inputBinding:
      position: 101
      prefix: --genoError
  - id: max_af
    type:
      - 'null'
      - float
    doc: Maximum allele frequency
    inputBinding:
      position: 101
      prefix: --maxAF
  - id: min_af
    type:
      - 'null'
      - float
    doc: Minimum allele frequency
    inputBinding:
      position: 101
      prefix: --minAF
  - id: min_call_rate
    type:
      - 'null'
      - float
    doc: Minimum call rate
    inputBinding:
      position: 101
      prefix: --minCallRate
  - id: self
    type:
      - 'null'
      - boolean
    doc: Verify the sample against itself
    inputBinding:
      position: 101
      prefix: --self
  - id: sm_id
    type:
      - 'null'
      - string
    doc: Sample ID to verify
    inputBinding:
      position: 101
      prefix: --smID
  - id: subset
    type:
      - 'null'
      - File
    doc: VCF file containing a subset of markers to use
    inputBinding:
      position: 101
      prefix: --subset
  - id: threshold
    type:
      - 'null'
      - float
    doc: Threshold for contamination
    inputBinding:
      position: 101
      prefix: --threshold
  - id: vcf
    type: File
    doc: VCF file containing the population genotypes
    inputBinding:
      position: 101
      prefix: --vcf
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out
    type: File
    doc: Output file prefix
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/verifybamid:1.1.3--h5b5514e_6
