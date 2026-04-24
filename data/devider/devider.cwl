cwlVersion: v1.2
class: CommandLineTool
baseCommand: divider
label: devider
doc: "Long-read haplotyping for diverse small sequences (e.g. viruses, genes).\n\n\
  Tool homepage: https://github.com/bluenote-1577/devider"
inputs:
  - id: allele_output
    type:
      - 'null'
      - boolean
    doc: Output nucleotide alleles instead of 0-1 (ref,alt) alleles
    inputBinding:
      position: 101
      prefix: --allele-output
  - id: bam_file
    type: File
    doc: Indexed bam file to phase
    inputBinding:
      position: 101
      prefix: --bam-file
  - id: bed_file
    type:
      - 'null'
      - File
    doc: BED file with >= 3 columns (contig, start, end). Only these regions 
      will be phased; reads must cover 50% of the region to be considered
    inputBinding:
      position: 101
      prefix: --bed-file
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug logging
    inputBinding:
      position: 101
      prefix: --debug
  - id: dont_use_supp_aln
    type:
      - 'null'
      - boolean
    doc: Do not use supplementary alignments
    inputBinding:
      position: 101
      prefix: --dont-use-supp-aln
  - id: k
    type:
      - 'null'
      - string
    doc: Value of "k". Set automatically if not provided
    inputBinding:
      position: 101
      prefix: -k
  - id: mapq_cutoff
    type:
      - 'null'
      - int
    doc: Don't use primary mappings with < --mapq-cutoff
    inputBinding:
      position: 101
      prefix: --mapq-cutoff
  - id: max_frags
    type:
      - 'null'
      - int
    doc: Maximum number of alignments per contig
    inputBinding:
      position: 101
      prefix: --max-frags
  - id: min_abund
    type:
      - 'null'
      - float
    doc: Minimum abundance (in %) of a haplotype to be considered
    inputBinding:
      position: 101
      prefix: --min-abund
  - id: min_cov
    type:
      - 'null'
      - int
    doc: Minimum coverage (depth) of a haplotype to be considered
    inputBinding:
      position: 101
      prefix: --min-cov
  - id: min_qual
    type:
      - 'null'
      - int
    doc: Minimum base quality to consider for fastq
    inputBinding:
      position: 101
      prefix: --min-qual
  - id: n_fraction
    type:
      - 'null'
      - float
    doc: '> this fraction supporting the major allele to call a non-N base'
    inputBinding:
      position: 101
      prefix: --n-fraction
  - id: no_realign
    type:
      - 'null'
      - boolean
    doc: No base realignment against SNPs
    inputBinding:
      position: 101
      prefix: --no-realign
  - id: output_reads
    type:
      - 'null'
      - boolean
    doc: Output haplotype-tagged reads
    inputBinding:
      position: 101
      prefix: --output-reads
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite output directory if it exists
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: preset
    type:
      - 'null'
      - string
    doc: Presets for different technologies. More accurate technologies use more
      aggressive parameters
    inputBinding:
      position: 101
      prefix: --preset
  - id: reference_fasta
    type: File
    doc: Reference fasta file
    inputBinding:
      position: 101
      prefix: --reference-fasta
  - id: resolution
    type:
      - 'null'
      - string
    doc: Merge haplotypes with < this fractional difference. Value depends on 
      preset
    inputBinding:
      position: 101
      prefix: --resolution
  - id: sequences_to_phase
    type:
      - 'null'
      - string
    doc: Sequences to phase separated by commas (e.g. 
      NC_001802.1:1-1000,NC_045512.2). See also --bed-file
    inputBinding:
      position: 101
      prefix: --sequences-to-phase
  - id: snp_count_filter
    type:
      - 'null'
      - int
    doc: 'Only phase contigs with > this # of SNPs'
    inputBinding:
      position: 101
      prefix: --snp-count-filter
  - id: strand_bias_fdr
    type:
      - 'null'
      - float
    doc: FDR for strand bias filtering
    inputBinding:
      position: 101
      prefix: --strand-bias-fdr
  - id: supp_aln_dist_cutoff
    type:
      - 'null'
      - int
    doc: Require supplementary alignments to be within this distance of the 
      primary alignment
    inputBinding:
      position: 101
      prefix: --supp-aln-dist-cutoff
  - id: supp_mapq_cutoff
    type:
      - 'null'
      - int
    doc: Don't use supp. mappings with < --supp-mapq-cutoff
    inputBinding:
      position: 101
      prefix: --supp-mapq-cutoff
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: trace
    type:
      - 'null'
      - boolean
    doc: Trace logging (VERY VERBOSE)
    inputBinding:
      position: 101
      prefix: --trace
  - id: vcf_file
    type: File
    doc: VCF file with SNPs
    inputBinding:
      position: 101
      prefix: --vcf-file
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/devider:0.0.1--ha6fb395_3
