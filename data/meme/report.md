# meme CWL Generation Report

## streme

### Tool Description
STREME (Sensitive, Thorough, Rapid, Enriched Motif Elicitation) discovers motifs in a set of sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/meme:5.5.9--pl5321h1ca524f_0
- **Homepage**: https://meme-suite.org
- **Package**: https://anaconda.org/channels/bioconda/packages/meme/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/meme/overview
- **Total Downloads**: 2.3M
- **Last updated**: 2025-11-24
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
/usr/local/bin/streme: option '--h' is ambiguous; possibilities: '--hofract' '--help'

Usage: streme [options] --p <primary sequences>

   Options:
     --p <filename>            primary (positive) sequence file name (required)
     --o <output_dir>          output directory; default: 'streme_out'
     --oc <output_dir>         allow overwriting; default: 'streme_out'
                               default: if --n is not given, then STREME
                               creates control sequences by shuffling each of
                               the primary sequences preserving the positions
                               of non-core characters and k-mer frequencies
                               (see --order, below; ignored if --objfun cd given)
     --text                    output text only; overrides --o and --oc;
                               default: create text, HTML, TSV and XML files in <output_dir>
     --objfun de|cd            objective function to optimize in motif discovery
                                 de : Differential Enrichment
                                 cd : Central Distance
                               default: de
     --no-pgc                  do not show actual genomic coordinates for the discovered motif
                               sites reported in the Sites TSV file
     --n <filename>            control (negative) sequence file name;
     --notrim                  do not trim the control sequences even if their
                               average length is greater the than primary sequences;
                               default: trim control sequences if needed
     --order <m>               estimates an m-order background model for scoring
                               sites and uses an m-order shuffle if creating
                               control sequences from primary sequences;
                               default: 2 (DNA), 2 (RNA), 0 (Protein), 0 (custom)
     --bfile <bfile>           use the background model contained in bfile instead
                               of creating it from the control sequences;
                               default: see --order
     --kmer <m>                [deprecated: use --order instead]
     --hofract <hofract>       fraction of sequences in hold-out set;
                               default: 0.1
     --totallength <len>       truncate each sequence set to length <len>;
                               default: 0 (do not truncate)
     --seed <seed>             random seed for shuffling sequences;
                               default: 0
     --dna                     sequences use standard DNA alphabet (default)
     --rna                     sequences use standard RNA alphabet
     --protein                 sequences use standard protein alphabet
     --alph <alph_file>        sequences use alphabet defined in <alph_file>;
                               converts to uppercase unless both cases in core
     --thresh <thresh>         significance threshold for reporting enriched motifs;
                               default: p-value= 0.05 (0.05 if --evalue given)
     --evalue                  use p-value significance threshold; default: p-value
     --patience <patience>     quit after <patience> consecutive motifs exceed <thresh>;
                               default: 3
     --nmotifs <nmotifs>       stop if <nmotifs> motifs have been output;
                               overrides --thresh if > 0;
                               default: quit when new motif significance exceeds <thresh>
     --time <t>                quit before <t> CPU seconds consumed;
                               default: no time limit
     --minw <minwidth>         minimum width for motifs (must be >= 3); 
                               default: 8
     --maxw <maxwidth>         maximum width for motifs (must be <= 30);
                               default: 15
     --w <w>                   sets <minwidth> and <maxwidth> to <w> (must be <= 30);
                               default: see --minw and --maxw
     --neval <neval>           evaluate <neval> seeds of each width;
                               default: 25
     --nref <nref>             refine <nref> evaluated seeds of each width;
                               nref==0 means just evaluate single best seed;
                               default: 4
     --niter <niter>           iterate refinement at most <niter> times per seed;
                               default: 20
     --align left|center|right align sequences left/center/right for site
                               positional distribution plots; default: center
     --desc <desc>             include this description text in HTML
     --dfile <dfile>           include contents of this description file in HTML,
                               overrides --desc
     --help                    print this message and exit
     --version                 print the program version and exit
     --verbosity 1|2|3|4|5     level of diagnostic output (default: 2)
                               1: none 2: helpful 3: debug 4: tons 5: ludicrous
