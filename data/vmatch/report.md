# vmatch CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| vmatch | PASS | index staged at the fixed path /vmatch_work |
| vmatch_chain2dim | PASS |  |
| vmatch_matchcluster | PASS | index must be staged at the same fixed path /vmatch_work as in the vmatch run that wrote the match file |
| vmatch_mkdna6idx | PASS |  |
| vmatch_mkvtree | PASS |  |
| vmatch_repfind | PASS |  |
| vmatch_vendian | PASS |  |
| vmatch_vmatchselect | PASS | index must be staged at the same fixed path /vmatch_work as in the vmatch run that wrote the match file |
| vmatch_vmatchtrans | PASS |  |
| vmatch_vseqinfo | PASS |  |
| vmatch_vseqselect | PASS |  |
| vmatch_vstree2tex | PASS |  |
| vmatch_vsubseqselect | PASS |  |

## vmatch

### Tool Description
vmatch

### Metadata
- **Docker Image**: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
- **Homepage**: http://www.vmatch.de/
- **Package**: https://anaconda.org/channels/bioconda/packages/vmatch/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vmatch/overview
- **Total Downloads**: 21.9K
- **Last updated**: 2025-09-23
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
-q           specify files containing queries to be matched
-complete    specify that query sequences must match completely
-online      run algorithms online without using the index
-d           compute direct matches (default)
-p           compute palindromic (i.e. reverse complemented matches)
-l           specify that match must have the given length
             optionally specify minimum and maximum size of
             gaps between repeat instances
-h           specify the allowed hamming distance > 0
             in combination with option -complete one can switch on
             the percentage search mode or the best search mode
             for the percentage search mode use an argument
             of the form ip where i is a positive integer
             this means that up to i*100/m mismatches are
             allowed in a match of a query of length m
             for the best search mode use an argument
             of the form ib where i is a positive integer
             this means that in a first phase the minimum threshold q
             is determined such that there is still a match
             with q mismatches. q is in the range 0 to i*100/m
-e           specify the allowed edit distance > 0
             in combination with option -complete one can switch on
             the percentage search mode or the best search mode
             for the percentage search mode use an argument
             of the form ip where i is a positive integer
             this means that up to i*100/m differences are
             allowed in a match of a query of length m
             for the best search mode use an argument
             of the form ib where i is a positive integer
             this means that in a first phase the minimum threshold q
             is determined such that there is still a match
             with q differences. q is in the range 0 to i*100/m
-hxdrop      specify the xdrop value for hamming distance extension
-exdrop      specify the xdrop value for edit distance extension
-leastscore  specify the minimum score of a match
-evalue      specify the maximum E-value of a match
-identity    specify minimum identity of match in range [1..100%]
-s           show the alignment of matching sequences
-showdesc    show sequence description of match
-v           verbose mode
-version     show the version of the Vmatch package
-help        show basic options
-help+       show all options
```

## vmatch_mkvtree

### Tool Description
Construct the enhanced suffix array index of sequence files for Vmatch.

### Metadata
- **Docker Image**: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
- **Homepage**: http://www.vmatch.de/
- **Package**: https://anaconda.org/channels/bioconda/packages/vmatch/overview
- **Validation**: PASS

### Original Help Text
```text
-db         specify database files (mandatory)
-smap       specify file containing a symbol mapping
            this describes the grouping of symbols
            possibly set environment variable
            MKVTREESMAPDIR to path
            where these files can be found
-dna        input is DNA sequence
-protein    input is Protein sequence
-indexname  specify name for index to be generated
-pl         specify prefix length for bucket sort
            recommendation: use without argument;
            then a reasonable prefix length is automatically determined
-tis        output transformed input sequences (tistab) to file
-ois        output original input sequences (oistab) to file
-suf        output suffix array (suftab) to file
-sti1       output reduced inverse suffix array (sti1tab) to file
-bwt        output Burrows-Wheeler Transformation (bwttab) to file
-bck        output bucket boundaries (bcktab) to file
-lcp        output longest common prefix lengths (lcptab) to file
-skp        output skip values (skptab) to file
-allout     output all index tables to files
-maxdepth   restrict the sorting to prefixes of the given length
-v          verbose mode
-version    show the version of the Vmatch package
-help       this option
```

## vmatch_vseqinfo

### Tool Description
Show information on the sequences of a Vmatch index.

### Metadata
- **Docker Image**: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
- **Homepage**: http://www.vmatch.de/
- **Package**: https://anaconda.org/channels/bioconda/packages/vmatch/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: vseqinfo indexname
see Vmatch manual at http://www.vmatch.de  for more information
```

## vmatch_vseqselect

### Tool Description
Select sequences from a Vmatch index.

