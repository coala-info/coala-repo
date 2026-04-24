cwlVersion: v1.2
class: CommandLineTool
baseCommand: rbpbench optex
label: rbpbench_optex
doc: "rbpbench optex\n\nTool homepage: https://github.com/michauhl/RBPBench"
inputs:
  - id: bed_sc_thr
    type:
      - 'null'
      - float
    doc: 'Minimum site score (by default: --in BED column 5, or set via --bed-score-col)
      for filtering (assuming higher score == better site)'
    inputBinding:
      position: 101
      prefix: --bed-sc-thr
  - id: bed_sc_thr_rf
    type:
      - 'null'
      - boolean
    doc: Reverse --bed-sc-thr filtering (i.e. the lower the better, e.g. if 
      score column contains p-values)
    inputBinding:
      position: 101
      prefix: --bed-sc-thr-rf
  - id: bed_score_col
    type:
      - 'null'
      - int
    doc: --in BED score column used for p-value calculations and finding optimal
      extension. BED score can be e.g. log2 fold change or -log10 p-value of the
      region
    inputBinding:
      position: 101
      prefix: --bed-score-col
  - id: cmsearch_bs
    type:
      - 'null'
      - float
    doc: 'CMSEARCH bit score threshold (CMSEARCH options: -T --incT). The higher the
      more strict'
    inputBinding:
      position: 101
      prefix: --cmsearch-bs
  - id: cmsearch_mode
    type:
      - 'null'
      - string
    doc: 'Set CMSEARCH mode to control strictness of filtering. 1: default setting
      (CMSEARCH option: --default). 2: max setting (CMSEARCH option: --max), i.e.,
      turn all heuristic filters off, slower and more sensitive / more hits)'
    inputBinding:
      position: 101
      prefix: --cmsearch-mode
  - id: ext_list
    type:
      - 'null'
      - type: array
        items: int
    doc: List of extensions to test (e.g. --ext-list 0 10 20 30 40 50). 
      Internally, all combinations will be tested
    inputBinding:
      position: 101
      prefix: --ext-list
  - id: ext_pval
    type:
      - 'null'
      - float
    doc: Longest extension p-value
    inputBinding:
      position: 101
      prefix: --ext-pval
  - id: fimo_ntf_file
    type:
      - 'null'
      - string
    doc: 'Provide FIMO nucleotide frequencies (FIMO option: --bfile) file (default:
      use internal frequencies file, define which with --fimo-ntf-mode)'
    inputBinding:
      position: 101
      prefix: --fimo-ntf-file
  - id: fimo_ntf_mode
    type:
      - 'null'
      - string
    doc: 'Set which internal nucleotide frequencies to use for FIMO search. 1: use
      frequencies from human ENSEMBL transcripts (excluding introns, A most prominent)
      2: use frequencies from human ENSEMBL transcripts (including introns, resulting
      in lower G+C and T most prominent) 3: use uniform frequencies (same for every
      nucleotide)'
    inputBinding:
      position: 101
      prefix: --fimo-ntf-mode
  - id: fimo_pval
    type:
      - 'null'
      - float
    doc: 'FIMO p-value threshold (FIMO option: --thresh)'
    inputBinding:
      position: 101
      prefix: --fimo-pval
  - id: genome
    type: File
    doc: 'Genomic sequences file (currently supported formats: FASTA)'
    inputBinding:
      position: 101
      prefix: --genome
  - id: greatest_hits
    type:
      - 'null'
      - boolean
    doc: Keep only best FIMO/CMSEARCH motif hits (i.e., hit with lowest p-value 
      / highest bit score for each motif sequence/site combination). By default,
      report all hits
    inputBinding:
      position: 101
      prefix: --greatest-hits
  - id: input_file
    type: File
    doc: Genomic RBP binding sites (peak regions) file in BED format (also 
      positives + negatives)
    inputBinding:
      position: 101
      prefix: --in
  - id: meme_no_check
    type:
      - 'null'
      - boolean
    doc: Disable MEME version check. Make sure --meme-no-pgc is set if MEME 
      version >= 5.5.4 is installed!
    inputBinding:
      position: 101
      prefix: --meme-no-check
  - id: meme_no_pgc
    type:
      - 'null'
      - boolean
    doc: Manually set MEME's FIMO --no-pgc option (required for MEME version >= 
      5.5.4). Make sure that MEME >= 5.5.4 is installed!
    inputBinding:
      position: 101
      prefix: --meme-no-pgc
  - id: motif_db
    type:
      - 'null'
      - string
    doc: 'Built-in motif database to use. 1: human RBP motifs (257 RBPs, 599 motifs,
      "catrapid_omics_v2.1_human_6plus_ext"), 2: human RBP motifs + 23 ucRBP motifs
      (277 RBPs, 622 motifs, "catrapid_omics_v2.1_human_6plus_ext_ucrbps"), 3: human
      RBP motifs from Ray et al. 2013 (80 RBPs, 102 motifs, "ray2013_human_rbps_rnacompete")'
    inputBinding:
      position: 101
      prefix: --motif-db
  - id: rbp_id
    type: string
    doc: Provide RBP ID to define RBP motifs used for search
    inputBinding:
      position: 101
      prefix: --rbp-id
  - id: user_cm
    type:
      - 'null'
      - string
    doc: Provide covariance model (.cm) file containing covariance model(s) to 
      be used as search motifs
    inputBinding:
      position: 101
      prefix: --user-cm
  - id: user_meme_xml
    type:
      - 'null'
      - string
    doc: Provide MEME/DREME XML file containing sequence motif(s) to be used as 
      search motifs
    inputBinding:
      position: 101
      prefix: --user-meme-xml
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
stdout: rbpbench_optex.out