```

## meme_glam2

### Tool Description
Gapped Local Alignment of Motifs (GLAM2) finds motifs in sequences, allowing for insertions and deletions.

### Metadata
- **Docker Image**: quay.io/biocontainers/meme:5.5.9--pl5321h1ca524f_0
- **Homepage**: https://meme-suite.org
- **Package**: https://anaconda.org/channels/bioconda/packages/meme/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: glam2 [options] alphabet my_seqs.fa
Alphabets: p = proteins, n = nucleotides, other = alphabet file
Options (default settings):
-h: show all options and their default settings
-o: output directory; will not clobber existing files
-O: output directory (glam2_out); allow clobbering
-r: number of alignment runs (10)
-n: end each run after this many iterations without improvement (10000)
-2: examine both strands - forward and reverse complement
-z: minimum number of sequences in the alignment (2)
-a: minimum number of aligned columns (2)
-b: maximum number of aligned columns (50)
-w: initial number of aligned columns (20)
-d: Dirichlet mixture file
-D: deletion pseudocount (0.1)
-E: no-deletion pseudocount (2.0)
-I: insertion pseudocount (0.02)
-J: no-insertion pseudocount (1.0)
-q: weight for generic versus sequence-set-specific residue abundances (1e+99)
-t: initial temperature (1.2)
-c: cooling factor per n iterations (1.44)
-u: temperature lower bound (0.1)
-p: print progress information at each iteration
-m: column-sampling moves per site-sampling move (1.0)
-x: site sampling algorithm: 0=FAST 1=SLOW 2=FFT (0)
-s: seed for pseudo-random numbers (1)
-Q: run quietly
-v: print version and exit (also accepts --version)
=== Arguments used only by web the GLAM2 web server ===
-M:  embed sequence file contents as hidden field in HTML
-A <address>:  make email address a hidden field in HTML 
-X <description>:  make description a hidden field in HTML
```

## meme_dreme

### Tool Description
Finds discriminative regular expressions in two sets of DNA sequences. It can also find motifs in a single set of DNA sequences, in which case it uses a dinucleotide shuffled version of the first set of sequences as the second set.

### Metadata
- **Docker Image**: quay.io/biocontainers/meme:5.5.9--pl5321h1ca524f_0
- **Homepage**: https://meme-suite.org
- **Package**: https://anaconda.org/channels/bioconda/packages/meme/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
/usr/local/bin/dreme:1344: SyntaxWarning: "\s" is an invalid escape sequence. Such sequences will not work in the future. Did you mean "\\s"? A raw string is also an option.
  space_re = re.compile("\s+")
/usr/local/lib/meme-5.5.9/python/sequence_py3.py:507: SyntaxWarning: "\{" is an invalid escape sequence. Such sequences will not work in the future. Did you mean "\\{"? A raw string is also an option.
  m_var = re.compile("\{\$([A-Z]+)\}")
USAGE:
    /usr/local/bin/dreme [options]

    -o  <directory>         create the specified output directory 
                            and write all output to files in that directory
    -oc <directory>         create the specified output directory 
                            overwritting it if it already exists;
                            default: create dreme_out in the currrent
                            working directory
    -p <filename>           positive sequence file name (required)
    -n <filename>           negative sequence file name (optional);
                            default: the positive sequences are shuffled
                            to create the negative set if -n is not used
    -dna                    use the standard DNA alphabet; this is the default
    -rna                    use the standard RNA alphabet
    -protein                use the standard Protein alphabet (may not work well)
    -alph <filename>        use custom alphabet (some restrictions apply - see manual)
    -norc                   search given strand only for motifs (not reverse complement)
    -e <ethresh>            stop if motif E-value > <ethresh>;
                            default: 0.05
    -m <m>                  stop if <m> motifs have been output;
                            default: only stop at E-value threshold
    -t <seconds>            stop if the specified time has elapsed;
                            default: only stop at E-value threshold
    -g <ngen>               number of REs to generalize; default: 100
                            Hint: Increasing <ngen> will make the motif
                            search more thorough at some cost in speed.
    -s <seed>               seed for shuffling sequences; ignored
                            if -n <filename> given; default: 1
    -verbosity <verbosity>  1..5 for varying degrees of extra output
                            default: 2
    -png                    create PNG logos
    -eps                    create EPS logos
    -desc <description>     store the description in the output;
                            default: no description
    -dfile <filename>       acts like -desc but reads the description from
                            the specified file; allows characters that would 
                            otherwise have to be escaped; 
                            default: no description
    -h                      print this usage message

