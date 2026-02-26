# gmap CWL Generation Report

## gmap

### Tool Description
Aligns DNA or protein sequences to a genome database.

### Metadata
- **Docker Image**: quay.io/biocontainers/gmap:2025.07.31--pl5321hb1d24b7_1
- **Homepage**: http://research-pub.gene.com/gmap
- **Package**: https://anaconda.org/channels/bioconda/packages/gmap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gmap/overview
- **Total Downloads**: 440.6K
- **Last updated**: 2025-09-15
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: gmap [OPTIONS...] <FASTA files...>, or
       cat <FASTA files...> | gmap [OPTIONS...]

Input options (must include -d or -g)
  -D, --dir=directory            Genome directory.  Default (as specified by --with-gmapdb to the configure program) is
                                    /usr/local/share
  -d, --db=STRING                Genome database.  If argument is '?' (with
                                   the quotes), this command lists available databases.

  -k, --kmer=INT                 kmer size to use in genome database (allowed values: 16 or less).
                                   If not specified, the program will find the highest available
                                   kmer size in the genome database
  --sampling=INT                 Sampling to use in genome database.  If not specified, the program
                                   will find the smallest available sampling value in the genome database
                                   within selected k-mer size
  -g, --gseg=filename            User-supplied genomic segments.  If multiple segments are provided, then
                                   every query sequence is aligned against every genomic segment
  -1, --selfalign                Align one sequence against itself in FASTA format via stdin
                                   (Useful for getting protein translation of a nucleotide sequence)
  -2, --pairalign                Align two sequences in FASTA format via stdin, first one being
                                   genomic and second one being cDNA

  --cmdline=STRING,STRING        Align these two sequences provided on the command line,
                                   first one being genomic and second one being cDNA
  --align-fraction=FLOAT         Process only the given fraction of reads, selected at random
                                   If --align-fraction and --part are given, --align-fraction takes precedence
  -q, --part=INT/INT             Process only the i-th out of every n sequences
                                   e.g., 0/100 or 99/100 (useful for distributing jobs
                                   to a computer farm).
  --input-buffer-size=INT        Size of input buffer (program reads this many sequences
                                   at a time for efficiency) (default 1000)

