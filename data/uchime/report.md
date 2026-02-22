# uchime CWL Generation Report

## uchime

### Tool Description
UCHIME is an algorithm for detecting chimeric sequences, usable in de novo or reference database mode.

### Metadata
- **Docker Image**: quay.io/biocontainers/uchime:4.2--h9948957_0
- **Homepage**: https://drive5.com/uchime/uchime_download.html
- **Package**: https://anaconda.org/channels/bioconda/packages/uchime/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/uchime/overview
- **Total Downloads**: 418
- **Last updated**: 2025-06-06
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
UCHIME 4.2 by Robert C. Edgar
http://www.drive5.com/uchime

This software is donated to the public domain


Usage
-----

uchime --input query.fasta [--db db.fasta] [--uchimeout results.uchime]
    [--uchimealns results.alns]

Options
-------

--input filename
    Query sequences in FASTA format.
    If the --db option is not specificed, uchime uses de novo
    detection. In de novo mode, relative abundance must be given
    by a string /ab=xxx/ somewhere in the label, where xxx is a
    floating-point number, e.g. >F00QGH67HG/ab=1.2/.

--db filename
    Reference database in FASTA format.
    Optional, if not specified uchime uses de novo mode.

    ***WARNING*** The database is searched ONLY on the plus strand.
    You MUST include reverse-complemented sequences in the database
    if you want both strands to be searched.

--abskew x
    Minimum abundance skew. Default 1.9. De novo mode only.
    Abundance skew is:
        min [ abund(parent1), abund(parent2) ] / abund(query).

--uchimeout filename
    Output in tabbed format with one record per query sequence.
    First field is score (h), second field is query label.
    For details, see manual.

--uchimealns filename
    Multiple alignments of query sequences to parents in human-
    readable format. Alignments show columns with differences
    that support or contradict a chimeric model.

--minh h
    Mininum score to report chimera. Default 0.3. Values from 0.1
    to 5 might be reasonable. Lower values increase sensitivity
    but may report more false positives. If you decrease --xn,
    you may need to increase --minh, and vice versa.

--mindiv div
    Minimum divergence ratio, default 0.5. Div ratio is 100% - 
    %identity between query sequence and the closest candidate for
    being a parent. If you don't care about very close chimeras,
    then you could increase --mindiv to, say, 1.0 or 2.0, and
    also decrease --min h, say to 0.1, to increase sensitivity.
    How well this works will depend on your data. Best is to
    tune parameters on a good benchmark.

--xn beta
    Weight of a no vote, also called the beta parameter. Default 8.0.
    Decreasing this weight to around 3 or 4 may give better
    performance on denoised data.

--dn n
    Pseudo-count prior on number of no votes. Default 1.4. Probably
    no good reason to change this unless you can retune to a good
    benchmark for your data. Reasonable values are probably in the
    range from 0.2 to 2.

--xa w
    Weight of an abstain vote. Default 1. So far, results do not
    seem to be very sensitive to this parameter, but if you have
    a good training set might be worth trying. Reasonable values
    might range from 0.1 to 2.

--chunks n
    Number of chunks to extract from the query sequence when searching
    for parents. Default 4.

--[no]ovchunks
    [Do not] use overlapping chunks. Default do not.

--minchunk n
    Minimum length of a chunk. Default 64.

--idsmoothwindow w
    Length of id smoothing window. Default 32.

--minsmoothid f
    Minimum factional identity over smoothed window of candidate parent.
    Default 0.95.

--maxp n
    Maximum number of candidate parents to consider. Default 2. In tests so
    far, increasing --maxp gives only a very small improvement in sensivity
    but tends to increase the error rate quite a bit.

--[no]skipgaps
--[no]skipgaps2
    These options control how gapped columns affect counting of diffs.
    If --skipgaps is specified, columns containing gaps do not found as diffs.
    If --skipgaps2 is specified, if column is immediately adjacent to
    a column containing a gap, it is not counted as a diff.
    Default is --skipgaps --skipgaps2.

--minlen L
--maxlen L
    Minimum and maximum sequence length. Defaults 10, 10000.
    Applies to both query and reference sequences.

--ucl
    Use local-X alignments. Default is global-X. On tests so far, global-X
    is always better; this option is retained because it just might work
    well on some future type of data.

--queryfract f
    Minimum fraction of the query sequence that must be covered by a local-X
    alignment. Default 0.5. Applies only when --ucl is specified.

--quiet
    Do not display progress messages on stderr.

--log filename
    Write miscellaneous information to the log file. Mostly of interest
    to me (the algorithm developer). Use --verbose to get more info.

