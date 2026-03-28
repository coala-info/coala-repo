# wise2 CWL Generation Report

## wise2_genewise

### Tool Description
genewise <protein-file> <dna-file> in fasta format

### Metadata
- **Docker Image**: quay.io/biocontainers/wise2:2.4.1--h08bb679_0
- **Homepage**: https://www.ebi.ac.uk/~birney/wise2/
- **Package**: https://anaconda.org/channels/bioconda/packages/wise2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/wise2/overview
- **Total Downloads**: 14.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
genewise ($Name: wise2-4-1 $)
genewise <protein-file> <dna-file> in fasta format
Dna sequence options
  -u               start position in dna
  -v               end position in dna
  -trev            Compare on the reverse strand
  -tfor [default]  Compare on the forward strand
  -both            Both strands
  -tabs            Report positions as absolute to truncated/reverse sequence
  -fembl            File is an EMBL file native format
Protein comparison options
  -s               start position in protein
  -t               end   position in protein
  -[g]ap    [ 12]  gap penalty
  -[e]xt    [  2]  extension penalty
  -[m]atrix [BLOSUM62.bla]  Comparison matrix
HMM options
  -hmmer           Protein file is HMMer file (version 2 compatible)
  -hname           Use this as the name of the HMM, not filename
New gene model statistics
  -splice_max_collar      [5.0]  maximum Bits value for a splice site 
  -splice_min_collar      [-5.0] minimum Bits value for a splice site 
  -splice_score_offset    [1.5]  score offset for splice sites
  -[no]splice_gtag        make just gtag splice sites (default is gtag, ie no model)
  -splice_gtag_prob       [0.001] probability for gt/ag 
  -genestats              [gene.stat]
  -splice [model/flat] [LEGACY only for -splice flat. use -splice_gtag]
Phased Protein/HMM parameters (separate from other options)
  -phase_marked    [0.95]        Probability of marked introns
  -phase_unmarked  [0.00001]     Probability of unmarked introns
  -phase_file      [filename]    Intron positions and phases
  -phase_help      prints longer help on phase file and exits
Other model options
  -[no]newgene  use new gene stats (default), no for reverting to old system
  -init   [default]  [default/global/local/wing/endbias] startend policy for the HMM/protein
  -codon  [codon.table]  Codon file
  -subs   [1e-06] Substitution error rate
  -indel  [1e-06] Insertion/deletion error rate
  -null   [syn/flat]   Random Model as synchronous or flat [default syn]
  -alln   [1.0]   Probability of matching a NNN codon
  -insert [model/flat] Use protein insert model     [default flat]
Algorithm options
  -alg    [623/623L/623S/623P/2193/2193L]  Algorithm used [default 623/623L]
  (normally use 623 for proteins, 623L for HMMs and 623P for Phased Proteins)
