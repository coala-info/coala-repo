cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - peakhood
  - extract
label: peakhood_extract
doc: "Extract transcript and genomic context for CLIP-seq peak regions using BAM coverage
  and GTF annotations.\n\nTool homepage: https://github.com/BackofenLab/Peakhood"
inputs:
  - id: bam
    type:
      type: array
      items: File
    doc: BAM file or list of BAM files containing CLIP-seq library reads used for
      estimating --in site context
    inputBinding:
      position: 101
      prefix: --bam
  - id: bam_pp_mode
    type:
      - 'null'
      - int
    doc: 'Define type of preprocessing for read-in --bam files. 1: none, 2: R2 only
      (eCLIP), 3: R1 only (iCLIP)'
    inputBinding:
      position: 101
      prefix: --bam-pp-mode
  - id: data_id
    type:
      - 'null'
      - string
    doc: Define dataset ID for the input dataset to be stored in --out folder
    inputBinding:
      position: 101
      prefix: --data-id
  - id: discard_single_ex_tr
    type:
      - 'null'
      - boolean
    doc: Exclude single exon transcripts from transcript context selection
    inputBinding:
      position: 101
      prefix: --discard-single-ex-tr
  - id: eib_width
    type:
      - 'null'
      - int
    doc: Width of exon-intron border regions (EIB) to calculate coverage drops from
      exon to intron region
    inputBinding:
      position: 101
      prefix: --eib-width
  - id: eibr_mode
    type:
      - 'null'
      - int
    doc: 'How to extract the exon-intron border ratio of an exon. 1: higher coverage,
      2: average'
    inputBinding:
      position: 101
      prefix: --eibr-mode
  - id: f1_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: Define F1 filters to be applied for F1 transcript selection filtering
    inputBinding:
      position: 101
      prefix: --f1-filter
  - id: f2_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: Define F2 filters to be applied for F2 transcript selection filtering
    inputBinding:
      position: 101
      prefix: --f2-filter
  - id: f2_mode
    type:
      - 'null'
      - int
    doc: Define transcript selection strategy for a given exonic site during F2 filtering.
      (1) majority vote, (2) sequential
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
  - id: in
    type: File
    doc: Genomic CLIP-seq peak regions file in BED format (6-column BED)
    inputBinding:
      position: 101
      prefix: --in
  - id: isr_ext_mode
    type:
      - 'null'
      - int
    doc: 'Define which portions of intron-spanning reads to use for overlap calculations.
      1: whole matching region, 2: end positions only'
    inputBinding:
      position: 101
      prefix: --isr-ext-mode
  - id: isr_max_reg_len
    type:
      - 'null'
      - int
    doc: Set maximum region length for intron-spanning read matches
    inputBinding:
      position: 101
      prefix: --isr-max-reg-len
  - id: isrn_prefilter
    type:
      - 'null'
      - int
    doc: Enable prefilerting of exons by exon neigbhorhood intron-spanning read count
    inputBinding:
      position: 101
      prefix: --isrn-prefilter
  - id: keep_bam
    type:
      - 'null'
      - boolean
    doc: Keep filtered BAM files in --out folder
    inputBinding:
      position: 101
      prefix: --keep-bam
  - id: max_len
    type:
      - 'null'
      - int
    doc: Maximum length of --in sites
    inputBinding:
      position: 101
      prefix: --max-len
  - id: merge_ext
    type:
      - 'null'
      - int
    doc: Extend regions by --merge-ext before merging overlapping regions
    inputBinding:
      position: 101
      prefix: --merge-ext
  - id: merge_mode
    type:
      - 'null'
      - int
    doc: Defines whether or how to merge nearby sites before applying --seq-ext. (1)
      No merge, (2) merge overlapping/adjacent
    inputBinding:
      position: 101
      prefix: --merge-mode
  - id: min_ei_ratio
    type:
      - 'null'
      - float
    doc: Minimum exon to neighboring intron coverage for exonic site to be reported
      as exonic site with transcript context
    inputBinding:
      position: 101
      prefix: --min-ei-ratio
  - id: min_eib_ratio
    type:
      - 'null'
      - float
    doc: Minimum exon border to neighboring intron border region coverage for an exon
      to be considered for transcript context selection
    inputBinding:
      position: 101
      prefix: --min-eib-ratio
  - id: min_exbs_isr_c
    type:
      - 'null'
      - int
    doc: Minimum intron-spanning read count to connect two sites at adjacent exon
      borders
    inputBinding:
      position: 101
      prefix: --min-exbs-isr-c
  - id: min_exon_overlap
    type:
      - 'null'
      - float
    doc: Minimum exon overlap of a site to be considered for transcript context extraction
    inputBinding:
      position: 101
      prefix: --min-exon-overlap
  - id: min_tis_sites
    type:
      - 'null'
      - int
    doc: Minimum number of intronic sites needed per transcript to assign all sites
      on the transcript to genomic context
    inputBinding:
      position: 101
      prefix: --min-tis-sites
  - id: new_site_id
    type:
      - 'null'
      - string
    doc: Generate new IDs with stem ID --new-site-id to exchange --in BED column 4
      site IDs
    inputBinding:
      position: 101
      prefix: --new-site-id
  - id: no_biotype_filter
    type:
      - 'null'
      - boolean
    doc: Disable transcript biotype filter
    inputBinding:
      position: 101
      prefix: --no-biotype-filter
  - id: no_eibr_filter
    type:
      - 'null'
      - boolean
    doc: Disable exon-intron border ratio (EIBR) filtering of exons
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
  - id: no_isr_double_count
    type:
      - 'null'
      - boolean
    doc: Do not count intron-spanning reads twice for intron-exon coverage calculations
    inputBinding:
      position: 101
      prefix: --no-isr-double-count
  - id: no_isr_sub_count
    type:
      - 'null'
      - boolean
    doc: Do not substract the intron-spanning read count from the intronic read count
    inputBinding:
      position: 101
      prefix: --no-isr-sub-count
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
    doc: Merge book-ended and overlapping --in sites BEFORE transcript context extraction
    inputBinding:
      position: 101
      prefix: --pre-merge
  - id: read_pos_mode
    type:
      - 'null'
      - int
    doc: "Define which BAM read part to take for overlap and coverage calculations.
      1: full-length, 2: 5' end, 3: center"
    inputBinding:
      position: 101
      prefix: --read-pos-mode
  - id: report
    type:
      - 'null'
      - boolean
    doc: Generate an .html report containing various additional statistics and plots
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
    inputBinding:
      position: 101
      prefix: --rnaseq-bam-rev
  - id: seq_ext
    type:
      - 'null'
      - int
    doc: Up- and downstream sequence extension length of sites
    inputBinding:
      position: 101
      prefix: --seq-ext
  - id: seq_ext_mode
    type:
      - 'null'
      - int
    doc: Define mode for site context sequence extraction after determining context.
      (1) Complete site, (2) Center, (3) Upstream end
    inputBinding:
      position: 101
      prefix: --seq-ext-mode
  - id: site_id
    type:
      - 'null'
      - type: array
        items: string
    doc: Provide site ID(s) from --in (BED column 4) and run peakhood extract only
      for these regions
    inputBinding:
      position: 101
      prefix: --site-id
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
    doc: Minimum site score (--in BED column 5) for filtering
    inputBinding:
      position: 101
      prefix: --thr
  - id: thr_rev_filter
    type:
      - 'null'
      - boolean
    doc: Reverse --thr filtering (i.e. the lower the better, e.g. for p-values)
    inputBinding:
      position: 101
      prefix: --thr-rev-filter
outputs:
  - id: out
    type: Directory
    doc: Site context extraction results output folder
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peakhood:0.3--pyhdfd78af_0
