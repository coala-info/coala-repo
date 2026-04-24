cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nanopolish
  - variants
label: nanopolish_variants
doc: "Find SNPs using a signal-level HMM\n\nTool homepage: https://github.com/jts/nanopolish"
inputs:
  - id: alternative_basecalls_bam
    type:
      - 'null'
      - File
    doc: "if an alternative basecaller was used that does not output event annotations\n\
      \                                       then use basecalled sequences from FILE.
      The signal-level events will still be taken from the -b bam."
    inputBinding:
      position: 101
      prefix: --alternative-basecalls-bam
  - id: bam
    type: File
    doc: the reads aligned to the reference genome are in bam FILE
    inputBinding:
      position: 101
      prefix: --bam
  - id: calculate_all_support
    type:
      - 'null'
      - boolean
    doc: when making a call, also calculate the support of the 3 other possible 
      bases
    inputBinding:
      position: 101
      prefix: --calculate-all-support
  - id: candidates
    type:
      - 'null'
      - File
    doc: read variant candidates from VCF, rather than discovering them from 
      aligned reads
    inputBinding:
      position: 101
      prefix: --candidates
  - id: consensus
    type:
      - 'null'
      - boolean
    doc: run in consensus calling mode
    inputBinding:
      position: 101
      prefix: --consensus
  - id: event_bam
    type:
      - 'null'
      - File
    doc: the events aligned to the reference genome are in bam FILE
    inputBinding:
      position: 101
      prefix: --event-bam
  - id: faster
    type:
      - 'null'
      - boolean
    doc: minimize compute time while slightly reducing consensus accuracy
    inputBinding:
      position: 101
      prefix: --faster
  - id: fix_homopolymers
    type:
      - 'null'
      - boolean
    doc: run the experimental homopolymer caller
    inputBinding:
      position: 101
      prefix: --fix-homopolymers
  - id: genome
    type: File
    doc: the reference genome is in FILE
    inputBinding:
      position: 101
      prefix: --genome
  - id: genotype
    type:
      - 'null'
      - File
    doc: call genotypes for the variants in the vcf FILE
    inputBinding:
      position: 101
      prefix: --genotype
  - id: indel_bias
    type:
      - 'null'
      - float
    doc: "bias HMM transition parameters to favor insertions (F<1) or deletions (F>1).\n\
      \                                       this value is automatically set depending
      on --consensus, but can be manually set if spurious indels are called"
    inputBinding:
      position: 101
      prefix: --indel-bias
  - id: max_haplotypes
    type:
      - 'null'
      - int
    doc: 'consider at most N haplotype combinations (default: 1000)'
    inputBinding:
      position: 101
      prefix: --max-haplotypes
  - id: max_rounds
    type:
      - 'null'
      - int
    doc: 'perform N rounds of consensus sequence improvement (default: 50)'
    inputBinding:
      position: 101
      prefix: --max-rounds
  - id: methylation_aware
    type:
      - 'null'
      - string
    doc: 'turn on methylation aware polishing and test motifs given in STR (example:
      -q dcm,dam)'
    inputBinding:
      position: 101
      prefix: --methylation-aware
  - id: min_candidate_depth
    type:
      - 'null'
      - int
    doc: 'extract candidate variants from the aligned reads when the depth is at least
      D (default: 20)'
    inputBinding:
      position: 101
      prefix: --min-candidate-depth
  - id: min_candidate_frequency
    type:
      - 'null'
      - float
    doc: extract candidate variants from the aligned reads when the variant 
      frequency is at least F (default 0.2)
    inputBinding:
      position: 101
      prefix: --min-candidate-frequency
  - id: min_flanking_sequence
    type:
      - 'null'
      - int
    doc: 'distance from alignment end to calculate variants (default: 30)'
    inputBinding:
      position: 101
      prefix: --min-flanking-sequence
  - id: models_fofn
    type:
      - 'null'
      - File
    doc: read alternative k-mer models from FILE
    inputBinding:
      position: 101
      prefix: --models-fofn
  - id: ploidy
    type:
      - 'null'
      - int
    doc: the ploidy level of the sequenced genome
    inputBinding:
      position: 101
      prefix: --ploidy
  - id: read_group
    type:
      - 'null'
      - string
    doc: only use alignments with read group tag RG
    inputBinding:
      position: 101
      prefix: --read-group
  - id: reads
    type: File
    doc: the ONT reads are in fasta FILE
    inputBinding:
      position: 101
      prefix: --reads
  - id: snps
    type:
      - 'null'
      - boolean
    doc: only call SNPs
    inputBinding:
      position: 101
      prefix: --snps
  - id: threads
    type:
      - 'null'
      - int
    doc: 'use NUM threads (default: 1)'
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: window
    type:
      - 'null'
      - string
    doc: 'find variants in window STR (format: <chromsome_name>:<start>-<end>)'
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: 'write result to FILE [default: stdout]'
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopolish:0.14.0--h773013f_3