--self
    In reference database mode, exclude a reference sequence if it has
    the same label as the query. This is useful for benchmarking by using
    the ref db as a query to test for false positives.

  --abskew <float>  help

  --absort <str>  help

  --abx <float>  help

  --allpairs <str>  help

  --alpha <str>  help

  --band <uint>  help

  --blast6out <str>  help

  --[no]blast_termgaps   help

  --blastout <str>  help

  --bump <uint>  help

  --[no]cartoon_orfs   help

  --cc <str>  help

  --chain_evalue <float>  help

  --chain_targetfract <float>  help

  --chainhits <str>  help

  --chainout <str>  help

  --chunks <uint>  help

  --clstr2uc <str>  help

  --clump <str>  help

  --clump2fasta <str>  help

  --clumpfasta <str>  help

  --clumpout <str>  help

  --cluster <str>  help

  --compilerinfo   Write info about compiler types and #defines to stdout.

  --computekl <str>  help

  --db <str>  help

  --dbstep <uint>  help

  --[no]denovo   help

  --derep   help

  --diffchar <str>  help

  --dn <float>  help

  --doug <str>  help

  --droppct <uint>  help

  --evalue <float>  help

  --evalue_g <float>  help

  --exact   help

  --[no]fastalign   help

  --fastapairs <str>  help

  --fastq2fasta <str>  help

  --findorfs <str>  help

  --[no]flushuc   help

  --frame <int>  help

  --fspenalty <float>  help

  --gapext <str>  help

  --gapopen <str>  help

  --getseqs <str>  help

  --global   help

  --hash   help

  --hashsize <uint>  help

  --help   Display command-line options.

  --hireout <str>  help

  --hspalpha <str>  help

  --id <float>  help

  --idchar <str>  help

  --iddef <uint>  help

  --idprefix <uint>  help

  --ids <str>  help

  --idsmoothwindow <uint>  help

  --idsuffix <uint>  help

  --indexstats <str>  help

  --input <str>  help

  --[no]isort   help

  --k <uint>  help

  --ka_dbsize <float>  help

  --ka_gapped_k <float>  help

  --ka_gapped_lambda <float>  help

  --ka_ungapped_k <float>  help

  --ka_ungapped_lambda <float>  help

  --[no]label_ab   help

  --labels <str>  help

  --[no]leftjust   help

  --lext <float>  help

  --local   help

  --log <str>  Log file name.

  --[no]log_hothits   help

  --[no]log_query   help

  --[no]logmemgrows   help

  --logopts   Log options.

  --[no]logwordstats   help

  --lopen <float>  help

  --makeindex <str>  help

  --match <float>  help

  --matrix <str>  help

  --max2 <uint>  help

  --maxaccepts <uint>  help

  --maxclump <uint>  help

  --maxlen <uint>  help

  --maxovd <uint>  help

  --maxp <uint>  help

  --maxpoly <uint>  help

  --maxqgap <uint>  help

  --maxrejects <uint>  help

  --maxspan1 <uint>  help

  --maxspan2 <uint>  help

  --maxtargets <uint>  help

  --maxtgap <uint>  help

  --mcc <str>  help

  --mergeclumps <str>  help

  --mergesort <str>  help

  --minchunk <uint>  help

  --mincodons <uint>  help

  --mindiffs <uint>  help

  --mindiv <float>  help

  --minh <float>  help

  --minhsp <uint>  help

  --minlen <uint>  help

  --minorfcov <uint>  help

  --minspanratio1 <float>  help

  --minspanratio2 <float>  help

  --[no]minus_frames   help

  --mismatch <float>  help

  --mkctest <str>  help

  --[no]nb   help

  --optimal   help

  --orfstyle <uint>  help

  --otusort <str>  help

  --output <str>  help

  --[no]output_rejects   help

  --probmx <str>  help

  --query <str>  help

  --queryfract <float>  help

  --querylen <uint>  help

  --quiet   Turn off progress messages.

  --randseed <uint>  help

  --realign   help

  --[no]rev   help

  --[no]rightjust   help

  --rowlen <uint>  help

  --secs <uint>  help

  --seeds <str>  help

  --seedsout <str>  help

  --seedt1 <float>  help

  --seedt2 <float>  help

  --self   help

  --[no]selfid   help

  --simcl <str>  help

  --[no]skipgaps   help

  --[no]skipgaps2   help

  --sort <str>  help

  --sortuc <str>  help

  --sparsedist <str>  help

  --sparsedistparams <str>  help

  --split <float>  help

  --[no]ssort   help

  --sspenalty <float>  help

  --[no]stable_sort   help

  --staralign <str>  help

  --stepwords <uint>  help

  --strand <str>  help

  --targetfract <float>  help

  --targetlen <uint>  help

  --tmpdir <str>  help

  --[no]trace   help

  --tracestate <str>  help

  --[no]trunclabels   help

  --[no]twohit   help

  --uc <str>  help

  --uc2clstr <str>  help

  --uc2fasta <str>  help

  --uc2fastax <str>  help

  --uchime <str>  help

  --uchimealns <str>  help

  --uchimeout <str>  help

  --[no]ucl   help

  --uhire <str>  help

  --ungapped   help

  --userfields <str>  help

  --userout <str>  help

  --usersort   help

  --uslink <str>  help

  --[no]usort   help

  --utax <str>  help

  --[no]verbose   help

  --version   Show version and exit.

  --w <uint>  help

  --weak_evalue <float>  help

  --weak_id <float>  help

  --[no]wordcountreject   help

  --[no]wordweight   help

  --xa <float>  help

  --xdrop_g <float>  help

  --xdrop_nw <float>  help

  --xdrop_u <float>  help

  --xdrop_ug <float>  help

  --xframe <str>  help

  --xlat   help

  --xn <float>  help
```


## Metadata
- **Skill**: generated