Output options [default -pretty -para]
  -pretty          show pretty ascii output
  -pseudo          Mark genes with frameshifts as pseudogenes
  -genes           show gene structure
  -genesf          show gene structure with supporting evidence
  -embl            show EMBL feature format with CDS key
  -diana           show EMBL feature format with misc_feature key (for diana)
  -para            show parameters
  -sum             show summary output
  -cdna            show cDNA
  -trans           show protein translation, breaking at frameshifts
  -pep             show protein translation, splicing frameshifts
  -ace             ace file gene structure
  -gff             Gene Feature Format file
  -gener           raw gene structure
  -alb             show logical AlnBlock alignment
  -pal             show raw matrix alignment
  -block  [50]     Length of main block in pretty output
  -divide [//]     divide string for multiple outputs
Genewise protein running heuristics
   -[no]gwhsp        use heuristics for proteins [FALSE currently]
   -gw_edgequery     at start/end, amount of protein area to expand [10]
   -gw_edgetarget    at start/end, amount of DNA area to expand [3000]
   -gw_splicespread  spread around splice sites in codons [5]
   -gwdebug          print out debugging of heuristics on stdout
Dynamic programming matrix implementation
  -dymem       memory style [default/linear/explicit]
  -kbyte       memory amount to use [4000]
  -[no]dycache implicitly cache dy matrix usage (default yes)
  -dydebug     drop into dynamite dp matrix debugger
  -paldebug    print PackAln after debugger run if used
Standard options
  -help       help
  -version    show version and compile info
  -silent     No messages    on stderr
  -quiet      No report/info on stderr
  -erroroffstd No warning messages to stderr
  -errorlog   [file] Log warning messages to file
  -errorstyle [server/program] style of error reporting (default program)
```


## wise2_promoterwise

### Tool Description
Seed restriction

### Metadata
- **Docker Image**: quay.io/biocontainers/wise2:2.4.1--h08bb679_0
- **Homepage**: https://www.ebi.ac.uk/~birney/wise2/
- **Package**: https://anaconda.org/channels/bioconda/packages/wise2/overview
- **Validation**: PASS

### Original Help Text
```text
promoterwise query_sequence target_sequence
Seed restriction
  -align [normal/motif] use normal DBA or motif alignment [normal]
  -s    query start position restriction
  -t    query end position restriction
  -u    target start position restriction
  -v    target end position restriction
Local Hit expansion parameters
  -lhwindow    - sequence window given to alignment [50]
  -lhseed      - seed score cutoff [10.0 bits]
  -lhaln       - aln  score cutoff [8.0 bits]
  -lhscore     - sort final list by score (default by position)
  -lhreject [none/query/both] - overlap rejection criteria in greedy assembly [query]
  -lhmax    [20000] - maximum number of processed hits
Motif Matching and TransFactor matches only for motif alignment
  ie, when the -align motif option is used
 -lr  motif library is in Laurence's format (default is Ewan's)
 -ben motif library is in Ben's IUPAC format (default is Ewan's)
 -motiflib [filename] motif library file name
Motif Matrix matching paramters
  -mm_motif [0.9]  Probability of a match in a motif
  -mm_cons  [0.75] Probability of a match in a non-motif conserved
  -mm_spacer[0.35] Probability of a match in a spacer
  -mm_motif_indel [0.00001] indel inside a motif
  -mm_cons_indel  [0.025]   indel inside a conserved region
  -mm_spacer_indel [0.1]    indel inside a spacer
  -mm_switch_motif [0.05]    cost of switching to motif match
  -mm_switch_cons  [0.000001]  cost of switching to conserved match
TransFactor Build Parameters
  -tfb_pseudo   simple pseudo count, default 0.3
  -[no]tfb_warn warn on small sequence number [default yes]
TransFactor Match Parameters
  -tfm_type [abs/rel/relmix] type of cutoff: absolute, relative, relative mixed
  -tfm_cutoff  (abs) bits cutoff for absolute matches, default 11.0
  -tfm_rel     [0.95] (rel/relmix) Relative to best possible score, accept if above irregardless of score
n  -tfm_relsoft [0.9] (relmix) Relative to best possible score, accept if above this relative and bit score
  -tfm_relbits [11.0] (relmix) If above relsoft and above this bits score, accept
Hit list output options
   -hitoutput [pseudoblast/xml/tab] pseudoblast by default
   -hithelp   more detailed help on hitlist formats
Dynamic programming matrix implementation
  -dymem       memory style [default/linear/explicit]
  -kbyte       memory amount to use [4000]
  -[no]dycache implicitly cache dy matrix usage (default yes)
  -dydebug     drop into dynamite dp matrix debugger
  -paldebug    print PackAln after debugger run if used
Standard options
  -help       help
  -version    show version and compile info
  -silent     No messages    on stderr
  -quiet      No report/info on stderr
  -erroroffstd No warning messages to stderr
  -errorlog   [file] Log warning messages to file
  -errorstyle [server/program] style of error reporting (default program)
```


## Metadata
- **Skill**: generated
