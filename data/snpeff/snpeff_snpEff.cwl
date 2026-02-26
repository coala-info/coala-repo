cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpEff
label: snpeff_snpEff
doc: "SnpEff version SnpEff 5.4a (build 2025-11-25 12:22), by Pablo Cingolani\n\n\
  Tool homepage: http://snpeff.sourceforge.net/"
inputs:
  - id: ann
    type:
      - 'null'
      - string
    doc: Annotation command (e.g., 'ann')
    inputBinding:
      position: 1
  - id: genome_version
    type: string
    doc: Genome version
    inputBinding:
      position: 2
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input variants file (default is STDIN)
    inputBinding:
      position: 3
  - id: cancer
    type:
      - 'null'
      - boolean
    doc: "Perform 'cancer' comparisons (Somatic vs Germline). Default: false"
    default: false
    inputBinding:
      position: 104
      prefix: -cancer
  - id: cancer_samples_file
    type:
      - 'null'
      - File
    doc: Two column TXT file defining 'oringinal \t derived' samples.
    inputBinding:
      position: 104
      prefix: -cancerSamples
  - id: canonical
    type:
      - 'null'
      - boolean
    doc: Only use canonical transcripts.
    inputBinding:
      position: 104
      prefix: -canon
  - id: canonical_list_file
    type:
      - 'null'
      - File
    doc: "Only use canonical transcripts, replace some transcripts using the 'gene_id
      \t transcript_id' entries in <file>."
    inputBinding:
      position: 104
      prefix: -canonList
  - id: classic
    type:
      - 'null'
      - boolean
    doc: Use old style annotations instead of Sequence Ontology and Hgvs.
    inputBinding:
      position: 104
      prefix: -classic
  - id: config_file
    type:
      - 'null'
      - File
    doc: Specify config file
    inputBinding:
      position: 104
      prefix: -c
  - id: config_option
    type:
      - 'null'
      - string
    doc: Override a config file option
    inputBinding:
      position: 104
      prefix: -configOption
  - id: csv_stats_file
    type:
      - 'null'
      - File
    doc: Create CSV summary file.
    inputBinding:
      position: 104
      prefix: -csvStats
  - id: custom_intervals_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Use a custom intervals in TXT/BED/BigBed/VCF/GFF file (you may use this
      option many times)
    inputBinding:
      position: 104
      prefix: -interval
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: Override data_dir parameter from config file.
    inputBinding:
      position: 104
      prefix: -dataDir
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug mode (very verbose).
    inputBinding:
      position: 104
      prefix: -d
  - id: download_ref_genome
    type:
      - 'null'
      - boolean
    doc: 'Download reference genome if not available. Default: true'
    default: true
    inputBinding:
      position: 104
      prefix: -download
  - id: fasta_prot_file
    type:
      - 'null'
      - File
    doc: Create an output file containing the resulting protein sequences.
    inputBinding:
      position: 104
      prefix: -fastaProt
  - id: fasta_prot_no_ref
    type:
      - 'null'
      - boolean
    doc: 'Do not add reference sequences to the output (only valid when -fastaProt).
      Default: false'
    default: false
    inputBinding:
      position: 104
      prefix: -fastaProtNoRef
  - id: file_list
    type:
      - 'null'
      - boolean
    doc: Input actually contains a list of files to process.
    inputBinding:
      position: 104
      prefix: -fileList
  - id: filter_interval_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Only analyze changes that intersect with the intervals specified in 
      this file (you may use this option many times)
    inputBinding:
      position: 104
      prefix: -fi
  - id: format_eff
    type:
      - 'null'
      - boolean
    doc: Use 'EFF' field compatible with older versions (instead of 'ANN').
    inputBinding:
      position: 104
      prefix: -formatEff
  - id: gene_id
    type:
      - 'null'
      - boolean
    doc: 'Use gene ID instead of gene name (VCF output). Default: false'
    default: false
    inputBinding:
      position: 104
      prefix: -geneId
  - id: hgvs
    type:
      - 'null'
      - boolean
    doc: 'Use HGVS annotations for amino acid sub-field. Default: true'
    default: true
    inputBinding:
      position: 104
      prefix: -hgvs
  - id: hgvs_old
    type:
      - 'null'
      - boolean
    doc: 'Use old HGVS notation. Default: false'
    default: false
    inputBinding:
      position: 104
      prefix: -hgvsOld
  - id: hgvs_one_letter_aa
    type:
      - 'null'
      - boolean
    doc: 'Use one letter Amino acid codes in HGVS notation. Default: false'
    default: false
    inputBinding:
      position: 104
      prefix: -hgvs1LetterAa
  - id: hgvs_transcript_id
    type:
      - 'null'
      - boolean
    doc: 'Use transcript ID in HGVS notation. Default: false'
    default: false
    inputBinding:
      position: 104
      prefix: -hgvsTrId
  - id: html_stats_file
    type:
      - 'null'
      - File
    doc: Create HTML summary file. Default is 'snpEff_summary.html'
    default: snpEff_summary.html
    inputBinding:
      position: 104
      prefix: -s
  - id: input_format
    type:
      - 'null'
      - string
    doc: 'Input format [ vcf, bed ]. Default: VCF.'
    default: VCF
    inputBinding:
      position: 104
      prefix: -i
  - id: interaction
    type:
      - 'null'
      - boolean
    doc: 'Annotate using interactions (requires interaction database). Default: true'
    default: true
    inputBinding:
      position: 104
      prefix: -interaction
  - id: lof
    type:
      - 'null'
      - boolean
    doc: Add loss of function (LOF) and Nonsense mediated decay (NMD) tags.
    inputBinding:
      position: 104
      prefix: -lof
  - id: max_transcript_support_level
    type:
      - 'null'
      - int
    doc: Only use transcripts having Transcript Support Level lower than 
      <TSL_number>.
    inputBinding:
      position: 104
      prefix: -maxTSL
  - id: motif
    type:
      - 'null'
      - boolean
    doc: 'Annotate using motifs (requires Motif database). Default: true'
    default: true
    inputBinding:
      position: 104
      prefix: -motif
  - id: next_prot
    type:
      - 'null'
      - boolean
    doc: Annotate using NextProt (requires NextProt database).
    inputBinding:
      position: 104
      prefix: -nextProt
  - id: no_download
    type:
      - 'null'
      - boolean
    doc: Do not download a SnpEff database, if not available locally.
    inputBinding:
      position: 104
      prefix: -nodownload
  - id: no_downstream
    type:
      - 'null'
      - boolean
    doc: Do not show DOWNSTREAM changes
    inputBinding:
      position: 104
      prefix: -no-downstream
  - id: no_effect_type
    type:
      - 'null'
      - type: array
        items: string
    doc: Do not show 'EffectType'. This option can be used several times.
    inputBinding:
      position: 104
      prefix: -no
  - id: no_expand_iub
    type:
      - 'null'
      - boolean
    doc: Disable IUB code expansion in input variants
    inputBinding:
      position: 104
      prefix: -noExpandIUB
  - id: no_genome
    type:
      - 'null'
      - boolean
    doc: Do not load any genomic database (e.g. annotate using custom files).
    inputBinding:
      position: 104
      prefix: -noGenome
  - id: no_hgvs
    type:
      - 'null'
      - boolean
    doc: Do not add HGVS annotations.
    inputBinding:
      position: 104
      prefix: -noHgvs
  - id: no_interaction
    type:
      - 'null'
      - boolean
    doc: Disable inteaction annotations
    inputBinding:
      position: 104
      prefix: -noInteraction
  - id: no_intergenic
    type:
      - 'null'
      - boolean
    doc: Do not show INTERGENIC changes
    inputBinding:
      position: 104
      prefix: -no-intergenic
  - id: no_intron
    type:
      - 'null'
      - boolean
    doc: Do not show INTRON changes
    inputBinding:
      position: 104
      prefix: -no-intron
  - id: no_lof
    type:
      - 'null'
      - boolean
    doc: Do not add LOF and NMD annotations.
    inputBinding:
      position: 104
      prefix: -noLof
  - id: no_log
    type:
      - 'null'
      - boolean
    doc: Do not report usage statistics to server
    inputBinding:
      position: 104
      prefix: -noLog
  - id: no_motif
    type:
      - 'null'
      - boolean
    doc: Disable motif annotations.
    inputBinding:
      position: 104
      prefix: -noMotif
  - id: no_next_prot
    type:
      - 'null'
      - boolean
    doc: Disable NextProt annotations.
    inputBinding:
      position: 104
      prefix: -noNextProt
  - id: no_output
    type:
      - 'null'
      - boolean
    doc: Do not write the output resuts to STDOUT (maybe used for debugging).
    inputBinding:
      position: 104
      prefix: -noOut
  - id: no_shift_hgvs
    type:
      - 'null'
      - boolean
    doc: Do not shift variants according to HGVS notation (most 3prime end).
    inputBinding:
      position: 104
      prefix: -noShiftHgvs
  - id: no_stats
    type:
      - 'null'
      - boolean
    doc: Do not create stats (summary) file
    inputBinding:
      position: 104
      prefix: -noStats
  - id: no_tag
    type:
      - 'null'
      - type: array
        items: string
    doc: Filter out transcript having a tag 'tagName'. This option can be used 
      multiple times.
    inputBinding:
      position: 104
      prefix: -notag
  - id: no_upstream
    type:
      - 'null'
      - boolean
    doc: Do not show UPSTREAM changes
    inputBinding:
      position: 104
      prefix: -no-upstream
  - id: no_utr
    type:
      - 'null'
      - boolean
    doc: Do not show 5_PRIME_UTR or 3_PRIME_UTR changes
    inputBinding:
      position: 104
      prefix: -no-utr
  - id: oicr
    type:
      - 'null'
      - boolean
    doc: 'Add OICR tag in VCF file. Default: false'
    default: false
    inputBinding:
      position: 104
      prefix: -oicr
  - id: only_protein
    type:
      - 'null'
      - boolean
    doc: 'Only use protein coding transcripts. Default: false'
    default: false
    inputBinding:
      position: 104
      prefix: -onlyProtein
  - id: only_reg
    type:
      - 'null'
      - boolean
    doc: Only use regulation tracks.
    inputBinding:
      position: 104
      prefix: -onlyReg
  - id: only_transcripts_file
    type:
      - 'null'
      - File
    doc: 'Only use the transcripts in this file. Format: One transcript ID per line.'
    inputBinding:
      position: 104
      prefix: -onlyTr
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Output format [ vcf, gatk, bed, bedAnn ]. Default: VCF.'
    default: VCF
    inputBinding:
      position: 104
      prefix: -o
  - id: prepend_chr
    type:
      - 'null'
      - string
    doc: Prepend 'string' to chromosome name (e.g. 'chr1' instead of '1'). Only 
      on TXT output.
    inputBinding:
      position: 104
      prefix: -chr
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode (do not show any messages or errors)
    inputBinding:
      position: 104
      prefix: -q
  - id: regulation_track
    type:
      - 'null'
      - type: array
        items: string
    doc: Regulation track to use (this option can be used add several times).
    inputBinding:
      position: 104
      prefix: -reg
  - id: sequence_ontology
    type:
      - 'null'
      - boolean
    doc: 'Use Sequence Ontology terms. Default: true'
    default: true
    inputBinding:
      position: 104
      prefix: -sequenceOntology
  - id: splice_region_exon_size
    type:
      - 'null'
      - int
    doc: 'Set size for splice site region within exons. Default: 3 bases'
    default: 3
    inputBinding:
      position: 104
      prefix: -spliceRegionExonSize
  - id: splice_region_intron_max
    type:
      - 'null'
      - int
    doc: 'Set maximum number of bases for splice site region within intron. Default:
      8 bases'
    default: 8
    inputBinding:
      position: 104
      prefix: -spliceRegionIntronMax
  - id: splice_region_intron_min
    type:
      - 'null'
      - int
    doc: 'Set minimum number of bases for splice site region within intron. Default:
      3 bases'
    default: 3
    inputBinding:
      position: 104
      prefix: -spliceRegionIntronMin
  - id: splice_site_size
    type:
      - 'null'
      - int
    doc: 'Set size for splice sites (donor and acceptor) in bases. Default: 2'
    default: 2
    inputBinding:
      position: 104
      prefix: -ss
  - id: strict
    type:
      - 'null'
      - boolean
    doc: "Only use 'validated' transcripts (i.e. sequence has been checked). Default:
      false"
    default: false
    inputBinding:
      position: 104
      prefix: -strict
  - id: tag
    type:
      - 'null'
      - type: array
        items: string
    doc: Only use transcript having a tag 'tagName'. This option can be used 
      multiple times.
    inputBinding:
      position: 104
      prefix: -tag
  - id: up_down_stream_len
    type:
      - 'null'
      - int
    doc: Set upstream downstream interval length (in bases)
    inputBinding:
      position: 104
      prefix: -ud
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpeff:5.4.0a--hdfd78af_0
stdout: snpeff_snpEff.out
