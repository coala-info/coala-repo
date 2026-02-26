# reparation_blast CWL Generation Report

## reparation_blast_reparation.pl

### Tool Description
Performs BLAST analysis for bacterial protein sequence identification and ORF prediction.

### Metadata
- **Docker Image**: quay.io/biocontainers/reparation_blast:1.0.9--pl526_0
- **Homepage**: https://github.com/RickGelhausen/REPARATION_blast
- **Package**: https://anaconda.org/channels/bioconda/packages/reparation_blast/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/reparation_blast/overview
- **Total Downloads**: 47.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/RickGelhausen/REPARATION_blast
- **Stars**: N/A
### Original Help Text
```text
Usage:
    reparation.pl [options] -bam riboseq_alignment_files_bam_format -g
    bacteria_genome_fasta_file -sdir scripts_directory -db
    curated_protein_db(fasta)

Options:
  Mandatory:
    -bam
        Ribosome alignment file (bam)

    -g  Genome fasta file. This should be the same genome fasta file used in
        the alignment of the Ribo-seq reads.

    -sdir
        The "scripts" directory (avialable within the REPARATION directory),
        defaults to directory of reparation.pl script

    -db fasta database of curated bacteria protein sequences

  Optional:
    -gtf
        GTF genome annotation file

    -wdir
        working directory (defaults to current directory)

    -en Experiment name

    -p  Ribosome profiling read p site assignment strategy, 1 = plastid
        P-site estimation ((default), 3 = 3 prime of read, 5 prime of the
        read

    -mn All ribosome profiling reads shorter than these values are
        eliminated from the ananlysis (default = 22)

    -mx All ribosome profiling reads longerer than these values are
        eliminated from the ananlysis (default = 40)

    -mo Minimum length of open reading frame considered for prediction
        (default = 30 value in nucleotides)

    -mr Open reading frames with less than these number of ribosome
        profiling reads are eliminated from analysis (default = 3)

    -ost
        Start region length in nucleotides (default = 45nts). This value is
        used to calculate features specific to the start region.

    -osp
        Stop region length in nucleotides (default = 21nts). This value is
        used to calculate features specific to the stop region.

    -osd
        Distance of Shine dalgarno sequence from start codon (defualt =
        5nts).

    -seed
        Shine dalgarno sequence (default = GGAGG). The shine dalgarno
        sequence used for Ribosome binind site energy calculation.

    -sd Use ribosome binding site (RBS) energy in the open reading frame
        prediction (Y = use RBS energy (default), N = donot use RBS engergy)

    -id Online-Ticket UNI STUTT Minimum identify score for BLAST protein
    sequence search (default = 0.75)
    -ev maximum e-vlaue for BLAST protein sequence search (default = 1e-5)

    -pg program for initial positive set generation (1 = prodigal (default),
        2 = glimmer)

    -cdn
        Comma separted list of start codons (default = ATG,GTG,TTG)

    -ncdn
        Start codon for negative set (default = CTG)

    -pcdn
        Start codon for positive set (default = ATG,GTG,TTG). Should be a
        subset of the standard genetic code for bacteria

    -gcode
        Genetic code to use for initail positive set generation. Valid when
        -pg is 1. (default = 11, takes value between 1-25)

    -by Flag to determine if prodigal should bypass Shine-Dalgarno trainer
        and force a full motif scan (default = N). (Y = yes, N = no) Valid
        only for -pg 1

    -score
        Random forest classification probability score threshold to define
        as ORF are protein coding, the minimum (defualt is 0.5)
```


## reparation_blast_prodigal

### Tool Description
PRODIGAL v2.6.3 [February, 2016] Univ of Tenn / Oak Ridge National Lab Doug Hyatt, Loren Hauser, et al.

### Metadata
- **Docker Image**: quay.io/biocontainers/reparation_blast:1.0.9--pl526_0
- **Homepage**: https://github.com/RickGelhausen/REPARATION_blast
- **Package**: https://anaconda.org/channels/bioconda/packages/reparation_blast/overview
- **Validation**: PASS