-----------------------Setting Core Motif Width---------------------------------
                   Hint: The defaults are pretty good; making k larger
                         than 8 slows DREME down with little other effect.
                         Use these if you just want motifs shorter than 8.
--------------------------------------------------------------------------------
    -mink <mink>            minimum width of core motif; default 3
    -maxk <maxk>            maximum width of core motif; default 8
    -k <k>                  sets mink=maxk=<k>
--------------------------------------------------------------------------------

---------------------Experimental below here; enter at your own risk.-----------
    -l                      print list of enrichment of all REs tested
--------------------------------------------------------------------------------

    DREME Finds discriminative regular expressions in two sets of DNA
    sequences.  It can also find motifs in a single set of DNA sequences,
    in which case it uses a dinucleotide shuffled version of the first
    set of sequences as the second set.

    DNA IUPAC letters in sequences are converted to N, except U-->T.

    IMPORTANT: If a negative sequence file is given, the sequences
    in it should have exactly the same length distribution as the 
    sequences in the positive sequence file.  (E.g., all sequences
    in both files could have the same length, or each sequence in
    the positive file could have exactly N corresponding sequences with
    the same length as it in in the negative file.)  
    Failure to insure this will cause DREME to fail to find motifs or 
    to report inaccurate E-values.
```

## meme_ame

### Tool Description
AME (Analysis of Motif Enrichment) finds known motifs that are enriched in a set of sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/meme:5.5.9--pl5321h1ca524f_0
- **Homepage**: https://meme-suite.org
- **Package**: https://anaconda.org/channels/bioconda/packages/meme/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Error: Must specify a sequence file and motif file(s).

Usage: ame [options] <sequence file> <motif file>+
     <sequence file>           file of sequences in FASTA format
     <motif file>+             file(s) of motifs in MEME format

     --o <output dir>          output directory; default: ame_out
     --oc <output dir>         overwrite output; default: ame_out
     --text                    output TSV format to stdout; overrides --o and --oc;
                               default: create HTML and TSV files in <output_dir>
     --control <control file>  control sequences in FASTA format or the keyword
                               '--shuffle--' to use shuffled versions of the
                               primary sequences
     --kmer <k>                preserve k-mer frequencies when shuffling;
                               default: 2
     --seed <s>                random number seed (integer); default: 1
     --method [fisher|3dmhg|4dmhg|ranksum|pearson|spearman]
                               statistical test; default: fisher
     --scoring [avg|max|sum|totalhits]
                               sequence scoring method; default: avg
     --hit-lo-fraction <fraction>
                               fraction of maximum log-odds for a hit;
                               default: 0.25
     --evalue-report-threshold <ev>
                               motif significance reporting threshold;
                               default: 10
     --fasta-threshold <ft>    maximum FASTA score for sequence to be positive
                               (requires --poslist pwm); default: 0.001
     --fix-partition <int>     number of sequences in positive partition;
     --poslist [fasta|pwm]     partition on affinity (fasta) or motif (pwm)
                               scores; default: fasta
     --log-fscores             use log of FASTA scores (pearson) or log of
                               ranks (spearman)
     --log-pwmscores           use log of log of PWM scores
     --linreg-switchxy         switch roles of X=FASTA scores and Y=PWM scores
     --xalph <alph file>       motifs will be converted to this custom alphabet
     --bfile <bfile>           background model file; default: motif file freqs
                               default: unconstrained partition maximization
     --motif-pseudo <pc>       pseudocount for creating PWMs from motifs;
                               default: 0.1
     --inc <pattern>           name pattern to select as motif; may be
                               repeated; default: all motifs are used
     --exc <pattern>           name pattern to exclude as motif; may be
                               repeated; default: all motifs are used
     --verbose [1|2|3|4|5]     controls program verbosity (5=maximum verbosity);
                               default: 2
     --help                    print this message and exit
     --version                 print the version and exit
```

## meme_sea

