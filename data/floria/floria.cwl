cwlVersion: v1.2
class: CommandLineTool
baseCommand: floria
label: floria
doc: "strain phasing for short or long-read shotgun metagenomic sequencing.\n\nTool
  homepage: https://github.com/bluenote-1577/floria"
inputs:
  - id: bam_file
    type: File
    doc: Indexed and sorted bam file to phase.
    inputBinding:
      position: 101
      prefix: -b
  - id: beam_solns
    type:
      - 'null'
      - int
    doc: Maximum number of solutions for beam search.
    inputBinding:
      position: 101
      prefix: --beam-solns
  - id: block_length
    type:
      - 'null'
      - int
    doc: 'Length of blocks (in bp) for flow graph construction when using bam file.
      (default: 66th percentile of read-lengths, minimum 500 bp)'
    inputBinding:
      position: 101
      prefix: --block-length
  - id: contigs
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Phase only contigs in this argument. Usage: -G contig1 contig2 contig3 ...'
    inputBinding:
      position: 101
      prefix: --contigs
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debugging output.
    inputBinding:
      position: 101
      prefix: --debug
  - id: epsilon
    type:
      - 'null'
      - float
    doc: 'Estimated allele call error rate; we recommend: noisy long-reads, 0.02-0.06;
      hifi, 0.01; short-reads, 0.01. (default: if no -e provided, -e is estimated
      from data.)'
    inputBinding:
      position: 101
      prefix: --epsilon
  - id: extra_trimming
    type:
      - 'null'
      - boolean
    doc: Trim the reads extra carefully against the reference genome. May cause 
      more fragmented but accurate assemblies.
    inputBinding:
      position: 101
      prefix: --extra-trimming
  - id: gzip_reads
    type:
      - 'null'
      - boolean
    doc: Output gzipped reads instead of raw fastq if using --output-reads.
    inputBinding:
      position: 101
      prefix: --gzip-reads
  - id: ignore_monomorphic
    type:
      - 'null'
      - boolean
    doc: Ignore SNPs that have minor allele frequency less than -e.
    inputBinding:
      position: 101
      prefix: --ignore-monomorphic
  - id: mapq_cutoff
    type:
      - 'null'
      - int
    doc: Primary MAPQ cutoff.
    default: 15
    inputBinding:
      position: 101
      prefix: --mapq-cutoff
  - id: max_ploidy
    type:
      - 'null'
      - int
    doc: Maximum ploidy (i.e. strain count) to try to phase up to.
    default: 5
    inputBinding:
      position: 101
      prefix: --max-ploidy
  - id: no_stop_heuristic
    type:
      - 'null'
      - boolean
    doc: 'Do not use MEC stopping heuristic for local ploidy/strain count computation;
      only stop phasing when SNP error rate in block is < epsilon. (default: use stopping
      heuristic)'
    inputBinding:
      position: 101
      prefix: --no-stop-heuristic
  - id: no_supp
    type:
      - 'null'
      - boolean
    doc: 'Do not use supplementary alignments. (default: use supp. alignments with
      MAPQ = 60)'
    inputBinding:
      position: 101
      prefix: --no-supp
  - id: output_reads
    type:
      - 'null'
      - boolean
    doc: Output reads in fastq format for the resulting haplosets.
    inputBinding:
      position: 101
      prefix: --output-reads
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Force overwrite for output directory.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: ploidy_sensitivity
    type:
      - 'null'
      - string
    doc: 'Sensitivity for the local strain count stopping heuristic; higher values
      try to phase more haplotypes, but may give more spurious results. (default:
      2)'
    inputBinding:
      position: 101
      prefix: --ploidy-sensitivity
  - id: reference_fasta
    type: File
    doc: Reference fasta for the BAM file.
    inputBinding:
      position: 101
      prefix: -r
  - id: snp_count_filter
    type:
      - 'null'
      - int
    doc: Skip contigs with less than --snp-count-filter SNPs.
    default: 100
    inputBinding:
      position: 101
      prefix: --snp-count-filter
  - id: snp_density
    type:
      - 'null'
      - float
    doc: Blocks with fraction of SNPs per base less than -d won't be phased.
    default: 0.0005
    inputBinding:
      position: 101
      prefix: --snp-density
  - id: supp_aln_dist_cutoff
    type:
      - 'null'
      - int
    doc: Maximum allowed distance between supp. alignments.
    default: 40000
    inputBinding:
      position: 101
      prefix: --supp-aln-dist-cutoff
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    default: 10
    inputBinding:
      position: 101
      prefix: --threads
  - id: trace
    type:
      - 'null'
      - boolean
    doc: Trace output.
    inputBinding:
      position: 101
      prefix: --trace
  - id: vcf_file
    type: File
    doc: VCF file with contig header information; see README if contig header 
      information is not present.
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output folder.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/floria:0.0.2--ha6fb395_0