### Original Help Text
```text
-------------------------------------
PRODIGAL v2.6.3 [February, 2016]         
Univ of Tenn / Oak Ridge National Lab
Doug Hyatt, Loren Hauser, et al.     
-------------------------------------

Usage:  prodigal [-a trans_file] [-c] [-d nuc_file] [-f output_type]
                 [-g tr_table] [-h] [-i input_file] [-m] [-n] [-o output_file]
                 [-p mode] [-q] [-s start_file] [-t training_file] [-v]

         -a:  Write protein translations to the selected file.
         -c:  Closed ends.  Do not allow genes to run off edges.
         -d:  Write nucleotide sequences of genes to the selected file.
         -f:  Select output format (gbk, gff, or sco).  Default is gbk.
         -g:  Specify a translation table to use (default 11).
         -h:  Print help menu and exit.
         -i:  Specify FASTA/Genbank input file (default reads from stdin).
         -m:  Treat runs of N as masked sequence; don't build genes across them.
         -n:  Bypass Shine-Dalgarno trainer and force a full motif scan.
         -o:  Specify output file (default writes to stdout).
         -p:  Select procedure (single or meta).  Default is single.
         -q:  Run quietly (suppress normal stderr output).
         -s:  Write all potential genes (with scores) to the selected file.
         -t:  Write a training file (if none exists); otherwise, read and use
              the specified training file.
         -v:  Print version number and exit.
```


## reparation_blast_glimmer3

### Tool Description
Read DNA sequences in <sequence-file> and predict genes
in them using the Interpolated Context Model in <icm-file>.
Output details go to file <tag>.detail and predictions go to
file <tag>.predict

### Metadata
- **Docker Image**: quay.io/biocontainers/reparation_blast:1.0.9--pl526_0
- **Homepage**: https://github.com/RickGelhausen/REPARATION_blast
- **Package**: https://anaconda.org/channels/bioconda/packages/reparation_blast/overview
- **Validation**: PASS

### Original Help Text
```text
Starting at Wed Feb 25 12:29:06 2026

USAGE:  glimmer3 [options] <sequence-file> <icm-file> <tag>

Read DNA sequences in <sequence-file> and predict genes
in them using the Interpolated Context Model in <icm-file>.
Output details go to file <tag>.detail and predictions go to
file <tag>.predict

Options:
 -A <codon-list>
 --start_codons <codon-list>
    Use comma-separated list of codons as start codons
    Sample format:  -A atg,gtg
    Use -P option to specify relative proportions of use.
    If -P not used, then proportions will be equal
 -b <filename>
 --rbs_pwm <filename>
    Read a position weight matrix (PWM) from <filename> to identify
    the ribosome binding site to help choose start sites
 -C <p>
 --gc_percent <p>
    Use <p> as GC percentage of independent model
    Note:  <p> should be a percentage, e.g., -C 45.2
 -E <filename>
 --entropy <filename>
    Read entropy profiles from <filename>.  Format is one header
    line, then 20 lines of 3 columns each.  Columns are amino acid,
    positive entropy, negative entropy.  Rows must be in order
    by amino acid code letter
 -f
 --first_codon
    Use first codon in orf as start codon
 -g <n>
 --gene_len <n>
    Set minimum gene length to <n>
 -h
 --help
    Print this message
 -i <filename>
 --ignore <filename>
    <filename> specifies regions of bases that are off 
    limits, so that no bases within that area will be examined
 -l
 --linear
    Assume linear rather than circular genome, i.e., no wraparound
 -L <filename>
 --orf_coords <filename>
    Use <filename> to specify a list of orfs that should
    be scored separately, with no overlap rules
 -M
 --separate_genes
    <sequence-file> is a multifasta file of separate genes to
    be scored separately, with no overlap rules
 -o <n>
 --max_olap <n>
    Set maximum overlap length to <n>.  Overlaps this short or shorter
    are ignored.
 -P <number-list>
 --start_probs <number-list>
    Specify probability of different start codons (same number & order
    as in -A option).  If no -A option, then 3 values for atg, gtg and ttg
    in that order.  Sample format:  -P 0.6,0.35,0.05
    If -A is specified without -P, then starts are equally likely.
 -q <n>
 --ignore_score_len <n>
    Do not use the initial score filter on any gene <n> or more
    base long
 -r
 --no_indep
    Don't use independent probability score column
 -t <n>
 --threshold <n>
    Set threshold score for calling as gene to n.  If the in-frame
    score >= <n>, then the region is given a number and considered
    a potential gene.
 -X
 --extend
    Allow orfs extending off ends of sequence to be scored
 -z <n>
 --trans_table <n>
    Use Genbank translation table number <n> for stop codons
 -Z <codon-list>
 --stop_codons <codon-list>
    Use comma-separated list of codons as stop codons
    Sample format:  -Z tag,tga,taa
```


## reparation_blast_samtools

### Tool Description
Tools for alignments in the SAM format