### Metadata
- **Docker Image**: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
- **Homepage**: http://www.vmatch.de/
- **Package**: https://anaconda.org/channels/bioconda/packages/vmatch/overview
- **Validation**: PASS

### Original Help Text
```text
-minlength     specify the minimal length of the sequences to be selected
-maxlength     specify the maximal length of the sequences to be selected
-randomnum     specify the number of random sequences to be selected
-randomlength  specify the minimal total length of the random sequences
               to be selected
-seqnum        select the sequences with numbers given in filename
-version       show the version of the Vmatch package
-help          this option
```

## vmatch_vsubseqselect

### Tool Description
Select substrings of the sequences of a Vmatch index.

### Metadata
- **Docker Image**: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
- **Homepage**: http://www.vmatch.de/
- **Package**: https://anaconda.org/channels/bioconda/packages/vmatch/overview
- **Validation**: PASS

### Original Help Text
```text
-minlength  specify the minimal length of the substrings to be selected
-maxlength  specify the maximal length of the substrings to be selected
-snum       specify the number of substrings to be selected
            the previous three option must be used in combination
-range      specify the first and last position of the substring to be selected
-seq        specify length, number, and relative position
            of the substring to be selected
-version    show the version of the Vmatch package
-help       this option
```

## vmatch_vmatchselect

### Tool Description
Select, sort and cluster the matches of a Vmatch match file.

### Metadata
- **Docker Image**: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
- **Homepage**: http://www.vmatch.de/
- **Package**: https://anaconda.org/channels/bioconda/packages/vmatch/overview
- **Validation**: PASS

### Original Help Text
```text
-dbcluster     cluster the database sequences
               * first argument is percentage of shorter string
                 to be included in match,
               * second argument is percentage of larger string
                 to be included in match,
               * third optional argument is filenameprefix,
               * fourth optional argument is (minclustersize, maxclustersize)
-nonredundant  generate file with non-redundant set of sequences;
               only works together with option -dbcluster
-selfun        specify shared object file containing selection function
-l             specify that match must have the given length
               optionally specify minimum and maximum size of
               gaps between repeat instances
-leastscore    specify the minimum score of a match
-evalue        specify the maximum E-value of a match
-identity      specify minimum identity of match in range [1..100%]
-sort          sort the matches, additional argument is mode
               la: ascending order of length
               ld: descending order of length
               ia: ascending order of first position
               id: descending order of first position
               ja: ascending order of second position
               jd: descending order of second position
               ea: ascending order of Evalue
               ed: descending order of Evalue
               sa: ascending order of score
               sd: descending order of score
               ida: ascending order of identity
               idd: descending order of identity
-best          show the best matches (those with smallest E-values)
               default is best 50
-s             show the alignment of matching sequences
-showdesc      show sequence description of match
-f             show filename where match occurs
-absolute      show absolute positions
-nodist        do not show distance of match
-noevalue      do not show E-value of match
-noscore       do not show score of match
-noidentity    do not show identity of match
-v             verbose mode
```

## vmatch_matchcluster

### Tool Description
Cluster the matches of a Vmatch match file.

### Metadata
- **Docker Image**: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
- **Homepage**: http://www.vmatch.de/
- **Package**: https://anaconda.org/channels/bioconda/packages/vmatch/overview
- **Validation**: PASS

### Original Help Text
```text
-erate      specify maximum error rate in range [0,100] for similarity clustering
-gapsize    specify maximum gap size for gap clustering
-overlap    specify minimum percentage of overlap for overlap clustering
-outprefix  specify prefix of files to output clusters
-version    show the version of the Vmatch package
-help       this option
```

## vmatch_chain2dim

### Tool Description
Compute chains of matches from a Vmatch match file in open format.

### Metadata
- **Docker Image**: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
- **Homepage**: http://www.vmatch.de/
- **Package**: https://anaconda.org/channels/bioconda/packages/vmatch/overview
- **Validation**: PASS

### Original Help Text
```text
-global         global chaining
                optional parameter "gc" switches
                on gap costs (according to L1-model)
                optional parameter "ov" means
                that overlaps between matches are allowed
-local          compute local chains (according to L1-model).
                If no parameter is given, compute local chains with
                maximums score.
                If parameter is given, this must be a positive number
                optionally followed by the character b or p.
                If only the number, say k, is given, this is the minimum
                score of the chains output.
                If a number is followed by character b, then output all
                chains with the largest k scores.
                If a number is followed by character p, then output all
                chains with scores at most k percent away
                from the best score.
-wf             specify weight factor > 0.0 to obtain the score of a fragment
                requires one of the options
                -local,
                -global gc,
                -global ov
-maxgap         maximal width of gap in chain
-outprefix      specify prefix of files to output chains
-withinborders  only compute chains which do not cross sequence borders
                not possible for matches in open format
-thread         thread the chains, i.e. close the gaps
                optional list of keywords
                minlen1 minlen2 maxerror1 maxerror2
                each followed by a number specifies the minimum
                length and the maximum error rate of thread
                1 refers to match instance in indexed sequence
                2 refers to matching instance in query
-silent         do not output the chains
                and only report their lengths and scores
-v              be verbose
-version        show the version of the Vmatch package
-help           this option
```

