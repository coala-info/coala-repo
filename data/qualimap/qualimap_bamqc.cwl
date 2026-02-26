cwlVersion: v1.2
class: CommandLineTool
baseCommand: qualimap bamqc
label: qualimap_bamqc
doc: "Performs a quality control analysis on BAM files.\n\nTool homepage: http://qualimap.bioinfo.cipf.es/"
inputs:
  - id: bam_file
    type: File
    doc: Input mapping file in BAM format
    inputBinding:
      position: 101
      prefix: -bam
  - id: collect_overlap_pairs
    type:
      - 'null'
      - boolean
    doc: Activate this option to collect statistics of overlapping paired-end 
      reads
    inputBinding:
      position: 101
      prefix: --collect-overlap-pairs
  - id: cov_hist_lim
    type:
      - 'null'
      - string
    doc: Upstream limit for targeted per-bin coverage histogram
    default: 50X
    inputBinding:
      position: 101
      prefix: --cov-hist-lim
  - id: dup_rate_lim
    type:
      - 'null'
      - string
    doc: Upstream limit for duplication rate histogram
    default: '50'
    inputBinding:
      position: 101
      prefix: --dup-rate-lim
  - id: feature_file
    type:
      - 'null'
      - File
    doc: Feature file with regions of interest in GFF/GTF or BED format
    inputBinding:
      position: 101
      prefix: --feature-file
  - id: genome_gc_distr
    type:
      - 'null'
      - string
    doc: 'Species to compare with genome GC distribution. Possible values: HUMAN -
      hg19, hg38; MOUSE - mm9(default), mm10'
    inputBinding:
      position: 101
      prefix: --genome-gc-distr
  - id: homopolymer_min_size
    type:
      - 'null'
      - int
    doc: Minimum size of a homopolymer to be considered in indel analysis
    default: 3
    inputBinding:
      position: 101
      prefix: -hm
  - id: output_format
    type:
      - 'null'
      - string
    doc: Format of the output report (PDF, HTML or both PDF:HTML)
    default: HTML
    inputBinding:
      position: 101
      prefix: -outformat
  - id: outside_stats
    type:
      - 'null'
      - boolean
    doc: Report information for the regions outside those defined by 
      feature-file (ignored when -gff option is not set)
    inputBinding:
      position: 101
      prefix: --outside-stats
  - id: paint_chromosome_limits
    type:
      - 'null'
      - boolean
    doc: Paint chromosome limits inside charts
    inputBinding:
      position: 101
      prefix: --paint-chromosome-limits
  - id: reads_per_chunk
    type:
      - 'null'
      - int
    doc: Number of reads analyzed in a chunk
    default: 1000
    inputBinding:
      position: 101
      prefix: -nr
  - id: sequencing_protocol
    type:
      - 'null'
      - string
    doc: 'Sequencing library protocol: strand-specific-forward, strand-specific-reverse
      or non-strand-specific (default)'
    inputBinding:
      position: 101
      prefix: --sequencing-protocol
  - id: skip_dup_mode
    type:
      - 'null'
      - string
    doc: 'Specific type of duplicated alignments to skip (if this option is activated).
      0 : only flagged duplicates (default); 1 : only estimated by Qualimap; 2 : both
      flagged and estimated'
    default: '0'
    inputBinding:
      position: 101
      prefix: --skip-dup-mode
  - id: skip_duplicated
    type:
      - 'null'
      - boolean
    doc: Activate this option to skip duplicated alignments from the analysis. 
      If the duplicates are not flagged in the BAM file, then they will be 
      detected by Qualimap and can be selected for skipping.
    inputBinding:
      position: 101
      prefix: --skip-duplicated
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 20
    inputBinding:
      position: 101
      prefix: -nt
  - id: windows
    type:
      - 'null'
      - int
    doc: Number of windows
    default: 400
    inputBinding:
      position: 101
      prefix: -nw
outputs:
  - id: output_genome_coverage
    type:
      - 'null'
      - File
    doc: 'File to save per base non-zero coverage. Warning: large files are expected
      for large genomes'
    outputBinding:
      glob: $(inputs.output_genome_coverage)
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output folder for HTML report and raw data.
    outputBinding:
      glob: $(inputs.output_dir)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for PDF report
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qualimap:2.3--hdfd78af_0
