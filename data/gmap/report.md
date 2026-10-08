# gmap CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gmap | PASS |  |
| gmap_gmap_build | PASS |  |
| gmap_gsnap | PASS |  |

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

## gmap_gmap_build

### Tool Description
Builds a gmap database for a genome to be used by GMAP or GSNAP

### Metadata
- **Docker Image**: quay.io/biocontainers/gmap:2025.07.31--pl5321hb1d24b7_1
- **Homepage**: http://research-pub.gene.com/gmap/
- **Package**: https://anaconda.org/channels/bioconda/packages/gmap/overview
- **Validation**: PASS

### Original Help Text
```text
Name "main::contigs_mapped_p" used only once: possible typo at /usr/local/bin/gmap_build line 192.
Name "main::transcriptomedir" used only once: possible typo at /usr/local/bin/gmap_build line 228.
Unknown option: help
-k flag not specified, so building main hash table with default 15-mers
Must specify genome database name with -d flag. at /usr/local/bin/gmap_build line 68.

gmap_build: Builds a gmap database for a genome to be used by GMAP or GSNAP.
Part of GMAP package, version 2025-07-31.

Usage: gmap_build [options...] -d <genome> [-c <transcriptome> -T <transcript_fasta>] <genome_fasta_files>

You are free to name <genome> and <transcriptome> as you wish.  You
will use the same names when performing alignments subsequently using
GMAP or GSNAP.

Note: If adding a transcriptome to an existing genome, then there is
no need to specify the genome_fasta_files.  This way you can add
transcriptome information to an existing genome database.

Options:
    -D, --genomedir=STRING    Destination directory for installation (defaults to gmapdb
                                directory specified at configure time)
    -d, --genomedb=STRING     Genome name (required)

    -n, --names=STRING        Substitute names for contigs, provided in a file.
        The file can have two formats:

        1.  A file with one column per line, with each line
            corresponding to a FASTA file, in the order given to
            gmap_build.  The chromosome name for each FASTA file will
            be replaced with the desired chromosome name in the file.
            Every chromosome in the FASTA must have a corresponding line
            in the file.  This is useful if you want to rename chromosomes
            with a systematic numbering pattern.

        2.  A file with two columns per line, separated by white
            space.  In each line, the original FASTA chromosome name
            should be in column 1 and the desired chromosome name
            will be in column 2.

            The meaning of file format 2 depends on whether
            --limit-to-names is specified.  If so, the genome build will
            be limited to those chromosomes in this file.  Otherwise,
            all chromosomes in the FASTA file will be included,
            but only those chromosomes in this file will be re-named, which
            provides an easy way to change just a few chromosome names.

        This file can be combined with the --sort=names option, in
        which the order of chromosomes is that given in the file.  In
        this case, every chromosome must be listed in the file, and
        for chromosome names that should not be changed, column 2 can
        be blank (or the same as column 1).  The option of a blank
        column 2 is allowed only when specifying --sort=names,
        because otherwise, the program cannot distinguish between a
        1-column and 2-column names file.

    -L, --limit-to-names      Determines whether to limit the genome build to the lines listed
                              in the --names file.  You can limit a genome build to certain
                              chromosomes with this option, plus a --names file that either
                              renames chromosomes, or lists the same names in both columns for
                              the desired chromosomes.

    -k, --kmer=INT            k-mer value for genomic index (allowed: 15 or less, default is 15)
    -q INT                    sampling interval for genomoe (allowed: 1-3, default 3)

    -s, --sort=STRING         Sort chromosomes using given method:
                                none - use chromosomes as found in FASTA file(s) (default)
                                alpha - sort chromosomes alphabetically (chr10 before chr 1)
                                numeric-alpha - chr1, chr1U, chr2, chrM, chrU, chrX, chrY
                                chrom - chr1, chr2, chrM, chrX, chrY, chr1U, chrU
                                names - sort chromosomes based on file provided to --names flag

    -g, --gunzip              Files are gzipped, so need to gunzip each file first
    -E, --fasta-pipe=STRING   Interpret argument as a command, instead of a list of FASTA files
    -Q, --fastq               Files are in FASTQ format
    -R, --revcomp             Reverse complement all contigs
    -w INT                    Wait (sleep) this many seconds after each step (default 2)

    -o, --circular=STRING     Circular chromosomes (either a list of chromosomes separated
                                by a comma, or a filename containing circular chromosomes,
                                one per line).  If you use the --names feature, then you
                                should use the substitute name of the chromosome, not the
                                original name, for this option.  (NOTE: This behavior is different
                                from previous versions, and starts with version 2020-10-20.)

    -2, --altscaffold=STRING  File with alt scaffold info, listing alternate scaffolds,
                                one per line, tab-delimited, with the following fields:
                                (1) alt_scaf_acc, (2) parent_name, (3) orientation,
                                (4) alt_scaf_start, (5) alt_scaf_stop, (6) parent_start, (7) parent_end.

    -e, --nmessages=INT       Maximum number of messages (warnings, contig reports) to report (default 50)

    --sarray=INT              Whether to build suffix array: 0=no (default), 1=yes

Options for older genome formats:
    -M, --mdflag=STRING       Use MD file from NCBI for mapping contigs to
                                chromosomal coordinates


Options for transcriptome-guided alignment:
    -C, --transcriptomedir=STRING   Destination directory for installation (defaults to gmapdb
                                      directory specified at configure time)
    -c, --transcriptomedb=STRING    Transcriptome name, plus one of these four flags:

    --gtf=FILE                GTF file containing transcripts
    --gff3=FILE               GFF3 file containing transcripts
    -G, --genes=FILE          Genes file containing transcripts
    -T, --transcripts=FILE    FASTA file containing transcripts

    -t, --nthreads=INT        Number of threads for GMAP alignment of transcripts to genome
                                (default 8).  Applies if --transcripts option is given
```