### Metadata
- **Docker Image**: quay.io/biocontainers/reparation_blast:1.0.9--pl526_0
- **Homepage**: https://github.com/RickGelhausen/REPARATION_blast
- **Package**: https://anaconda.org/channels/bioconda/packages/reparation_blast/overview
- **Validation**: PASS

### Original Help Text
```text
Program: samtools (Tools for alignments in the SAM format)
Version: 1.7 (using htslib 1.7)

Usage:   samtools <command> [options]

Commands:
  -- Indexing
     dict           create a sequence dictionary file
     faidx          index/extract FASTA
     index          index alignment

  -- Editing
     calmd          recalculate MD/NM tags and '=' bases
     fixmate        fix mate information
     reheader       replace BAM header
     targetcut      cut fosmid regions (for fosmid pool only)
     addreplacerg   adds or replaces RG tags
     markdup        mark duplicates

  -- File operations
     collate        shuffle and group alignments by name
     cat            concatenate BAMs
     merge          merge sorted alignments
     mpileup        multi-way pileup
     sort           sort alignment file
     split          splits a file by read group
     quickcheck     quickly check if SAM/BAM/CRAM file appears intact
     fastq          converts a BAM to a FASTQ
     fasta          converts a BAM to a FASTA

  -- Statistics
     bedcov         read depth per BED region
     depth          compute the depth
     flagstat       simple stats
     idxstats       BAM index stats
     phase          phase heterozygotes
     stats          generate stats (former bamcheck)

  -- Viewing
     flags          explain BAM flags
     tview          text alignment viewer
     view           SAM<->BAM<->CRAM conversion
     depad          convert padded BAM to unpadded BAM
```


## reparation_blast_blastp

### Tool Description
Protein-Protein BLAST 2.7.1+

### Metadata
- **Docker Image**: quay.io/biocontainers/reparation_blast:1.0.9--pl526_0
- **Homepage**: https://github.com/RickGelhausen/REPARATION_blast
- **Package**: https://anaconda.org/channels/bioconda/packages/reparation_blast/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE
  blastp [-h] [-help] [-import_search_strategy filename]
    [-export_search_strategy filename] [-task task_name] [-db database_name]
    [-dbsize num_letters] [-gilist filename] [-seqidlist filename]
    [-negative_gilist filename] [-negative_seqidlist filename]
    [-entrez_query entrez_query] [-db_soft_mask filtering_algorithm]
    [-db_hard_mask filtering_algorithm] [-subject subject_input_file]
    [-subject_loc range] [-query input_file] [-out output_file]
    [-evalue evalue] [-word_size int_value] [-gapopen open_penalty]
    [-gapextend extend_penalty] [-qcov_hsp_perc float_value]
    [-max_hsps int_value] [-xdrop_ungap float_value] [-xdrop_gap float_value]
    [-xdrop_gap_final float_value] [-searchsp int_value]
    [-sum_stats bool_value] [-seg SEG_options] [-soft_masking soft_masking]
    [-matrix matrix_name] [-threshold float_value] [-culling_limit int_value]
    [-best_hit_overhang float_value] [-best_hit_score_edge float_value]
    [-window_size int_value] [-lcase_masking] [-query_loc range]
    [-parse_deflines] [-outfmt format] [-show_gis]
    [-num_descriptions int_value] [-num_alignments int_value]
    [-line_length line_length] [-html] [-max_target_seqs num_sequences]
    [-num_threads int_value] [-ungapped] [-remote] [-comp_based_stats compo]
    [-use_sw_tback] [-version]

DESCRIPTION
   Protein-Protein BLAST 2.7.1+

