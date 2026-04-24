cwlVersion: v1.2
class: CommandLineTool
baseCommand: pindel2vcf
label: pindel_pindel2vcf
doc: "conversion of Pindel output to VCF format\n\nTool homepage: http://gmt.genome.wustl.edu/packages/pindel/index.html"
inputs:
  - id: both_strands_supported
    type:
      - 'null'
      - boolean
    doc: Only report events that are detected on both strands
    inputBinding:
      position: 101
      prefix: --both_strands_supported
  - id: chromosome
    type:
      - 'null'
      - string
    doc: 'The name of the chromosome (default: SVs on all chromosomes are processed)'
    inputBinding:
      position: 101
      prefix: --chromosome
  - id: compact_output_limit
    type:
      - 'null'
      - int
    doc: Puts all structural variations of which either the ref allele or the alt
      allele exceeds the specified size in a compact format
    inputBinding:
      position: 101
      prefix: --compact_output_limit
  - id: gatk_compatible
    type:
      - 'null'
      - boolean
    doc: calls genotypes which could either be homozygous or heterozygous not as ./1
      but as 0/1, to ensure compatibility with GATK
    inputBinding:
      position: 101
      prefix: --gatk_compatible
  - id: het_cutoff
    type:
      - 'null'
      - float
    doc: The propertion of reads to call het
    inputBinding:
      position: 101
      prefix: --het_cutoff
  - id: hom_cutoff
    type:
      - 'null'
      - float
    doc: The propertion of reads to call het
    inputBinding:
      position: 101
      prefix: --hom_cutoff
  - id: max_internal_repeatlength
    type:
      - 'null'
      - int
    doc: Filters out all indels where the inserted/deleted sequence is a homopolymers/microsatellite
      with an unit size of more than Y
    inputBinding:
      position: 101
      prefix: --max_internal_repeatlength
  - id: max_internal_repeats
    type:
      - 'null'
      - int
    doc: Filters out all indels where the inserted/deleted sequence is a homopolymer/microsatellite
      of more than X repetitions
    inputBinding:
      position: 101
      prefix: --max_internal_repeats
  - id: max_postindel_repeatlength
    type:
      - 'null'
      - int
    doc: Filters out all indels where the inserted/deleted sequence is followed by
      a repetition of the fundamental repeat unit; the maximum size of that 'fundamental
      unit' given by the value of -pl
    inputBinding:
      position: 101
      prefix: --max_postindel_repeatlength
  - id: max_postindel_repeats
    type:
      - 'null'
      - int
    doc: Filters out all indels where the inserted/deleted sequence is followed by
      a repetition (of over X times) of the fundamental repeat unit
    inputBinding:
      position: 101
      prefix: --max_postindel_repeats
  - id: max_size
    type:
      - 'null'
      - int
    doc: The maximum size of events to be reported
    inputBinding:
      position: 101
      prefix: --max_size
  - id: max_supporting_reads
    type:
      - 'null'
      - int
    doc: The maximum number of supporting reads allowed for an event to be reported
    inputBinding:
      position: 101
      prefix: --max_supporting_reads
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: The minimum number of reads to provide a genotype
    inputBinding:
      position: 101
      prefix: --min_coverage
  - id: min_size
    type:
      - 'null'
      - int
    doc: The minimum size of events to be reported
    inputBinding:
      position: 101
      prefix: --min_size
  - id: min_supporting_reads
    type:
      - 'null'
      - int
    doc: The minimum number of supporting reads required for an event to be reported
    inputBinding:
      position: 101
      prefix: --min_supporting_reads
  - id: min_supporting_samples
    type:
      - 'null'
      - int
    doc: The minimum number of samples an event needs to occur in with sufficient
      support to be reported
    inputBinding:
      position: 101
      prefix: --min_supporting_samples
  - id: minimum_strand_support
    type:
      - 'null'
      - int
    doc: Only count a sample as supporting an event if at least one of its strands
      is supported by X reads
    inputBinding:
      position: 101
      prefix: --minimum_strand_support
  - id: only_balanced_samples
    type:
      - 'null'
      - boolean
    doc: Only count a sample as supporting an event if it is supported by reads on
      both strands
    inputBinding:
      position: 101
      prefix: --only_balanced_samples
  - id: pindel_output
    type:
      - 'null'
      - File
    doc: The name of the pindel output file containing the SVs
    inputBinding:
      position: 101
      prefix: --pindel_output
  - id: pindel_output_root
    type:
      - 'null'
      - string
    doc: The root-name of the pindel output file; combines deletions, insertions,
      duplications, and inversions into one VCF.
    inputBinding:
      position: 101
      prefix: --pindel_output_root
  - id: reference
    type: File
    doc: The name of the file containing the reference genome
    inputBinding:
      position: 101
      prefix: --reference
  - id: reference_date
    type: string
    doc: The date of the version of the reference genome used
    inputBinding:
      position: 101
      prefix: --reference_date
  - id: reference_name
    type: string
    doc: The name and version of the reference genome
    inputBinding:
      position: 101
      prefix: --reference_name
  - id: region_end
    type:
      - 'null'
      - int
    doc: The end of the region of which events are to be reported
    inputBinding:
      position: 101
      prefix: --region_end
  - id: region_start
    type:
      - 'null'
      - int
    doc: The start of the region of which events are to be reported
    inputBinding:
      position: 101
      prefix: --region_start
  - id: window_size
    type:
      - 'null'
      - int
    doc: 'Memory saving option: the size of the genomic region in a chromosome of
      which structural variants are calculated separately, in millions of bases'
    inputBinding:
      position: 101
      prefix: --window_size
outputs:
  - id: vcf
    type:
      - 'null'
      - File
    doc: 'The name of the output vcf-file (default: name of pindel output file +".vcf")'
    outputBinding:
      glob: $(inputs.vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pindel:0.2.5b9--h077b44d_12
