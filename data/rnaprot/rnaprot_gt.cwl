cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnaprot gt
label: rnaprot_gt
doc: "Generate training data for RNA binding protein motif discovery.\n\nTool homepage:
  https://github.com/BackofenLab/RNAProt"
inputs:
  - id: add_exon_intron_annotations
    type:
      - 'null'
      - boolean
    doc: Add exon-intron annotations to genomic regions
    inputBinding:
      position: 101
      prefix: --eia
  - id: add_intron_border_annotations
    type:
      - 'null'
      - boolean
    doc: Add intron border annotations to genomic regions (in combination with 
      --eia)
    inputBinding:
      position: 101
      prefix: --eia-ib
  - id: add_repeat_region_annotations
    type:
      - 'null'
      - boolean
    doc: Add repeat region annotations for genomic or transcript regions 
      retrieved from --gen .2bit
    inputBinding:
      position: 101
      prefix: --rra
  - id: add_secondary_structure
    type:
      - 'null'
      - boolean
    doc: Add secondary structure probabilities feature (calculate with 
      RNAplfold)
    inputBinding:
      position: 101
      prefix: --str
  - id: add_transcript_border_annotations
    type:
      - 'null'
      - boolean
    doc: Add transcript and exon border annotations to transcript regions (in 
      combination with --tra)
    inputBinding:
      position: 101
      prefix: --tra-borders
  - id: add_transcript_codon_annotations
    type:
      - 'null'
      - boolean
    doc: Add start and stop codon annotations to genomic or transcript regions 
      (in combination with --tra)
    inputBinding:
      position: 101
      prefix: --tra-codons
  - id: add_transcript_region_annotations
    type:
      - 'null'
      - boolean
    doc: Add transcript region annotations (5'UTR, CDS, 3'UTR, None) to genomic 
      and transcript regions
    inputBinding:
      position: 101
      prefix: --tra
  - id: additional_features_file
    type:
      - 'null'
      - File
    doc: Provide tabular file with additional position-wise genomic region 
      features (infos and paths to BED files) to add. NOTE that if --in == FASTA
      sequences, input file format changes from BED to tabular (see 
      documentation)
    inputBinding:
      position: 101
      prefix: --feat-in
  - id: allow_overlapping_sites
    type:
      - 'null'
      - boolean
    doc: Do not select for highest-scoring sites in case of overlapping sites
    inputBinding:
      position: 101
      prefix: --allow-overlaps
  - id: generate_report
    type:
      - 'null'
      - boolean
    doc: Output an .html report providing various training set statistics and 
      plots
    inputBinding:
      position: 101
      prefix: --report
  - id: genomic_sequences
    type:
      - 'null'
      - File
    doc: Genomic sequences .2bit file
    inputBinding:
      position: 101
      prefix: --gen
  - id: gtf_file
    type:
      - 'null'
      - File
    doc: Genomic annotations GTF file (.gtf or .gtf.gz)
    inputBinding:
      position: 101
      prefix: --gtf
  - id: input_sites
    type: string
    doc: Genomic or transcript RBP binding sites file in BED (6-column format) 
      or FASTA format. If --in FASTA, only --str is supported as additional 
      feature. If --in BED, --gtf and --gen become mandatory
    inputBinding:
      position: 101
      prefix: --in
  - id: keep_additional_negatives
    type:
      - 'null'
      - boolean
    doc: Keep additional negatives (# controlled by --neg-factor) instead of 
      outputting same numbers of positive and negative sites
    inputBinding:
      position: 101
      prefix: --keep-add-neg
  - id: keep_site_ids
    type:
      - 'null'
      - boolean
    doc: Keep --in BED column 4 site IDs. Note that site IDs have to be unique
    inputBinding:
      position: 101
      prefix: --keep-ids
  - id: label_non_intron_exon_as_n
    type:
      - 'null'
      - boolean
    doc: Label regions not covered by intron or exon regions as N instead of 
      labelling them as introns (I) (in combination with --eia)
    inputBinding:
      position: 101
      prefix: --eia-n
  - id: mask_bed_file
    type:
      - 'null'
      - File
    doc: Additional BED regions file (6-column format) for masking negatives 
      (e.g. all positive RBP CLIP sites)
    inputBinding:
      position: 101
      prefix: --mask-bed
  - id: max_site_length
    type:
      - 'null'
      - int
    doc: Maximum length of --in sites
    inputBinding:
      position: 101
      prefix: --max-len
  - id: min_site_length
    type:
      - 'null'
      - int
    doc: Minimum length of --in sites (only effective for --mode 2). If length <
      --min-len, take center and extend to --min-len. Use uneven numbers for 
      equal up- and downstream extension
    inputBinding:
      position: 101
      prefix: --min-len
  - id: mode
    type:
      - 'null'
      - string
    doc: Define mode for --in BED site extraction. (1) Take the center of each 
      site, (2) Take the complete site, (3) Take the upstream end for each site.
      Note that --min-len applies only for --mode 2
    inputBinding:
      position: 101
      prefix: --mode
  - id: neg_comp_threshold
    type:
      - 'null'
      - float
    doc: Sequence complexity (Shannon entropy) threshold for filtering random 
      negative regions
    inputBinding:
      position: 101
      prefix: --neg-comp-thr
  - id: neg_factor
    type:
      - 'null'
      - string
    doc: 'Determines number of initial random negatives to be extracted (== --neg-factor
      n times # positives)'
    inputBinding:
      position: 101
      prefix: --neg-factor
  - id: negative_input
    type:
      - 'null'
      - string
    doc: Negative genomic or transcript sites in BED (6-column format) or FASTA 
      format. Use with --in BED/FASTA. If not set, negatives are generated by 
      shuffling --in sequences (if --in FASTA) or random selection of genomic or
      transcript sites (if --in BED)
    inputBinding:
      position: 101
      prefix: --neg-in
  - id: no_gene_filter
    type:
      - 'null'
      - boolean
    doc: Do not filter positives based on gene coverage (gene annotations from 
      --gtf)
    inputBinding:
      position: 101
      prefix: --no-gene-filter
  - id: output_folder
    type: Directory
    doc: Output training data folder (== input folder to rnaprot train)
    inputBinding:
      position: 101
      prefix: --out
  - id: phastcons_file
    type:
      - 'null'
      - File
    doc: Genomic .bigWig file with phastCons conservation scores to add as 
      annotations
    inputBinding:
      position: 101
      prefix: --phastcons
  - id: phylop_file
    type:
      - 'null'
      - File
    doc: Genomic .bigWig file with phyloP conservation scores to add as 
      annotations
    inputBinding:
      position: 101
      prefix: --phylop
  - id: plfold_max_length
    type:
      - 'null'
      - int
    doc: RNAplfold -L parameter value
    inputBinding:
      position: 101
      prefix: --plfold-l
  - id: plfold_upstream_extension
    type:
      - 'null'
      - int
    doc: RNAplfold -u parameter value
    inputBinding:
      position: 101
      prefix: --plfold-u
  - id: plfold_window_size
    type:
      - 'null'
      - int
    doc: RNAplfold -W parameter value
    inputBinding:
      position: 101
      prefix: --plfold-w
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Set a fixed random seed number (e.g. --seed 1) to obtain the same 
      random negative set for identical rnaprot gt runs
    inputBinding:
      position: 101
      prefix: --seed
  - id: report_theme
    type:
      - 'null'
      - string
    doc: 'Set theme for .html report (1: palm beach, 2: midnight sunset)'
    inputBinding:
      position: 101
      prefix: --theme
  - id: reverse_threshold_filter
    type:
      - 'null'
      - boolean
    doc: Reverse --thr filtering (i.e. the lower the better, e.g. for p-values)
    inputBinding:
      position: 101
      prefix: --rev-filter
  - id: score_threshold
    type:
      - 'null'
      - float
    doc: Minimum site score (--in BED column 5) for filtering (assuming higher 
      score == better site)
    inputBinding:
      position: 101
      prefix: --thr
  - id: seq_extension
    type:
      - 'null'
      - int
    doc: Up- and downstream sequence extension length of sites (site definition 
      by --mode)
    inputBinding:
      position: 101
      prefix: --seq-ext
  - id: shuffle_k
    type:
      - 'null'
      - string
    doc: Supply k for k-nucleotide shuffling of --in sequences to generate 
      negative sequences (if no --neg-in supplied)
    inputBinding:
      position: 101
      prefix: --shuffle-k
  - id: transcript_list_file
    type:
      - 'null'
      - File
    doc: Supply file with transcript IDs (one ID per row) for exon-intron 
      labeling (using the corresponding exon regions from --gtf). By default, 
      exon regions of the most prominent transcripts (automatically selected 
      from --gtf) are used
    inputBinding:
      position: 101
      prefix: --tr-list
  - id: use_all_exons_for_eia
    type:
      - 'null'
      - boolean
    doc: Use all annotated exons in --gtf file, instead of exons of most 
      prominent transcripts defined by --tr-list. Set this and --tr-list will be
      effective only for --tra
    inputBinding:
      position: 101
      prefix: --eia-all-ex
  - id: use_one_hot_encoding_for_features
    type:
      - 'null'
      - boolean
    doc: Use one-hot encoding for all additional position-wise features from 
      --feat-in table, ignoring type definitions in --feat-in table
    inputBinding:
      position: 101
      prefix: --feat-in-1h
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnaprot:0.5--pyhdfd78af_1
stdout: rnaprot_gt.out