## gmap_gsnap

### Tool Description
Genomic Short-read Nucleotide Alignment Program (GSNAP)

### Metadata
- **Docker Image**: quay.io/biocontainers/gmap:2025.07.31--pl5321hb1d24b7_1
- **Homepage**: http://research-pub.gene.com/gmap/
- **Package**: https://anaconda.org/channels/bioconda/packages/gmap/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gsnap [OPTIONS...] <FASTA file>, or
       cat <FASTA file> | gmap [OPTIONS...]

Input options (must include -d)
  -D, --dir=directory            Genome directory.  Default (as specified by --with-gmapdb to the configure program) is
                                   /usr/local/share
  -d, --db=STRING                Genome database
  --two-pass                     Two-pass mode, in which the sequences are processed first to identify splice sites
                                   and introns, and then aligned using this splicing information
  --use-localdb=INT              Whether to use the local suffix arrays, which help with finding extensions to the ends
                                   of alignments in the presence of splicing or indels (0=no, 1=yes if available (default))

Transcriptome-guided options (optional)
  -C, --transcriptdir=directory  Transcriptome directory.  Default is the value for --dir above
  -c, --transcriptdb=STRING      Transcriptome database
  --transcriptome-mode=STRING    Options: assist, only, annotate (default).  The option assist means
                                   to try transcriptome alignment first, but then use genomic alignment
                                   if nothing is found.  The option only means to try transcriptome
                                   alignment only.  The option annotate means to try only genomic
                                   alignment, to use the transcriptome only for annotation; this is
                                   the fastest option.  In the other two options, annotation is also
                                   performed

