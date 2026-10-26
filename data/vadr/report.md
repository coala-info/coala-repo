# vadr CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| vadr_v-annotate.pl | PASS | real SARS-CoV-2 genomes (NC_045512.2 and MT520263.1) classified and annotated with the sarscov2 model that ships in the image; the run takes about 5 minutes |
| vadr_v-build.pl | PASS | built a model of hepatitis B virus (NC_003977, 3.2 kb) in about 2 minutes; the accession must be given without a version suffix |
| vadr_vadr-map-model-coords.pl | PASS | real VADR .alt.list and .alt output for MW691153.1 (NC_045512-del28254 model) mapped to NC_045512 with the official sarscov2.mmap; coordinates after the deleted position 28254 shift by 1 as expected |
| vadr_vadr-map-two-complete-models.pl | PASS | NC_045512-MW422255 to NC_045512 map from the official sarscov2.mmap; 29884 positions, the 9 base gap after position 11287 is mapped correctly |

## vadr_v-annotate.pl

### Tool Description
classify and annotate sequences using a model library

### Metadata
- **Docker Image**: quay.io/biocontainers/vadr:1.6.4--pl5321h031d066_0
- **Homepage**: https://github.com/ncbi/vadr
- **Package**: https://anaconda.org/channels/bioconda/packages/vadr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vadr/overview
- **Total Downloads**: 18.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ncbi/vadr
- **Stars**: N/A
### Original Help Text
```text
# v-annotate.pl :: classify and annotate sequences using a model library
# VADR 1.6.4 (Jun 2024)
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# date:    Wed Feb 25 03:57:04 2026
#
Usage: v-annotate.pl [-options] <fasta file to annotate> <output directory to create>

basic options:
  -f             : force; if output dir exists, overwrite it
  -v             : be verbose; output commands to stdout as they're run
  --atgonly      : only consider ATG a valid start codon
  --minpvlen <n> : min CDS/mat_peptide/gene length for feature table output and protein validation is <n> [30]
  --nkb <n>      : number of KB of sequence for each alignment job and/or chunk is <n> [300]
  --keep         : do not remove intermediate files, keep them all on disk

options for specifying classification:
  --group <s>    : set expected classification of all seqs to group <s>
  --subgroup <s> : set expected classification of all seqs to subgroup <s>

options for controlling severity of alerts:
  --alt_list        : output summary of all alerts and exit
  --alt_pass <s>    : specify that alert codes in comma-separated <s> do not cause FAILure
  --alt_fail <s>    : specify that alert codes in comma-separated <s> do cause FAILure
  --alt_mnf_yes <s> : alert codes in <s> for 'misc_not_failure' features cause misc_feature-ization, not failure
  --alt_mnf_no <s>  : alert codes in <s> for 'misc_not_failure' features cause failure, not misc-feature-ization

options for ignoring/forcing specific keys in the input model info (.minfo) file:
  --ignore_mnf       : ignore non-zero 'misc_not_feature' values in .minfo file, set to 0 for all features/models
  --ignore_isdel     : ignore non-zero 'is_deletable' values in .minfo file, set to 0 for all features/models
  --ignore_afset     : ignore 'alternative_ftr_set' and 'alternative_ftr_set_subn' values in .minfo file
  --ignore_afsetsubn : ignore 'alternative_ftr_set_subn' values in .minfo file
  --ignore_canonss   : ignore 'canon_splice_sites' values in .minfo file (never check intron splice sites)
  --force_canonss    : force 'canon_splice_sites' is 1 for all CDS with qualifying introns
  --ignore_exc       : ignore all exception keys '*_exc' in .minfo file

options related to model files:
  -m <s>      : use CM file <s> instead of default
  -a <s>      : use protein HMM file <s> instead of default
  -i <s>      : use model info file <s> instead of default
  -n <s>      : use blastn db file <s> instead of default
  -x <s>      : blastx dbs are in dir <s>, instead of default
  --mkey <s>  : .cm, .minfo, blastn .fa files in $VADRMODELDIR start with key <s>, not 'vadr' [calici]
  --mdir <s>  : model files are in directory <s>, not in $VADRMODELDIR
  --mlist <s> : only use models listed in file <s>

options for controlling output feature table:
  --nomisc        : in feature table for failed seqs, never change feature type to misc_feature
  --notrim        : in feature table, don't trim coords due to ambiguities (for any feature types)
  --noftrtrim <s> : in feature table, don't trim coords due to ambiguities for feature types in comma-delmited <s>
  --noprotid      : in feature table, don't add protein_id for CDS and mat_peptides
  --forceprotid   : in feature table, force protein_id value to be sequence name, then idx
  --forcegene     : in feature table, add 'gene' qualifiers in model info file to CDS and mat_peptide
  --forcequal <s> : in feature table, add qualifiers in model info file listed in comma-delimited <s>

options for controlling thresholds related to alerts:
  --lowsc <x>       : lowscore/LOW_SCORE bits per nucleotide threshold is <x> [0.3]
  --indefclass <x>  : indfcls/INDEFINITE_CLASSIFICATION bits per nucleotide diff threshold is <x> [0.03]
  --incspec <x>     : inc{group,subgrp}/INCORRECT_{GROUP,SUBGROUP} bits/nt threshold is <x> [0.2]
  --lowcov <x>      : lowcovrg/LOW_COVERAGE fractional coverage threshold is <x> [0.9]
  --dupregolp <n>   : dupregin/DUPLICATE_REGIONS minimum model overlap is <n> [20]
  --dupregsc <x>    : dupregin/DUPLICATE_REGIONS minimum bit score is <x> [10]
  --indefstr <x>    : indfstrn/INDEFINITE_STRAND minimum weaker strand bit score is <x> [25]
  --lowsim5seq <n>  : lowsim5s/LOW_SIMILARITY_START minimum length is <n> [15]
  --lowsim3seq <n>  : lowsim3s/LOW_SIMILARITY_END minimum length is <n> [15]
  --lowsimiseq <n>  : lowsimi/LOW_SIMILARITY (internal) minimum length is <n> [1]
  --lowsim5ftr <n>  : lowsim5{c,n}/LOW_FEATURE_SIMILARITY_START minimum length is <n> [5]
  --lowsim3ftr <n>  : lowsim3{c,n}/LOW_FEATURE_SIMILARITY_END minimum length is <n> [5]
  --lowsimiftr <n>  : lowsimi{c,n}/LOW_FEATURE_SIMILARITY (internal) minimum length is <n> [1]
  --lowsim5lftr <n> : long lowsim5l/LOW_FEATURE_SIMILARITY_START minimum length is <n> [30]
  --lowsim3lftr <n> : long lowsim3l/LOW_FEATURE_SIMILARITY_END minimum length is <n> [30]
  --lowsimilftr <n> : long lowsimil/LOW_FEATURE_SIMILARITY (internal) minimum length is <n> [30]
  --extrant5 <n>    : extrant5/EXTRA_SEQUENCE_START minimum length is <n> [1]
  --extrant3 <n>    : extrant3/EXTRA_SEQUENCE_END minimum length is <n> [1]
  --biasfract <x>   : biasdseq/BIASED_SEQUENCE fractional threshold is <x> [0.25]
  --nmiscftrthr <n> : nmiscftr/TOO_MANY_MISC_FEATURES reported if <n> or more misc_features [4]
  --indefann <x>    : indf{5,3}lc{c,n}/'INDEFINITE_ANNOTATION_{START,END} non-mat_peptide min allowed post probability is <x> [0.8]
  --indefann_mp <x> : indf{5,3}lc{c,n}/'INDEFINITE_ANNOTATION_{START,END} mat_peptide min allowed post probability is <x> [0.6]
  --fstminntt <n>   : fst{hi,lo,uk}cft/POSSIBLE_FRAMESHIFT{_{HIGH,LOW}_CONF,} max allowed terminal nt length w/o alert is <n> [4]
  --fstminnti <n>   : fst{hi,lo,uk}cfi/POSSIBLE_FRAMESHIFT{_{HIGH,LOW}_CONF,} max allowed internal nt length w/o alert is <n> [6]
  --fsthighthr <x>  : fsthicf{t,i}/POSSIBLE_FRAMESHIFT_HIGH_CONF minimum average probability for alert is <x> [0.8]
  --fstlowthr <x>   : fstlocf{t,i}/POSSIBLE_FRAMESHIFT_LOW_CONF minimum average probability for alert is <x> [0]
  --xalntol <n>     : indf{5,3}{st,lg}/INDEFINITE_ANNOTATION_{START,END} max allowed nt diff blastx start/end is <n> [5]
  --xmaxins <n>     : insertnp/INSERTION_OF_NT max allowed nucleotide insertion length in blastx validation is <n> [27]
  --xmaxdel <n>     : deletinp/DELETION_OF_NT max allowed nucleotide deletion length in blastx validation is <n> [27]
  --nmaxins <n>     : insertnn/INSERTION_OF_NT max allowed nucleotide (nt) insertion length in CDS nt alignment is <n> [27]
  --nmaxdel <n>     : deletinn/DELETION_OF_NT max allowed nucleotide (nt) deletion length in CDS nt alignment is <n> [27]
  --xlonescore <n>  : indfantp/INDEFINITE_ANNOTATION min score for a blastx hit not supported by CM analysis is <n> [80]
  --hlonescore <n>  : indfantp/INDEFINITE_ANNOTATION min score for a hmmer hit not supported by CM analysis is <n> [10]

options for controlling cmalign alignment stage:
  --mxsize <n>       : set max allowed memory for cmalign to <n> Mb [16000]
  --tau <x>          : set the initial tau value for cmalign to <x> [0.001]
  --nofixedtau       : do not fix the tau value when running cmalign, allow it to decrease if nec
  --nosub            : use alternative alignment strategy for truncated sequences
  --noglocal         : do not run cmalign in glocal mode (run in local mode)
  --cmindi           : force cmalign to align on seq at a time
  --noflank          : do not use --flank* options to improve alns at ends
  --flanktoins <x>   : set transition probs to ROOT_IL/IR for cmalign to <x> [0.1]
  --flankselfins <x> : set self-transit probs in ROOT_IL/IR for cmalign to <x> [0.8]

options for controlling glsearch alignment stage as alternative to cmalign:
  --glsearch          : align with glsearch from the FASTA package, not to a cm with cmalign
  --gls_match <n>     : set glsearch match score to <n> > 0 with glsearch -r option [5]
  --gls_mismatch <n>  : set glsearch mismatch score to <n> < 0 with glsearch -r option [-3]
  --gls_gapopen <n>   : set glsearch gap open score to <n> < 0 with glsearch -f option [-17]
  --gls_gapextend <n> : set glsearch gap extend score to <n> < 0 with glsearch -g option [-4]

options for controlling blastx protein validation stage:
  --xmatrix <s> : use the matrix <s> with blastx (e.g. BLOSUM45)
  --xdrop <n>   : set the xdrop value for blastx to <n> [25]
  --xnumali <n> : number of alignments to keep in blastx output and consider if --xlongest is <n> [20]
  --xnolongest  : do not consider longest blastx hit, only max scoring
  --xnocomp     : turn off composition-based for blastx statistics with comp_based_stats 0

options for using hmmer instead of blastx for protein validation:
  --pv_hmmer     : use hmmer for protein validation, not blastx
  --h_max        : use --max option with hmmsearch
  --h_minbit <x> : set minimum hmmsearch bit score threshold to <x> [-10]

options related to blastn-derived seeded alignment acceleration:
  -s                : use top-scoring HSP from blastn to seed the alignment
  --s_blastnws <n>  : for -s, set blastn -word_size <n> to <n> [7]
  --s_blastnrw <n>  : for -s, set blastn -reward <n> to <n> [1]
  --s_blastnpn <n>  : for -s, set blastn -penalty <n> to <n> [-2]
  --s_blastngo <n>  : for -s, set blastn -gapopen <n> to <n> [2]
  --s_blastnge <x>  : for -s, set blastn -gapextend <x> to <x> [1]
  --s_blastngdf     : for -s, don't use -gapopen/-gapextend w/blastn (use default values)
  --s_blastnsc <x>  : for -s, set blastn minimum HSP score to consider to <x> [50]
  --s_blastntk      : for -s, set blastn option -task blastn
  --s_blastnxd <n>  : for -s, set blastn -xdrop_gap_final <n> to <n> [110]
  --s_minsgmlen <n> : for -s, set minimum length of ungapped region in HSP seed to <n> [10]
  --s_allsgm        : for -s, keep full HSP seed, do not enforce minimum segment length
  --s_ungapsgm      : for -s, only keep max length ungapped segment of HSP
  --s_startstop     : for -s, allow seed to include gaps in start/stop codons
  --s_overhang <n>  : for -s, set length of nt overhang for subseqs to align to <n> [100]

options for deriving seeds from minimap2 as alternative to blastn:
  --minimap2  : use minimap2 to derive seed and use it if >= length of blastn seed
  --mm2_asm5  : use -x asm5 with minimap2, instead of -x asm20
  --mm2_asm10 : use -x asm10 with minimap2, instead of -x asm20
  --mm2_k <n> : use -k <n> option with minimap2, instead of -x asm20 [0]
  --mm2_w <n> : use -w <n> option with minimap2, instead of -x asm20 [0]

options related to replacing Ns with expected nucleotides:
  -r                   : replace stretches of Ns with expected nts, where possible
  --r_minlen <n>       : minimum length subsequence to replace Ns in is <n> [5]
  --r_minfract5 <x>    : minimum fraction of Ns in subseq at 5' end to trigger replacement is <x> [0.25]
  --r_minfract3 <x>    : minimum fraction of Ns in subseq at 3' end to trigger replacement is <x> [0.25]
  --r_minfracti <x>    : minimum fraction of Ns in internal subseq to trigger replacement is <x> [0.5]
  --r_diffno           : do not try replacement if seq and mdl regions are of different lengths
  --r_diffmaxdel <n>   : max allowed length difference b/t seq/mdl regions (mdllen>seqlen) to try replacement is <n> [10]
  --r_diffmaxins <n>   : max allowed length difference b/t seq/mdl regions (seqlen>mdllen) to try replacement is <n> [10]
  --r_diffminnonn <n>  : min number non-Ns in diff len replacement region to try replacement is <n> [1]
  --r_diffminfract <x> : min allowed fraction of non-N matches in diff len replacement region is <x> [0.75]
  --r_fetchr           : fetch features for output fastas from seqs w/Ns replaced, not originals
  --r_cdsmpr           : detect CDS and MP alerts in sequences w/Ns replaced, not originals
  --r_pvorig           : use original sequences for protein validation, not replaced seqs
  --r_prof             : use slower profile methods, not blastn, to identify Ns to replace
  --r_list <s>         : with -r, only use models listed in file <s> for N replacement stage
  --r_only <s>         : with -r, only use model named <s> for N replacement stage
  --r_blastnws <n>     : for -r, set blastn -word_size <n> to <n> [7]
  --r_blastnrw <n>     : for -r, set blastn -reward <n> to <n> [1]
  --r_blastnpn <n>     : for -r, set blastn -penalty <n> to <n> [-2]
  --r_blastngo <n>     : for -r, set blastn -gapopen <n> to <n> [2]
  --r_blastnge <x>     : for -r, set blastn -gapextend <x> to <x> [1]
  --r_blastngdf        : for -r, don't use -gapopen/-gapextend w/blastn (use default values)
  --r_blastnsc <x>     : for -r, set blastn minimum HSP score to consider to <x> [50]
  --r_blastntk         : for -r, set blastn option -task blastn
  --r_blastnxd <n>     : for -r, set blastn -xdrop_gap_final <n> to <n> [110]
  --r_lowsimok         : with -r, do not report lowsim{5,3,i}s within identified N-rich regions
  --r_lowsimmf <x>     : w/--r_lowsimok, minimum fraction of Ns in N-rich region is <x> [0.75]
  --r_lowsimxl <n>     : w/--r_lowsimok, maximum length of N-rich region is <n> [5000]
  --r_lowsimxd <n>     : w/--r_lowsimok, max diff from expected length for N-rich region is <n> [200]

options related to splitting input file into chunks and processing each chunk separately:
  --split    : split input file into chunks, run each chunk separately
  --cpu <n>  : parallelize across <n> CPU workers (requires --split or --glsearch) [1]
  --sidx <n> : start sequence indexing at <n> in tabular output files [1]

options related to parallelization on compute farm:
  -p             : parallelize cmsearch/cmalign on a compute farm
  -q <s>         : use qsub info file <s> instead of default
  --errcheck     : consider any farm stderr output as indicating a job failure
  --wait <n>     : allow <n> wall-clock minutes for jobs on farm to finish, including queueing time [500]
  --maxnjobs <n> : set max number of jobs to submit to compute farm to <n> [2500]

options for skipping stages:
  --pv_skip    : do not perform blastx-based protein validation
  --align_skip : skip the alignment step, use results from an earlier run of the script
  --val_only   : validate CM and other input files and exit

optional output files:
  --out_stk        : output per-model full length stockholm alignments (.stk)
  --out_afa        : output per-model full length fasta alignments (.afa)
  --out_rpstk      : with -r, output stockholm alignments of seqs with Ns replaced
  --out_rpafa      : with -r, output fasta alignments of seqs with Ns replaced
  --out_fsstk      : additionally output frameshift stockholm alignment files
  --out_allfasta   : additionally output fasta files of features
  --out_nofasta    : do not output fasta files of passing/failing seqs
  --out_noftrfasta : with --keep, do not output fasta for each feature
  --out_debug      : dump voluminous info from various data structures to output files

other expert options:
  --execname <s> : define executable name of this script as <s>
  --alicheck     : for debugging, check aligned sequence vs input sequence for identity
  --noseqnamemax : do not enforce a maximum length of 50 for sequence names (GenBank max)
  --minbit <x>   : set minimum cmsearch bit score threshold to <x> [-10]
  --origfa       : do not copy fasta file prior to analysis, use original
  --msub <s>     : read model substitution file from <s>
  --xsub <s>     : read blastx db substitution file from <s>
  --nodcr        : do not doctor alignments to shift gaps in start/stop codons
  --forcedcrins  : force insert type alignment doctoring, requires --cmindi
  --xnoid        : ignore blastx hits that are full length and 100% identical
  --intlen <n>   : set min length of intron to check for splice sites to <n> [40]
```