Computation options
  -B, --batch=INT                Batch mode (default = 2)
                                 Mode     Positions       Genome
                                   0      mmap            mmap
                                   1      mmap & preload  mmap
                      (default)    2      mmap & preload  mmap & preload
                                   3      allocate        mmap & preload
                                   4      allocate        allocate
                                   5      allocate        allocate     (same as 4)
                           Note: For a single sequence, all data structures use mmap
                           If mmap not available and allocate not chosen, then will use fileio (very slow)
  --use-shared-memory=INT        If 1, then allocated memory is shared among all processes on this node
                                   If 0 (default), then each process has private allocated memory
  --nosplicing                   Turns off splicing (useful for aligning genomic sequences
                                   onto a genome)
  --max-deletionlength=INT       Max length for a deletion (default 30).  Above this size,
                                   a genomic gap will be considered an intron rather than a deletion.
                                   If the genomic gap is less than --max-deletionlength and greater
                                   than --min-intronlength, a known splice site or splice site probabilities
                                   of 0.80 on both sides will be reported as an intron.
  --min-intronlength=INT         Min length for one internal intron (default 9).  Below this size,
                                   a genomic gap will be considered a deletion rather than an intron.
                                   If the genomic gap is less than --max-deletionlength and greater
                                   than --min-intronlength, a known splice site or splice site probabilities
                                   of 0.80 on both sides will be reported as an intron.
  --max-intronlength-middle=INT  Max length for one internal intron (default 500000).  Note: for backward
                                   compatibility, the -K or --intronlength flag will set both
                                   --max-intronlength-middle and --max-intronlength-ends.
                                   Also see --split-large-introns below.
  --max-intronlength-ends=INT    Max length for first or last intron (default 10000).  Note: for backward
                                   compatibility, the -K or --intronlength flag will set both
                                   --max-intronlength-middle and --max-intronlength-ends.
  --split-large-introns          Sometimes GMAP will exceed the value for --max-intronlength-middle,
                                   if it finds a good single alignment.  However, you can force GMAP
                                   to split such alignments by using this flag
  --end-trimming-score=INT       Trim ends if the alignment score is below this value
                                   where a match scores +1 and a mismatch scores -3
                                   The value should be 0 (default) or negative.  A negative
                                   allows some mismatches at the ends of the alignment
  --trim-end-exons=INT           Trim end exons with fewer than given number of matches
                                   (in nt, default 12)
  -w, --localsplicedist=INT      Max length for known splice sites at ends of sequence
                                   (default 2000000)
  -L, --totallength=INT          Max total intron length (default 2400000)
  -x, --chimera-margin=INT       Amount of unaligned sequence that triggers
                                   search for the remaining sequence (default 30).
                                   Enables alignment of chimeric reads, and may help
                                   with some non-chimeric reads.  To turn off, set to
                                   zero.
  --no-chimeras                  Turns off finding of chimeras.  Same effect as --chimera-margin=0
  -t, --nthreads=INT             Number of worker threads
  -c, --chrsubset=string         Limit search to given chromosome
  --strand=STRING                Genome strand to try aligning to (plus, minus, or both default)
  -z, --direction=STRING         cDNA direction (sense_force, antisense_force,
                                   sense_filter, antisense_filter,or auto (default))
  --canonical-mode=INT           Reward for canonical and semi-canonical introns
                                   0=low reward, 1=high reward (default), 2=low reward for
                                   high-identity sequences and high reward otherwise
  --cross-species                Use a more sensitive search for canonical splicing, which helps especially
                                   for cross-species alignments and other difficult cases
  --allow-close-indels=INT       Allow an insertion and deletion close to each other
                                   (0=no, 1=yes (default), 2=only for high-quality alignments)
  --microexon-spliceprob=FLOAT   Allow microexons only if one of the splice site probabilities is
                                   greater than this value (default 0.95)
  --indel-open                   In dynamic programming, opening penalty for indel
  --indel-extend                 In dynamic programming, extension penalty for indel
                                   Values for --indel-open and --indel-extend should be in [-127,-1].
                                   If value is < -127, then will use -127 instead.
                                   If --indel-open and --indel-extend are not specified, values are chosen
                                   adaptively, based on the differences between the query and reference
  --cmetdir=STRING               Directory for methylcytosine index files (created using cmetindex)
                                   (default is location of genome index files specified using -D, -V, and -d)
  --atoidir=STRING               Directory for A-to-I RNA editing index files (created using atoiindex)
                                   (default is location of genome index files specified using -D, -V, and -d)
  --mode=STRING                  Alignment mode: standard (default), cmet-stranded, cmet-nonstranded,
                                    atoi-stranded, atoi-nonstranded, ttoc-stranded, or ttoc-nonstranded.
                                    Non-standard modes requires you to have previously run the cmetindex
                                    or atoiindex programs (which also cover the ttoc modes) on the genome
  -p, --prunelevel               Pruning level: 0=no pruning (default), 1=poor seqs,
                                   2=repetitive seqs, 3=poor and repetitive