OPTIONAL ARGUMENTS
 -h
   Print USAGE and DESCRIPTION;  ignore all other parameters
 -help
   Print USAGE, DESCRIPTION and ARGUMENTS; ignore all other parameters
 -version
   Print version number;  ignore other arguments

 *** Input query options
 -query <File_In>
   Input file name
   Default = `-'
 -query_loc <String>
   Location on the query sequence in 1-based offsets (Format: start-stop)

 *** General search options
 -task <String, Permissible values: 'blastp' 'blastp-fast' 'blastp-short' >
   Task to execute
   Default = `blastp'
 -db <String>
   BLAST database name
    * Incompatible with:  subject, subject_loc
 -out <File_Out>
   Output file name
   Default = `-'
 -evalue <Real>
   Expectation value (E) threshold for saving hits 
   Default = `10'
 -word_size <Integer, >=2>
   Word size for wordfinder algorithm
 -gapopen <Integer>
   Cost to open a gap
 -gapextend <Integer>
   Cost to extend a gap
 -matrix <String>
   Scoring matrix name (normally BLOSUM62)
 -threshold <Real, >=0>
   Minimum word score such that the word is added to the BLAST lookup table
 -comp_based_stats <String>
   Use composition-based statistics:
       D or d: default (equivalent to 2 )
       0 or F or f: No composition-based statistics
       1: Composition-based statistics as in NAR 29:2994-3005, 2001
       2 or T or t : Composition-based score adjustment as in Bioinformatics
   21:902-911,
       2005, conditioned on sequence properties
       3: Composition-based score adjustment as in Bioinformatics 21:902-911,
       2005, unconditionally
   Default = `2'

 *** BLAST-2-Sequences options
 -subject <File_In>
   Subject sequence(s) to search
    * Incompatible with:  db, gilist, seqidlist, negative_gilist,
   negative_seqidlist, db_soft_mask, db_hard_mask
 -subject_loc <String>
   Location on the subject sequence in 1-based offsets (Format: start-stop)
    * Incompatible with:  db, gilist, seqidlist, negative_gilist,
   negative_seqidlist, db_soft_mask, db_hard_mask, remote

 *** Formatting options
 -outfmt <String>
   alignment view options:
     0 = Pairwise,
     1 = Query-anchored showing identities,
     2 = Query-anchored no identities,
     3 = Flat query-anchored showing identities,
     4 = Flat query-anchored no identities,
     5 = BLAST XML,
     6 = Tabular,
     7 = Tabular with comment lines,
     8 = Seqalign (Text ASN.1),
     9 = Seqalign (Binary ASN.1),
    10 = Comma-separated values,
    11 = BLAST archive (ASN.1),
    12 = Seqalign (JSON),
    13 = Multiple-file BLAST JSON,
    14 = Multiple-file BLAST XML2,
    15 = Single-file BLAST JSON,
    16 = Single-file BLAST XML2,
    18 = Organism Report
   
   Options 6, 7 and 10 can be additionally configured to produce
   a custom format specified by space delimited format specifiers.
   The supported format specifiers are:
   	    qseqid means Query Seq-id
   	       qgi means Query GI
   	      qacc means Query accesion
   	   qaccver means Query accesion.version
   	      qlen means Query sequence length
   	    sseqid means Subject Seq-id
   	 sallseqid means All subject Seq-id(s), separated by a ';'
   	       sgi means Subject GI
   	    sallgi means All subject GIs
   	      sacc means Subject accession
   	   saccver means Subject accession.version
   	   sallacc means All subject accessions
   	      slen means Subject sequence length
   	    qstart means Start of alignment in query
   	      qend means End of alignment in query
   	    sstart means Start of alignment in subject
   	      send means End of alignment in subject
   	      qseq means Aligned part of query sequence
   	      sseq means Aligned part of subject sequence
   	    evalue means Expect value
   	  bitscore means Bit score
   	     score means Raw score
   	    length means Alignment length
   	    pident means Percentage of identical matches
   	    nident means Number of identical matches
   	  mismatch means Number of mismatches
   	  positive means Number of positive-scoring matches
   	   gapopen means Number of gap openings
   	      gaps means Total number of gaps
   	      ppos means Percentage of positive-scoring matches
   	    frames means Query and subject frames separated by a '/'
   	    qframe means Query frame
   	    sframe means Subject frame
   	      btop means Blast traceback operations (BTOP)
   	    staxid means Subject Taxonomy ID
   	  ssciname means Subject Scientific Name
   	  scomname means Subject Common Name
   	sblastname means Subject Blast Name
   	 sskingdom means Subject Super Kingdom
   	   staxids means unique Subject Taxonomy ID(s), separated by a ';'
   			 (in numerical order)
   	 sscinames means unique Subject Scientific Name(s), separated by a ';'
   	 scomnames means unique Subject Common Name(s), separated by a ';'
   	sblastnames means unique Subject Blast Name(s), separated by a ';'
   			 (in alphabetical order)
   	sskingdoms means unique Subject Super Kingdom(s), separated by a ';'
   			 (in alphabetical order) 
   	    stitle means Subject Title
   	salltitles means All Subject Title(s), separated by a '<>'
   	   sstrand means Subject Strand
   	     qcovs means Query Coverage Per Subject
   	   qcovhsp means Query Coverage Per HSP
   	    qcovus means Query Coverage Per Unique Subject (blastn only)
   When not provided, the default value is:
   'qaccver saccver pident length mismatch gapopen qstart qend sstart send
   evalue bitscore', which is equivalent to the keyword 'std'
   Default = `0'
 -show_gis
   Show NCBI GIs in deflines?
 -num_descriptions <Integer, >=0>
   Number of database sequences to show one-line descriptions for
   Not applicable for outfmt > 4
   Default = `500'
    * Incompatible with:  max_target_seqs
 -num_alignments <Integer, >=0>
   Number of database sequences to show alignments for
   Default = `250'
    * Incompatible with:  max_target_seqs
 -line_length <Integer, >=1>
   Line length for formatting alignments
   Not applicable for outfmt > 4
   Default = `60'
 -html
   Produce HTML output?

 *** Query filtering options
 -seg <String>
   Filter query sequence with SEG (Format: 'yes', 'window locut hicut', or
   'no' to disable)
   Default = `no'
 -soft_masking <Boolean>
   Apply filtering locations as soft masks
   Default = `false'
 -lcase_masking
   Use lower case filtering in query and subject sequence(s)?

 *** Restrict search or results
 -gilist <String>
   Restrict search of database to list of GI's
    * Incompatible with:  negative_gilist, seqidlist, negative_seqidlist,
   remote, subject, subject_loc
 -seqidlist <String>
   Restrict search of database to list of SeqId's
    * Incompatible with:  gilist, negative_gilist, negative_seqidlist, remote,
   subject, subject_loc
 -negative_gilist <String>
   Restrict search of database to everything except the listed GIs
    * Incompatible with:  gilist, seqidlist, remote, subject, subject_loc
 -negative_seqidlist <String>
   Restrict search of database to everything except the listed SeqIDs
    * Incompatible with:  gilist, seqidlist, remote, subject, subject_loc
 -entrez_query <String>
   Restrict search with the given Entrez query
    * Requires:  remote
 -db_soft_mask <String>
   Filtering algorithm ID to apply to the BLAST database as soft masking
    * Incompatible with:  db_hard_mask, subject, subject_loc
 -db_hard_mask <String>
   Filtering algorithm ID to apply to the BLAST database as hard masking
    * Incompatible with:  db_soft_mask, subject, subject_loc
 -qcov_hsp_perc <Real, 0..100>
   Percent query coverage per hsp
 -max_hsps <Integer, >=1>
   Set maximum number of HSPs per subject sequence to save for each query
 -culling_limit <Integer, >=0>
   If the query range of a hit is enveloped by that of at least this many
   higher-scoring hits, delete the hit
    * Incompatible with:  best_hit_overhang, best_hit_score_edge
 -best_hit_overhang <Real, (>0 and <0.5)>
   Best Hit algorithm overhang value (recommended value: 0.1)
    * Incompatible with:  culling_limit
 -best_hit_score_edge <Real, (>0 and <0.5)>
   Best Hit algorithm score edge value (recommended value: 0.1)
    * Incompatible with:  culling_limit
 -max_target_seqs <Integer, >=1>
   Maximum number of aligned sequences to keep 
   Not applicable for outfmt <= 4
   Default = `500'
    * Incompatible with:  num_descriptions, num_alignments

 *** Statistical options
 -dbsize <Int8>
   Effective length of the database 
 -searchsp <Int8, >=0>
   Effective length of the search space
 -sum_stats <Boolean>
   Use sum statistics

 *** Search strategy options
 -import_search_strategy <File_In>
   Search strategy to use
    * Incompatible with:  export_search_strategy
 -export_search_strategy <File_Out>
   File name to record the search strategy used
    * Incompatible with:  import_search_strategy

 *** Extension options
 -xdrop_ungap <Real>
   X-dropoff value (in bits) for ungapped extensions
 -xdrop_gap <Real>
   X-dropoff value (in bits) for preliminary gapped extensions
 -xdrop_gap_final <Real>
   X-dropoff value (in bits) for final gapped alignment
 -window_size <Integer, >=0>
   Multiple hits window size, use 0 to specify 1-hit algorithm
 -ungapped
   Perform ungapped alignment only?

 *** Miscellaneous options
 -parse_deflines
   Should the query and subject defline(s) be parsed?
 -num_threads <Integer, (>=1 and =<20)>
   Number of threads (CPUs) to use in the BLAST search
   Default = `1'
    * Incompatible with:  remote
 -remote
   Execute search remotely?
    * Incompatible with:  gilist, seqidlist, negative_gilist,
   negative_seqidlist, subject_loc, num_threads
 -use_sw_tback
   Compute locally optimal Smith-Waterman alignments?
```

