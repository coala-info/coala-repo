cwlVersion: v1.2
class: CommandLineTool
baseCommand: verifyBamID
label: verifybamid
doc: "VerifyBamID is a software tool to verify whether the reads in a BAM file match
  a known genotype call set, and/or to estimate the level of DNA contamination.\n\n\
  \ Tool homepage: https://github.com/Griffan/VerifyBamID"
inputs:
  - id: vcf
    type: File
    doc: VCF file containing the population genotypes (GT) and allele frequencies (AF in INFO)
    inputBinding:
      position: 101
      prefix: --vcf
  - id: bam
    type: File
    doc: BAM file to be verified
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 101
      prefix: --bam
  - id: bai
    type: ['null', File]
    doc: Index file of the BAM (default is the BAM file name plus .bai)
    inputBinding:
      position: 101
      prefix: --bai
  - id: subset
    type: ['null', File]
    doc: File with a list of sample IDs to use from the VCF
    inputBinding:
      position: 101
      prefix: --subset
  - id: sm_id
    type: ['null', string]
    doc: Sample ID of the chip genotype to compare with
    inputBinding:
      position: 101
      prefix: --smID
  - id: geno_error
    type: ['null', float]
    doc: "Genotype error rate [0.001]"
    inputBinding:
      position: 101
      prefix: --genoError
  - id: min_af
    type: ['null', float]
    doc: "Minimum allele frequency [0.01]"
    inputBinding:
      position: 101
      prefix: --minAF
  - id: min_call_rate
    type: ['null', float]
    doc: "Minimum call rate [0.50]"
    inputBinding:
      position: 101
      prefix: --minCallRate
  - id: site
    type: ['null', boolean]
    doc: Compare reads with the genotypes of all individuals at the site level
    inputBinding:
      position: 101
      prefix: --site
  - id: self
    type: ['null', boolean]
    doc: Verify the sample against its own genotypes in the VCF
    inputBinding:
      position: 101
      prefix: --self
  - id: best
    type: ['null', boolean]
    doc: Find the best matching sample in the VCF
    inputBinding:
      position: 101
      prefix: --best
  - id: free_none
    type: ['null', boolean]
    doc: "Chip-free optimization: no optimization"
    inputBinding:
      position: 101
      prefix: --free-none
  - id: free_mix
    type: ['null', boolean]
    doc: "Chip-free optimization: estimate the mixture fraction [default on]"
    inputBinding:
      position: 101
      prefix: --free-mix
  - id: free_ref_bias
    type: ['null', boolean]
    doc: "Chip-free optimization: estimate mixture and reference bias"
    inputBinding:
      position: 101
      prefix: --free-refBias
  - id: free_full
    type: ['null', boolean]
    doc: "Chip-free optimization: full optimization"
    inputBinding:
      position: 101
      prefix: --free-full
  - id: chip_none
    type: ['null', boolean]
    doc: "With-chip optimization: no optimization"
    inputBinding:
      position: 101
      prefix: --chip-none
  - id: chip_mix
    type: ['null', boolean]
    doc: "With-chip optimization: estimate the mixture fraction [default on]"
    inputBinding:
      position: 101
      prefix: --chip-mix
  - id: chip_ref_bias
    type: ['null', boolean]
    doc: "With-chip optimization: estimate mixture and reference bias"
    inputBinding:
      position: 101
      prefix: --chip-refBias
  - id: chip_full
    type: ['null', boolean]
    doc: "With-chip optimization: full optimization"
    inputBinding:
      position: 101
      prefix: --chip-full
  - id: ignore_rg
    type: ['null', boolean]
    doc: Ignore read group information and treat all reads as one library
    inputBinding:
      position: 101
      prefix: --ignoreRG
  - id: ignore_overlap_pair
    type: ['null', boolean]
    doc: Ignore overlapping read pairs
    inputBinding:
      position: 101
      prefix: --ignoreOverlapPair
  - id: no_eof
    type: ['null', boolean]
    doc: Allow a BAM file without the EOF marker
    inputBinding:
      position: 101
      prefix: --noEOF
  - id: precise
    type: ['null', boolean]
    doc: Use the more precise (slower) likelihood computation
    inputBinding:
      position: 101
      prefix: --precise
  - id: min_map_q
    type: ['null', int]
    doc: "Minimum mapping quality [10]"
    inputBinding:
      position: 101
      prefix: --minMapQ
  - id: max_depth
    type: ['null', int]
    doc: "Maximum depth per site [20]"
    inputBinding:
      position: 101
      prefix: --maxDepth
  - id: min_q
    type: ['null', int]
    doc: "Minimum base quality [13]"
    inputBinding:
      position: 101
      prefix: --minQ
  - id: max_q
    type: ['null', int]
    doc: "Maximum base quality [40]"
    inputBinding:
      position: 101
      prefix: --maxQ
  - id: grid
    type: ['null', float]
    doc: "Step size of the mixture grid [0.05]"
    inputBinding:
      position: 101
      prefix: --grid
  - id: ref_ref
    type: ['null', float]
    doc: "Reference bias: probability of a reference read at a reference homozygous site [1.00]"
    inputBinding:
      position: 101
      prefix: --refRef
  - id: ref_het
    type: ['null', float]
    doc: "Reference bias: probability of a reference read at a heterozygous site [0.50]"
    inputBinding:
      position: 101
      prefix: --refHet
  - id: ref_alt
    type: ['null', float]
    doc: "Reference bias: probability of a reference read at an alternate homozygous site [0.00]"
    inputBinding:
      position: 101
      prefix: --refAlt
  - id: verbose
    type: ['null', boolean]
    doc: Verbose output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: no_phone_home
    type: ['null', boolean]
    doc: Do not send usage statistics
    inputBinding:
      position: 101
      prefix: --noPhoneHome
  - id: phone_home_thinning
    type: ['null', int]
    doc: "Phone home thinning [50]"
    inputBinding:
      position: 101
      prefix: --phoneHomeThinning
  - id: out_path
    type: string
    doc: Output file prefix
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Result files written with the output prefix (.selfSM, .selfRG, .depthSM, .depthRG, .bestSM, .bestRG, .log)
    outputBinding:
      glob: $(inputs.out_path).*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/verifybamid:1.1.3--h5b5514e_6