### Tool Description
Simple Enrichment Analysis (SEA) for motifs in sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/meme:5.5.9--pl5321h1ca524f_0
- **Homepage**: https://meme-suite.org
- **Package**: https://anaconda.org/channels/bioconda/packages/meme/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
/usr/local/bin/sea: option '--hofract' requires an argument

Usage: sea [options]

   Options:
     --p <filename>            primary (positive) sequence file name (required)
     --m <filename>            motif file name (required, may be repeated)
     --n <filename>            control (negative) sequence file name;
                               defaults: if --n is not given, then SEA
                               creates one by shuffling the primary sequences
     --no-pgc                  do not show actual genomic coordinates for the motif
                               sites reported in the Sites TSV file
     --notrim                  do not trim the control sequences even if their
                               average length is greater the than primary sequences;
                               default: trim control sequences if needed
     --order <m>               estimate an m-order background model
                               and use an m-order shuffle if creating
                               control sequences from primary sequences;
                               default: 2 (DNA), 2 (RNA), 0 (Protein), 0 (custom)
     --bfile <bfile>           use the background model contained in bfile instead
                               of creating it from the control sequences;
                               default: see --order
     --o <output_dir>          output directory; default: 'sea_out'
     --oc <output_dir>         allow overwriting; default: 'sea_out'
     --text                    output text only; overrides --o and --oc;
                               default: create text, HTML and TSV files in <output_dir>
     --hofract <hofract>       fraction of sequences in hold-out set; default: 0.1
     --seed <seed>             random seed for shuffling sequences;
                               default: 0
     --xalph <alph_file>       motifs will be converted to this custom alphabet
                               converts to uppercase unless both cases in core
     --motif-pseudo <pc>       pseudocount for creating PWMs from motifs;
                               default: 0.1
     --inc <pattern>           name pattern to select as motif; may be
                               repeated; default: all motifs are used
     --exc <pattern>           name pattern to exclude as motif; may be
                               repeated; default: all motifs are used
     --thresh <thresh>         significance threshold for reporting enriched motifs;
                               default: E-value= 10 (0.05 if --qvalue or --pvalue given)
     --qvalue                  use q-value significance threshold; default: E-value
     --pvalue                  use p-value significance threshold; default: E-value
     --align left|center|right align sequences left/center/right for site
                               positional distribution plots; default: center
     --noseqs                  do not output matching sequences TSV file;
                               default: output matching sequences
     --desc <desc>             include this description text in HTML
     --dfile <dfile>           include contents of this description file in HTML
     --version                 print the program version and exit
     --verbosity 1|2|3|4|5     level of diagnostic output (default: 2)
```

## meme_centrimo

### Tool Description
CentriMo (Local Motif Enrichment Analysis) - identifies motifs that are enriched in the center of sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/meme:5.5.9--pl5321h1ca524f_0
- **Homepage**: https://meme-suite.org
- **Package**: https://anaconda.org/channels/bioconda/packages/meme/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Sequences and motifs are both required

Usage: centrimo [options] <sequence file> <motif file>+

   Options:
     --o <output dir>         output directory; default: 'centrimo_out'
     --oc <output dir>        allow overwriting; default: 'centrimo_out'
     --neg <fasta file>       plot motif distributions in this set as well
                               in the <sequence file> (positive sequences)
                               and compute the relative enrichment
     --xalph <alph file>      name of the file containing a custom alphabet,
                               which specifies that motifs should be converted;
     --bfile <background>     0-order background frequency model for PWMs;
                               default: base frequencies in input sequences
     --motif-pseudo <pseudo>  pseudo-count to use creating PWMs;
                               default: 5
     --inc <pattern>          name pattern to select as motif; may be
                               repeated; default: all motifs are used
     --exc <pattern>          name pattern to exclude as motif; may be
                               repeated; default: all motifs are used
     --seqlen <length>        use sequences with this length; default: use
                               sequences with the same length as the first
     --score <S>              score threshold for PWMs, in bits;
                               sequences without a site with score >= <S>
                               are ignored;
                               default: 0.1
     --use-lo-fraction        score threshold <S> is fraction of maximum log-odds
     --use-pvalues            use p-values instead of PWM scores
     --norc                   do not scan with the reverse complement motif
     --sep                    scan separately with reverse complement motif;
                               (implies --norc)
     --flip                   'flip' sequences so that matches on the 
                               reverse strand are 'reflected' around center;
                               default: do not flip sequences
     --optimize-score         search for optimized score above the threshold
                               given by '--score' argument. Slow computation
                               due to multiple tests.
                               default: use fixed score threshold
     --maxreg <maxreg>        maximum width of any region to consider;
                               default: use the sequence length
     --minreg <minreg>        minimum width of any region to consider;
                               must be less than <maxreg>;
                               default: 1 bp
     --local                  compute the enrichment of all regions;
                               default: enrichment of central regions only
     --cd                     distance to sequence center enrichment;
                               default: region enrichment
     --ethresh <thresh>       evalue threshold for including in results;
                               default: 10
     --desc <description>     include the description in the output;
                               default: no description
     --dfile <desc file>      use the file content as the description;
                               default: no descriptionn
     --noseq                  do not store sequence IDs in HTML output;
                               default: IDs are stored in the HTML output
     --verbosity [1|2|3|4]    verbosity of output: 1 (quiet) - 4 (dump);
                               default: 2
     --version                print the version and exit
```