## vadr_v-build.pl

### Tool Description
Build homology model of a single sequence for feature annotation.

### Metadata
- **Docker Image**: quay.io/biocontainers/vadr:1.6.4--pl5321h031d066_0
- **Homepage**: https://github.com/ncbi/vadr
- **Package**: https://anaconda.org/channels/bioconda/packages/vadr/overview
- **Validation**: PASS

### Original Help Text
```text
# v-build.pl :: build homology model of a single sequence for feature annotation
# VADR 1.6.4 (Jun 2024)
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# date:    Mon Oct 26 05:26:26 2026
#
Usage: v-build.pl [-options] <accession> <path to output directory to create>

basic options:
  -f             : force; if dir <output directory> exists, overwrite it
  -v             : be verbose; output commands to stdout as they're run
  --stk <s>      : read single sequence stockholm 'alignment' from <s>
  --infa <s>     : read single sequence fasta file from <s>, don't fetch it
  --inft <s>     : read feature table file from <s>, don't fetch it
  --ftfetch1     : fetch feature table with efetch -format ft
  --ftfetch2     : fetch feature table with efetch -format gbc | xml2tbl
  --gb           : parse a genbank file, not a feature table file
  --ingb <s>     : read genbank file from <s>, don't fetch it
  --addminfo <s> : add feature info from model info file <s>
  --forcelong    : allow long models > 25Kb in length
  --keep         : do not remove intermediate files, keep them all on disk

options for controlling what feature types are stored in model info file
[default set is: CDS,gene,mat_peptide,sig_peptide]:
  --fall      : store info for all feature types (except those in --fskip)
  --fadd <s>  : also store feature types in comma separated string <s>
  --fskip <s> : do not store info for feature types in comma separated string <s>

options for controlling what qualifiers are stored in model info file
[default set is:product,gene,exception]:
  --qall        : store info for all qualifiers (except those in --qskip)
  --qadd <s>    : also store info for qualifiers in comma separated string <s>
  --qftradd <s> : --qadd <s2> only applies for feature types in comma separated string <s>
  --qskip <s>   : do not store info for qualifiers in comma separated string <s>
  --noaddgene   : do not add gene qualifiers from gene features to overlapping features
  --nosplice    : do not check and add valid splice sites qualifiers for CDS
  --ssplice     : exit if any noncanonical splice sites exist in any CDS

options for including additional model attributes:
  --group <s>    : specify model group is <s>
  --subgroup <s> : specify model subgroup is <s>

options for controlling CDS translation step:
  --ttbl <n> : use NCBI translation table <n> to translate CDS [1]

options for controlling cmbuild step:
  --cmn <n>       : set number of seqs for glocal fwd HMM calibration to <n>
  --cmp7ml        : set CM's filter p7 HMM as the ML p7 HMM
  --cmere <x>     : set CM relative entropy target to <x>
  --cmeset <x>    : set CM eff seq # for CM to <x>
  --cmemaxseq <x> : set CM maximum alowed eff seq # for CM to <x>
  --cmnoh3pri     : do not use --noh3pri option with cmbuild
  --cminfile <s>  : read cmbuild options from file <s>, one per line

options for skipping stages:
  --skipbuild : skip the cmbuild and blastn db creation steps
  --onlyurl   : output genbank file url for accession and exit

optional output files:
  --ftrinfo : create file with internal feature information
  --sgminfo : create file with internal segment information

other expert options:
  --execname <s> : define executable name of this script as <s>
  --nosig2mat    : do not treat sig_peptide as mat_peptide
  --intlen <n>   : set min length of intron to check for splice sites to <n> [40]
```

