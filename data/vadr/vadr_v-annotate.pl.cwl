cwlVersion: v1.2
class: CommandLineTool
baseCommand: v-annotate.pl
label: vadr_v-annotate.pl
doc: "classify and annotate sequences using a model library\n\nTool homepage: https://github.com/ncbi/vadr"
inputs:
  - id: fasta_file
    type: File
    doc: fasta file to annotate
    inputBinding:
      position: 1
  - id: output_directory
    type: Directory
    doc: output directory to create
    inputBinding:
      position: 2
  - id: alicheck
    type:
      - 'null'
      - boolean
    doc: for debugging, check aligned sequence vs input sequence for identity
    inputBinding:
      position: 103
      prefix: --alicheck
  - id: align_skip
    type:
      - 'null'
      - boolean
    doc: skip the alignment step, use results from an earlier run of the script
    inputBinding:
      position: 103
      prefix: --align_skip
  - id: alt_fail
    type:
      - 'null'
      - string
    doc: specify that alert codes in comma-separated <s> do cause FAILure
    inputBinding:
      position: 103
      prefix: --alt_fail
  - id: alt_list
    type:
      - 'null'
      - boolean
    doc: output summary of all alerts and exit
    inputBinding:
      position: 103
      prefix: --alt_list
  - id: alt_mnf_no
    type:
      - 'null'
      - string
    doc: alert codes in <s> for 'misc_not_failure' features cause failure, not 
      misc-feature-ization
    inputBinding:
      position: 103
      prefix: --alt_mnf_no
  - id: alt_mnf_yes
    type:
      - 'null'
      - string
    doc: alert codes in <s> for 'misc_not_failure' features cause 
      misc_feature-ization, not failure
    inputBinding:
      position: 103
      prefix: --alt_mnf_yes
  - id: alt_pass
    type:
      - 'null'
      - string
    doc: specify that alert codes in comma-separated <s> do not cause FAILure
    inputBinding:
      position: 103
      prefix: --alt_pass
  - id: atgonly
    type:
      - 'null'
      - boolean
    doc: only consider ATG a valid start codon
    inputBinding:
      position: 103
      prefix: --atgonly
  - id: biasfract
    type:
      - 'null'
      - float
    doc: biasdseq/BIASED_SEQUENCE fractional threshold is <x>
    inputBinding:
      position: 103
      prefix: --biasfract
  - id: blastn_db_file
    type:
      - 'null'
      - string
    doc: use blastn db file <s> instead of default
    inputBinding:
      position: 103
      prefix: -n
  - id: blastx_dbs_dir
    type:
      - 'null'
      - Directory
    doc: blastx dbs are in dir <s>, instead of default
    inputBinding:
      position: 103
      prefix: -x
  - id: cm_file
    type:
      - 'null'
      - string
    doc: use CM file <s> instead of default
    inputBinding:
      position: 103
      prefix: -m
  - id: cmindi
    type:
      - 'null'
      - boolean
    doc: force cmalign to align on seq at a time
    inputBinding:
      position: 103
      prefix: --cmindi
  - id: cpu
    type:
      - 'null'
      - int
    doc: parallelize across <n> CPU workers (requires --split or --glsearch)
    inputBinding:
      position: 103
      prefix: --cpu
  - id: dupregolp
    type:
      - 'null'
      - int
    doc: dupreg in/DUPLICATE_REGIONS minimum model overlap is <n>
    inputBinding:
      position: 103
      prefix: --dupregolp
  - id: dupregsc
    type:
      - 'null'
      - float
    doc: dupreg in/DUPLICATE_REGIONS minimum bit score is <x>
    inputBinding:
      position: 103
      prefix: --dupregsc
  - id: errcheck
    type:
      - 'null'
      - boolean
    doc: consider any farm stderr output as indicating a job failure
    inputBinding:
      position: 103
      prefix: --errcheck
  - id: execname
    type:
      - 'null'
      - string
    doc: define executable name of this script as <s>
    inputBinding:
      position: 103
      prefix: --execname
  - id: extrant3
    type:
      - 'null'
      - int
    doc: extrant3/EXTRA_SEQUENCE_END minimum length is <n>
    inputBinding:
      position: 103
      prefix: --extrant3
  - id: extrant5
    type:
      - 'null'
      - int
    doc: extrant5/EXTRA_SEQUENCE_START minimum length is <n>
    inputBinding:
      position: 103
      prefix: --extrant5
  - id: flankselfins
    type:
      - 'null'
      - float
    doc: set self-transit probs in ROOT_IL/IR for cmalign to <x>
    inputBinding:
      position: 103
      prefix: --flankselfins
  - id: flanktoins
    type:
      - 'null'
      - float
    doc: set transition probs to ROOT_IL/IR for cmalign to <x>
    inputBinding:
      position: 103
      prefix: --flanktoins
  - id: force
    type:
      - 'null'
      - boolean
    doc: force; if output dir exists, overwrite it
    inputBinding:
      position: 103
      prefix: -f
  - id: force_canonss
    type:
      - 'null'
      - boolean
    doc: force 'canon_splice_sites' is 1 for all CDS with qualifying introns
    inputBinding:
      position: 103
      prefix: --force_canonss
  - id: forcedcrins
    type:
      - 'null'
      - boolean
    doc: force insert type alignment doctoring, requires --cmindi
    inputBinding:
      position: 103
      prefix: --forcedcrins
  - id: forcegene
    type:
      - 'null'
      - boolean
    doc: in feature table, add 'gene' qualifiers in model info file to CDS and 
      mat_peptide
    inputBinding:
      position: 103
      prefix: --forcegene
  - id: forceprotid
    type:
      - 'null'
      - boolean
    doc: in feature table, force protein_id value to be sequence name, then idx
    inputBinding:
      position: 103
      prefix: --forceprotid
  - id: forcequal
    type:
      - 'null'
      - string
    doc: in feature table, add qualifiers in model info file listed in 
      comma-delimited <s>
    inputBinding:
      position: 103
      prefix: --forcequal
  - id: fsthighthr
    type:
      - 'null'
      - float
    doc: fsthicf{t,i}/POSSIBLE_FRAMESHIFT_HIGH_CONF minimum average probability 
      for alert is <x>
    inputBinding:
      position: 103
      prefix: --fsthighthr
  - id: fstlowthr
    type:
      - 'null'
      - float
    doc: fstlocf{t,i}/POSSIBLE_FRAMESHIFT_LOW_CONF minimum average probability 
      for alert is <x>
    inputBinding:
      position: 103
      prefix: --fstlowthr
  - id: fstminnti
    type:
      - 'null'
      - int
    doc: fst{hi,lo,uk}cfi/POSSIBLE_FRAMESHIFT{_{HIGH,LOW}_CONF,} max allowed 
      internal nt length w/o alert is <n>
    inputBinding:
      position: 103
      prefix: --fstminnti
  - id: fstminntt
    type:
      - 'null'
      - int
    doc: fst{hi,lo,uk}cft/POSSIBLE_FRAMESHIFT{_{HIGH,LOW}_CONF,} max allowed 
      terminal nt length w/o alert is <n>
    inputBinding:
      position: 103
      prefix: --fstminntt
  - id: gls_gapextend
    type:
      - 'null'
      - int
    doc: set glsearch gap extend score to <n> < 0 with glsearch -g option
    inputBinding:
      position: 103
      prefix: --gls_gapextend
  - id: gls_gapopen
    type:
      - 'null'
      - int
    doc: set glsearch gap open score to <n> < 0 with glsearch -f option
    inputBinding:
      position: 103
      prefix: --gls_gapopen
  - id: gls_match
    type:
      - 'null'
      - int
    doc: set glsearch match score to <n> > 0 with glsearch -r option
    inputBinding:
      position: 103
      prefix: --gls_match
  - id: gls_mismatch
    type:
      - 'null'
      - int
    doc: set glsearch mismatch score to <n> < 0 with glsearch -r option
    inputBinding:
      position: 103
      prefix: --gls_mismatch
  - id: glsearch
    type:
      - 'null'
      - boolean
    doc: align with glsearch from the FASTA package, not to a cm with cmalign
    inputBinding:
      position: 103
      prefix: --glsearch
  - id: group
    type:
      - 'null'
      - string
    doc: set expected classification of all seqs to group <s>
    inputBinding:
      position: 103
      prefix: --group
  - id: h_max
    type:
      - 'null'
      - boolean
    doc: use --max option with hmmsearch
    inputBinding:
      position: 103
      prefix: --h_max
  - id: h_minbit
    type:
      - 'null'
      - float
    doc: set minimum hmmsearch bit score threshold to <x>
    inputBinding:
      position: 103
      prefix: --h_minbit
  - id: hlonescore
    type:
      - 'null'
      - int
    doc: indfantp/INDEFINITE_ANNOTATION min score for a hmmer hit not supported 
      by CM analysis is <n>
    inputBinding:
      position: 103
      prefix: --hlonescore
  - id: ignore_afset
    type:
      - 'null'
      - boolean
    doc: ignore 'alternative_ftr_set' and 'alternative_ftr_set_subn' values in 
      .minfo file
    inputBinding:
      position: 103
      prefix: --ignore_afset
  - id: ignore_afsetsubn
    type:
      - 'null'
      - boolean
    doc: ignore 'alternative_ftr_set_subn' values in .minfo file
    inputBinding:
      position: 103
      prefix: --ignore_afsetsubn
  - id: ignore_canonss
    type:
      - 'null'
      - boolean
    doc: ignore 'canon_splice_sites' values in .minfo file (never check intron 
      splice sites)
    inputBinding:
      position: 103
      prefix: --ignore_canonss
  - id: ignore_exc
    type:
      - 'null'
      - boolean
    doc: ignore all exception keys '*_exc' in .minfo file
    inputBinding:
      position: 103
      prefix: --ignore_exc
  - id: ignore_isdel
    type:
      - 'null'
      - boolean
    doc: ignore non-zero 'is_deletable' values in .minfo file, set to 0 for all 
      features/models
    inputBinding:
      position: 103
      prefix: --ignore_isdel
  - id: ignore_mnf
    type:
      - 'null'
      - boolean
    doc: ignore non-zero 'misc_not_feature' values in .minfo file, set to 0 for 
      all features/models
    inputBinding:
      position: 103
      prefix: --ignore_mnf
  - id: incspec
    type:
      - 'null'
      - float
    doc: inc{group,subgrp}/INCORRECT_{GROUP,SUBGROUP} bits/nt threshold is <x>
    inputBinding:
      position: 103
      prefix: --incspec
  - id: indefann
    type:
      - 'null'
      - float
    doc: indf{5,3}lc{c,n}/'INDEFINITE_ANNOTATION_{START,END} non-mat_peptide min
      allowed post probability is <x>
    inputBinding:
      position: 103
      prefix: --indefann
  - id: indefann_mp
    type:
      - 'null'
      - float
    doc: indf{5,3}lc{c,n}/'INDEFINITE_ANNOTATION_{START,END} mat_peptide min 
      allowed post probability is <x>
    inputBinding:
      position: 103
      prefix: --indefann_mp
  - id: indefclass
    type:
      - 'null'
      - float
    doc: indfcls/INDEFINITE_CLASSIFICATION bits per nucleotide diff threshold is
      <x>
    inputBinding:
      position: 103
      prefix: --indefclass
  - id: indefstr
    type:
      - 'null'
      - float
    doc: indfstrn/INDEFINITE_STRAND minimum weaker strand bit score is <x>
    inputBinding:
      position: 103
      prefix: --indefstr
  - id: intlen
    type:
      - 'null'
      - int
    doc: set min length of intron to check for splice sites to <n>
    inputBinding:
      position: 103
      prefix: --intlen
  - id: keep
    type:
      - 'null'
      - boolean
    doc: do not remove intermediate files, keep them all on disk
    inputBinding:
      position: 103
      prefix: --keep
  - id: lowcov
    type:
      - 'null'
      - float
    doc: lowcovrg/LOW_COVERAGE fractional coverage threshold is <x>
    inputBinding:
      position: 103
      prefix: --lowcov
  - id: lowsc
    type:
      - 'null'
      - float
    doc: lowscore/LOW_SCORE bits per nucleotide threshold is <x>
    inputBinding:
      position: 103
      prefix: --lowsc
  - id: lowsim3ftr
    type:
      - 'null'
      - int
    doc: lowsim3{c,n}/LOW_FEATURE_SIMILARITY_END minimum length is <n>
    inputBinding:
      position: 103
      prefix: --lowsim3ftr
  - id: lowsim3lftr
    type:
      - 'null'
      - int
    doc: long lowsim3l/LOW_FEATURE_SIMILARITY_END minimum length is <n>
    inputBinding:
      position: 103
      prefix: --lowsim3lftr
  - id: lowsim3seq
    type:
      - 'null'
      - int
    doc: lowsim3s/LOW_SIMILARITY_END minimum length is <n>
    inputBinding:
      position: 103
      prefix: --lowsim3seq
  - id: lowsim5ftr
    type:
      - 'null'
      - int
    doc: lowsim5{c,n}/LOW_FEATURE_SIMILARITY_START minimum length is <n>
    inputBinding:
      position: 103
      prefix: --lowsim5ftr
  - id: lowsim5lftr
    type:
      - 'null'
      - int
    doc: long lowsim5l/LOW_FEATURE_SIMILARITY_START minimum length is <n>
    inputBinding:
      position: 103
      prefix: --lowsim5lftr
  - id: lowsim5seq
    type:
      - 'null'
      - int
    doc: lowsim5s/LOW_SIMILARITY_START minimum length is <n>
    inputBinding:
      position: 103
      prefix: --lowsim5seq
  - id: lowsimiftr
    type:
      - 'null'
      - int
    doc: lowsimi{c,n}/LOW_FEATURE_SIMILARITY (internal) minimum length is <n>
    inputBinding:
      position: 103
      prefix: --lowsimiftr
  - id: lowsimilftr
    type:
      - 'null'
      - int
    doc: long lowsimil/LOW_FEATURE_SIMILARITY (internal) minimum length is <n>
    inputBinding:
      position: 103
      prefix: --lowsimilftr
  - id: lowsimiseq
    type:
      - 'null'
      - int
    doc: lowsimi/LOW_SIMILARITY (internal) minimum length is <n>
    inputBinding:
      position: 103
      prefix: --lowsimiseq
  - id: maxnjobs
    type:
      - 'null'
      - int
    doc: set max number of jobs to submit to compute farm to <n>
    inputBinding:
      position: 103
      prefix: --maxnjobs
  - id: minbit
    type:
      - 'null'
      - float
    doc: set minimum cmsearch bit score threshold to <x>
    inputBinding:
      position: 103
      prefix: --minbit
  - id: minimap2
    type:
      - 'null'
      - boolean
    doc: use minimap2 to derive seed and use it if >= length of blastn seed
    inputBinding:
      position: 103
      prefix: --minimap2
  - id: minpvlen
    type:
      - 'null'
      - int
    doc: min CDS/mat_peptide/gene length for feature table output and protein 
      validation is <n>
    inputBinding:
      position: 103
      prefix: --minpvlen
  - id: mm2_asm10
    type:
      - 'null'
      - boolean
    doc: use -x asm10 with minimap2, instead of -x asm20
    inputBinding:
      position: 103
      prefix: --mm2_asm10
  - id: mm2_asm5
    type:
      - 'null'
      - boolean
    doc: use -x asm5 with minimap2, instead of -x asm20
    inputBinding:
      position: 103
      prefix: --mm2_asm5
  - id: mm2_k
    type:
      - 'null'
      - int
    doc: use -k <n> option with minimap2, instead of -x asm20
    inputBinding:
      position: 103
      prefix: --mm2_k
  - id: mm2_w
    type:
      - 'null'
      - int
    doc: use -w <n> option with minimap2, instead of -x asm20
    inputBinding:
      position: 103
      prefix: --mm2_w
  - id: model_dir
    type:
      - 'null'
      - Directory
    doc: model files are in directory <s>, not in $VADRMODELDIR
    inputBinding:
      position: 103
      prefix: --mdir
  - id: model_info_file
    type:
      - 'null'
      - string
    doc: use model info file <s> instead of default
    inputBinding:
      position: 103
      prefix: -i
  - id: model_key
    type:
      - 'null'
      - string
    doc: .cm, .minfo, blastn .fa files in $VADRMODELDIR start with key <s>, not 
      'vadr'
    inputBinding:
      position: 103
      prefix: --mkey
  - id: model_list_file
    type:
      - 'null'
      - File
    doc: only use models listed in file <s>
    inputBinding:
      position: 103
      prefix: --mlist
  - id: msub
    type:
      - 'null'
      - string
    doc: read model substitution file from <s>
    inputBinding:
      position: 103
      prefix: --msub
  - id: mxsize
    type:
      - 'null'
      - int
    doc: set max allowed memory for cmalign to <n> Mb
    inputBinding:
      position: 103
      prefix: --mxsize
  - id: nkb
    type:
      - 'null'
      - int
    doc: number of KB of sequence for each alignment job and/or chunk is <n>
    inputBinding:
      position: 103
      prefix: --nkb
  - id: nmaxdel
    type:
      - 'null'
      - int
    doc: deletinn/DELETION_OF_NT max allowed nucleotide (nt) deletion length in 
      CDS nt alignment is <n>
    inputBinding:
      position: 103
      prefix: --nmaxdel
  - id: nmaxins
    type:
      - 'null'
      - int
    doc: insertnn/INSERTION_OF_NT max allowed nucleotide (nt) insertion length 
      in CDS nt alignment is <n>
    inputBinding:
      position: 103
      prefix: --nmaxins
  - id: nmiscftrthr
    type:
      - 'null'
      - int
    doc: nmiscftr/TOO_MANY_MISC_FEATURES reported if <n> or more misc_features
    inputBinding:
      position: 103
      prefix: --nmiscftrthr
  - id: nodcr
    type:
      - 'null'
      - boolean
    doc: do not doctor alignments to shift gaps in start/stop codons
    inputBinding:
      position: 103
      prefix: --nodcr
  - id: nofixedtau
    type:
      - 'null'
      - boolean
    doc: do not fix the tau value when running cmalign, allow it to decrease if 
      nec
    inputBinding:
      position: 103
      prefix: --nofixedtau
  - id: noflank
    type:
      - 'null'
      - boolean
    doc: do not use --flank* options to improve alns at ends
    inputBinding:
      position: 103
      prefix: --noflank
  - id: noftrtrim
    type:
      - 'null'
      - string
    doc: in feature table, don't trim coords due to ambiguities for feature 
      types in comma-delmited <s>
    inputBinding:
      position: 103
      prefix: --noftrtrim
  - id: noglocal
    type:
      - 'null'
      - boolean
    doc: do not run cmalign in glocal mode (run in local mode)
    inputBinding:
      position: 103
      prefix: --noglocal
  - id: nomisc
    type:
      - 'null'
      - boolean
    doc: in feature table for failed seqs, never change feature type to 
      misc_feature
    inputBinding:
      position: 103
      prefix: --nomisc
  - id: noprotid
    type:
      - 'null'
      - boolean
    doc: in feature table, don't add protein_id for CDS and mat_peptides
    inputBinding:
      position: 103
      prefix: --noprotid
  - id: noseqnamemax
    type:
      - 'null'
      - boolean
    doc: do not enforce a maximum length of 50 for sequence names (GenBank max)
    inputBinding:
      position: 103
      prefix: --noseqnamemax
  - id: nosub
    type:
      - 'null'
      - boolean
    doc: use alternative alignment strategy for truncated sequences
    inputBinding:
      position: 103
      prefix: --nosub
  - id: notrim
    type:
      - 'null'
      - boolean
    doc: in feature table, don't trim coords due to ambiguities (for any feature
      types)
    inputBinding:
      position: 103
      prefix: --notrim
  - id: origfa
    type:
      - 'null'
      - boolean
    doc: do not copy fasta file prior to analysis, use original
    inputBinding:
      position: 103
      prefix: --origfa
  - id: out_afa
    type:
      - 'null'
      - boolean
    doc: output per-model full length fasta alignments (.afa)
    inputBinding:
      position: 103
      prefix: --out_afa
  - id: out_allfasta
    type:
      - 'null'
      - boolean
    doc: additionally output fasta files of features
    inputBinding:
      position: 103
      prefix: --out_allfasta
  - id: out_debug
    type:
      - 'null'
      - boolean
    doc: dump voluminous info from various data structures to output files
    inputBinding:
      position: 103
      prefix: --out_debug
  - id: out_fsstk
    type:
      - 'null'
      - boolean
    doc: additionally output frameshift stockholm alignment files
    inputBinding:
      position: 103
      prefix: --out_fsstk
  - id: out_nofasta
    type:
      - 'null'
      - boolean
    doc: do not output fasta files of passing/failing seqs
    inputBinding:
      position: 103
      prefix: --out_nofasta
  - id: out_noftrfasta
    type:
      - 'null'
      - boolean
    doc: with --keep, do not output fasta for each feature
    inputBinding:
      position: 103
      prefix: --out_noftrfasta
  - id: out_rpafa
    type:
      - 'null'
      - boolean
    doc: with -r, output fasta alignments of seqs with Ns replaced
    inputBinding:
      position: 103
      prefix: --out_rpafa
  - id: out_rpstk
    type:
      - 'null'
      - boolean
    doc: with -r, output stockholm alignments of seqs with Ns replaced
    inputBinding:
      position: 103
      prefix: --out_rpstk
  - id: out_stk
    type:
      - 'null'
      - boolean
    doc: output per-model full length stockholm alignments (.stk)
    inputBinding:
      position: 103
      prefix: --out_stk
  - id: parallel_farm
    type:
      - 'null'
      - boolean
    doc: parallelize cmsearch/cmalign on a compute farm
    inputBinding:
      position: 103
      prefix: -p
  - id: protein_hmm_file
    type:
      - 'null'
      - string
    doc: use protein HMM file <s> instead of default
    inputBinding:
      position: 103
      prefix: -a
  - id: pv_hmmer
    type:
      - 'null'
      - boolean
    doc: use hmmer for protein validation, not blastx
    inputBinding:
      position: 103
      prefix: --pv_hmmer
  - id: pv_skip
    type:
      - 'null'
      - boolean
    doc: do not perform blastx-based protein validation
    inputBinding:
      position: 103
      prefix: --pv_skip
  - id: qsub_file
    type:
      - 'null'
      - string
    doc: use qsub info file <s> instead of default
    inputBinding:
      position: 103
      prefix: -q
  - id: r_blastngdf
    type:
      - 'null'
      - boolean
    doc: for -r, don't use -gapopen/-gapextend w/blastn (use default values)
    inputBinding:
      position: 103
      prefix: --r_blastngdf
  - id: r_blastnge
    type:
      - 'null'
      - float
    doc: for -r, set blastn -gapextend <x> to <x>
    inputBinding:
      position: 103
      prefix: --r_blastnge
  - id: r_blastngo
    type:
      - 'null'
      - int
    doc: for -r, set blastn -gapopen <n> to <n>
    inputBinding:
      position: 103
      prefix: --r_blastngo
  - id: r_blastnpn
    type:
      - 'null'
      - int
    doc: for -r, set blastn -penalty <n> to <n>
    inputBinding:
      position: 103
      prefix: --r_blastnpn
  - id: r_blastnrw
    type:
      - 'null'
      - int
    doc: for -r, set blastn -reward <n> to <n>
    inputBinding:
      position: 103
      prefix: --r_blastnrw
  - id: r_blastnsc
    type:
      - 'null'
      - float
    doc: for -r, set blastn minimum HSP score to consider to <x>
    inputBinding:
      position: 103
      prefix: --r_blastnsc
  - id: r_blastntk
    type:
      - 'null'
      - boolean
    doc: for -r, set blastn option -task blastn
    inputBinding:
      position: 103
      prefix: --r_blastntk
  - id: r_blastnws
    type:
      - 'null'
      - int
    doc: for -r, set blastn -word_size <n> to <n>
    inputBinding:
      position: 103
      prefix: --r_blastnws
  - id: r_blastnxd
    type:
      - 'null'
      - int
    doc: for -r, set blastn -xdrop_gap_final <n> to <n>
    inputBinding:
      position: 103
      prefix: --r_blastnxd
  - id: r_cdsmpr
    type:
      - 'null'
      - boolean
    doc: detect CDS and MP alerts in sequences w/Ns replaced, not originals
    inputBinding:
      position: 103
      prefix: --r_cdsmpr
  - id: r_diffmaxdel
    type:
      - 'null'
      - int
    doc: max allowed length difference b/t seq/mdl regions (mdllen>seqlen) to 
      try replacement is <n>
    inputBinding:
      position: 103
      prefix: --r_diffmaxdel
  - id: r_diffmaxins
    type:
      - 'null'
      - int
    doc: max allowed length difference b/t seq/mdl regions (seqlen>mdllen) to 
      try replacement is <n>
    inputBinding:
      position: 103
      prefix: --r_diffmaxins
  - id: r_diffminfract
    type:
      - 'null'
      - float
    doc: min allowed fraction of non-N matches in diff len replacement region is
      <x>
    inputBinding:
      position: 103
      prefix: --r_diffminfract
  - id: r_diffminnonn
    type:
      - 'null'
      - int
    doc: min number non-Ns in diff len replacement region to try replacement is 
      <n>
    inputBinding:
      position: 103
      prefix: --r_diffminnonn
  - id: r_diffno
    type:
      - 'null'
      - boolean
    doc: do not try replacement if seq and mdl regions are of different lengths
    inputBinding:
      position: 103
      prefix: --r_diffno
  - id: r_fetchr
    type:
      - 'null'
      - boolean
    doc: fetch features for output fastas from seqs w/Ns replaced, not originals
    inputBinding:
      position: 103
      prefix: --r_fetchr
  - id: r_list
    type:
      - 'null'
      - string
    doc: with -r, only use models listed in file <s> for N replacement stage
    inputBinding:
      position: 103
      prefix: --r_list
  - id: r_lowsimmf
    type:
      - 'null'
      - float
    doc: w/--r_lowsimok, minimum fraction of Ns in N-rich region is <x>
    inputBinding:
      position: 103
      prefix: --r_lowsimmf
  - id: r_lowsimok
    type:
      - 'null'
      - boolean
    doc: with -r, do not report lowsim{5,3,i}s within identified N-rich regions
    inputBinding:
      position: 103
      prefix: --r_lowsimok
  - id: r_lowsimxd
    type:
      - 'null'
      - int
    doc: w/--r_lowsimok, max diff from expected length for N-rich region is <n>
    inputBinding:
      position: 103
      prefix: --r_lowsimxd
  - id: r_lowsimxl
    type:
      - 'null'
      - int
    doc: w/--r_lowsimok, maximum length of N-rich region is <n>
    inputBinding:
      position: 103
      prefix: --r_lowsimxl
  - id: r_minfract3
    type:
      - 'null'
      - float
    doc: minimum fraction of Ns in subseq at 3' end to trigger replacement is 
      <x>
    inputBinding:
      position: 103
      prefix: --r_minfract3
  - id: r_minfract5
    type:
      - 'null'
      - float
    doc: minimum fraction of Ns in subseq at 5' end to trigger replacement is 
      <x>
    inputBinding:
      position: 103
      prefix: --r_minfract5
  - id: r_minfracti
    type:
      - 'null'
      - float
    doc: minimum fraction of Ns in internal subseq to trigger replacement is <x>
    inputBinding:
      position: 103
      prefix: --r_minfracti
  - id: r_minlen
    type:
      - 'null'
      - int
    doc: minimum length subsequence to replace Ns in is <n>
    inputBinding:
      position: 103
      prefix: --r_minlen
  - id: r_only
    type:
      - 'null'
      - string
    doc: with -r, only use model named <s> for N replacement stage
    inputBinding:
      position: 103
      prefix: --r_only
  - id: r_prof
    type:
      - 'null'
      - boolean
    doc: use slower profile methods, not blastn, to identify Ns to replace
    inputBinding:
      position: 103
      prefix: --r_prof
  - id: r_pvorig
    type:
      - 'null'
      - boolean
    doc: use original sequences for protein validation, not replaced seqs
    inputBinding:
      position: 103
      prefix: --r_pvorig
  - id: replace_ns
    type:
      - 'null'
      - boolean
    doc: replace stretches of Ns with expected nts, where possible
    inputBinding:
      position: 103
      prefix: -r
  - id: s_allsgm
    type:
      - 'null'
      - boolean
    doc: for -s, keep full HSP seed, do not enforce minimum segment length
    inputBinding:
      position: 103
      prefix: --s_allsgm
  - id: s_blastngdf
    type:
      - 'null'
      - boolean
    doc: for -s, don't use -gapopen/-gapextend w/blastn (use default values)
    inputBinding:
      position: 103
      prefix: --s_blastngdf
  - id: s_blastnge
    type:
      - 'null'
      - float
    doc: for -s, set blastn -gapextend <x> to <x>
    inputBinding:
      position: 103
      prefix: --s_blastnge
  - id: s_blastngo
    type:
      - 'null'
      - int
    doc: for -s, set blastn -gapopen <n> to <n>
    inputBinding:
      position: 103
      prefix: --s_blastngo
  - id: s_blastnpn
    type:
      - 'null'
      - int
    doc: for -s, set blastn -penalty <n> to <n>
    inputBinding:
      position: 103
      prefix: --s_blastnpn
  - id: s_blastnrw
    type:
      - 'null'
      - int
    doc: for -s, set blastn -reward <n> to <n>
    inputBinding:
      position: 103
      prefix: --s_blastnrw
  - id: s_blastnsc
    type:
      - 'null'
      - float
    doc: for -s, set blastn minimum HSP score to consider to <x>
    inputBinding:
      position: 103
      prefix: --s_blastnsc
  - id: s_blastntk
    type:
      - 'null'
      - boolean
    doc: for -s, set blastn option -task blastn
    inputBinding:
      position: 103
      prefix: --s_blastntk
  - id: s_blastnws
    type:
      - 'null'
      - int
    doc: for -s, set blastn -word_size <n> to <n>
    inputBinding:
      position: 103
      prefix: --s_blastnws
  - id: s_blastnxd
    type:
      - 'null'
      - int
    doc: for -s, set blastn -xdrop_gap_final <n> to <n>
    inputBinding:
      position: 103
      prefix: --s_blastnxd
  - id: s_minsgmlen
    type:
      - 'null'
      - int
    doc: for -s, set minimum length of ungapped region in HSP seed to <n>
    inputBinding:
      position: 103
      prefix: --s_minsgmlen
  - id: s_overhang
    type:
      - 'null'
      - int
    doc: for -s, set length of nt overhang for subseqs to align to <n>
    inputBinding:
      position: 103
      prefix: --s_overhang
  - id: s_startstop
    type:
      - 'null'
      - boolean
    doc: for -s, allow seed to include gaps in start/stop codons
    inputBinding:
      position: 103
      prefix: --s_startstop
  - id: s_ungapsgm
    type:
      - 'null'
      - boolean
    doc: for -s, only keep max length ungapped segment of HSP
    inputBinding:
      position: 103
      prefix: --s_ungapsgm
  - id: seed_blastn
    type:
      - 'null'
      - boolean
    doc: use top-scoring HSP from blastn to seed the alignment
    inputBinding:
      position: 103
      prefix: -s
  - id: sidx
    type:
      - 'null'
      - int
    doc: start sequence indexing at <n> in tabular output files
    inputBinding:
      position: 103
      prefix: --sidx
  - id: split
    type:
      - 'null'
      - boolean
    doc: split input file into chunks, run each chunk separately
    inputBinding:
      position: 103
      prefix: --split
  - id: subgroup
    type:
      - 'null'
      - string
    doc: set expected classification of all seqs to subgroup <s>
    inputBinding:
      position: 103
      prefix: --subgroup
  - id: tau
    type:
      - 'null'
      - float
    doc: set the initial tau value for cmalign to <x>
    inputBinding:
      position: 103
      prefix: --tau
  - id: val_only
    type:
      - 'null'
      - boolean
    doc: validate CM and other input files and exit
    inputBinding:
      position: 103
      prefix: --val_only
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: be verbose; output commands to stdout as they're run
    inputBinding:
      position: 103
      prefix: -v
  - id: wait
    type:
      - 'null'
      - int
    doc: allow <n> wall-clock minutes for jobs on farm to finish, including 
      queueing time
    inputBinding:
      position: 103
      prefix: --wait
  - id: xalntol
    type:
      - 'null'
      - int
    doc: indf{5,3}{st,lg}/INDEFINITE_ANNOTATION_{START,END} max allowed nt diff 
      blastx start/end is <n>
    inputBinding:
      position: 103
      prefix: --xalntol
  - id: xdrop
    type:
      - 'null'
      - int
    doc: set the xdrop value for blastx to <n>
    inputBinding:
      position: 103
      prefix: --xdrop
  - id: xlonescore
    type:
      - 'null'
      - int
    doc: indfantp/INDEFINITE_ANNOTATION min score for a blastx hit not supported
      by CM analysis is <n>
    inputBinding:
      position: 103
      prefix: --xlonescore
  - id: xmatrix
    type:
      - 'null'
      - string
    doc: use the matrix <s> with blastx (e.g. BLOSUM45)
    inputBinding:
      position: 103
      prefix: --xmatrix
  - id: xmaxdel
    type:
      - 'null'
      - int
    doc: deletinp/DELETION_OF_NT max allowed nucleotide deletion length in 
      blastx validation is <n>
    inputBinding:
      position: 103
      prefix: --xmaxdel
  - id: xmaxins
    type:
      - 'null'
      - int
    doc: insertnp/INSERTION_OF_NT max allowed nucleotide insertion length in 
      blastx validation is <n>
    inputBinding:
      position: 103
      prefix: --xmaxins
  - id: xnocomp
    type:
      - 'null'
      - boolean
    doc: turn off composition-based for blastx statistics with comp_based_stats 
      0
    inputBinding:
      position: 103
      prefix: --xnocomp
  - id: xnoid
    type:
      - 'null'
      - boolean
    doc: ignore blastx hits that are full length and 100% identical
    inputBinding:
      position: 103
      prefix: --xnoid
  - id: xnolongest
    type:
      - 'null'
      - boolean
    doc: do not consider longest blastx hit, only max scoring
    inputBinding:
      position: 103
      prefix: --xnolongest
  - id: xnumali
    type:
      - 'null'
      - int
    doc: number of alignments to keep in blastx output and consider if 
      --xlongest is <n>
    inputBinding:
      position: 103
      prefix: --xnumali
  - id: xsub
    type:
      - 'null'
      - string
    doc: read blastx db substitution file from <s>
    inputBinding:
      position: 103
      prefix: --xsub
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vadr:1.6.4--pl5321h031d066_0
stdout: vadr_v-annotate.pl.out