Output types
  -S, --summary                  Show summary of alignments only
  -A, --align                    Show alignments
  -3, --continuous               Show alignment in three continuous lines
  -4, --continuous-by-exon       Show alignment in three lines per exon
  -E, --exons=STRING             Print exons ("cdna" or "genomic")
                                   Will also print introns with "cdna+introns" or
                                   "genomic+introns"
  -P, --protein_dna              Print protein sequence (cDNA)
  -Q, --protein_gen              Print protein sequence (genomic)
  -f, --format=INT               Other format for output (also note the -A and -S options
                                   and other options listed under Output types):
                                   mask_introns,
                                   mask_utr_introns,
                                   psl (or 1) = PSL (BLAT) format,
                                   gff3_gene (or 2) = GFF3 gene format,
                                   gff3_match_cdna (or 3) = GFF3 cDNA_match format,
                                   gff3_match_est (or 4) = GFF3 EST_match format,
                                   splicesites (or 6) = splicesites output (for GSNAP splicing file),
                                   introns = introns output (for GSNAP splicing file),
                                   map_exons (or 7) = IIT FASTA exon map format,
                                   map_ranges (or 8) = IIT FASTA range map format,
                                   coords (or 9) = coords in table format,
                                   sampe = SAM format (setting paired_read bit in flag),
                                   samse = SAM format (without setting paired_read bit),
                                   bedpe = indels and gaps in BEDPE format

Output options
  -n, --npaths=INT               Maximum number of paths to show (default 5).  If set to 1, GMAP
                                   will not report chimeric alignments, since those imply
                                   two paths.  If you want a single alignment plus chimeric
                                   alignments, then set this to be 0.
  --suboptimal-score=FLOAT       Report only paths whose score is within this value of the
                                   best path.
                                 If specified between 0.0 and 1.0, then treated as a fraction
                                   of the score of the best alignment (matches minus penalties for
                                   mismatches and indels).  Otherwise, treated as an integer
                                   number to be subtracted from the score of the best alignment.
                                   Default value is 0.50.
  -O, --ordered                  Print output in same order as input (relevant
                                   only if there is more than one worker thread)
  -5, --md5                      Print MD5 checksum for each query sequence
  -o, --chimera-overlap          Overlap to show, if any, at chimera breakpoint
  --failsonly                    Print only failed alignments, those with no results
  --nofails                      Exclude printing of failed alignments

  -V, --snpsdir=STRING           Directory for SNPs index files (created using snpindex) (default is
                                   location of genome index files specified using -D and -d)
   -v, --use-snps=STRING          Use database containing known SNPs (in <STRING>.iit, built
                                   previously using snpindex) for tolerance to SNPs
  --split-output=STRING          Basename for multiple-file output, separately for nomapping,
                                   uniq, mult, (and chimera, if --chimera-margin is selected)
  --failed-input=STRING          Print completely failed alignments as input FASTA or FASTQ format
                                   to the given file.  If the --split-output flag is also given, this file
                                   is generated in addition to the output in the .nomapping file.
  --append-output                When --split-output or --failedinput is given, this flag will append output
                                   to the existing files.  Otherwise, the default is to create new files.
  --output-buffer-size=INT       Buffer size, in queries, for output thread (default 1000).  When the number
                                   of results to be printed exceeds this size, worker threads wait
                                   until the backlog is cleared
  --translation-code=INT         Genetic code used for translating codons to amino acids and computing CDS
                                   Integer value (default=1) corresponds to an available code at
                                   http://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi
  --alt-start-codons             Also, use the alternate initiation codons shown in the above Web site
                                   By default, without this option, only ATG is considered an initiation codon
  -F, --fulllength               Assume full-length protein, starting with Met
  -a, --cdsstart=INT             Translate codons from given nucleotide (1-based)
  -T, --truncate                 Truncate alignment around full-length protein, Met to Stop
                                 Implies -F flag.
  -Y, --tolerant                 Translates cDNA with corrections for frameshifts

Options for GFF3 output
  --gff3-add-separators=INT      Whether to add a ### separator after each query sequence
                                   Values: 0 (no), 1 (yes, default)
  --gff3-swap-phase=INT          Whether to swap phase (0 => 0, 1 => 2, 2 => 1) in gff3_gene format
                                   Needed by some analysis programs, but deviates from GFF3 specification
                                   Values: 0 (no, default), 1 (yes)
  --gff3-fasta-annotation=INT    Whether to include annotation from the FASTA header into the GFF3 output
                                   Values: 0 (default): Do not include
                                           1: Wrap all annotation as Annot="<header>"
                                           2: Include key=value pairs, replacing brackets with quotation marks
                                              and replacing spaces between key=value pairs with semicolons
  --gff3-cds=STRING              Whether to use cDNA or genomic translation for the CDS coordinates
                                   Values: cdna (default), genomic