## vadr_vadr-map-model-coords.pl

### Tool Description
Map model coordinates in a VADR .alt.list/.alt file to another model of the library using an mmap file.

### Metadata
- **Docker Image**: quay.io/biocontainers/vadr:1.6.4--pl5321h031d066_0
- **Homepage**: https://github.com/ncbi/vadr
- **Package**: https://anaconda.org/channels/bioconda/packages/vadr/overview
- **Validation**: PASS

### Original Help Text
```text
vadr-map-model-coords.pl

Usage:

perl vadr-map-model-coords.pl [OPTIONS]
	<detailed-error-report.tsv or .alt.list file path>
	<mmap file path>
	<model to map positions to>

	OPTIONS:
		--alt : file listed in first argument is an .alt file (not a detailed-error-report.tsv or .alt.list file)
```

## vadr_vadr-map-two-complete-models.pl

### Tool Description
Print the position map of one complete model onto another from an mmap file.

### Metadata
- **Docker Image**: quay.io/biocontainers/vadr:1.6.4--pl5321h031d066_0
- **Homepage**: https://github.com/ncbi/vadr
- **Package**: https://anaconda.org/channels/bioconda/packages/vadr/overview
- **Validation**: PASS

### Original Help Text
```text
vadr-map-two-complete-models.pl

Usage:

perl vadr-map-two-complete-models.pl [OPTIONS]
	<mmap file path>
	<model to map positions from>
	<model to map positions to>
```

## Metadata
- **Skill**: generated
