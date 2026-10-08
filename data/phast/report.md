# phast CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| phast_chooselines | PASS |  |
| phast_consentropy | PASS |  |
| phast_hmm_train | PASS |  |
| phast_hmm_tweak | Failed | tool bug: hmm_tweak segfaults on every input, even the package's own exoniphy default.hmm and default.cm with no options. |
| phast_modfreqs | PASS |  |
| phast_msa_split | PASS | Split of the phast test alignment by BED category gives the expected column counts; the --summary option crashes (segfault) with --by-category, and --by-category without --catmap also crashes. |
| phast_pbsencode | PASS |  |
| phast_pbstrain | PASS |  |
| phast_phastbias | PASS |  |
| phast_phastmotif | PASS |  |
| phast_phylofit | PASS |  |
| phast_phylop | PASS |  |

## phast_chooselines

### Tool Description
Randomly choose k lines from a file of n lines, for 0 < k < n.

### Metadata
- **Docker Image**: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
- **Homepage**: http://compgen.cshl.edu/phast/
- **Package**: https://anaconda.org/channels/bioconda/packages/phast/overview
- **Validation**: PASS

### Original Help Text
```text

PROGRAM:      chooseLines
DESCRIPTION:  Randomly choose k lines from a file of n lines, for 0 < k < n.
USAGE:        chooseLines [OPTIONS] <infile>
OPTIONS:
    -k <k>    Number of lines to choose (default is all lines).
    -h        Print this help message.
```


## phast_consentropy

### Tool Description
For use with phastCons: compute the relative entropy of conserved and non-conserved phylogenetic models, L_min, L_max and the phylogenetic information threshold.

### Metadata
- **Docker Image**: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
- **Homepage**: http://compgen.cshl.edu/phast/
- **Package**: https://anaconda.org/channels/bioconda/packages/phast/overview
- **Validation**: PASS

### Original Help Text
```text
PROGRAM: consEntropy

DESCRIPTION:
    For use with phastCons.  Given phylogenetic models for conserved and
    non-conserved states, the target coverage, and the (prior) expected
    length of a conserved element, compute the relative entropy (H) of the
    phylogenetic models, the expected minimum number of conserved sites
    required to predict conserved element (L_min), the "phylogenetic
    information threshold" (PIT = L_min * H), and the expected maximum
    number of nonconserved sites tolerated within a conserved element
    (L_max).  Also will make a recommendation for a new prior expected
    length based on a given target value of L_min*H (see --LminH).

USAGE: consEntropy [OPTIONS] <target-coverage> <expected-length> \
            [ <cons.mod> <noncons.mod> ]

OPTIONS:
    --H, -H <value>
        Instead of computing the relative entropy from two .mod files,
        just use the specified value.  The .mod files aren't required
        in this case.

    --LminH, -L <value> [or --NH/-N, for backward compatibility]
        Report the expected length that would produce the specified value
        of L_min * H (i.e., the specified PIT), assuming H remains constant
        (it generally won't).  Can be used iteratively to converge on a
        desired PIT.

    --help, -h
        Print this help message.

NOTE:
    The relative entropy is currently computed by brute force, i.e.,
    by enumerating all possible labelings of the leaves of the tree.
    This approach won't be feasible with large trees.
```


## phast_hmm_train

### Tool Description
Estimate the transition probabilities of an HMM, based on multiple alignments, sequence annotations, and a category map.

### Metadata
- **Docker Image**: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
- **Homepage**: http://compgen.cshl.edu/phast/
- **Package**: https://anaconda.org/channels/bioconda/packages/phast/overview
- **Validation**: PASS

### Original Help Text
```text
PROGRAM: hmm_train

USAGE: hmm_train -m <msa_fname_list> -c <category_map_fname> \
              -g <gff_fname_list> [OPTIONS] > out.hmm 

DESCRIPTION: 
    Estimate the transition probabilities of an HMM, based on multiple
    alignments, sequence annotations, and a category map.

OPTIONS:

 (required options)
    -m <msa_fname_list>
        List of multiple sequence alignment files.
        Currently, in testing mode, the list must be of length one.

    -c <category_map_fname>
        File defining mapping of feature types to category
        numbers.

    -g <gff_fname_list>
        Files in GFF defining sequence
        features to be used in labeling sites.   Frame of reference of 
        feature indices is determined feature-by-feature according to 
         'seqname' attribute.  Filenames must correspond in number and order
        to the elements of <msa_fname_list>. 

 (alignment options)
    -M <msa_length_list>
        (Mutually exclusive with -m) Assume alignments
        of the specified lengths (comma-separated list) and do not not
        attempt to map the coordinates in the specified GFFs (assume
        they are in the desired coordinate frame).  This option allows
        an HMM to be trained directly from GFFs, without alignments.
        Not permitted with -I.

    -i PHYLIP|FASTA|MPM|SS 
        (default SS) Alignment format.

    -R <tag>
        Before estimating transition probabilities, group features by <tag>
        (e.g., "transcript_id" or "exon_id") and reverse complement
        segments of the alignment corresponding to groups on the
        reverse strand.  Groups must be non-overlapping (see refeature
        --unique). 

 (indel options)
    -I <indel_cat_list>
        Model indels for specified categories.  To have
        nonzero probability for the states corresponding to a
        specified category range, indels must be "clean"
        (nonoverlapping), must be assignable by parsimony to a single
        branch in the phylogenetic tree, and must have lengths that
        are exact multiples of the category range size.  Avoid -G with
        this option.  If used in training mode, requires -T.

    -t <tree_fname>
        Use the specified tree topology when training
        for indels. 

    -n <nseqs> 
        Train an indel model for <nseqs>
        sequences, despite that the training alignment has a different
        number.  All (non-trivial) gap patterns are assumed to be
        equally frequent.

 (other options)
    -q 
        Proceed quietly (without updates to stderr).

    -h
        Print this help message and exit.
```


## phast_hmm_tweak

### Tool Description
Alter transition probabilities in an HMM definition file.

### Metadata
- **Docker Image**: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
- **Homepage**: http://compgen.cshl.edu/phast/
- **Package**: https://anaconda.org/channels/bioconda/packages/phast/overview
- **Validation**: PASS

### Original Help Text
```text
PROGRAM:       hmm_tweak

DESCRIPTION:   Alter transition probabilities in an HMM definition file.
               After specified operations are performed, transition
               probabilities are renormalized and the adjusted file is
               written to standard out.  This program may be used
               multiple times in a pipe.

USAGE:         hmm_tweak [OPTIONS] <file.hmm> <cmap.cm>

OPTIONS:
    -f <cats>  Operate on transitions *from* states corresponding to the 
               specified category names (default all)
    -t <cats>  Operate on transitions *to* states corresponding to the 
               specified category names (default all)
    -m <fact>  Multiply transition probabilities by the specified factor.
    -a <const> Add the specified constant to transition probabilities.
    -e <val>   Set transition probabilities equal to the specified value.
    -i <icats> Assume a phylo-HMM indel model for states corresponding to 
               the specified category names.
    -u <tree>  (Required with -i) Assume given tree topology (.nh file).
    -F <gps>   (For use with -i) Operate on transitions from states corresp.
               to the specified gap-pattern numbers (ANDed with -f).
    -T <gps>   (For use with -i) Operate on transitions to states corresp.
               to the specified gap-pattern numbers (ANDed with -t).
    -z         Equalize transition probabilities.  Set all transition
               probabilities indicated by -f/-t/-F/-T to their overall
               average value.  Options -m and/or -a can be used to adjust
               this average value.
    -R         Restrict to successive transitions within a category range.
    -y         Like -z, except compute separate averages for five classes
               of transitions, based on the gap patterns of the states
               involved: between null gap patterns, between equal
               non-null gap patterns, from null to non-null gap
               patterns, from non-null to null gap patterns, and all
               others.  Useful with the indel model when training data
               is sparse (e.g., for splice-site states).  Options -m and -a
               will be applied to transitions of the 3rd and 5th classes
               described.
    -h         Print this help message.
```


## phast_modfreqs

### Tool Description
Change background frequencies of reversible tree model in such a way that reversibility is maintained.

### Metadata
- **Docker Image**: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
- **Homepage**: http://compgen.cshl.edu/phast/
- **Package**: https://anaconda.org/channels/bioconda/packages/phast/overview
- **Validation**: PASS

