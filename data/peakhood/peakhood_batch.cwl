cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - peakhood
  - batch
label: peakhood_batch
doc: "Batch processing for peakhood to extract transcript context and genomic context
  for sites using BAM, BED, GTF, and genomic sequence files.\n\nTool homepage: https://github.com/BackofenLab/Peakhood"
inputs:
  - id: add_gtf
    type:
      - 'null'
      - File
    doc: Additional genomic annotations GTF file (.gtf or .gtf.gz) for transcript
      to gene region annotation
    inputBinding:
      position: 101
      prefix: --add-gtf
  - id: bam_pp_mode
    type:
      - 'null'
      - int
    doc: 'Define type of preprocessing for read-in --bam files. 1: no preprocessing.
      2: use only R2 reads. 3: use only R1 reads.'
    default: 1
    inputBinding:
      position: 101
      prefix: --bam-pp-mode
  - id: eib_width
    type:
      - 'null'
      - int
    doc: Width of exon-intron border regions (EIB) to calculate coverage drops from
      exon to intron region
    default: 20
    inputBinding:
      position: 101
      prefix: --eib-width
  - id: eibr_mode
    type:
      - 'null'
      - int
    doc: 'How to extract the exon-intron border ratio of an exon. 1: return the exon-intro
      border ratio with the higher coverage. 2: average the two exon-intron border
      ratios of the exon'
    default: 1
    inputBinding:
      position: 101
      prefix: --eibr-mode
  - id: f1_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: Define F1 filters to be applied for F1 transcript selection filtering
    default: TSC
    inputBinding:
      position: 101
      prefix: --f1-filter
  - id: f2_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: Define F2 filters to be applied for F2 transcript selection filtering
    default: EIR ISRN ISR ISRFC SEO FUCO TCOV
    inputBinding:
      position: 101
      prefix: --f2-filter
  - id: f2_mode
    type:
      - 'null'
      - int
    doc: Define transcript selection strategy for a given exonic site during F2 filtering.
      (1) majority vote filtering, (2) sequential filtering.
    default: 1
    inputBinding:
      position: 101
      prefix: --f2-mode
  - id: gen
    type: File
    doc: Genomic sequences .2bit file
    inputBinding:
      position: 101
      prefix: --gen
  - id: gtf
    type: File
    doc: Genomic annotations GTF file (.gtf or .gtf.gz)
    inputBinding:
      position: 101
      prefix: --gtf
  - id: in_dir
    type: Directory
    doc: 'Input folder containing BAM and BED files for batch processing. Naming convention:
      datasetid_rep1.bam, datasetid_rep2.bam, ... and datasetid.bed'
    inputBinding:
      position: 101
      prefix: --in
  - id: isr_ext_mode
    type:
      - 'null'
      - int
    doc: 'Define which portions of intron-spanning reads to use for overlap calculations.
      1: use whole matching region. 2: use end positions only.'
    default: 1
    inputBinding:
      position: 101
      prefix: --isr-ext-mode
  - id: isr_max_reg_len
    type:
      - 'null'
      - int
    doc: Set maximum region length for intron-spanning read matches.
    default: 10
    inputBinding:
      position: 101
      prefix: --isr-max-reg-len
  - id: isrn_prefilter
    type:
      - 'null'
      - int
    doc: Enable prefilerting of exons (before F1, F2) by exon neigbhorhood intron-spanning
      read count.
    inputBinding:
      position: 101
      prefix: --isrn-prefilter
  - id: max_len
    type:
      - 'null'
      - int
    doc: Maximum length of --in sites
    default: 250
    inputBinding:
      position: 101
      prefix: --max-len
  - id: merge_ext
    type:
      - 'null'
      - int
    doc: Extend regions by --merge-ext before merging overlapping regions (if --merge-mode
      2)
    default: 0
    inputBinding:
      position: 101
      prefix: --merge-ext
  - id: merge_mode
    type:
      - 'null'
      - int
    doc: Defines whether or how to merge nearby sites before applying --seq-ext. (1)
      Do NOT merge sites, (2) merge overlapping and adjacent sites.
    default: 1
    inputBinding:
      position: 101
      prefix: --merge-mode
  - id: min_ei_ratio
    type:
      - 'null'
      - float
    doc: Minimum exon to neighboring intron coverage for exonic site to be reported
      as exonic site with transcript context
    default: 4.0
    inputBinding:
      position: 101
      prefix: --min-ei-ratio
  - id: min_eib_ratio
    type:
      - 'null'
      - float
    doc: Minimum exon border to neighboring intron border region coverage for an exon
      to be considered for transcript context selection
    default: 4.0
    inputBinding:
      position: 101
      prefix: --min-eib-ratio
  - id: min_exbs_isr_c
    type:
      - 'null'
      - int
    doc: Minimum intron-spanning read count to connect two sites at adjacent exon
      borders.
    default: 2
    inputBinding:
      position: 101
      prefix: --min-exbs-isr-c
  - id: min_exon_overlap
    type:
      - 'null'
      - float
    doc: Minimum exon overlap of a site to be considered for transcript context extraction
      (intersectBed -f parameter)
    default: 0.9
    inputBinding:
      position: 101
      prefix: --min-exon-overlap
  - id: min_tis_sites
    type:
      - 'null'
      - int
    doc: Minimum number of intronic sites needed per transcript to assign all sites
      on the transcript to genomic context
    default: 2
    inputBinding:
      position: 101
      prefix: --min-tis-sites
  - id: new_ids
    type:
      - 'null'
      - boolean
    doc: Generate new IDs to exchange --in BED column 4 site IDs.
    default: false
    inputBinding:
      position: 101
      prefix: --new-ids
  - id: no_biotype_filter
    type:
      - 'null'
      - boolean
    doc: Disable transcript biotype filter.
    inputBinding:
      position: 101
      prefix: --no-biotype-filter
  - id: no_eibr_filter
    type:
      - 'null'
      - boolean
    doc: Disable exon-intron border ratio (EIBR) filtering of exons.
    inputBinding:
      position: 101
      prefix: --no-eibr-filter
  - id: no_eibr_wt_filter
    type:
      - 'null'
      - boolean
    doc: Disable exon-intron border ratio filtering by checking the ratios of whole
      transcripts
    inputBinding:
      position: 101
      prefix: --no-eibr-wt-filter
  - id: no_eir_wt_filter
    type:
      - 'null'
      - boolean
    doc: Disable exon-intron ratio filtering by checking the ratios of whole transcripts
    inputBinding:
      position: 101
      prefix: --no-eir-wt-filter
  - id: no_f1_filter
    type:
      - 'null'
      - boolean
    doc: Disable F1 sequential filtering step
    inputBinding:
      position: 101
      prefix: --no-f1-filter
  - id: no_tis_filter
    type:
      - 'null'
      - boolean
    doc: Do not discard transcripts containing intronic sites from transcript context
      selection
    inputBinding:
      position: 101
      prefix: --no-tis-filter
  - id: pre_merge
    type:
      - 'null'
      - boolean
    doc: Merge book-ended and overlapping --in sites BEFORE transcript context extraction.
    inputBinding:
      position: 101
      prefix: --pre-merge
  - id: read_pos_mode
    type:
      - 'null'
      - int
    doc: "Define which BAM read part to take for overlap and coverage calculations.
      1: full-length read. 2: 5' end. 3: center position."
    default: 1
    inputBinding:
      position: 101
      prefix: --read-pos-mode
  - id: report
    type:
      - 'null'
      - boolean
    doc: Generate .html reports for extract and merge, containing dataset statistics
      and plots
    default: false
    inputBinding:
      position: 101
      prefix: --report
  - id: rnaseq_bam
    type:
      - 'null'
      - File
    doc: RNA-Seq BAM file to extract additional intron-spanning reads from
    inputBinding:
      position: 101
      prefix: --rnaseq-bam
  - id: rnaseq_bam_rev
    type:
      - 'null'
      - boolean
    doc: Enable if --rnaseq-bam reads are reverse strand-specific
    default: false
    inputBinding:
      position: 101
      prefix: --rnaseq-bam-rev
  - id: seq_ext
    type:
      - 'null'
      - int
    doc: Up- and downstream sequence extension length of sites
    default: 0
    inputBinding:
      position: 101
      prefix: --seq-ext
  - id: seq_ext_mode
    type:
      - 'null'
      - int
    doc: Define mode for site context sequence extraction after determining context.
      (1) Take the complete site, (2) Take the center, (3) Take the upstream end.
    default: 1
    inputBinding:
      position: 101
      prefix: --seq-ext-mode
  - id: tbt_filter_ids
    type:
      - 'null'
      - type: array
        items: string
    doc: Manually provide transcript biotype ID(s) to filter out transcripts with
      these biotypes
    inputBinding:
      position: 101
      prefix: --tbt-filter-ids
  - id: thr
    type:
      - 'null'
      - float
    doc: Minimum site score (--in BED files column 5) for filtering (assuming higher
      score == better site)
    inputBinding:
      position: 101
      prefix: --thr
  - id: thr_rev_filter
    type:
      - 'null'
      - boolean
    doc: Reverse --thr filtering (i.e. the lower the better, e.g. for p-values)
    default: false
    inputBinding:
      position: 101
      prefix: --thr-rev-filter
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads used for batch processing.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out_dir
    type: Directory
    doc: Results output folder
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peakhood:0.3--pyhdfd78af_0