## meme_fimo

### Tool Description
Find Individual Motif Occurrences (FIMO) searches a sequence database for occurrences of known motifs.

### Metadata
- **Docker Image**: quay.io/biocontainers/meme:5.5.9--pl5321h1ca524f_0
- **Homepage**: https://meme-suite.org
- **Package**: https://anaconda.org/channels/bioconda/packages/meme/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: fimo [options] <motif file> <sequence file>

   Options:
     --o <output dir> (default: fimo_out)
     --oc <output dir> (default: fimo_out)
     --text
     --skip-matched-sequence
     --best-site
     --motif <id> (default: all)
     --motif-pseudo <float> (default: 0.1)
     --no-pgc
     --bfile <background file> (DNA and protein use NRDB by default)
     --psp <PSP filename> (default: none)
     --alpha <double> (default 1.0)
     --prior-dist <PSP distribution filename> (default: none)
     --thresh <float> (default: 1e-4)
     --qv-thresh
     --no-qvalue
     --norc
     --max-strand
     --max-stored-scores <int> (default: 100000)
     --version (print the version and exit)
     --verbosity [1|2|3|4|5] (default: 2)

   When scanning with a single motif use '-' for <sequence file> to
     read the database from standard input.
   Use '--bfile --motif--' to read the background from the motif file.
   Use '--bfile --uniform--' to use a uniform background.
   Use '--bfile --nrdb--' to use a NRDB background.
```

## meme_mast

### Tool Description
Motif Alignment and Search Tool (MAST) - searches for motifs in sequence databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/meme:5.5.9--pl5321h1ca524f_0
- **Homepage**: https://meme-suite.org
- **Package**: https://anaconda.org/channels/bioconda/packages/meme/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Motif file not specified

Usage: mast [options] <motif file> <sequence file>

   Options:
     -bfile <bf>    read background frequencies from <bf>
     -dblist        the file specified as database contains a list of databases
     -o <dir>       directory to output mast results
     -oc <dir>      directory to output mast results with overwriting allowed
     -hit_list      print only a list of non-overlapping hits to stdout
     -remcorr       remove highly correlated motifs from query
     -m <id>        use only motif(s) named <id> (overrides -mev);
                      can be repeated
     -mi <m>        use only motif(s) numbered <m> (overrides -mev);
                      can be repeated
     -c <count>     only use the first <count> motifs or all motifs
                      when <count> is zero
     -mev <thresh>  use only motifs with E-values (or p-values) less than
                      or equal to <thresh>
     -diag <diag>   nominal order and spacing of motifs
     -norc          do not score reverse complement DNA strand
     -sep           score reverse complement DNA strand as a separate sequence
     -dna           translate DNA sequences to protein
     -comp          adjust p-values and E-values for sequence composition
     -ev <ev>       print results for sequences with E-value < <ev>;
                      default: 10
     -mt <mt>       show motif matches with p-value < mt; default: 0.0001
     -w             show weak matches (mt < p-value < mt*10) in angle brackets
     -best          include only the best motif in diagrams;
                      hit_list mode only
     -seqp          use SEQUENCE p-values for motif thresholds
                      default: use POSITION p-values
     -mv <mf>       in results use <mf> as motif file name
     -df <df>       in results use <df> as database name; ignored when
                      option -dblist is specified
     -dl <dl>       in results use <dl> as link to search sequence names;
                      ignored when -dblist specified
     -minseqs <ms>  lower bound on number of sequences in db
     -nostatus      do not print progress report
     -notext        do not generate text output
     -nohtml        do not generate html output
     -version       print the version and exit
```

