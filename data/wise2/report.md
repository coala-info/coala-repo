# wise2 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| wise2_dba | PASS | Human INS cDNA aligned to the INS gene with the intron gap. |
| wise2_dnal | PASS | Local alignment of human and mouse insulin promoter regions gave a score and blocks. |
| wise2_estwise | PASS | Protein translation of the INS cDNA alignment equals the INS protein. |
| wise2_estwisedb | PASS | INS protein found the INS cDNA in a small cDNA set. |
| wise2_genewise | PASS | Gene model of human INS on its genomic DNA gave the exact INS protein. |
| wise2_genewisedb | PASS | INS protein found the INS gene; GFF gene model matches genewise. |
| wise2_promoterwise | PASS |  |
| wise2_psw | PASS | Human and pig insulin aligned with expected identity. |
| wise2_pswdb | PASS | Human insulin ranked itself first, then pig, cow and mouse insulin. |

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


## wise2_estwise

### Tool Description
Compare a protein or HMM against an EST/cDNA sequence (protein-to-EST alignment, allowing frameshifts).

### Metadata
- **Docker Image**: quay.io/biocontainers/wise2:2.4.1--h08bb679_0
- **Homepage**: https://www.ebi.ac.uk/~birney/wise2/
- **Package**: https://anaconda.org/channels/bioconda/packages/wise2/overview
- **Validation**: PASS

### Original Help Text
```text
estwise ($Name: wise2-4-1 $)
estwise <protein-file> <dna-file> in fasta format
Dna sequence options
  -u               start position in dna
  -v               end position in dna
  -trev            reverse complement dna
  -tfor            use forward strands only
  -both [default]  do both strands
  -tabs            Positions reported as absolute to DNA
Protein comparison options
  -s               start position in protein
  -t               end   position in protein
  -[g]ap    [ 12]  gap penalty
  -[e]xt    [  2]  extension penalty
  -[m]atrix [BLOSUM62.bla]   Comparison matrix
HMM options
  -hmmer           Protein file is HMMer file (version 2 compatible)
  -hname           Name of HMM rather than using the filename
Model options
  -init   [default]    [default/global/local/wing] start end policy of HMM/protein match
  -subs   [0.01] Substitution error rate
  -indel  [0.01] Insertion/deletion error rate
  -null   [syn/flat]   Random Model as synchronous or flat [default syn]
  -alln   [1.0]   Probability of matching a NNN codon
Algorithm options
  -alg    [333,333L,312,312L,333F]  Algorithm used
Output options [default -pretty -para]
  -pretty          show pretty ascii output
  -para            show parameters
  -sum             show summary information
  -pep             show protein translation, splicing frameshifts
  -alb             show logical AlnBlock alignment
  -pal             show raw matrix alignment
  -block  [50]     Length of main block in pretty output
  -divide [//]     divide string for multiple outputs
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

See WWW help at http://www.sanger.ac.uk/Software/Wise2/
```

## wise2_dnal

### Tool Description
Align two DNA sequences with a simple score model.

### Metadata
- **Docker Image**: quay.io/biocontainers/wise2:2.4.1--h08bb679_0
- **Homepage**: https://www.ebi.ac.uk/~birney/wise2/
- **Package**: https://anaconda.org/channels/bioconda/packages/wise2/overview
- **Validation**: PASS

### Original Help Text
```text
dnal ($Name: wise2-4-1 $)
This program is freely distributed under a GPL. See -version for more info
Copyright (c) GRL limited: portions of the code are from separate copyright

dnal <dna-file> <dna-file> in fasta format
 Options. In any order, '-' as filename (for any input) means stdin
 -match  [4]  Match score
 -mis    [-1] MisMatch score
 -gap    [5]  Gap penalty
 -ext    [1]  Gap extension penalty
 -bound  [local/global/edge]  Start/End policy
 -kbyte  [100000] Number of kbytes allowed in main memory
 -[no]pretty - show pretty alignment (default - yes)
 -[no]alb    - show alb    alignment (default - no)
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

See WWW help at http://www.sanger.ac.uk/Software/Wise2/
```

## wise2_dba

### Tool Description
DNA block aligner: align two DNA sequences with conserved blocks.

### Metadata
- **Docker Image**: quay.io/biocontainers/wise2:2.4.1--h08bb679_0
- **Homepage**: https://www.ebi.ac.uk/~birney/wise2/
- **Package**: https://anaconda.org/channels/bioconda/packages/wise2/overview
- **Validation**: PASS

