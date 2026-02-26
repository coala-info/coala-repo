# exonerate CWL Generation Report

## exonerate

### Tool Description
A generic sequence comparison tool

### Metadata
- **Docker Image**: biocontainers/exonerate:v2.4.0-4-deb_cv1
- **Homepage**: https://www.ebi.ac.uk/about/vertebrate-genomics/software/exonerate
- **Package**: https://anaconda.org/channels/bioconda/packages/exonerate/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/exonerate/overview
- **Total Downloads**: 94.0K
- **Last updated**: 2025-07-08
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
exonerate from exonerate version 2.4.0
Using glib version 2.58.2
Built on Jan  6 2019

exonerate: A generic sequence comparison tool
Guy St.C. Slater. guy@ebi.ac.uk. 2000-2009.


Examples of use:

1. Ungapped alignment of any DNA or protein sequences:
    exonerate queries.fa targets.fa
2. Gapped alignment of Mouse proteins to Fugu proteins:
    exonerate --model affine:local mouse.fa fugu.fa
3. Find top 10 matches of each EST to a genome:
    exonerate --model est2genome --bestn 10 est.fa genome.fa
4. Find proteins with at least a 50% match to a genome:
    exonerate --model protein2genome --percent 50 p.fa g.fa
5. Perform a full Smith-Waterman-Gotoh alignment:
    exonerate --model affine:local --exhaustive yes a.fa b.fa
6. Many more combinations are possible.  To find out more:
    exonerate --help
    man exonerate


General Options:
---------------

-h --shorthelp
Display compact help text
Environment variable: $EXONERATE_EXONERATE_SHORTHELP (Not set)
Default: "FALSE"

--help
Displays verbose help text
Environment variable: $EXONERATE_EXONERATE_HELP (Not set)
Default: "FALSE"
Using: <TRUE>
-v --version
Show version number for this program
Environment variable: $EXONERATE_EXONERATE_VERSION (Not set)
Default: "FALSE"

Sequence Input Options:
----------------------

-q --query <path>
Specify query sequences as a fasta format file
Environment variable: $EXONERATE_EXONERATE_QUERY (Not set)
*** This argument is mandatory ***
 <*** empty list ***>
-t --target <path>
Specify target sequences as a fasta format file
Environment variable: $EXONERATE_EXONERATE_TARGET (Not set)
*** This argument is mandatory ***
 <*** empty list ***>
-Q --querytype <alphabet type>
Specify query alphabet type
Environment variable: $EXONERATE_EXONERATE_QUERYTYPE (Not set)
Default: "unknown"

-T --targettype <alphabet type>
Specify target alphabet type
Environment variable: $EXONERATE_EXONERATE_TARGETTYPE (Not set)
Default: "unknown"

--querychunkid
Specify query job number
Environment variable: $EXONERATE_EXONERATE_QUERYCHUNKID (Not set)
Default: "0"

--targetchunkid
Specify target job number
Environment variable: $EXONERATE_EXONERATE_TARGETCHUNKID (Not set)
Default: "0"

--querychunktotal
Specify total number of query jobs
Environment variable: $EXONERATE_EXONERATE_QUERYCHUNKTOTAL (Not set)
Default: "0"

--targetchunktotal
Specify total number of target jobs
Environment variable: $EXONERATE_EXONERATE_TARGETCHUNKTOTAL (Not set)
Default: "0"

-V --verbose <level>
Show search progress
Environment variable: $EXONERATE_EXONERATE_VERBOSE (Not set)
Default: "1"

Translation Options:
-------------------

--geneticcode
Use built-in or custom genetic code
Environment variable: $EXONERATE_EXONERATE_GENETICCODE (Not set)
Default: "1"

Analysis Options:
----------------

-E --exhaustive
Perform exhaustive alignment (slow)
Environment variable: $EXONERATE_EXONERATE_EXHAUSTIVE (Not set)
Default: "FALSE"

-B --bigseq
Allow rapid comparison between big sequences
Environment variable: $EXONERATE_EXONERATE_BIGSEQ (Not set)
Default: "FALSE"

-r --revcomp
Also search reverse complement of query and target
Environment variable: $EXONERATE_EXONERATE_REVCOMP (Not set)
Default: "TRUE"

--forcescan <[q|t]>
Force FSM scan on query or target sequences
Environment variable: $EXONERATE_EXONERATE_FORCESCAN (Not set)
Default: "none"