### Original Help Text
```text
PROGRAM: modFreqs

DESCRIPTION: Change background frequencies of reversible tree model in such
a way that reversibility is maintained.

USAGE: modFreqs tree.mod <Afreq> <Cfreq> <Gfreq> <Tfreq> > new.mod
        OR
       modFreqs tree.mod <G+Cfreq> > new.mod

OPTIONS:
    --help, -h
        Print this help message.
```


## phast_msa_split

### Tool Description
Partitions a multiple sequence alignment either at designated columns, or according to specified category labels, and outputs sub-alignments for the partitions.

### Metadata
- **Docker Image**: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
- **Homepage**: http://compgen.cshl.edu/phast/
- **Package**: https://anaconda.org/channels/bioconda/packages/phast/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: msa_split [OPTIONS] <fname> 

DESCRIPTION:

    Partitions a multiple sequence alignment either at designated
    columns, or according to specified category labels, and outputs
    sub-alignments for the partitions.  Optionally splits an
    associated annotations file.

EXAMPLES:

    (See below for details on options)

    1. Read an alignment for a whole human chromosome from a MAF file
    and extract sub-alignments in 1Mb windows overlapping by 1kb.  Use
    sufficient statistics (SS) format for output (can be used by
    phyloFit, phastCons, or exoniphy).  Set window boundaries between
    alignment blocks, if possible.

        msa_split chr1.maf --refseq chr1.fa --in-format MAF \
            --windows 1000000,1000 --out-format SS \
            --between-blocks 5000 --out-root chr1

    (Windows will be defined using the coordinate system of the first
    sequence in the alignment, assumed to be the reference sequence;
    output will be to chr1.1-1000000.ss, chr1.999001-1999000.ss, ...)

    2. As in (1), but report unordered sufficient statistics (much
    more compact and adequate for use with phyloFit).

        msa_split chr1.maf --refseq chr1.fa --in-format MAF \
            --windows 1000000,1000 --out-format SS \
            --between-blocks 5000 --out-root chr1 --unordered-ss

    3. Extract sub-alignments of sites in conserved elements and not
    in conserved elements, as defined by a BED file (coordinates
    assumed to be for 1st sequence).  Read multiple alignment in FASTA
    format.

        msa_split mydata.fa --features conserved.bed --by-category \
            --out-root mydata

    (Output will be to mydata.background-0.fa and mydata.bed_feature-1.fa
    [latter has sites of category number 1, defined by bed file]

    3. Extract sub-alignments of sites in each of the three codon
    positions, as defined by a GFF file (coordinates assumed to be for
    1st sequence).  Reverse complement genes on minus strand.

        msa_split chr22.maf --in-format MAF --features chr22.gff \
            --by-category --catmap "NCATS 3 ; CDS 1-3" --do-cats CDS \
            --reverse-compl --out-root chr22 --out-format SS

    (Output will be to chr22.cds-1.ss, chr22.cds-2.ss, chr22.cds-3.ss)

    4. Split an alignment into pieces corresponding to the genes in a
    GFF file.  Assume genes are defined by the tag "transcript_id".

        msa_split cftr.fa --features cftr.gff --by-group transcript_id

    5. Obtain a sub-alignment for each of a set of regulatory regions,
    as defined in a BED file.

        msa_split chr22.maf --in-format MAF --refseq chr22.fa \
	    --features chr22.reg.bed --for-features \
	    --out-root chr22.reg

OPTIONS:

 (Splitting options)
    --windows, -w <win_size,win_overlap>
        Split the alignment into "windows" of size <win_size> bases,
        overlapping by <win_overlap>.

    --by-category, -L
        (Requires --features) Split by category, as defined by
        annotations file and (optionally) category map (see
        --catmap)

    --by-group, -P <tag>
        (Requires --features) Split by groups in annotation file,
        as defined by specified tag.  Splits midway between every
        pair of consecutive groups.  Features will be sorted by group.
        There should be no overlapping features (see 'refeature
        --unique').

    --for-features, -F
        (Requires --features) Extract section of alignment
        corresponding to every feature.  There will be no output for
        regions not covered by features.

    --by-index, -p <indices>
        List of explicit indices at which to split alignment
        (comma-separated).  If the list of indices is "10,20",
        then sub-alignments will be output for sites 1-9, 10-19, and
        20-<msa_len>.  Note that the indices are relative to the 
        input alignment, and not necessarily in genomic coordinates.

    --npartitions, -n <number>
        Split alignment equally into specified number of partitions.

    --between-blocks, -B <radius>
        (Not for use with --by-category or --for-features) Try to
        partition at sites between alignment blocks.  Assumes a
        reference sequence alignment, with the first sequence as the
        reference seq (as created by multiz).  Blocks of 30 sites with
        gaps in all sequences but the reference seq are assumed to
        indicate boundaries between alignment blocks.  Partition
        indices will not be moved more than <radius> sites.

    --features, -g <fname>
        (For use with --by-category, --by-group, --for-features, or 
	--windows) Annotations file.  May be GFF, BED, or genepred
        format.  Coordinates are assumed to be in the coordinate frame of 
        the first sequence in the alignment (assumed to be the reference
        sequence).

    --catmap, -c <fname>|<string>
        (Optionally use with --by-category) Mapping of feature types
        to category numbers.  Can either give a filename or an
        "inline" description of a simple category map, e.g.,
        --catmap "NCATS = 3 ; CDS 1-3" or --catmap "NCATS = 1 ; UTR
        1".

    --refidx, -d <frame_index>
        (For use with --windows or --by-index) Index of frame of
        reference for split indices.  Default is 1 (1st sequence
        assumed reference).

 (File names & formats, type of output, etc.)
    --in-format, -i FASTA|PHYLIP|MPM|MAF|SS
        Input alignment file format.  Default is to guess format from 
        file contents.

    --refseq, -M <fname>
        (For use with --in-format MAF) Name of file containing
        reference sequence, in FASTA format.

    --out-format, -o FASTA|PHYLIP|MPM|SS
        Output alignment file format.  Default is FASTA.

    --out-root, -r <name>
        Filename root for output files (default "msa_split").

    --sub-features, -f
	(For use with --features)  Output subsets of features
	corresponding to subalignments.  Features overlapping
	partition boundaries will be discarded.  Not permitted with
	--by-category.

    --reverse-compl, -s
        Reverse complement all segments having at least one feature on
        the reverse strand and none on the positive strand.  For use
        with --by-group.  Can also be used with --by-category to ensure
        all sites in a category are represented in the same strand
        orientation.

    --gap-strip, -G ALL|ANY|<seqno>
        Strip columns in output alignments containing all gaps, any
        gaps, or gaps in the specified sequence (<seqno>; indexing
        begins with one).  Default is not to strip any columns.

    --seqs, -l <seq_list>
        Include only specified sequences in output.  Indicate by 
        sequence number or name (numbering starts with 1 and is
        evaluated *after* --order is applied).

    --exclude, -x
        Exclude rather than include specified sequences.

    --order, -O <name_list>
        Change order of rows in alignment to match sequence names
        specified in name_list.  If a name appears in name_list but
        not in the alignment, a row of gaps will be inserted.

    --min-informative, -I <n> 
        Only output alignments having at least <n> informative sites
        (sites at which at least two non-gap and non-N gaps are present).

    --do-cats, -C <cat_list>
        (For use with --by-category) Output sub-alignments for only the
        specified categories (column-delimited list).

    --tuple-size, -T <tuple_size>
        (for use with --by-category or --out-format SS) Size of tuples
        of columns to consider in downstream analysis (e.g., with
        context-dependent phylogenetic models; see 'phyloFit').  With
        --by-category, insert tuple_size-1 columns of missing data
        between sites that were not adjacent in the original alignment,
        to avoid creating artificial context.  With --out-format SS,
        express sufficient statistics in terms of tuples of specified size.

    --unordered-ss, -z  
        (For use with --out-format SS)  Suppress the portion of the
        sufficient statistics concerned with the order in which columns
        appear.

    --summary, -S 
        Output summary of each output alignment to a file with suffix
        ".sum" (includes base frequencies and numbers of gapped columns).

 (Other)
    --quiet, -q
        Proceed quietly.

    --help, -h
        Print this help message.
```


## phast_pbsencode

### Tool Description
Produce an approximate binary encoding of a probabilistic biological sequence (PBS).

### Metadata
- **Docker Image**: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
- **Homepage**: http://compgen.cshl.edu/phast/
- **Package**: https://anaconda.org/channels/bioconda/packages/phast/overview
- **Validation**: PASS

### Original Help Text
```text
PROGRAM: pbsEncode

USAGE: pbsEncode [OPTIONS] input.probs codefile > output.bin

DESCRIPTION: 

    Produce an approximate binary encoding of a probabilistic
    biological sequence (PBS), as defined by a text file
    ("input.probs") with a row for each position in the sequence and a
    column for each base.  The (i,j)th value in this table should be
    the probability of base j at position i.  Columns should be
    white-space delimited.  The encoding will be as defined by
    "codefile", which should be in the format used by pbsTrain.

    This program performs the inverse function of pbsDecode.

EXAMPLE:

    Encode the probabilities in a file "anc.human-mouse.probs",
    produced by prequel, using a code file "mammals.code", produced by
    pbsTrain.

	pbsEncode anc.human-mouse.probs mammals.code > anc.human-mouse.bin

OPTIONS:

    --discard-gaps, -G
	Discard gaps in the PBS.  Gaps in the input data are assumed
	to be represented by rows consisting of a single "-" character.

    --help, -h
	Produce this help message.
```


## phast_pbstrain

### Tool Description
Estimate a discrete encoding scheme for probabilistic biological sequences (PBSs) based on training data.

### Metadata
- **Docker Image**: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
- **Homepage**: http://compgen.cshl.edu/phast/
- **Package**: https://anaconda.org/channels/bioconda/packages/phast/overview
- **Validation**: PASS

### Original Help Text
```text
PROGRAM: pbsTrain

USAGE: pbsTrain [OPTIONS] file.stats > file.code

DESCRIPTION: 

    Estimate a discrete encoding scheme for probabilistic biological
    sequences (PBSs) based on training data.  Input file should be a
    table of probability vectors, with a row for each distinct vector,
    and a column of counts (positive integers) followed by d columns
    for the elements of the d-dimensional probability vectors (see
    example below).  It may be produced with 'prequel' using the
    --suff-stats option.  Output is a code file that can be used with
    pbsEncode, pbsDecode, etc.  By default, a code of size 255 is
    created, so that encoded PBSs can be represented with one byte per
    position (the 256th letter in the code is reserved for gaps).  The
    --nbytes option allows larger codes to be created, if desired.

    The code is estimated by a two-part procedure designed to minimize
    the "training error" (defined as the total KL divergence) of the
    encoded training data with respect to the original training data.
    First, a "grid" is defined for the probability simplex,
    partitioning it into regions that intersect "cells" (hypercubes)
    in a matrix in d-dimensional space.  This grid has n "rows" per
    dimension.  By default, n is given the largest possible value such
    that the number of simplex regions is no larger than the target
    code size, but smaller values of n can be specified using --nrows.
    Each simplex region is assigned a letter in the code, and the
    representative point for that letter is set equal to the mean
    (weighted by the counts) of all vectors in the training data that
    fall in that region.  This can be shown to minimize the training
    error for this initial encoding scheme.  (If no vectors fall in a
    region, then the representative point is set equal to the centroid
    of the region, which can be shown to minimize the expected KL
    divergence of points uniformly distributed in the region.)

    In the second part of the estimation procedure, the remaining
    letters in the code are defined by a greedy algorithm, which
    attempts to further minimize the training error.  Briefly, on
    each step, the simplex region with the largest contribution to the
    total error is identified, and the next letter in the code is
    assigned to that region.  In this new encoding, there are multiple
    letters, hence multiple representative points, per region; the
    representative point for a given vector is taken to be the
    closest, in terms of KL divergence, of the representative points
    associated with the simplex region in which that vector falls.
    When a new representative point is added to a region, all
    representative points for that region are reoptimized using a
    k-means type algorithm.  This procedure is repeated, letter by
    letter, until the number of code letters equals the target code
    size.

EXAMPLES:

    Generate training data using prequel:
	prequel --suff-stats mammals.fa mytree.mod training

    A file called "training.stats" will be generated.  It will look
    something like this:

        #count  p(A)    p(C)    p(G)    p(T)
	170085  0.043485        0.797886        0.029534        0.129096
	158006  0.191119        0.046081        0.695205        0.067595
	221937  0.047309        0.122834        0.043852        0.786004
	221585  0.781156        0.044520        0.126179        0.048146
	159472  0.067254        0.697947        0.045959        0.188840
	...

    Now estimate a code from the training data:
	pbsTrain training.stats > mammals.code

    The code file contains some metadata followed by a list of code
    indices and representative points, e.g.,

	##NROWS = 7
	##DIMENSION = 4
	##NBYTES = 1
	##CODESIZE = 255

	# Code generated by pbsTrain, with argument(s) "training.stats"
	# acs, Mon Jul 18 23:29:07 2005

	# Average training error = 0.001298 bits

	# Each index of the code is shown below with its representative probability
	# vector (p1, p2, ..., pd).

	#code_index p1 p2 ...
	0       0.107143        0.107143        0.107143        0.678571
	1       0.033226        0.093854        0.031987        0.840933
	2       0.000059        0.001645        0.000111        0.998185
	3       0.139270        0.021059        0.278993        0.560678
	...

    The reported "average training error" is the training error
    divided by the number of data points (the sum of the counts).

OPTIONS:

    --nrows, -n <n>  
	Number of "rows" per dimension in the simplex grid.  Default
	is maximum possible for code size.

    --nbytes, -b <b>  
	Number of bytes per encoded probabilistic base (default 1).
	The size of the code will be 256^b - 1 (one letter in the code
	is reserved for gaps).  Values as large as 4 are allowed for
	b, but in the current implementation, performance
	considerations effectively limit it to 2 or 3.

    --no-greedy, -G 
	Skip greedy optimization -- just assign a single
	representative point to each region of the probability
	simplex, equal to the (weighted) mean of all vectors from the
	training data that fall in that region.

    --no-train, -x <dim> 
	Ignore the data entirely; just use the centroid of each
	simplex partition.  The dimension of the simplex must be given
	(<dim>) but no data file is required.

    --log, -l <file> 
	write log of optimization procedure to specified file.

    --help, -h
	Print this help message.
```


## phast_phastbias

### Tool Description
Identify regions of the alignment which are affected by GC-biased gene conversion (gBGC) on a branch of the tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
- **Homepage**: http://compgen.cshl.edu/phast/
- **Package**: https://anaconda.org/channels/bioconda/packages/phast/overview
- **Validation**: PASS

### Original Help Text
```text
PROGRAM: phastBias

USAGE: phastBias [OPTIONS] alignment neutral.mod foreground_branch > scores.wig

    The alignment file can be in any of several file formats (see
    --msa-format).  The neutral model must be in the .mod format
    produced by the phyloFit program.  The foreground_branch should
    identify a branch of the tree (internal branches can be named
    with tree_doctor --name-ancestors).

DESCRIPTION:

    Identify regions of the alignment which are affected by gBGC,
    indicated by a cluster of weak-to-strong (A/T -> G/C) substitutions
    amidst a deficit of strong-to-weak substitutions on a particular
    branch of the tree.  The regions are identified by a phylo-HMM
    with four states: neutral, conserved, neutral with gBGC, and
    conserved with gBGC.

OUTPUT:

    phastBias produces a wig file with scores for every position in the
    alignment indicating the probability of being in one of the gBGC
    states.  It can also produce gBGC tracts by thresholding this
    probability at 0.5, or a matrix of probabilities for all four states.
    See OUTPUT OPTIONS below.

GENERAL OPTIONS:

    --help,-h
       Print this help message.
 
TUNING PARAMETER OPTIONS:

  gBGC PARAMETERS:

    --bgc <B>
      The B parameter describes the strength of gBGC.  It must be > 0.
        Too low of a value may yield false positives, as the gBGC model 
        becomes indistinguishable from the non-gBGC model.
      Default: 3

    --estimate-bgc <0|1>
      Use "--estimate-bgc 1" to estimate B by maximum likelihood.
      Default: 0

    --bgc-exp-length <length>
      Set the prior expected length of gBGC tracts.  This is equivalent to
        1/alpha in the parametrization defined by Capra et al, where
        alpha is the rate out of gBGC states.
      Default: 1000

    --estimate-bgc-exp-length <0|1>
      Use "--estimate-bgc-exp-length 1" to estimate this parameter by an
        expectation-maximization algorithm.
      Default: 0

    --bgc-target-coverage <coverage>
      Set the prior for gBGC tract coverage (as a fraction between 0 and 1).
        This is represented in the model as beta/(alpha+beta), where beta
        is the rate into the gBGC state, and alpha is the rate out of the
        gBGC state.
      Default: 0.01

    --estimate-bgc-target-coverage <0|1>
      Use "--estimate-bgc-target-coverage 0" to hold this parameter constant.
      Default: 1 (This is the only parameter estimated by default.)

  CONSERVATION PARAMETERS:
     Note: it is not recommended to tune these parameters with phastBias.
       Rather, phastCons may be used to determine the best values for rho
       and the transition rates into/out of conserved elements.  See
       phastCons --help and the phastCons HOWTO (available online) to learn
       about tuning these parameters.

    --rho <rho>
      Set the scaling factor for branch lengths in conserved states.  Rho should
        be between 0 and 1.
      Default: 0.31
    
    --cons-exp-length <length>
      Set the prior expected length of conserved elements.  This parameter is
        held constant; if you want to tune it, it is recommended to do this
        with the phastCons program under a non-gBGC model (see the 
        --expected-length option in phastCons).
      Default: 45

    --cons-target-coverage <cov>
      Set the prior for coverage of conserved elements (as a fraction 
        between 0 and 1).  Like the --cons-exp-length above, this parameter
        is also held constant, but can be tuned with phastCons (see
        phastCons --transitions).
      Default: 0.3

  OTHER PARAMETERS:

    --scale <scale>
      Set an overall scaling factor for the branch lengths in all states.
      Default: 1

    --estimate-scale <0|1>
      Rescale the branches in all states by a scaling factor determined by
        maximum likelihood (initialized by --scale above).
      Default: 0

    --eqfreqs-from-msa <0|1>
      Reset equilibrium frequencies of A,C,G,T based on frequencies observed
         in the alignment.  Otherwise will not be altered from input model.
      Default: 1


OUTPUT OPTIONS:
    --output-tracts <file.gff>
       Print a GFF file identifying all regions with posterior probability of
       being in a gBGC state > 0.5.

    --posteriors <none|wig|full>
       Use this option to control posterior probability output, which is 
         written to stdout.  "none" implies do not output anything; wig outputs
         a standard fixed-step wiggle file giving the probability that each
         base is assigned to a gBGC state; "full" outputs a table with five
         columns.  The first column is the coordinate (1-based relative to
         the first sequence in the alignment), followed by the probabilities
         of each of the four states: neutral, conserved, gBGC neutral, 
         gBGC conserved.
       Default: wig

    --output-mods <output_root>
       Print out the tree models for all four states to <output_root>.cons.mod,
       <output_root>.neutral.mod, <output_root>.gBGC_cons.mod, and
       <output_root>.gBGC_neutral.mod.

    --informative-fn,-i <file.gff>
       Print a GFF containing regions of the alignment which are informative
       for gBGC. Note: only works properly if foreground branch is a single
       branch (not a group of branches). 

    --informative-only,-o
      (To be used with --informative-fn). Print the informative regions, then
      quit.


REFERENCES:

    Capra JA, Hubisz MJ, Kostka D, Pollard KS, Siepel A: A Model-Based Analysis
       of GC-Biased Gene Conversion in the Human and Chimpanzee Genomes.
       (Manuscript in submission).
```


## phast_phastmotif

### Tool Description
Predicts motifs from a set of multiple alignments, using phylogenetic models.

### Metadata
- **Docker Image**: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
- **Homepage**: http://compgen.cshl.edu/phast/
- **Package**: https://anaconda.org/channels/bioconda/packages/phast/overview
- **Validation**: PASS

### Original Help Text
```text
PROGRAM:      phastMotif

DESCRIPTION:  Predicts motifs from a set of multiple alignments.  Uses
              an EM algorithm similar to that of MEME, but a motif is
              defined by phylogenetic models rather than multinomial
              distributions.  The specified multiple alignments may
              actually be single sequences (see -m).  Various parameters
              control the strategy for initialization (see below).
              Currently, the F81 substitution model is assumed.

USAGE:        phastMotif [-t <treefile>] [OPTIONS] <msa_list>

OPTIONS:
    -t <file> (Required unless -m or -p) Use specified tree topology for
              all phylogenetic models (Newick format).

    -i <fmt>  Input format for alignment.  May be FASTA, PHYLIP, MPM, SS,
              or MAF (default FASTA).

    -b <file> Read background model from specified file (.mod format).
              By default, the background model is estimated
              in a preprocessing step, by pooling all data.

    -k <size> Learn motifs of the specified size (default is 10).

    -B <n>    Report best <n> motifs (default 3).

    -m        MEME mode.  Use multinomial rather than phylogenetic
              models.  Causes multiple alignments to be ignored -- any
              gaps are discarded and all sequences are assumed
              independent.

    -d <+lst> Use the discriminative training method of Segal et
              al. (RECOMB'02), rather than EM.  The specified list
              should contain the filenames from msa_list that are to
              be considered *positive* examples (containing the
              desired motif); all others will be considered negative
              examples.  Can be used with or without -m.

    -p        Use "profile" models rather than phylogenetic models
              (characters in each alignment column assumed
              independent).  The resulting model is a hybrid of the
              full model and MEME's model.  Essentially, it uses the
              multiple alignments but not the phylogeny.  NOT YET IMPLEMENTED.

    -n <n>    Perform <n> random restarts and report the motif with highest
              likelihood.  Default number is 10.  Ignored with -I, -P, and
              -R unless -S is specified (see below).

    -I <mlst> Run the algorithm after a "soft" initialization with
              each of the consensus sequences in the specified list.
              At each position, <pc> pseudocounts (see -c) are given
              to the consensus base and 1 pseudocount to all other
              bases.  Each string must have length at most equal to
              the size of the motif.  If shorter, it is used as a
              "seed" for a motif, with flanking positions treated as
              wildcards.

    -P <x,y>  Initialize with the x most prevalent y-tuples.  A soft
              initialization is performed, as above.  If y is less
              than the motif size, y-tuples are used as a "seed" for
              a motif, as above.

    -R <x,y>  Initialize with a random sample of x y-tuples.  A soft
              initialization is performed, as above.  If y is less
              than the motif size, y-tuples are used as a "seed" for
              a motif, as above.

    -w <n>    (for use with -I, -P, -R) Winnow initialization sequences
              to the top <n> based on the unmaximized likelihood.

    -c <pc>   (for use with -I, -P, -R) Number of pseudocounts for
              consensus bases (default 5).

    -S        (for use with -I, -P, -R) Instead of doing a deterministic
              initialization based on a consensus sequence, sample
              parameters from a Dirichlet distribution defined by the
              pseudocounts (see -c).  In this case, random restarts
              are performed, as specified by -n.

    -o <pref> Use the specified prefix for all output files (dflt. "phastm").
    -H        Produce HTML formatted output, in addition to ordinary output.
              One file is produced per predicted motif, as well as a 
              single HTML-formatted summary file.

    -D        Produce a BED file with predicted motifs, for use in the 
              UCSC browser.  Currently, sequence names must be
              formatted such as "chr10:102553847-102554897+", with
              the final '+' or '-' indicating strand.

    -x        (For use with -H or -D) Suppress ordinary output to stdout.

    -h        Print this help message.
```


## phast_phylofit

### Tool Description
Fits one or more tree models to a multiple alignment of DNA sequences by maximum likelihood.

### Metadata
- **Docker Image**: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
- **Homepage**: http://compgen.cshl.edu/phast/
- **Package**: https://anaconda.org/channels/bioconda/packages/phast/overview
- **Validation**: PASS

### Original Help Text
```text
PROGRAM: phyloFit

DESCRIPTION: 

    Fits one or more tree models to a multiple alignment of DNA
    sequences by maximum likelihood, using the specified tree topology
    and substitution model.  If categories of sites are defined via
    --features and --catmap (see below), then a separate model will be
    estimated for each category.  A description of each model will
    be written to a separate file, with the suffix ".mod".  These
    .mod files minimally include a substitution rate matrix, a tree with
    branch lengths, and estimates of nucleotide equilibrium
    frequencies.  They may also include information about parameters
    for modeling rate variation.

USAGE: phyloFit [OPTIONS] <msa_fname>

    <msa_fname> should be a multiple alignment in FASTA format or
    one of several alternative formats (see --msa-format).  For
    backward compatibility, this argument may be preceded by '-m' or
    '--msa'.  Note that --tree is required in most cases.  By default,
    all output files will have the prefix "phyloFit" (see
    --out-root).

EXAMPLES:

    (If you're like me, you want some basic examples first, and a list
    of all options later.)

    1. Compute the distance between two aligned sequences (in FASTA file
    pair.fa) under the REV model.

        phyloFit pair.fa

    (output is to phyloFit.mod; distance in substitutions per site
    appears in the TREE line in the output file)

    2. Fit a phylogenetic model to an alignment of human, chimp, mouse,
    and rat sequences.  Use the HKY85 substitution model.  Write output
    to files with prefix "myfile".

        phyloFit --tree "((human,chimp),(mouse,rat))" --subst-mod HKY85
            --out-root myfile primate-rodent.fa

    3. As above, but use the discrete-gamma model for rate variation,
    with 4 rate categories.

        phyloFit --tree "((human,chimp),(mouse,rat))" --subst-mod HKY85
            --out-root myfile --nrates 4 primate-rodent.fa

    4. As above, but use genome-wide data, stored in the compact
    "sufficient-statistics" format (can be produced with "msa_view
    -o SS").

        phyloFit --tree "((human,chimp),(mouse,rat))" --subst-mod HKY85
            --out-root myfile --nrates 4 --msa-format SS 
            primate-rodent.ss

    5. Fit a context-dependent phylogenetic model (U2S) to an
    alignment of human, mouse, and rat sequences.  Use
    an EM algorithm for parameter optimization and relax the
    convergence criteria a bit (recommended with context-dependent
    models).  Write a log file for the optimization procedure.
    Consider only non-overlapping pairs of sites.

        phyloFit --tree "(human,(mouse,rat))" --subst-mod U2S --EM
            --precision MED --non-overlapping --log u2s.log --out-root
            hmr-u2s hmr.fa

    6. As above, but allow overlapping pairs of sites, and compute
    likelihoods by assuming Markov-dependence of columns (see Siepel &
    Haussler, 2004).  The EM algorithm can no longer be used
    (optimization will be much slower).

        phyloFit --tree "(human,(mouse,rat))" --subst-mod U2S
            --precision MED --log u2s-markov.log --markov hmr.fa

    7. Compute a likelihood using parameter estimates obtained in (5)
    and an assumption of Markov dependence.  This provides a lower
    bound on the likelihood of the Markov-dependent model.

        phyloFit --init-model hmr-u2s.mod --lnl --markov hmr.fa

    8. Given an alignment of several mammalian sequences (mammals.fa), a
    tree topology (tree.nh), and a set of gene annotations in GFF
    (genes.gff), fit separate models to sites in 1st, 2nd, and 3rd
    codon positions.  Use the REV substitution model.  Assume coding
    regions have feature type 'CDS'.

        phyloFit --tree tree.nh --features genes.gff --out-root mammals-rev
            --catmap "NCATS = 3; CDS 1-3" --do-cats 1,2,3 mammals.fa

    (output will be to mammals-rev.cds-1.mod, mammals-rev.cds-2.mod, and 
    mammals-rev.cds-3.mod)


OPTIONS:

    --tree, -t <tree_fname>|<tree_string>
        (Required if more than three species, or more than two species
        and a non-reversible substitution model, e.g., UNREST, U2, U3)
        Name of file or literal string defining tree topology.  Tree
        must be in Newick format, with the label at each leaf equal to
        the index or name of the corresponding sequence in the alignment
        (indexing begins with 1).  Examples: --tree "(1,(2,3))", 
        --tree "(human,(mouse,rat))".  Currently, the topology must be
        rooted.  When a reversible substitution model is used, the root
        is ignored during the optimization procedure.

    --subst-mod, -s JC69|F81|HKY85|HKY85+Gap|REV|SSREV|UNREST|R2|R2S|U2|U2S|R3|R3S|U3|U3S
        (default REV).  Nucleotide substitution model.  JC69, F81, HKY85
        REV, and UNREST have the usual meanings (see, e.g., Yang, 
        Goldman, and Friday, 1994).  SSREV is a strand-symmetric version
        of REV.  HKY85+Gap is an adaptation of HKY that treats gaps as a 
        fifth character (courtesy of James Taylor).  The others, all
	considered "context-dependent", are as defined in Siepel and 
        Haussler, 2004.  The options --EM and --precision MED are 
        recommended with context-dependent models (see below).

    --msa-format, -i FASTA|PHYLIP|MPM|MAF|SS
        (default is to guess format from file contents) Alignment format.  
        FASTA is as usual.  PHYLIP is compatible with the formats used in 
        the PHYLIP and PAML packages.  MPM is the format used by the 
        MultiPipMaker aligner and some other of Webb Miller's older tools.  
        MAF ("Multiple Alignment Format") is used by MULTIZ/TBA and the 
        UCSC Genome Browser.  SS is a simple format describing the 
	sufficient statistics for phylogenetic inference (distinct columns
        or tuple of columns and their counts).  Note that the program
        "msa_view" can be used for file conversion.

    --out-root, -o <output_fname_root>
        (default "phyloFit").  Use specified string as root filename
        for all files created.

    --min-informative, -I <ninf_sites>
        Require at least <ninf_sites> "informative" sites -- i.e., 
        sites at which at least two non-gap and non-missing-data ('N'
        or '*') characters are present.  Default is 50.

    --gaps-as-bases, -G
        Treat alignment gap characters ('-') like ordinary bases.  By
        default, they are treated as missing data.

    --ignore-branches, -b <branches>
        Ignore specified branches in likelihood computations and parameter
        estimation, and treat the induced subtrees as independent.  Can be
        useful for likelihood ratio tests.  The argument <branches> should
        be a comma-separated list of nodes in the tree, indicating the
        branches above these nodes, e.g., human-chimp,cow-dog.  (See
        tree_doctor --name-ancestors regarding names for ancestral nodes.)
        This option does not currently work with --EM.

    --threads, -j <n>
        Set number of OpenMP threads (overrides OMP_NUM_THREADS).
        If OpenMP support is disabled at build time, using this option
        causes an error. If neither this nor OMP_NUM_THREADS is set,
        defaults to 1 thread.

    --quiet, -q
        Proceed quietly.

    --help, -h
        Print this help message.


 (Options for controlling and monitoring the optimization procedure)

    --lnl, -L
        (for use with --init-model) Simply evaluate the log likelihood of
        the specified tree model, without performing any further
        optimization.  Can be used with --post-probs, --expected-subs, and
        --expected-total-subs.

    --EM, -E 
        Fit model(s) using EM rather than the BFGS quasi-Newton
        algorithm (the default).

    --precision, -p HIGH|MED|LOW
        (default HIGH) Level of precision to use in estimating model
        parameters.  Affects convergence criteria for iterative
        algorithms: higher precision means more iterations and longer
        execution time.

    --log, -l <log_fname>
        Write log to <log_fname> describing details of the optimization
        procedure.

    --init-model, -M <mod_fname>
        Initialize with specified tree model.  By choosing good
        starting values for parameters, it is possible to reduce
        execution time dramatically.  If this option is chosen, --tree
        is not allowed.  The substitution model used in the given
        model will be used unless --subst-mod is also specified.  
        Note: currently only one mod_fname may be specified; it will be 
        used for all categories.

    --init-random, -r
        Initialize parameters randomly.  Can be used multiple times to test
        whether the m.l.e. is real.

    --seed, -D <seed>
        Provide a random number seed for choosing initial parameter values
	(usually with --init-random, though random values are used in some
        other cases as well).  Should be an integer >=1.  If not provided,
	seed is chosen based on current time.

    --init-parsimony, -y
        Initialize branch lengths using parsimony counts for given data.
        Only currently implemented for models with single character state
	(ie, not di- or tri-nucleotides).  Other --init options such
	as --init-random or --init-model can be used in conjunction to 
	initialize substitution matrix parameters.

    --print-parsimony, -Y <filename>
        Print parsimony score to given file, and quit.  (Does not optimize
        or report likelihoods).

    --clock, -z
        Assume a molecular clock in estimation.  Causes the distances to all
        descendant leaves to be equal for each ancestral node and cuts the
        number of free branch-length parameters roughly in half.  

    --scale-only, -B
        (for use with --init-model) Estimate only the scale of the tree,
        rather than individual branch lengths (branch proportions fixed).
        Equilibrium frequencies and rate-matrix parameters will still be
        estimated unless --no-freqs and --no-rates are used.

    --scale-subtree, -S <node_name>
        (for use with --scale-only) Estimate separate scale factors for
        subtree beneath identified node and rest of tree.  The branch
        leading to the subtree is included with the subtree.  If ":loss" or
        ":gain" is appended to <node_name>, subtree scale is constrained to
        be greater than or less than (respectively) scale for rest of tree.

    --estimate-freqs, -F
        Estimate equilibrium frequencies by maximum likelihood, rather
        than approximating them by the relative frequencies in the data.
	If using the SSREV model, this option implies --sym-freqs.

    --sym-freqs, -W
        Estimate equilibrium frequencies, assuming freq(A)=freq(T) and
	freq(C)=freq(G).  This only works for an alphabet ACGT (and possibly
	gap).  This option implies --estimate-freqs.

    --no-freqs, -f
        (for use with --init-model) Do not estimate equilibrium
        frequencies; just use the ones from the given tree model.

    --no-rates, -n
        (for use with --init-model) Do not estimate rate-matrix
        parameters; just use the ones from the given tree model.

    --ancestor, -A <seqname>
        Treat specified sequence as the root of the tree.  The tree
        topology must define this sequence to be a child of the root
        (in practice, the branch from the root to the specified
        sequence will be retained, but will be constrained to have
        length zero).

    --error, -e <filename>
	For each parameter, report estimate, variance, and 95%% confidence
        interval, printed to given filename, one parameter per line.

    --no-opt, -O <param_list>
        Hold parameters listed in comma-separated param_list constant at
	initial values.  This applies only to the "main" model, and not to 
	any models defined with the --alt-mod option.  Param list can 
	contain values such as "branches" to hold branch lengths constant,
	"ratematrix", "backgd", or "ratevar" to hold entire rate matrix, 
	equilibrium frequencies, or rate variation parameters constant 
	(respectively).  There are also substitution model-specific 
	parameters such as "kappa" (transition/transversion rate ratio).

        Note: to hold certain branches constant, but optimize others,
        put an exclamation point in the newick-formatted tree after the
        branch lengths that should be held constant.  This can be useful
        for enforcing a star-phylogeny.  However, note that the two branches
        coming from root of tree are treated as one.  So they should both
        be held constant, or not held constant.  This option does *not* work
        with --scale-only or --clock.

    --bound <param_name[lower_bound,upper_bound]>
        Set boundaries for parameter.  lower_bound or upper_bound may be
	empty string to keep default.  For example --bound gc_param[1,] will
	set the lower bound for gc_param to 1 (keeping upper bound at infinity),
	for a GC model.  Only applies to parameters for model in the "main" 
	tree, but similar syntax can be used within the --alt-mod arguments.
    	Can be used multiple times to set boundaries for different parameters.

    --selection <selection_param>
        Use selection in the model (is also implied if --init-model is used
        and contains selection parameter).  Selection scales rate matrix
	entries by selection_param/(1-exp(-selection-param)); this is done
        after rate matrix is scaled to set expected number of substitutions
	per unit time to 1.  If using codon models selection acts only on
	nonysynonymous mutations.


 (Options for modeling rate variation)

    --nrates, -k <nratecats>
        (default 1).  Number of rate categories to use.  Specifying a
        value of greater than one causes the discrete gamma model for
        rate variation to be used (Yang, 1994).

    --alpha, -a <alpha>
        (for use with --nrates).  Initial value for alpha, the shape
        parameter of the gamma distribution.  Default is 1.

    --rate-constants, -K <rate_consts>
        Use a non-parameteric mixture model for rates, instead of
        assuming a gamma distribution.  The argument <rate_consts>
        must be a comma-delimited list explicitly defining the rate
        constants to be used.  The "weight" (mixing proportion)
        associated with each rate constant will be estimated by EM
        (this option implies --EM).  If --alpha is used with
        this option, then the mixing proportions will be initialized
        to reflect a gamma distribution with the specified shape
        parameter.


 (Options for separate handling of sites in different annotation categories)

    --features, -g <fname>
        Annotations file (GFF or BED format) describing features on
        one or more sequences in the alignment.  Together with a
        category map (see --catmap), will be taken to define site
        categories, and a separate model will be estimated for each
        category.  If no category map is specified, a category will be
        assumed for each type of feature, and they will be numbered in
        the order of appearance of the features.  Features are assumed
        to use the coordinate frame of the first sequence in the
        alignment and should be non-overlapping (see 'refeature
        --unique').

    --catmap, -c <fname>|<string>
        (optionally use with --features) Mapping of feature types to
        category numbers.  Can either give a filename or an "inline"
        description of a simple category map, e.g., --catmap "NCATS =
        3 ; CDS 1-3" or --catmap "NCATS = 1 ; UTR 1".  Note that
        category 0 is reserved for "background" (everything that is
        not described by a defined feature type).

    --do-cats, -C <cat_list>
        (optionally use with --features) Estimate models for only the
        specified categories (comma-delimited list categories, by name
        or numbera).  Default is to fit a model for every category.

    --reverse-groups, -R <tag>
        (optionally use with --features) Group features by <tag> (e.g.,
        "transcript_id" or "exon_id") and reverse complement
        segments of the alignment corresponding to groups on the
        reverse strand.  Groups must be non-overlapping (see refeature
        --unique).  Useful with categories corresponding to
        strand-specific phenomena (e.g., codon positions).


 (Options for context-dependent substitution models)

    --markov, -N
        (for use with context-dependent substitutions models and not
        available with --EM.)  Assume Markov dependence of alignment
        columns, and compute the conditional probability of each
        column given its N-1 predecessors using the two-pass algorithm
        described by Siepel and Haussler (2004).  (Here, N is the
        "order" of the model, as defined by --subst-mod; e.g., N=1
        for REV, N=2 for U2S, N=3 for U3S.) The alternative (the
        default) is simply to work with joint probabilities of tuples
        of columns.  (You can ensure that these tuples are
        non-overlapping with the --non-overlapping option.)  The use
        of joint probabilities during parameter estimation allows the
        use of the --EM option and can be much faster; in addition, it
        appears to produce nearly equivalent estimates.  If desired,
        parameters can be estimated without --markov, and
        then the likelihood can be evaluated using --lnl and
        --markov together.  This gives a lower bound on the
        likelihood of the Markov-dependent model.

    --non-overlapping, -V
        (for use with context-dependent substitution models; not
        compatible with --markov, --features, or
        --msa-format SS) Avoid using overlapping tuples of sites
        in parameter estimation.  If a dinucleotide model is selected,
        every other tuple will be considered, and if a nucleotide
        triplet model is selected, every third tuple will be
        considered.  This option cannot be used with an alignment
        represented only by unordered sufficient statistics.

 (Option for lineage-specific models)

   --label-branches branch1,branch2,branch3...:label
        Create a group of branches by giving a set of branches a 
        single label.  The label should be a word which does not 
        contain special characters (in particular, no spaces, brackets,
        parentheses, pound signs, commas, or colons).

        The label is for use with --alt-model option below, so that an 
        alternate model can be defined for a set of branches.  A branch
        is specified by the name of the node which is a descendant of
        that branch.

        For example, 
        --label-branches hg18,chimp,hg18-chimp:HC
        will apply the label "HC" to the hg18,chimp,and hg18-chimp 
        branches in the following tree:
        (((hg18,chimp)hg18-chimp, (mouse,rat)mouse-rat)

        The same label could be defined without using --label-branches
        by specifing the tree (either on the command-line or within
        init-model) as follows:
        (((hg18 # HC, chimp #HC)#HC, (mouse,rat))

   --label-subtree node[+]:label
        Similar to label-branches, except labels the entire subtree
        of the named node.  If the node name is followed by a "+" sign,
        then includes the branch leading up to the node in the subtree.

   --alt-model, -d <label:(model|param_list)>
        Create a lineage-specific substitution model on a group of branches.
        The group is defined by a label, which can be specified within
        the tree string (using the # sign notation), or by using the
        --label-branches or --label-subtree arguments.  If the alt-model
        applies to only a single branch, labelling is not necessary and
        the name of the node descending from the branch can be used instead.  
        See --label-branches above for more details on labelling groups of
        branches.

	If a name of a substitution model (HKY85, REV, UNREST, etc)
	is given after the colon, then this model will be used for the
        group of branches, and parameters relevant to the model will be 
        estimated separately in this group.  This model may be different 
        (or the same) as the model used in the rest of the tree, but it
        must have the same number of states and be of the same order as 
	the model used for the rest of the tree.

	Alternately, a list of parameter names can be given after the colon.
	In this case, the same substitution model will be used for the 
        entire tree, but the parameters listed will be estimated separately 
        in the specified group of branches.

	The parameter names are model-specific, and include "kappa" for
	HKY models, "alpha" for GC models, "ratematrix" to specify
	all rate-matrix parameters in general models, and "backgd" for
	the equilibrium background frequencies.  The parameter names
	may optionally be followed by boundaries in square brackets to
	specify parameter bounds, as described in --bound option.

	The --alt-model argument may be used multiple times, if one
        wishes to (for example) optimize a parameter independently 
        on several different groups of branches.

	Example:
	phyloFit align.fa --subst-mod HKY85 \
	--tree "(human, (mouse#MR, rat#MR)#MR, cow)"\
	--alt-model "MR:kappa[0, 1]"
 
        will estimate the HKY85 parameter kappa separately on the
        mouse/rat subtree, and constrain kappa between 0 and 1.  The
        quotes are often necessary to prevent the square brakcets from
        being parsed by the shell.  The same model could be achieved with:
 
        phyloFit align.fa --subst-mod HKY85 \
        --tree "(human, (mouse,rat)mouse-rat, cow)"\
        --label-branches mouse,rat,mouse-rat:MR \
        --alt-model "MR:kappa[0,1]"

        or

        phyloFit align.fa --subst-mod HKY85 \
        --tree "(human, (mouse,rat)mouse-rat, cow)" \
        --label-subtree "mouse-rat+:MR" \
        --alt-model "MR:kappa[0,1]"

 (Options for posterior probabilities)

    --post-probs, -P
        Output posterior probabilities of all bases at all ancestral 
        nodes.  Output will be to auxiliary file(s) with suffix 
        ".postprobs".

    --expected-subs, -X
        Output posterior expected number of substitutions on each branch at
        each site, summed across all types of substitutions. 
        Output will be to auxiliary file(s) with suffix ".expsub".

    --expected-subs-col, -J
        Output posterior expected number of substitutions of each type
        on each branch, for each site.  Output will be to auxiliary 
        file(s) with suffix .expcolsub

    --expected-total-subs, -Z
        Output posterior expected number of substitutions of each type 
        on each branch, summed across all sites.  Output will be to 
        auxiliary file(s) with suffix ".exptotsub".

    --column-probs, -U
        (for use with -init-model; implies --lnl)  Output a separate log
        probability for each type of column in the input.  Output will
        be to a file with suffix ".colprobs".  Values are log base 2.


 (Options for estimation in sliding window)

    --windows, -w <size,shift>
        Apply a sliding window to the alignment, and fit a separate
        tree to each window.  Arguments specify size of window and
        amount by which to shift it on each iteration, both in bases
        of the first sequence in the alignment (assumed to be the
        reference sequence).  Separate versions of all output files
        will be created for each window.

    --windows-explicit, -v <window_coord_list>
        Like --windows, except that all start and end coordinates must
        be explicitly specified.  Each successive pair of numbers is
        interpreted as defining the start and end of a window.  Can be
        used with a two-column file and the '*' operator, e.g.,
        --windows-explicit '*mycoords'.


REFERENCES:

    A. Siepel and D. Haussler.  2004.  Phylogenetic estimation of
      context-dependent substitution rates by maximum likelihood.
      Mol. Biol. Evol., 21:468-488.

    Z. Yang, N. Goldman, and A. Friday.  1994. Comparison of models for
      nucleotide substution used in maximum likelihood phylogenetic
      estimation. Mol. Biol. Evol., 11:316-324.

    Z. Yang. 1994. Maximum likelihood phylogenetic estimation from
      DNA sequences with variable rates over sites: approximate
      methods. J. Mol. Evol., 39:306-314.
```


## phast_phylop

### Tool Description
Compute conservation or acceleration p-values based on an alignment and a model of neutral evolution.

### Metadata
- **Docker Image**: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
- **Homepage**: http://compgen.cshl.edu/phast/
- **Package**: https://anaconda.org/channels/bioconda/packages/phast/overview
- **Validation**: PASS

### Original Help Text
```text
PROGRAM: phyloP

USAGE: phyloP [OPTIONS] tree.mod [alignment] > out

    The phylogenetic model must be in the .mod format produced by the
    phyloFit program.  The alignment file can be in any of several file
    formats (see --msa-format).  No alignment is required with the --null
    option. 

DESCRIPTION:

    Compute conservation or acceleration p-values based on an alignment and
    a model of neutral evolution.  Will also compute p-values of
    conservation/acceleration in a subtree and in its complementary
    supertree given the whole tree (see --subtree).  P-values can be
    produced for entire input alignments (the default), pre-specified
    intervals within an alignment (see --features), or individual sites
    (see --wig-scores and --base-by-base).

    The default behavior is to compute a null distribution for the total
    number of substitutions from the tree model, an estimate of the number
    of substitutions that have actually occurred, and the p-value of this
    estimate wrt the null distribution.  These computations are performed
    as described by Siepel, Pollard, and Haussler (2006).  In addition to
    the SPH method, phyloP can compute p-values or
    conservation/acceleration scores using a likelihood ratio test
    (--method LRT), a score-based test (--method SCORE), or a procedure
    similar to that used by GERP (Cooper et al., 2005) (--method GERP).
    These alternative methods are currently supported only with
    --base-by-base, --wig-scores, or --features.

    The main advantage of the SPH method is that it can provide a complete
    and exact description of distributions over numbers of substitutions.
    However, simulation experiments suggest that the LRT and SCORE methods
    have somewhat better power than SPH for identifying selection,
    especially when the expected number of substitutions is small (e.g.,
    with short branch lengths and/or short intervals/individual sites).
    These two methods are also faster.  They are generally similar to one
    another in power, but in many cases SCORE is considerably faster than
    LRT.  On the other hand, SCORE appears to have slightly less power than
    LRT at low false positive rates, i.e., for cases of extreme selection.
    Thus, when using --base-by-base, --wig-scores, or --features, LRT is
    recommended for most purposes, but SCORE is a good alternative if speed
    is an issue.

    When computing p-values with the SPH method, the default is to use the
    posterior expected number of substitutions as an estimate of the actual
    number.  This is a conservative estimate, because it is biased toward
    the mean of the null distribution by the prior.  These p-values can be
    made less conservative with --fit-model and more conservative with
    --confidence-interval (see below).

EXAMPLES:

    1. Using the SPH method, compute and report p-values of conservation
    and acceleration for a given alignment with respect to a neutral model
    of evolution.  Estimated numbers of substitutions are also reported.

        phyloP neutral.mod alignment.fa > report.txt

    The file neutral.mod could be produced by running phyloFit on data from
    ancestral repeats or fourfold degenerate sites with an appropriate tree
    topology and substitution model.

    2. Compute and report p-values of conservation and acceleration for a
    particular subtree of interest (using SPH).

        phyloP --subtree human-mouse_lemur neutral.mod alignment.fa > report.txt

    Here human-mouse_lemur denote the most recent common ancestor of human
    and mouse_lemur, which is the node that defines the primate clade in
    this phylogeny.  The tree_doctor program with the --name-ancestors
    option can be used to assign names to ancestral nodes of the tree.

    3. Describe the complete null distribution over the number of
    substitutions for a 10bp alignment given the specified neutral model
    (using SPH).

        phyloP --null 10 neutral.mod > null.txt

    A two-column table is produced with numbers of substitutions and their
    probabilities, up to an appropriate upper limit.

    4. Describe the complete posterior distribution over the number of
    substitutions in a given alignment (using SPH).

        phyloP --posterior neutral.mod alignment.fa > posterior.txt

    5. Compute conservation scores (-log10 p-values) for each site in an
    alignment and output them in the fixed-step wig format (see
    http://genome.ucsc.edu/goldenPath/help/wiggle.html).  Use the
    likelihood ratio test (LRT) method.

        phyloP --wig-scores --method LRT neutral.mod alignment.fa > scores.wig

    The --mode option can be used instead to produce acceleration scores
    (ACC), scores of nonneutrality (NNEUT), or scores that summarize
    conservation and acceleration (CONACC).  The --base-by-base option can
    be used to output additional statistics of interest (estimated scale
    factors, log10 likelihood ratios, etc.).  As discussed above, several
    arguments to --method are possible.
    
    6. Similarly, compute scores describing lineage-specific conservation
    in primates.

        phyloP --wig-scores --method LRT --subtree human-mouse_lemur \
            neutral.mod alignment.fa > scores.wig

    7. Compute conservation p-values and associated statistics for each
    element in a BED file.  This time use a score test and allow for
    acceleration as well as conservation, flagging elements under
    acceleration by making their p-values negative (CONACC mode).

        phyloP --features elements.bed --method SCORE --mode CONACC \
            neutral.mod alignment.fa > element-scores.txt

    This option can also be used with --subtree.  The --gff-scores option
    can be used to output the original features in GFF format with scores
    equal to -log10 p.  Note that the input file can be in GFF instead of BED
    format.

OPTIONS:

    --msa-format, -i FASTA|PHYLIP|MPM|MAF|SS
        Alignment format (default is to guess format from file contents).

    --method, -m SPH|LRT|SCORE|GERP
        Method used to compute p-values or conservation/acceleration scores
        (Default SPH).  The likelihood ratio test (LRT) and score test
        (SCORE) compare an alternative model having a free scale parameter
        with the given neutral model, or, if --subtree is used, an
        alternative model having free scale parameters for the supertree
        and subtree with a null model having a single free scale parameter.
        P-values are computed by comparing test statistics with asymptotic
        chi-square null distributions.  The GERP-like method (GERP)
        estimates the number of "rejected substitutions" per base by
        comparing the (per-site) maximum likelihood expected number of
        substitutions with the expected number under the neutral model.
        Currently LRT, SCORE, and GERP can be used only with
        --base-by-base, --wig-scores, or --features.

    --wig-scores, -w
        Compute separate p-values per site, and then compute site-specific
        conservation (acceleration) scores as -log10(p).  Output base-by-base
        scores in fixed-step wig format, using the coordinate system of the
        reference sequence (see --refidx).  In GERP mode, outputs rejected
        substitutions per site instead of -log10 p-values.

    --base-by-base, -b
        Like --wig-scores, but outputs multiple values per site, in a
        method-dependent way.  With 'SPH', output includes mean and
        variance of posterior distribution, with LRT and SCORE it
        includes the estimated scale factor(s) and test statistics, and
        with GERP it includes the estimated numbers of neutral,
        observed, and rejected substitutions, along with the number of
        species available at each site.

    --refidx, -r <refseq_idx>
        (for use with --wig-scores or --base-by-base) Use coordinate frame
        of specified sequence in output.  Default value is 1, first
        sequence in alignment; 0 indicates coordinate frame of entire
        multiple alignment.

    --mode, -o CON|ACC|NNEUT|CONACC
        (For use with --wig-scores, --base-by-base, or --features) Whether
        to compute one-sided p-values so that small p (large -log10 p)
        indicates unexpected conservation (CON; the default) or
        acceleration (ACC); or two-sided p-values such that small p
        indicates an unexpected departure from neutrality (NNEUT).  The
        fourth option (CONACC) uses positive values (p-values or scores) to
        indicate conservation and negative values to indicate acceleration.
        In GERP mode, CON and CONACC both report the number of rejected
        substitutions R (which may be negative), while ACC reports -R, and
        NNEUT reports abs(R).

    --features, -f <file>
        Read features from <file> (GFF or BED format) and output a
        table of p-values and related statistics with one row per
        feature.  The features are assumed to use the coordinate frame
        of the first sequence in the alignment.  Not for use with
        --null or --posterior.  See also --gff-scores.

    --gff-scores, -g
        (For use with features)  Instead of a table, output a GFF and
        assign each feature a score equal to its -log10 p-value.

    --subtree, -s <node-name>
        (Not available in GERP mode) Partition the tree into the subtree
        beneath the node whose name is given and the complementary
        supertree, and consider conservation/acceleration in the subtree
        given the supertree.  The branch above the specified node is
        included with the subtree.  Thus, given the tree
        "((human,chimp)primate,(mouse,rat)rodent)", the option "--subtree
        primate" will create one partition consisting of human, chimp, and
        the branch leading to them, and another partition consisting of the
        rest of the tree; "--subtree human" will create one partition
        consisting only of human and the branch leading to it and another
        partition consisting of the rest of the tree.  In 'SPH' mode, a
        reversible substitution model is assumed.

    --branch, -B <node-name(s)>
        (Not available in GERP or SPH mode).  Like subtree, but partitions
	the tree into the set of named branches (each named by its child
	node), and all the remaining branches.  Then tests for conservation/
	acceleration in the set of named branches relative to the others.
	The argument is a comma-delimited list of child nodes.

    --chrom, -N <name>
        (Optionally use with --wig-scores or --base-by-base) Chromosome
        name for wig output.  Default is root of multiple alignment
        filename.

    --log, -l <fname>
        Write log to <fname> describing details of parameter optimization.
        Useful for debugging.  (Warning: may produce large file.)

    --seed, -d <seed>
        Provide a random number seed, should be an integer >=1.  Random
        numbers are used in some cases to generate starting values for
        optimization.  If not specified will use a seed based on the
	current time.

    --no-prune,-P
        Do not prune species from tree which are not in alignment.  Rather,
        treat these species as having missing data in the alignment.  Missing
        data does have an effect on the results when --method SPH is used.

    --help, -h
        Produce this help message.


  (Options for SPH mode only)

    --null, -n <nsites>
        Compute just the null (prior) distribution of the number of
        substitutions, as defined by the tree model and the given
        number of sites, and output as a table.  The 'alignment'
        argument will be ignored.  If used with --subtree, the joint
        distribution over the number of substitutions in the specified
        supertree and subtree will be output instead.

    --posterior, -p
        Compute just the posterior distribution of the number of
        substitutions, given the alignment and the model, and output
        as a table.  If used with --subtree, the joint distribution
        over the number of substitutions in the specified supertree
        and subtree will be output instead.

    --fit-model, -F
        Fit model to data before computing posterior distribution, by
        estimating a scale factor for the whole tree or (if --subtree)
        separate scale factors for the specified subtree and supertree.
        Makes p-values less conservative.  This option has no effect with
        --null and currently cannot be used with --features.  It can be
        used with --wig-scores and --base-by-base.

    --epsilon, -e <val>
        (Default 1e-10 or 1e-6 if --wig-scores or --base-by-base) Threshold
        used in truncating tails of distributions; tail probabilities less
        than this value are discarded.  To get accurate p-values smaller
        than 1e-10, this option will need to be used, at some cost in
        speed.  Note that truncation affects only *right* tails, not left
        tails, so it should be an issue only with p-values of acceleration.

    --confidence-interval, -c <val>
        Allow for uncertainty in the estimate of the actual number of
        substitutions by using a (central) confidence interval about the
        mean of the specified size (0 < val < 1).  To be conservative, the
        maximum of this interval is used when computing a p-value of
        conservation, and the minimum is used when computing a p-value of
        acceleration.  The variance of the posterior is computed
        exactly, but the confidence interval is based on the assumption
        that the combined distribution will be approximately normal (true
        for large numbers of sites by central limit theorem).

    --quantiles, -q
        (For use with --null or --posterior) Report quantiles of
        distribution rather than whole distribution.


REFERENCES:

    Cooper GM, Stone EA, Asimenos G, NISC Comparative Sequencing Program,
      Green ED, Batzoglou S, Sidow A. Distribution and intensity of
      constraint in mammalian genomic sequence.  Genome Res. 2005
      15(7):901-13.

    Siepel A, Pollard KS, and Haussler D. New methods for detecting
      lineage-specific selection. In Proceedings of the 10th International
      Conference on Research in Computational Molecular Biology (RECOMB
      2006), pp. 190-205.
```


## Metadata
- **Skill**: generated