### Original Help Text
```text
dba version: $Name: wise2-4-1 $
Usage: dba [options] seq1 seq2
 -matchA [0.65]     match level A
 -matchB [0.75]     match level B
 -matchC [0.85]     match level C
 -matchD [0.95]     match level D
 -gapA   [0.1]     (big only) Gap probability for A
 -gapAA  [0.1]     (big only) Gap probability for AA
 -gap [0.05]       gap probability
 -blockopen [0.01] block open probability
 -umatch [0.99]    unmatched gap probability
 -single         use only one match level, set with -matchA [0.8]
 -nomatchn       do not match N to any base
 -align          show alignment for computer parsing
 -anchor         show anchored alignment to first sequence
 -pretty         show alignment for ASCII viewing
 -pff            show phylogenetic footprinting format output
                 (gapped fasta)
 -label            show label alignment
 -slim             use slim DBA alignment
 -big              use big DBA alignment with AA block
 -params           print parameters
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

## wise2_genewisedb

### Tool Description
Search protein(s) against a DNA database with a gene model.

### Metadata
- **Docker Image**: quay.io/biocontainers/wise2:2.4.1--h08bb679_0
- **Homepage**: https://www.ebi.ac.uk/~birney/wise2/
- **Package**: https://anaconda.org/channels/bioconda/packages/wise2/overview
- **Validation**: PASS

### Original Help Text
```text
genewisedb ($Name: wise2-4-1 $)
genewisedb <protein-input> <dna-input>
Protein input type
  -protein  [default] single protein
  -prodb    protein fasta format db
  -pfam     pfam hmm library
  -pfam2    pfam old style model directory (2.1) 
  -hmmer    single hmmer HMM (version 2 compatible)
  -pro_db_start start position in protein/hmm database
  -pro_db_end   end   position in protein/hmm database
DNA input type
  -dnadb    [default] dna fasta database
  -dnas     a single dna fasta sequence
  -dna_db_start start position in dna database
  -dna_db_end   end   position in dna database
Protein comparison options
  -gap      [ 12]  gap penalty
  -ext      [  2]  extension penalty
  -matrix   [BLOSUM62.bla]  Comparison matrix
HMM options
  -hname           For single hmms, use this as the name, not filename
Gene Model options
  -init   [default]  [default/global/local/wing/endbias] start-end policy
  -codon  [codon.table]  Codon file
  -gene   [human.gf]  Gene parameter file
  -subs   [1e-05] Substitution error rate
  -indel  [1e-05] Insertion/deletion error rate
  -cfreq  [model/flat] Using codon bias or not?     [default flat]
  -splice [model/flat] Using splice model or GT/AG? [default model]
  -intron [model/tied] Use tied model for introns   [default tied]
  -null   [syn/flat]   Random Model as synchronous or flat [default syn]
  -insert [model/flat] Use protein insert model     [default flat]
Algorithm options
  -alg    [623/2193/]            Algorithm used for searching [default 623]
  -aalg   [623/623L/2193/2193L]  Algorithm used for alignment [default 623/623L]
  -cut    [20.00]   Bits cutoff for reporting in search algorithm
  -ecut   [n/a]    Evalue cutoff for single protein vs DNA searches.
  -aln    [50]   Max number of alignments (even if above cut)
  -alln   [0.9]   Probability of matching a NNN codon (only for single HMM vs DNAdb)
  -nohis           Don't show histogram on single protein/hmm vs DNA search
  -report [0]      Issue a report every x comparisons (default 0 comparisons)