--saturatethreshold <int>
Word saturation threshold
Environment variable: $EXONERATE_EXONERATE_SATURATETHRESHOLD (Not set)
Default: "0"

--customserver <command>
Custom command to send non-standard server
Environment variable: $EXONERATE_EXONERATE_CUSTOMSERVER (Not set)
Default: "NULL"

-c --cores <number>
Number of cores/CPUs/threads for alignment computation
Environment variable: $EXONERATE_EXONERATE_CORES (Not set)
Default: "1"

Fasta Database Options:
----------------------

--fastasuffix <suffix>
Fasta file suffix filter (in subdirectories)
Environment variable: $EXONERATE_EXONERATE_FASTASUFFIX (Not set)
Default: ".fa"

Gapped Alignment Options:
------------------------

-m --model <alignment model>
Specify alignment model type
Supported types:
    ungapped ungapped:trans
    affine:global affine:bestfit affine:local affine:overlap
    est2genome ner protein2dna protein2genome
    protein2dna:bestfit protein2genome:bestfit
    coding2coding coding2genome cdna2genome genome2genome

Environment variable: $EXONERATE_EXONERATE_MODEL (Not set)
Default: "ungapped"

-s --score <threshold>
Score threshold for gapped alignment
Environment variable: $EXONERATE_EXONERATE_SCORE (Not set)
Default: "100"

--percent <threshold>
Percent self-score threshold
Environment variable: $EXONERATE_EXONERATE_PERCENT (Not set)
Default: "0.0"

--showalignment
Include (human readable) alignment in results
Environment variable: $EXONERATE_EXONERATE_SHOWALIGNMENT (Not set)
Default: "TRUE"

--showsugar
Include 'sugar' format output in results
Environment variable: $EXONERATE_EXONERATE_SHOWSUGAR (Not set)
Default: "FALSE"

--showcigar
Include 'cigar' format output in results
Environment variable: $EXONERATE_EXONERATE_SHOWCIGAR (Not set)
Default: "FALSE"

--showvulgar
Include 'vulgar' format output in results
Environment variable: $EXONERATE_EXONERATE_SHOWVULGAR (Not set)
Default: "TRUE"

--showquerygff
Include GFF output on query in results
Environment variable: $EXONERATE_EXONERATE_SHOWQUERYGFF (Not set)
Default: "FALSE"

--showtargetgff
Include GFF output on target in results
Environment variable: $EXONERATE_EXONERATE_SHOWTARGETGFF (Not set)
Default: "FALSE"

--ryo <format>
Roll-your-own printf-esque output format
Environment variable: $EXONERATE_EXONERATE_RYO (Not set)
Default: "NULL"

-n --bestn <number>
Report best N results per query
Environment variable: $EXONERATE_EXONERATE_BESTN (Not set)
Default: "0"

-S --subopt
Search for suboptimal alignments
Environment variable: $EXONERATE_EXONERATE_SUBOPT (Not set)
Default: "TRUE"

-g --gappedextension
Use gapped extension (default is SDP)
Environment variable: $EXONERATE_EXONERATE_GAPPEDEXTENSION (Not set)
Default: "TRUE"

--refine
Alignment refinement strategy [none|full|region]
Environment variable: $EXONERATE_EXONERATE_REFINE (Not set)
Default: "none"

--refineboundary
Refinement region boundary
Environment variable: $EXONERATE_EXONERATE_REFINEBOUNDARY (Not set)
Default: "32"

Viterbi algorithm options:
-------------------------

-D --dpmemory <Mb>
Maximum memory to use for DP tracebacks (Mb)
Environment variable: $EXONERATE_EXONERATE_DPMEMORY (Not set)
Default: "32"

Code generation options:
-----------------------

-C --compiled
Use compiled viterbi implementations
Environment variable: $EXONERATE_EXONERATE_COMPILED (Not set)
Default: "TRUE"

Heuristic Options:
-----------------

--terminalrangeint
Internal terminal range
Environment variable: $EXONERATE_EXONERATE_TERMINALRANGEINT (Not set)
Default: "12"

--terminalrangeext
External terminal range
Environment variable: $EXONERATE_EXONERATE_TERMINALRANGEEXT (Not set)
Default: "12"

--joinrangeint
Internal join range
Environment variable: $EXONERATE_EXONERATE_JOINRANGEINT (Not set)
Default: "12"