## vmatch_mkdna6idx

### Tool Description
Construct the index of the six frame translation of DNA sequence files.

### Metadata
- **Docker Image**: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
- **Homepage**: http://www.vmatch.de/
- **Package**: https://anaconda.org/channels/bioconda/packages/vmatch/overview
- **Validation**: PASS

### Original Help Text
```text
-db         specify database files (mandatory)
-smap       specify file containing a symbol mapping
            this describes the grouping of symbols
            possibly set environment variable
            MKVTREESMAPDIR to path
            where these files can be found
-transnum   perform six frame translation
            specify codon translation table by a number in the range [1,23] except for 7, 8, 17, 18, 19 and 20; (default is 1):
             1 Standard
             2 Vertebrate Mitochondrial
             3 Yeast Mitochondrial
             4 Mold Mitochondrial; Protozoan Mitochondrial; Coelenterate Mitochondrial; Mycoplasma; Spiroplasma
             5 Invertebrate Mitochondrial
             6 Ciliate Nuclear; Dasycladacean Nuclear; Hexamita Nuclear
             9 Echinoderm Mitochondrial
            10 Euplotid Nuclear
            11 Bacterial
            12 Alternative Yeast Nuclear
            13 Ascidian Mitochondrial
            14 Flatworm Mitochondrial
            15 Blepharisma Macronuclear
            16 Chlorophycean Mitochondrial
            21 Trematode Mitochondrial
            22 Scenedesmus Obliquus Mitochondrial
            23 Thraustochytrium Mitochondrial
-indexname  specify name for index to be generated
-cpl        use reverse complement of the input sequence
-tis        output transformed input sequences (tistab) to file
-ois        output original input sequences (oistab) to file
-maxdepth   restrict the sorting to prefixes of the given length
-v          verbose mode
-version    show the version of the Vmatch package
-help       this option
```

## vmatch_vstree2tex

### Tool Description
Write tables of a Vmatch index as LaTeX.

### Metadata
- **Docker Image**: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
- **Homepage**: http://www.vmatch.de/
- **Package**: https://anaconda.org/channels/bioconda/packages/vmatch/overview
- **Validation**: PASS

### Original Help Text
```text
-s        output suffixes
-tis      output tistab
-ois      output oistab
-suf      output suftab
-sti1     output small inverse suftab
-bwt      output bwttab
-bck      output bcktab in vertical mode
-bckhz    output bcktab in horizontal mode
-lcp      output lcptab
-skp      output skptab
-cfr      output cfrtab
-crf      output crftab
-lsf      output lsftab
-sti      output inverse suftab
-cld      output cldtab
-iso      output isotab
-version  show the version of the Vmatch package
-help     this option
```

## vmatch_vendian

### Tool Description
Swap the byte order of a binary file of integers.

### Metadata
- **Docker Image**: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
- **Homepage**: http://www.vmatch.de/
- **Package**: https://anaconda.org/channels/bioconda/packages/vmatch/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: vendian bytes filename
```

## vmatch_repfind

### Tool Description
Find maximal repeats in a sequence file.

### Metadata
- **Docker Image**: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
- **Homepage**: http://www.vmatch.de/
- **Package**: https://anaconda.org/channels/bioconda/packages/vmatch/overview
- **Validation**: PASS

### Original Help Text
```text
-f           compute maximal forward repeats
-p           compute maximal palindromes
-l           specify that repeats must have the given length
-h           search for repeats up to the given hamming distance
-e           search for repeats up to the given edit distance
-seedsize    set the seed size
-allmax      show all maximal repeats in the order of their computation
-best        show the repeats with smallest E-value (default best 50)
-s           show the string content of the maximal repeats
-lw          format string output to given linewidth
-iub         print pair of different residues in IUB format
-nodistance  do not show distance values
-noevalue    do not compute evalues
-i           give info about number of different repeats
-v           show program version
-help        this option
```

## vmatch_vmatchtrans

### Tool Description
Transform a Vmatch match file into the chainer, open or posdist format.

### Metadata
- **Docker Image**: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
- **Homepage**: http://www.vmatch.de/
- **Package**: https://anaconda.org/channels/bioconda/packages/vmatch/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: Vmatchtrans.pl chainer|open|posdist [inputfile]
```