Computation options
  -k, --kmer=INT                 kmer size to use in genome database (allowed values: 16 or less)
                                   If not specified, the program will find the highest available
                                   kmer size in the genome database
  --sampling=INT                 Sampling to use in genome database.  If not specified, the program
                                   will find the smallest available sampling value in the genome database
                                   within selected k-mer size
  --align-fraction=FLOAT         Process only the given fraction of reads, selected at random
                                   If --align-fraction and --part are given, --align-fraction takes precedence
  -q, --part=INT/INT             Process only the i-th out of every n sequences
                                   e.g., 0/100 or 99/100 (useful for distributing jobs
                                   to a computer farm).
  --input-buffer-size=INT        Size of input buffer (program reads this many sequences
                                   at a time for efficiency) (default 10000)
  --barcode-length=INT           Amount of barcode to remove from start of every read before alignment
                                   (default 0)
  --endtrim-length=INT           Amount of trim to remove from the end of every read before alignment
                                   (default 0)
  --orientation=STRING           Orientation of paired-end reads
                                   Allowed values: FR (fwd-rev, or typical Illumina; default),
                                   RF (rev-fwd, for circularized inserts), or FF (fwd-fwd, same strand),
                                   or 10X (single-cell where read 1 has barcode information; read 2 is rev)
  --10x-whitelist=FILE           Whitelist of 10X Genomics GEM bead barcodes, needed to perform correction of
                                   cellular barcodes.  This file can be obtained at
                                   cellranger-x.y.z/lib/python/cellranger/barcodes (for Cell Ranger version >= 4)
                                   cellranger-x.y.z/lib/cellranger-cs/x.y.z/lib/python/cellranger/barcodes (<= 3)
  --10x-well-position=INT        Position of well information in the accession, when separated by colons
                                   If set to 0, then no well information will be printed in the CB field (default: 4)
  --fastq-id-start=INT           Starting position of identifier in FASTQ header, space-delimited (>= 1)
  --fastq-id-end=INT             Ending position of identifier in FASTQ header, space-delimited (>= 1)
                                 Examples:
                                   @HWUSI-EAS100R:6:73:941:1973#0/1
                                      start=1, end=1 (default) => identifier is HWUSI-EAS100R:6:73:941:1973#0
                                   @SRR001666.1 071112_SLXA-EAS1_s_7:5:1:817:345 length=36
                                      start=1, end=1  => identifier is SRR001666.1
                                      start=2, end=2  => identifier is 071112_SLXA-EAS1_s_7:5:1:817:345
                                      start=1, end=2  => identifier is SRR001666.1 071112_SLXA-EAS1_s_7:5:1:817:345
  --force-single-end             When multiple FASTQ files are provided on the command line, GSNAP assumes
                                    they are matching paired-end files.  This flag treats each file as single-end.
  --filter-chastity=STRING       Skips reads marked by the Illumina chastity program.  Expecting a string
                                   after the accession having a 'Y' after the first colon, like this:
                                         @accession 1:Y:0:CTTGTA
                                   where the 'Y' signifies filtering by chastity.
                                   Values: off (default), either, both.  For 'either', a 'Y' on either end
                                   of a paired-end read will be filtered.  For 'both', a 'Y' is required
                                   on both ends of a paired-end read (or on the only end of a single-end read).
  --allow-pe-name-mismatch       Allows accession names of reads to mismatch in paired-end files
  --interleaved                  Input is in interleaved format (one read per line, tab-delimited
  --gunzip                       Uncompress gzipped input files
  --bunzip2                      Uncompress bzip2-compressed input files

Computation options
  -B, --batch=INT                Batch mode (default = 5)
                                 Mode  Hash offsets  Hash positions  Genome          Local hash offsets  Local hash positions  Localdb
                                   0   allocate      mmap            mmap            allocate            mmap                  mmap
                                   1   allocate      mmap & preload  mmap            allocate            mmap & preload        mmap
                                   2   allocate      mmap & preload  mmap & preload  allocate            mmap & preload        mmap
                                   3   allocate      allocate        mmap & preload  allocate            allocate              mmap
                                   4   allocate      allocate        allocate        allocate            allocate              mmap
                      (default)    5   allocate      allocate        allocate        allocate            allocate              allocate
                           Note: For a single sequence, all data structures use mmap
                           A batch level of 5 means the same as 4, and is kept only for backward compatibility
  --use-shared-memory=INT        If 1, then allocated memory is shared among all processes on this node
                                   If 0 (default), then each process has private allocated memory
  --preload-shared-memory        Load files indicated by --batch mode into shared memory for use by other
                                   GMAP/GSNAP processes on this node, and then exit.  Ignore any input files.
  --unload-shared-memory         Unload files indicated by --batch mode into shared memory, or allow them
                                   to be unloaded when existing GMAP/GSNAP processes on this node are finished
                                   with them.  Ignore any input files.
  -m, --max-mismatches=FLOAT     Maximum number of mismatches allowed (if not specified, then
                                   GSNAP tries to find the best possible match in the genome)
                                   If specified between 0.0 and 1.0, then treated as a fraction
                                   of each read length.  Otherwise, treated as an integral number
                                   of mismatches (including indel and splicing penalties).
                                   Default is 0.3
  --query-unk-mismatch=INT       Whether to count unknown (N) characters in the query as a mismatch
                                   (0=no (default), 1=yes)
  --genome-unk-mismatch=INT      Whether to count unknown (N) characters in the genome as a mismatch
                                   (0=no, 1=yes).  If --use-mask is specified, default is no, otherwise yes.
  --maxsearch=INT                Maximum number of alignments to find (default 1000).
                                   Should be larger than --npaths, which is the number to report.
                                   Keeping this number large will allow for random selection among multiple alignments.
                                   Reducing this number can speed up the program.
  --indel-endlength=INT          Minimum length at end required for indel alignments (default 4)
  --max-insertions=INT           Maximum number of insertions allowed (default 6)
  --max-deletions=INT            Maximum number of deletions allowed (default 9)
  -M, --suboptimal-levels=INT    Report suboptimal hits beyond best hit (default 0)
                                   All hits with best score plus suboptimal-levels are reported
                                   (Note: Not currently implemented)
  -a, --adapter-strip=STRING     Method for removing adapters from reads.  Currently allowed values: off, paired.
                                   Default is "off".  To turn on, specify "paired", which removes adapters
                                   from paired-end reads if they appear to be present.
  -e, --use-mask=STRING          Use genome containing masks (e.g. for non-exons) for scoring preference
  -V, --snpsdir=STRING           Directory for SNPs index files (created using snpindex) (default is
                                   location of genome index files specified using -D and -d)
   -v, --use-snps=STRING          Use database containing known SNPs (in <STRING>.iit, built
                                   previously using snpindex) for tolerance to SNPs
  --cmetdir=STRING               Directory for methylcytosine index files (created using cmetindex)
                                   (default is location of genome index files specified using -D, -V, and -d)
  --atoidir=STRING               Directory for A-to-I RNA editing index files (created using atoiindex)
                                   (default is location of genome index files specified using -D, -V, and -d)
  --mode=STRING                  Alignment mode: standard (default), cmet-stranded, cmet-nonstranded,
                                    atoi-stranded, atoi-nonstranded, ttoc-stranded, or ttoc-nonstranded.
                                    Non-standard modes requires you to have previously run the cmetindex
                                    or atoiindex programs (which also cover the ttoc modes) on the genome
  -t, --nthreads=INT             Number of worker threads
Splicing options for DNA-Seq
  --find-dna-chimeras=INT              Look for distant splicing involving poor splice sites (0=no, 1=yes)
                                         If not specified, then default is to be on unless only known splicing
                                         is desired (--use-splicing is specified and --novelsplicing is off)

Splicing options for RNA-Seq
  -N, --novelsplicing=INT              Look for novel splicing (0=no (default), 1=yes)
  --splicingdir=STRING                 Directory for splicing involving known sites or known introns,
                                         as specified by the -s or --use-splicing flag (default is
                                         directory computed from -D and -d flags).  Note: can
                                         just give full pathname to the -s flag instead.
  -s, --use-splicing=STRING            Look for splicing involving known sites or known introns
                                         (in <STRING>.iit), at short or long distances
                                         See README instructions for the distinction between known sites
                                         and known introns
  --splices-noeval                     Do not evaluate splices for probability or intron length, but depend
                                         only on sequence alignment
  --splices-dump=FILE                  Write splice junction information to FILE, in the same format as for STAR
                                         plus MaxEnt probabilities for the two intron positions.  Note that in this
                                         dump file, the annotation column is reserved strictly for known introns,
                                         and not novel introns that passed some criterion from a first pass.
  --splices-exclude-known              In the file for --splices-dump, exclude all known introns
  -w, --localsplicedist=INT            Definition of local novel splicing event (default 200000)
  --merge-distant-samechr              Report distant splices on the same chromosome as a single splice, if possible.
                                         Will produce a single SAM line instead of two SAM lines, which is also done
                                         for translocations, inversions, and scramble events

Options for paired-end reads
  --pairmax-dna=INT              Max total genomic length for DNA-Seq paired reads, or other reads
                                   without splicing (default 2000).  Used if -N or -s is not specified.
                                   This value is also used for circular chromosomes when splicing in
                                   linear chromosomes is allowed
  --pairmax-rna=INT              Max total genomic length for RNA-Seq paired reads, or other reads
                                   that could have a splice (default 200000).  Used if -N or -s is specified.
                                   Should probably match the value for -w, --localsplicedist.
  --resolve-inner=INT            Whether to resolve soft-clipping on the insides of paired-end reads (default 1)
  --pairexpect=INT               Expected paired-end length, used for resolving soft-clipping on the insides
                                   of paired-end reads, and for pairing DNA-seq reads (default 200)
  --pairdev=INT                  Allowable deviation from expected paired-end length, used for
                                   resolving soft-clipping on the insides of paired-end reads (default 100).
  --pass1-min-support=INT        Threshold read support for learning an intron during pass 1 of --two-pass mode
                                   (default 20)
Options for quality scores
  --quality-protocol=STRING      Protocol for input quality scores.  Allowed values:
                                   illumina (ASCII 64-126) (equivalent to -J 64 -j -31)
                                   sanger   (ASCII 33-126) (equivalent to -J 33 -j 0)
                                 Default is sanger (no quality print shift)
                                 SAM output files should have quality scores in sanger protocol

                                 Or you can customize this behavior with these flags:
  -J, --quality-zero-score=INT   FASTQ quality scores are zero at this ASCII value
                                   (default is 33 for sanger protocol; for Illumina, select 64)
  -j, --quality-print-shift=INT  Shift FASTQ quality scores by this amount in output
                                   (default is 0 for sanger protocol; to change Illumina input
                                   to Sanger output, select -31)
Output options
  -n, --npaths=INT               Maximum number of paths to print (default 100).
  -Q, --quiet-if-excessive       If more than maximum number of paths are found,
                                   then nothing is printed.
  -O, --ordered                  Print output in same order as input (relevant
                                   only if there is more than one worker thread)
  --show-refdiff                 For GSNAP output in SNP-tolerant alignment, shows all differences
                                   relative to the reference genome as lower case (otherwise, it shows
                                   all differences relative to both the reference and alternate genome)
  --clip-overlap                 For paired-end reads whose alignments overlap, clip the overlapping region.
  --merge-overlap                For paired-end reads whose alignments overlap, merge the two ends into a single end (beta implementation)
  --print-snps                   Print detailed information about SNPs in reads (works only if -v also selected)
                                   (not fully implemented yet)
  --failsonly                    Print only failed alignments, those with no results
  --nofails                      Exclude printing of failed alignments
  --only-concordant              Print only concordant alignments (concordant_uniq, concordant_mult, concordant_circular)
  --omit-concordant-uniq         Do not print any concordant_uniq alignments
  --omit-concordant-mult         Do not print any concordant_mult alignments
  --omit-softclipped             Do not allow any alignments with soft clips
  --only-tr-consistent           Print only alignments with consistent transcripts (XX field present, identical if paired-end)
  -A, --format=STRING            Another format type, other than default.
                                   Currently implemented: sam, m8 (BLAST tabular format)
  --split-output=STRING          Basename for multiple-file output, separately for nomapping,
                                   halfmapping_uniq, halfmapping_mult, unpaired_uniq, unpaired_mult,
                                   paired_uniq, paired_mult, concordant_uniq, and concordant_mult results
  -o, --output-file=STRING       File name for a single stream of output results.
  --failed-input=STRING          Print completely failed alignments as input FASTA or FASTQ format,
                                    to the given file, appending .1 or .2, for paired-end data.
                                    If the --split-output flag is also given, this file is generated
                                    in addition to the output in the .nomapping file.
  --append-output                When --split-output or --failed-input is given, this flag will append output
                                    to the existing files.  Otherwise, the default is to create new files.
  --order-among-best=STRING      Among alignments tied with the best score, order those alignments in this order.
                                    Allowed values: genomic, random (default)
  --output-buffer-size=INT       Buffer size, in queries, for output thread (default 1000).  When the number
                                   of results to be printed exceeds this size, worker threads wait
                                   until the backlog is cleared

Options for SAM output
  --no-sam-headers               Do not print headers beginning with '@'
  --add-paired-nomappers         Add nomapper lines as needed to make all paired-end results alternate
                                   between first end and second end
  --paired-flag-means-concordant=INT  Whether the paired bit in the SAM flags means concordant only (1)
                                 or paired plus concordant (0, default)
  --sam-headers-batch=INT        Print headers only for this batch, as specified by -q
  --sam-hardclip-use-S           Use S instead of H for hardclips
  --sam-use-0M=INT               If 1 (default), then insert 0M in CIGAR between adjacent indels and introns
                                   If 0, do not allow 0M.  Picard disallows 0M, but other tools may require it
  --sam-extended-cigar           Use extended CIGAR format (using X and = symbols instead of M,
                                   to indicate matches and mismatches, respectively
  --sam-multiple-primaries       Allows multiple alignments to be marked as primary if they
                                   have equally good mapping scores
  --sam-sparse-secondaries       For secondary alignments (in multiple mappings), uses '*' for SEQ
                                   and QUAL fields, to give smaller file sizes.  However, the output
                                   will give warnings in Picard to give warnings and may not work
                                   with downstream tools
  --force-xs-dir                 For RNA-Seq alignments, disallows XS:A:? when the sense direction
                                   is unclear, and replaces this value arbitrarily with XS:A:+.
                                   May be useful for some programs, such as Cufflinks, that cannot
                                   handle XS:A:?.  However, if you use this flag, the reported value
                                   of XS:A:+ in these cases will not be meaningful.
  --md-report-snps               In MD string, when known SNPs are given by the -v flag,
                                   prints difference nucleotides when they differ
                                   from reference but match a known alternate allele
  --no-soft-clips                Does not allow soft clips at ends.  Mismatches will be counted over the entire query
  --extend-soft-clips            Extends alignments through soft clipped regions.  CIGAR string and coordinates
                                   will be revised, but mismatches and the MD string will reflect the clipped CIGAR
  --action-if-cigar-error        Action to take if there is a disagreement between CIGAR length and sequence length
                                   Allowed values: ignore, warning (default), noprint, abort
                                   Note that the noprint option does not print the CIGAR string at all if there
                                   is an error, so it may break a SAM parser
  --read-group-id=STRING         Value to put into read-group id (RG-ID) field
  --read-group-name=STRING       Value to put into read-group name (RG-SM) field
  --read-group-library=STRING    Value to put into read-group library (RG-LB) field
  --read-group-platform=STRING   Value to put into read-group library (RG-PL) field

Help options
  --check                        Check compiler assumptions
  --version                      Show version
  --help                         Show this help message
```