## meme_tomtom

### Tool Description
Compare a query motif database against one or more target motif databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/meme:5.5.9--pl5321h1ca524f_0
- **Homepage**: https://meme-suite.org
- **Package**: https://anaconda.org/channels/bioconda/packages/meme/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
No query motif database supplied

Usage:
  tomtom [options] <query file> <target file>+
Options:
  -o <output dir>  Name of directory for output files;
                    will not replace existing directory
  -oc <output dir> Name of directory for output files;
                    will replace existing directory
  -xalph           Convert the alphabet of the target motif databases
                    to the alphabet of the query motif database
                    assuming the core symbols of the target motif
                    alphabet are a subset; default: reject differences
  -bfile <background file>
                   Name of background file;
                    default: use the background from the query
                    motif database
  -motif-pseudo <pseudo count>
                   Apply the pseudocount to the query and target motifs;
                    default: apply a pseudocount of 0.1
  -m <id>          Use only query motifs with a specified id;
                    may be repeated
  -mi <index>      Use only query motifs with a specifed index;
                    may be repeated
  -thresh <float>  Significance threshold; default: 0.5
  -evalue          Use E-value threshold; default: q-value
  -dist allr|ed|kullback|pearson|sandelin|blic1|blic5|llr1|llr5
                   Distance metric for scoring alignments;
                    default: ed
  -internal        Only allow internal alignments;
                    default: allow overhangs
  -min-overlap <int>
                   Minimum overlap between query and target;
                    default: 1
  -norc            Do not score the reverse complements of targets
  -incomplete-scores
                   Ignore unaligned columns in computing scores
                    default: use complete set of columns
  -text            Output in text (TSV) format to stdout;
                    overrides -o and -oc;
                    default: output all formats to files in <output dir>
  -png             Create PNG logos; default: don't create PNG logos
  -eps             Create EPS logos; default: don't create EPS logos
  -no-ssc          Don't apply small-sample correction to logos;
                   default: use small-sample correction
  -time <time>     quit before <time> seconds elapsed
                   <time> must be > 0. The Default is unlimited elapsed time
  -verbosity [1|2|3|4]
                   Set the verbosity of the program; default: 2 (normal)
  -version         Print the version and exit
```

## meme_fasta-get-markov

### Tool Description
Estimate a Markov model from a FASTA file of sequences. Skips tuples containing ambiguous symbols. Combines both strands of complementable alphabets unless -norc is set.

### Metadata
- **Docker Image**: quay.io/biocontainers/meme:5.5.9--pl5321h1ca524f_0
- **Homepage**: https://meme-suite.org
- **Package**: https://anaconda.org/channels/bioconda/packages/meme/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
No input was received after half a second.
Usage:
    fasta-get-markov [options] [sequence file] [background file]
Options:
    [-m <order>]        order of Markov model to use; default 0
    [-alph <alphabet file>] use the specified custom alphabet;
                        default: guess alphabet
    [-dna]              use DNA alphabet; default: guess alphabet
    [-protein]          use protein alphabet; default: guess alphabet
    [-rna]              use rna alphabet; default: guess alphabet
    [-full]             use full list of seen symbols as the alphabet;
                        default: guess alphabet
    [-counts]           instead of a traditional Markov model output counts
                        and skip entries with no counts; implies "-norc";
                        default: output frequencies
    [-norc]             do not combine forward and reverse complement freqs;
                        this is highly recommended for RNA sequences.
    [-pseudo <count>]   pseudocount added to avoid probabilities of zero;
                        default: use a pseudocount of 0.1.
    [-nostatus]         do not print status messages.
    [-nosummary]        do not print the summary report even when a
                        background file is specified.
    [-help]             display this help message.
Description:
    Estimate a Markov model from a FASTA file of sequences.
    Skips tuples containing ambiguous symbols.
    Combines both strands of complementable alphabets unless -norc is set.

    Reads standard input if a sequence file is not specified.
    Writes standard output if a background file is not specified.

    When the background file is specified the following report is made:
    <sequence count> <min length> <max length> <average length> <summed length>
```