--joinrangeext
External join range
Environment variable: $EXONERATE_EXONERATE_JOINRANGEEXT (Not set)
Default: "12"

--spanrangeint
Internal span range
Environment variable: $EXONERATE_EXONERATE_SPANRANGEINT (Not set)
Default: "12"

--spanrangeext
External span range
Environment variable: $EXONERATE_EXONERATE_SPANRANGEEXT (Not set)
Default: "12"

Seeded Dynamic Programming options:
----------------------------------

-x --extensionthreshold
Gapped extension threshold
Environment variable: $EXONERATE_EXONERATE_EXTENSIONTHRESHOLD (Not set)
Default: "50"

--singlepass
Generate suboptimal alignment in a single pass
Environment variable: $EXONERATE_EXONERATE_SINGLEPASS (Not set)
Default: "TRUE"

BSDP algorithm options:
----------------------

--joinfilter
BSDP join filter threshold
Environment variable: $EXONERATE_EXONERATE_JOINFILTER (Not set)
Default: "0"

Sequence Options:
----------------

-A --annotation <path>
Path to sequence annotation file
Environment variable: $EXONERATE_EXONERATE_ANNOTATION (Not set)
Default: "none"

Symbol Comparison Options:
-------------------------

--softmaskquery
Allow softmasking on the query sequence
Environment variable: $EXONERATE_EXONERATE_SOFTMASKQUERY (Not set)
Default: "FALSE"

--softmasktarget
Allow softmasking on the target sequence
Environment variable: $EXONERATE_EXONERATE_SOFTMASKTARGET (Not set)
Default: "FALSE"

-d --dnasubmat <name>
DNA substitution matrix
Environment variable: $EXONERATE_EXONERATE_DNASUBMAT (Not set)
Default: "nucleic"

-p --proteinsubmat <name>
Protein substitution matrix
Environment variable: $EXONERATE_EXONERATE_PROTEINSUBMAT (Not set)
Default: "blosum62"

Alignment Seeding Options:
-------------------------

-M --fsmmemory <Mb>
Memory limit for FSM scanning
Environment variable: $EXONERATE_EXONERATE_FSMMEMORY (Not set)
Default: "256"

--forcefsm <fsm type>
Force FSM type ( normal | compact )
Environment variable: $EXONERATE_EXONERATE_FORCEFSM (Not set)
Default: "none"

--wordjump
Jump between query words
Environment variable: $EXONERATE_EXONERATE_WORDJUMP (Not set)
Default: "1"

--wordambiguity
Number of ambiguous words to expand
Environment variable: $EXONERATE_EXONERATE_WORDAMBIGUITY (Not set)
Default: "1"

Affine Model Options:
--------------------

-o --gapopen <penalty>
Affine gap open penalty
Environment variable: $EXONERATE_EXONERATE_GAPOPEN (Not set)
Default: "-12"

-e --gapextend <penalty>
Affine gap extend penalty
Environment variable: $EXONERATE_EXONERATE_GAPEXTEND (Not set)
Default: "-4"

--codongapopen <penalty>
Codon affine gap open penalty
Environment variable: $EXONERATE_EXONERATE_CODONGAPOPEN (Not set)
Default: "-18"

--codongapextend <penalty>
Codon affine gap extend penalty
Environment variable: $EXONERATE_EXONERATE_CODONGAPEXTEND (Not set)
Default: "-8"

NER Model Options:
-----------------

--minner <length>
Minimum NER length
Environment variable: $EXONERATE_EXONERATE_MINNER (Not set)
Default: "10"

--maxner <length>
Maximum NER length
Environment variable: $EXONERATE_EXONERATE_MAXNER (Not set)
Default: "50000"

--neropen <score>
NER open penalty
Environment variable: $EXONERATE_EXONERATE_NEROPEN (Not set)
Default: "-20"

Intron Modelling Options:
------------------------

--minintron <length>
Minimum intron length
Environment variable: $EXONERATE_EXONERATE_MININTRON (Not set)
Default: "30"

--maxintron <length>
Maximum intron length
Environment variable: $EXONERATE_EXONERATE_MAXINTRON (Not set)
Default: "200000"

-i --intronpenalty <score>
Intron Opening penalty
Environment variable: $EXONERATE_EXONERATE_INTRONPENALTY (Not set)
Default: "-30"

Frameshift Options:
------------------

-f --frameshift <penalty>
Frameshift creation penalty
Environment variable: $EXONERATE_EXONERATE_FRAMESHIFT (Not set)
Default: "-28"