Options for SAM output
  --no-sam-headers               Do not print headers beginning with '@'
  --sam-use-0M                   Insert 0M in CIGAR between adjacent insertions and deletions
                                   Required by Picard, but can cause errors in other tools
  --sam-extended-cigar           Use extended CIGAR format (using X and = symbols instead of M,
                                   to indicate matches and mismatches, respectively
  --sam-flipped                  Flip the query and genomic positions in the SAM output.
                                   Potentially useful with the -g flag when short reads are picked as query
                                   sequences and longer reads as picked as genomic sequences
  --force-xs-dir                 For RNA-Seq alignments, disallows XS:A:? when the sense direction
                                   is unclear, and replaces this value arbitrarily with XS:A:+.
                                   May be useful for some programs, such as Cufflinks, that cannot
                                   handle XS:A:?.  However, if you use this flag, the reported value
                                   of XS:A:+ in these cases will not be meaningful.
  --md-lowercase-snp             In MD string, when known SNPs are given by the -v flag,
                                   prints difference nucleotides as lower-case when they,
                                   differ from reference but match a known alternate allele
  --action-if-cigar-error        Action to take if there is a disagreement between CIGAR length and sequence length
                                   Allowed values: ignore, warning (default), noprint, abort
                                   Note that the noprint option does not print the CIGAR string at all if there
                                   is an error, so it may break a SAM parser
  --read-group-id=STRING         Value to put into read-group id (RG-ID) field
  --read-group-name=STRING       Value to put into read-group name (RG-SM) field
  --read-group-library=STRING    Value to put into read-group library (RG-LB) field
  --read-group-platform=STRING   Value to put into read-group library (RG-PL) field

Options for quality scores
  --quality-protocol=STRING      Protocol for input quality scores.  Allowed values:
                                   illumina (ASCII 64-126) (equivalent to -J 64 -j -31)
                                   sanger   (ASCII 33-126) (equivalent to -J 33 -j 0)
                                 Default is sanger (no quality print shift)
                                 SAM output files should have quality scores in sanger protocol

                                 Or you can specify the print shift with this flag:
  -j, --quality-print-shift=INT  Shift FASTQ quality scores by this amount in output
                                   (default is 0 for sanger protocol; to change Illumina input
                                   to Sanger output, select -31)
External map file options
  -M, --mapdir=directory         Map directory
  -m, --map=iitfile              Map file.  If argument is '?' (with the quotes),
                                   this lists available map files.
  -e, --mapexons                 Map each exon separately
  -b, --mapboth                  Report hits from both strands of genome
  -u, --flanking=INT             Show flanking hits (default 0)
  --print-comment                Show comment line for each hit

Alignment output options
  --nolengths                    No intron lengths in alignment
  --nomargin                     No left margin in GMAP standard output (with the -A flag)
  -I, --invertmode=INT           Mode for alignments to genomic (-) strand:
                                   0=Don't invert the cDNA (default)
                                   1=Invert cDNA and print genomic (-) strand
                                   2=Invert cDNA and print genomic (+) strand
  -i, --introngap=INT            Nucleotides to show on each end of intron (default 3)
  -l, --wraplength=INT           Wrap length for alignment (default 50)

Filtering output options
  --min-trimmed-coverage=FLOAT   Do not print alignments with trimmed coverage less
                                   this value (default=0.0, which means no filtering)
                                   Note that chimeric alignments will be output regardless
                                   of this filter
  --min-identity=FLOAT           Do not print alignments with identity less
                                   this value (default=0.0, which means no filtering)
                                   Note that chimeric alignments will be output regardless
                                   of this filter

Help options
  --check                        Check compiler assumptions
  --version                      Show version
  --help                         Show this help message
```