## Metadata
- **Skill**: generated

## meme

### Tool Description
Motif-based sequence analysis tool for discovering motifs in a set of sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/meme:5.5.9--pl5321h1ca524f_0
- **Homepage**: https://meme-suite.org
- **Package**: https://anaconda.org/channels/bioconda/packages/meme/overview
- **Validation**: PASS

### Original Help Text
```text
error at: --help
 Usage:	meme	<dataset> [optional arguments]

	<dataset> 		file containing sequences in FASTA format
	[-h]			print this message
	[-o <output dir>]	name of directory for output files
				will not replace existing directory
	[-oc <output dir>]	name of directory for output files
				will replace existing directory
	[-text]			output in text format (default is HTML)
	[-objfun classic|de|se|cd|ce]	objective function (default: classic)
	[-test mhg|mbn|mrs]	statistical test type (default: mhg)
	[-use_llr]		use LLR in search for starts in Classic mode
	[-neg <negdataset>]	file containing control sequences
	[-shuf <kmer>]		preserve frequencies of k-mers of size <kmer> 
				when shuffling (default: 2)
	[-hsfrac <hsfrac>]	fraction of primary sequences in holdout set 
				(default: 0.5)
	[-cefrac <cefrac>]	fraction sequence length for CE region 
				(default: 0.25)
	[-searchsize <ssize>]	maximum portion of primary dataset to use
				for motif search (in characters)
	[-maxsize <maxsize>]	maximum dataset size in characters
	[-norand]		do not randomize the order of the input 
				sequences with -searchsize
	[-csites <csites>]	maximum number of sites for EM in Classic mode
	[-seed <seed>]		random seed for shuffling and sampling
	[-dna]			sequences use DNA alphabet
	[-rna]			sequences use RNA alphabet
	[-protein]		sequences use protein alphabet
	[-alph <alph file>]	sequences use custom alphabet
	[-revcomp]		allow sites on + or - DNA strands
	[-pal]			force palindromes (requires -dna)
	[-mod oops|zoops|anr]	distribution of motifs
	[-nmotifs <nmotifs>]	maximum number of motifs to find
	[-evt <ev>]		stop if motif E-value greater than <evt>
	[-time <t>]		quit before <t> seconds have elapsed
	[-nsites <sites>]	number of sites for each motif
	[-minsites <minsites>]	minimum number of sites for each motif
	[-maxsites <maxsites>]	maximum number of sites for each motif
	[-wnsites <wnsites>]	weight on expected number of sites
	[-w <w>]		motif width
	[-minw <minw>]		minimum motif width
	[-maxw <maxw>]		maximum motif width
	[-allw]			test starts of all widths from minw to maxw
	[-nomatrim]		do not adjust motif width using multiple
				alignment
	[-wg <wg>]		gap opening cost for multiple alignments
	[-ws <ws>]		gap extension cost for multiple alignments
	[-noendgaps]		do not count end gaps in multiple alignments
	[-bfile <bfile>]	name of background Markov model file
	[-markov_order <order>]	(maximum) order of Markov model to use or create
	[-psp <pspfile>]	name of positional priors file
	[-maxiter <maxiter>]	maximum EM iterations to run
	[-distance <distance>]	EM convergence criterion
	[-prior dirichlet|dmix|mega|megap|addone]
				type of prior to use
	[-b <b>]		strength of the prior
	[-plib <plib>]		name of Dirichlet prior file
	[-spfuzz <spfuzz>]	fuzziness of sequence to theta mapping
	[-spmap uni|pam]	starting point seq to theta mapping type
	[-cons <cons>]		consensus sequence to start EM from
	[-brief <n>]		omit sites and sequence tables in
				output if more than <n> primary sequences
	[-nostatus]		do not print progress reports to terminal
	[-p <np>]		use parallel version with <np> processors
	[-sf <sf>]		print <sf> as name of sequence file
	[-V]			verbose mode
	[-version]		display the version number and exit
```