Alphabet Options:
----------------

--useaatla
Use three-letter abbreviation for AA names
Environment variable: $EXONERATE_EXONERATE_USEAATLA (Not set)
Default: "TRUE"

HSP creation options:
--------------------

--hspfilter
Aggressive HSP filtering level
Environment variable: $EXONERATE_EXONERATE_HSPFILTER (Not set)
Default: "0"

--useworddropoff
Use word neighbourhood dropoff
Environment variable: $EXONERATE_EXONERATE_USEWORDDROPOFF (Not set)
Default: "TRUE"

--seedrepeat
Seeds per diagonal required for HSP seeding
Environment variable: $EXONERATE_EXONERATE_SEEDREPEAT (Not set)
Default: "1"

--dnawordlen <bp>
Wordlength for DNA words
Environment variable: $EXONERATE_EXONERATE_DNAWORDLEN (Not set)
Default: "12"

--proteinwordlen <aa>
Wordlength for protein words
Environment variable: $EXONERATE_EXONERATE_PROTEINWORDLEN (Not set)
Default: "6"

--codonwordlen <bp>
Wordlength for codon words
Environment variable: $EXONERATE_EXONERATE_CODONWORDLEN (Not set)
Default: "12"

--dnahspdropoff <score>
DNA HSP dropoff score
Environment variable: $EXONERATE_EXONERATE_DNAHSPDROPOFF (Not set)
Default: "30"

--proteinhspdropoff <score>
Protein HSP dropoff score
Environment variable: $EXONERATE_EXONERATE_PROTEINHSPDROPOFF (Not set)
Default: "20"

--codonhspdropoff <score>
Codon HSP dropoff score
Environment variable: $EXONERATE_EXONERATE_CODONHSPDROPOFF (Not set)
Default: "40"

--dnahspthreshold <score>
DNA HSP threshold score
Environment variable: $EXONERATE_EXONERATE_DNAHSPTHRESHOLD (Not set)
Default: "75"

--proteinhspthreshold <score>
Protein HSP threshold score
Environment variable: $EXONERATE_EXONERATE_PROTEINHSPTHRESHOLD (Not set)
Default: "30"

--codonhspthreshold <score>
Codon HSP threshold score
Environment variable: $EXONERATE_EXONERATE_CODONHSPTHRESHOLD (Not set)
Default: "50"

--dnawordlimit <score>
Score limit for dna word neighbourhood
Environment variable: $EXONERATE_EXONERATE_DNAWORDLIMIT (Not set)
Default: "0"

--proteinwordlimit <score>
Score limit for protein word neighbourhood
Environment variable: $EXONERATE_EXONERATE_PROTEINWORDLIMIT (Not set)
Default: "4"

--codonwordlimit <score>
Score limit for codon word neighbourhood
Environment variable: $EXONERATE_EXONERATE_CODONWORDLIMIT (Not set)
Default: "4"

--geneseed <threshold>
Geneseed Threshold
Environment variable: $EXONERATE_EXONERATE_GENESEED (Not set)
Default: "0"

--geneseedrepeat <number>
Seeds per diagonal required for geneseed HSP seeding
Environment variable: $EXONERATE_EXONERATE_GENESEEDREPEAT (Not set)
Default: "3"

Alignment options:
-----------------

--alignmentwidth
Alignment display width
Environment variable: $EXONERATE_EXONERATE_ALIGNMENTWIDTH (Not set)
Default: "80"

--forwardcoordinates
Report all coordinates on the forward strand
Environment variable: $EXONERATE_EXONERATE_FORWARDCOORDINATES (Not set)
Default: "TRUE"

SAR Options:
-----------

--quality <percent>
HSP quality threshold
Environment variable: $EXONERATE_EXONERATE_QUALITY (Not set)
Default: "0"

Splice Site Prediction Options:
------------------------------

--splice3
Supply frequency matrix for 3' splice sites
Environment variable: $EXONERATE_EXONERATE_SPLICE3 (Not set)
Default: "primate"

--splice5
Supply frequency matrix for 5' splice sites
Environment variable: $EXONERATE_EXONERATE_SPLICE5 (Not set)
Default: "primate"

--forcegtag
Force use of gt...ag splice sites
Environment variable: $EXONERATE_EXONERATE_FORCEGTAG (Not set)
Default: "FALSE"

--
```


## Metadata
- **Skill**: not generated