Output options [default -pretty -para]
  -pretty          show pretty ascii output
  -genes           show gene structure
  -para            show parameters
  -sum             show summary output
  -cdna            show cDNA
  -trans           show protein translation
  -ace             ace file gene structure
  -gff             Gene Feature Format file
  -gener           raw gene structure
  -alb             show logical AlnBlock alignment
  -pal             show raw matrix alignment
  -block  [50]     Length of main block in pretty output
  -divide [//]     divide string for multiple outputs
Output for complete analysis (only available for single dna seq vs proteindb)
  -pseudo          Mark genes with frameshifts as pseudogenes
  -ctrans          provide all translations
  -ccdna           provide all cdna
  -cgene           provide all gene structures
  -cace            provide all gene structures in ace format
  -cdiana          provide all gene structures in diana EMBL FT format
  -cembl           provide all gene structures in EMBL FT format
  -caceh           provide all gene structures in halfwise type ace format
Database search implementation
  -serial       use serial code (single processor)
  -pthread      use pthread code (SMP box)
  -pthr_no <no> Number of threads to use
  -mpi          use MPI code (distributed memory system)
  -pvm          use parallel virtual machine search system
  -dbtrace <no> Trace level of the database code (for debugging only)
  -sroutine <type> Search type routine [exact/kbest/forward]
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

See WWW help at http://www.sanger.ac.uk/Software/Wise2/
```

## wise2_pswdb

### Tool Description
Smith-Waterman search of a protein query database against a target protein database.

### Metadata
- **Docker Image**: quay.io/biocontainers/wise2:2.4.1--h08bb679_0
- **Homepage**: https://www.ebi.ac.uk/~birney/wise2/
- **Package**: https://anaconda.org/channels/bioconda/packages/wise2/overview
- **Validation**: PASS

### Original Help Text
```text
Warning Error
	Must have two arguments for sequence 1 and sequence 2 2

pswdb <options> <query_db> <target_db>
Seqs in fasta format
	-g gap penalty (default 12)
	-e ext penatly (default 2)
	-m comp matrix (default BLOSUM62.bla)
	-abc use the abc model
	-a   a penalty for above (default 120)
	-b   b penalty for above (default 10)
	-c   c penalty for above (default 3)
	-pba use the pba model
	-max_desc Number of one line descriptions (default = 500)
	-max_aln Number of alignments to show (default = 50)
	-cut Search cutoff (score) (default = 40)
	-ids Output seq ids with alignments
	-nohis do not fit histogram
Database search implementation
  -serial       use serial code (single processor)
  -pthread      use pthread code (SMP box)
  -pthr_no <no> Number of threads to use
  -mpi          use MPI code (distributed memory system)
  -pvm          use parallel virtual machine search system
  -dbtrace <no> Trace level of the database code (for debugging only)
  -sroutine <type> Search type routine [exact/kbest/forward]
Dynamic programming matrix implementation
  -dymem       memory style [default/linear/explicit]
  -kbyte       memory amount to use [4000]
  -[no]dycache implicitly cache dy matrix usage (default yes)
  -dydebug     drop into dynamite dp matrix debugger
  -paldebug    print PackAln after debugger run if used
Standard options
  -help      help
  -version   show version and compile info
  -silent    No messages on stderr
  -quiet    No report on stderr
  -erroroffstd No warning messages to stderr
  -errorlog [file] Log warning messages to file

See WWW help at http://www.somewhere.edu/
```

## wise2_psw

### Tool Description
Smith-Waterman protein alignment of two sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/wise2:2.4.1--h08bb679_0
- **Homepage**: https://www.ebi.ac.uk/~birney/wise2/
- **Package**: https://anaconda.org/channels/bioconda/packages/wise2/overview
- **Validation**: PASS

### Original Help Text
```text

psw <options> seq1 seq2
Both sequences in fasta format
	OPTIONS
	-g gap penalty (default 12)
	-e ext penatly (default 2)
	-m comp matrix (default BLOSUM62.bla)
	-abc use the abc model
	-a   a penalty for above (default 120)
	-b   b penalty for above (default 10)
	-c   c penalty for above (default 3)
	-r show raw output
	-l show label output
	-f show fancy output
	-F force psw to use sequences that seem to be DNA
	-dpenv DP envelope file...
	   (default, -f, all outputs can be shown together)
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

## wise2_estwisedb

### Tool Description
Search protein(s) against a DNA (EST) database with frameshift-tolerant alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/wise2:2.4.1--h08bb679_0
- **Homepage**: https://www.ebi.ac.uk/~birney/wise2/
- **Package**: https://anaconda.org/channels/bioconda/packages/wise2/overview
- **Validation**: PASS

### Original Help Text
```text
estwisedb ($Name: wise2-4-1 $)
estwisedb <protein-input> <dna-input>
Protein input type
  -protein  [default] single protein
  -prodb    protein fasta format db
  -pfam     pfam hmm library 
  -pfam2    pfam style model directory (2.1) 
  -hmmer    single hmmer 1.x HMM
DNA input type
  -dnadb    [default] dna fasta database
  -dnas     a single dna fasta sequence
DNA sequence options
  -tfor     search forward strands only
Protein comparison options
  -gap      [ 12]  gap penalty
  -ext      [  2]  extension penalty
  -matrix   [BLOSUM62.bla]  Comparison matrix
HMM options
  -hname           For single hmms, use this as the name, not filename
Model options
  -init   [default] [default/global/local/wing] start-end policy
  -codon  [codon.table]  Codon file
  -subs   [0.01] Substitution error rate
  -indel  [0.01] Insertion/deletion error rate
  -null   [syn/flat]   Random Model as synchronous or flat [default syn]
  -alln   [1.0]   Probability of matching a NNN codon
  -flati         Flat insert probabilities
Algorithm options
  -alg    [333/312]         Algorithm used for searching [default 312]
  -aalg   [312/333/333L]    Algorithm used for alignment [default 333]
  -cut    [20.00]   Bits cutoff for reporting in search algorithm
  -ecut   [n/a]    Evalue cutoff for single protein vs DNA searches.
  -aln    [50]   Max number of alignments (even if above cut)
  -nohis           Don't show histogram on single protein/hmm vs DNA search
  -report [0]      Issue a report every x comparisons (default 0 comparisons)
Output options for each alignment [default -pretty -para]
  -pretty          show pretty ascii output
  -para            show parameters
  -pep             show protein translation, splicing frameshifts
  -mul             protein mul format alignments [only for one HMM vs DNA db]
  -sum             show summary output
  -alb             show logical AlnBlock alignment
  -pal             show raw matrix alignment
  -block  [50]     Length of main block in pretty output
  -divide [//]     divide string for multiple outputs
Database search implementation
  -serial       use serial code (single processor)
  -pthread      use pthread code (SMP box)
  -pthr_no <no> Number of threads to use
  -mpi          use MPI code (distributed memory system)
  -pvm          use parallel virtual machine search system
  -dbtrace <no> Trace level of the database code (for debugging only)
  -sroutine <type> Search type routine [exact/kbest/forward]
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

See WWW help at http://www.sanger.ac.uk/Software/Wise2/
```

## Metadata
- **Skill**: generated
