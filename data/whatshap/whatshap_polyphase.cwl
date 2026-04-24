cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - whatshap
  - polyphase
label: whatshap_polyphase
doc: "Phase variants in a polyploid VCF using a clustering+threading algorithm.\n\n\
  Tool homepage: https://whatshap.readthedocs.io"
inputs:
  - id: vcf
    type: File
    doc: VCF file with variants to be phased (can be gzip-compressed)
    inputBinding:
      position: 1
  - id: phase_input
    type:
      type: array
      items: File
    doc: BAM or CRAM with sequencing reads.
    inputBinding:
      position: 2
  - id: block_cut_sensitivity
    type:
      - 'null'
      - float
    doc: 'Strategy to determine block borders. 0 yields the longest blocks with more
      switch errors, 5 has the shortest blocks with lowest switch error rate (default:
      4).'
    inputBinding:
      position: 103
      prefix: --block-cut-sensitivity
  - id: chromosome
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of chromosome to phase. If not given, all chromosomes in the input
      VCF are phased. Can be used multiple times.
    inputBinding:
      position: 103
      prefix: --chromosome
  - id: distrust_genotypes
    type:
      - 'null'
      - boolean
    doc: Allows the phaser to change genotypes if beneficial for the internal 
      model.
    inputBinding:
      position: 103
      prefix: --distrust-genotypes
  - id: exclude_chromosome
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of chromosome not to phase.
    inputBinding:
      position: 103
      prefix: --exclude-chromosome
  - id: ignore_read_groups
    type:
      - 'null'
      - boolean
    doc: Ignore read groups in BAM/CRAM header and assume all reads come from 
      the same sample.
    inputBinding:
      position: 103
      prefix: --ignore-read-groups
  - id: include_haploid_sets
    type:
      - 'null'
      - boolean
    doc: Include the phase set information for every single haplotype in a 
      custom VCF format field 'HS'.
    inputBinding:
      position: 103
      prefix: --include-haploid-sets
  - id: mapping_quality
    type:
      - 'null'
      - int
    doc: 'Minimum mapping quality (default: 20)'
    inputBinding:
      position: 103
      prefix: --mapping-quality
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: 'Minimum required read overlap for internal read clustering stage (default:
      2).'
    inputBinding:
      position: 103
      prefix: --min-overlap
  - id: no_mav
    type:
      - 'null'
      - boolean
    doc: Disables phasing of multi-allelic variants.
    inputBinding:
      position: 103
      prefix: --no-mav
  - id: only_snvs
    type:
      - 'null'
      - boolean
    doc: Only phase SNVs
    inputBinding:
      position: 103
      prefix: --only-snvs
  - id: ploidy
    type: int
    doc: The ploidy of the sample(s). Argument is required.
    inputBinding:
      position: 103
      prefix: --ploidy
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference file. Provide this to detect alleles through re-alignment. If
      no index (.fai) exists, it will be created
    inputBinding:
      position: 103
      prefix: --reference
  - id: sample
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of a sample to phase. If not given, all samples in the input VCF 
      are phased. Can be used multiple times.
    inputBinding:
      position: 103
      prefix: --sample
  - id: supplementary_distance
    type:
      - 'null'
      - int
    doc: 'Skip supplementary alignments further than DIST bp away from the primary
      alignment (default: 100000)'
    inputBinding:
      position: 103
      prefix: --supplementary-distance
  - id: tag
    type:
      - 'null'
      - string
    doc: 'Store phasing information with PS tag (standardized) or HP tag (used by
      GATK ReadBackedPhasing) (default: PS)'
    inputBinding:
      position: 103
      prefix: --tag
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Maximum number of CPU threads used (default: 1).'
    inputBinding:
      position: 103
      prefix: --threads
  - id: use_prephasing
    type:
      - 'null'
      - boolean
    doc: Uses existing phase set blocks in the input to increase contiguity of 
      phasing output.
    inputBinding:
      position: 103
      prefix: --use-prephasing
  - id: use_supplementary
    type:
      - 'null'
      - boolean
    doc: 'Use also supplementary alignments (default: ignore supplementary_ alignments)'
    inputBinding:
      position: 103
      prefix: --use-supplementary
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output VCF file. Add .gz to the file name to get compressed output. If 
      omitted, use standard output.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
