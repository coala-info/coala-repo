cwlVersion: v1.2
class: CommandLineTool
baseCommand: kanpig gt
label: kanpig_gt
doc: "Germline SV Genotyping\n\nTool homepage: https://github.com/ACEnglish/kanpig"
inputs:
  - id: ab
    type:
      - 'null'
      - float
    doc: Minimum allele balance for compound het lower VAF (off=0)
    inputBinding:
      position: 101
      prefix: --ab
  - id: bed
    type:
      - 'null'
      - File
    doc: Regions to analyze
    inputBinding:
      position: 101
      prefix: --bed
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Verbose logging
    inputBinding:
      position: 101
      prefix: --debug
  - id: fnmax
    type:
      - 'null'
      - int
    doc: Maximum FNs allowed in a path
    inputBinding:
      position: 101
      prefix: --fnmax
  - id: fpenalty
    type:
      - 'null'
      - float
    doc: Scoring penalty for FNs
    inputBinding:
      position: 101
      prefix: --fpenalty
  - id: gpenalty
    type:
      - 'null'
      - float
    doc: Scoring penalty for gaps
    inputBinding:
      position: 101
      prefix: --gpenalty
  - id: gqconfig
    type:
      - 'null'
      - string
    doc: GQ Config
    inputBinding:
      position: 101
      prefix: --gqconfig
  - id: hapsim
    type:
      - 'null'
      - float
    doc: Collapse haplotypes of similar size (off=1)
    inputBinding:
      position: 101
      prefix: --hapsim
  - id: hps_weight
    type:
      - 'null'
      - float
    doc: Clustering weight for haplotagged reads (off=0.0, full=1.0)
    inputBinding:
      position: 101
      prefix: --hps-weight
  - id: input
    type: File
    doc: VCF to genotype
    inputBinding:
      position: 101
      prefix: --input
  - id: kmer
    type:
      - 'null'
      - int
    doc: Kmer size for featurization
    inputBinding:
      position: 101
      prefix: --kmer
  - id: mapflag
    type:
      - 'null'
      - int
    doc: Ignore alignments matching flag
    inputBinding:
      position: 101
      prefix: --mapflag
  - id: mapq
    type:
      - 'null'
      - int
    doc: Minimum mapq score for reads
    inputBinding:
      position: 101
      prefix: --mapq
  - id: maxcoverage
    type:
      - 'null'
      - int
    doc: Maximum coverage to attempt building haplotypes
    inputBinding:
      position: 101
      prefix: --maxcoverage
  - id: maxnodes
    type:
      - 'null'
      - int
    doc: Maximum graph size to search; otherwise perform 1-to-1
    inputBinding:
      position: 101
      prefix: --maxnodes
  - id: maxpaths
    type:
      - 'null'
      - int
    doc: Maximum paths to traverse per graph
    inputBinding:
      position: 101
      prefix: --maxpaths
  - id: mincoverage
    type:
      - 'null'
      - int
    doc: Minimum coverage to attempt building haplotypes
    inputBinding:
      position: 101
      prefix: --mincoverage
  - id: minkfreq
    type:
      - 'null'
      - int
    doc: Minimum frequency of kmers
    inputBinding:
      position: 101
      prefix: --minkfreq
  - id: neighdist
    type:
      - 'null'
      - int
    doc: Maximum variant distance within graphs
    inputBinding:
      position: 101
      prefix: --neighdist
  - id: one_to_one
    type:
      - 'null'
      - boolean
    doc: Restrict to 1-to-1 haplotype/node matching
    inputBinding:
      position: 101
      prefix: --one-to-one
  - id: passonly
    type:
      - 'null'
      - boolean
    doc: Only analyze variants with PASS FILTER
    inputBinding:
      position: 101
      prefix: --passonly
  - id: pileupmax
    type:
      - 'null'
      - int
    doc: Maximum pileups allowed for partials matching
    inputBinding:
      position: 101
      prefix: --pileupmax
  - id: ploidy_bed
    type:
      - 'null'
      - File
    doc: Bed file of non-diploid regions
    inputBinding:
      position: 101
      prefix: --ploidy-bed
  - id: reads
    type: File
    doc: Reads to genotype (indexed .bam, .cram, or .plup.gz)
    inputBinding:
      position: 101
      prefix: --reads
  - id: reference
    type: File
    doc: Reference genome
    inputBinding:
      position: 101
      prefix: --reference
  - id: rnames
    type:
      - 'null'
      - File
    doc: Output RNAMES file
    inputBinding:
      position: 101
      prefix: --rnames
  - id: sample
    type:
      - 'null'
      - string
    doc: Output VCF sample name
    inputBinding:
      position: 101
      prefix: --sample
  - id: seqsim
    type:
      - 'null'
      - float
    doc: Minimum sequence similarity for paths
    inputBinding:
      position: 101
      prefix: --seqsim
  - id: sizemax
    type:
      - 'null'
      - int
    doc: Maximum size of variant to analyze
    inputBinding:
      position: 101
      prefix: --sizemax
  - id: sizemin
    type:
      - 'null'
      - int
    doc: Minimum size of variant to analyze
    inputBinding:
      position: 101
      prefix: --sizemin
  - id: sizesim
    type:
      - 'null'
      - float
    doc: Minimum size similarity for paths
    inputBinding:
      position: 101
      prefix: --sizesim
  - id: squish
    type:
      - 'null'
      - boolean
    doc: Prefer simplier paths during scoring
    inputBinding:
      position: 101
      prefix: --squish
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output VCF (unsorted, uncompressed)
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kanpig:2.0.2--ha6fb395_0
