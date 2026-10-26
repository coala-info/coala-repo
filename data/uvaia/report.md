# uvaia CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| uvaia | PASS |  |
| uvaia_uvaia_legacy | PASS |  |
| uvaia_uvaiaball | PASS |  |
| uvaia_uvaiaclust | PASS |  |
| uvaia_uvaialign | PASS |  |

## uvaia

### Tool Description
For every query sequence, finds closest neighbours in reference alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/uvaia:2.0.1--heee599d_3
- **Homepage**: https://github.com/quadram-institute-bioscience/uvaia
- **Package**: https://anaconda.org/channels/bioconda/packages/uvaia/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/uvaia/overview
- **Total Downloads**: 6.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/quadram-institute-bioscience/uvaia
- **Stars**: N/A
### Original Help Text
```text
uvaia 2.0.1 
For every query sequence, finds closest neighbours in reference alignment. 
Notice that this software is multithreaded (and its performance depends on it)

The complete syntax is:

 uvaia  [-h|--help] [-v|--version] [--acgt] [-k|--keep_resolved] [-x|--exclude_self] [-n|--nbest=<int>] [-t|--trim=<int>] [-A|--ref_ambiguity=<double>] [-a|--query_ambiguity=<double>] [-p|--pool=<int>] -r|--reference=<ref.fa(.gz,.xz)> [-r|--reference=<ref.fa(.gz,.xz)>]... <seqs.fa(.gz,.xz)> [-t|--nthreads=<int>] [-o|--output=<without suffix>]

  -h, --help                       print a longer help and exit
  -v, --version                    print version and exit
  --acgt                           considers only ACGT sites (i.e. unambiguous SNP differences) in query sequences (mismatch-based)
  -k, --keep_resolved              keep more resolved and exclude redundant query seqs (default is to keep all)
  -x, --exclude_self               Exclude reference sequences with same name as a query sequence
  -n, --nbest=<int>                number of best reference sequences per query to store (default=100)
  -t, --trim=<int>                 number of sites to trim from both ends (default=0, suggested for sarscov2=230)
  -A, --ref_ambiguity=<double>     maximum allowed ambiguity for REFERENCE sequence to be excluded (default=0.5)
  -a, --query_ambiguity=<double>   maximum allowed ambiguity for QUERY sequence to be excluded (default=0.5)
  -p, --pool=<int>                 Pool size, i.e. how many reference seqs are queued to be processed in parallel (larger than number of threads, defaults to 64 per thread)
  -r, --reference=<ref.fa(.gz,.xz)> aligned reference sequences (can be several files)
  <seqs.fa(.gz,.xz)>               aligned query sequences
  -t, --nthreads=<int>             suggested number of threads (default is to let system decide; I may not honour your suggestion btw)
  -o, --output=<without suffix>    prefix of xzipped output alignment and table with nearest neighbour sequences
Notice that poorly-resolved query sequences (with excess of Ns or indels) have more close neighbours, since only non-N sites are considered). With `--keep_resolved`, if two sequences are equivalent ---in that one is more resolved than another---, only the higher-resolution version is considered. 

 e.g.
seq1 AAAGCG-C  : higher resolution
seq2 AA--CG-C  : lower resolution, but distance=0 to seq1 since no SNPs disagree
seq3 AAA-CGAC  : also no disagreements (d=0) to seq1
seq4 AAA-CGTC  : also distance=0 to seq1

Notice that both seq3 and seq4 have info not available on seq1 and thus are both kept. However seq2 is equivalent to seq1. 

It sorts neighbours in the same order as the table columns, using the next column to break ties:
 1. ACGT_matches -- considering only ACGT 
 2. text_matches -- exact matches, thus M-M is a match but M-A is not
 3. partial_matches -- M-A is considered a match since the partially ambiguous `M` equals {A,C}.
    However the fully ambiguous `N` is neglected
 4. valid_pair_comparisons -- the `effective` sequence length for the comparison, i.e. sum of sites
     without gaps or N in any of the two sequences
 5. ACGT_matches_unique -- a 'consensus' between query seqs is created, and this is the number of
    matches present in the query but not in the consensus (in short, it prefers neighbours farther
    from the common ancestor of the queries, in case of ties)
 6. valid_ref_sites -- if everything else is the same, then sequences with less gaps and Ns are preferred
    (caveat is that some sequencing labs  artificially impute states, in practice removing all gaps and Ns)

The reported number of matches may differ between programs or runs due to how the query sequences are compressed and indexed, however the distances (mismatches) are preserved. For instance `valid_pair_comparison - partial_matches` generates more similar distances as snp-dists (snp-dists assumes every non-ACGT is non-valid and counts only ACGT). Sites with a gap or `N` is one of the sequences are ignored. The columns 1, 3, and 4 above are the most useful for the final user.The option '--acgt' emulates other software, by considering only ACGT (it still considers matches instead of mimatches to avoid the trap of poorly-resolved sequenced being favoured). In this case two new columns appear, 'dist_consensus' and 'dist_unique' describing partial mismatches (the sum of both is the usual SNP distance).
```

## uvaia_uvaiaclust

### Tool Description
Cluster and dedups alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/uvaia:2.0.1--heee599d_3
- **Homepage**: https://github.com/quadram-institute-bioscience/uvaia
- **Package**: https://anaconda.org/channels/bioconda/packages/uvaia/overview
- **Validation**: PASS

### Original Help Text
```text
Error when reading arguments from command line:
uvaiaclust: missing option <seqs.fa(.gz,.xz)>
uvaia 2.0.1 
Cluster and dedups alignments
The complete syntax is:

 uvaiaclust  [-h|--help] [-v|--version] [-d|--distance=<int>] [-t|--trim=<int>] [-p|--pool=<int>] [-s|--snps=<int>] [-r|--reference=<ref.fa(.gz,.xz)>] <seqs.fa(.gz,.xz)> [<seqs.fa(.gz,.xz)>]... [-o|--output=<without suffix>]

  -h, --help                       print a longer help and exit
  -v, --version                    print version and exit
  -d, --distance=<int>             seqs with this SNP differences or less will be merged (default=1)
  -t, --trim=<int>                 number of sites to trim from both ends (default=0, suggested for sarscov2=230)
  -p, --pool=<int>                 Pool size, i.e. number of clustering queues (should be larger than avail threads)
  -s, --snps=<int>                 how many SNPs w.r.t. reference it keeps track (default=1, should be small number)
  -r, --reference=<ref.fa(.gz,.xz)> reference sequence (medoids are furthest from it)
  <seqs.fa(.gz,.xz)>               alignments to merge
  -o, --output=<without suffix>    prefix of xzipped output alignment and cluster table files
```

## uvaia_uvaialign

### Tool Description
Align query sequences against a reference.

### Metadata
- **Docker Image**: quay.io/biocontainers/uvaia:2.0.1--heee599d_3
- **Homepage**: https://github.com/quadram-institute-bioscience/uvaia
- **Package**: https://anaconda.org/channels/bioconda/packages/uvaia/overview
- **Validation**: PASS

### Original Help Text
```text
Error when reading arguments from command line:
uvaialign: missing option -r|--reference=<ref.fa|ref.fa.xz>
uvaialign: missing option <seqs.fa|seqs.fa.xz>
uvaia 2.0.1 
Align query sequences against a reference
The complete syntax is:

 uvaialign  [-h|--help] [-v|--version] [--stdout] [-p|--pool=<int>] [-t|--nthreads=<int>] [-o|--output=<without suffix>] [-a|--ambiguity=<double>] -r|--reference=<ref.fa|ref.fa.xz> <seqs.fa|seqs.fa.xz> [<seqs.fa|seqs.fa.xz>]...

  -h, --help                       print a longer help and exit
  -v, --version                    print version and exit
  --stdout                         print alignment to stdout (to redirect/pipe) instead of compress to file; much faster but may generate a big output
  -p, --pool=<int>                 How many query sequences are read in batch, to be aligned in parallel (should be larger than number of threads, defaults to 256 per thread)
  -t, --nthreads=<int>             suggested number of threads (default is to let system decide; I may not honour your suggestion btw)
  -o, --output=<without suffix>    prefix of xzipped output alignment and table with nearest neighbour sequences
  -a, --ambiguity=<double>         maximum allowed ambiguity for sequence to be excluded (default=0.5)
  -r, --reference=<ref.fa|ref.fa.xz> reference sequence in fasta format, possibly compressed with gz, xz, bz2
  <seqs.fa|seqs.fa.xz>             sequences to align in fasta format, possibly compressed with gz, xz, bz2 (can be multiple files)
```

## uvaia_uvaiaball

### Tool Description
Finds all reference neighbours to query sequences within a ball radius.

### Metadata
- **Docker Image**: quay.io/biocontainers/uvaia:2.0.1--heee599d_3
- **Homepage**: https://github.com/quadram-institute-bioscience/uvaia
- **Package**: https://anaconda.org/channels/bioconda/packages/uvaia/overview
- **Validation**: PASS

### Original Help Text
```text
Error when reading arguments from command line:
uvaiaball: missing option -r|--reference=<ref.fa(.gz,.xz)>
uvaiaball: missing option <seqs.fa(.gz,.xz)>
uvaia 2.0.1 
Finds all reference neighbours to query sequences within a ball radius (i.e. close to any query sequence)
Notice that this software is multithreaded (and currently there is no control over number of threads)
The complete syntax is:

 uvaiaball  [-h|--help] [-v|--version] [-x|--acgt] [-k|--keep_resolved] [-d|--distance=<int>] [-t|--trim=<int>] [-A|--ref_ambiguity=<double>] [-a|--query_ambiguity=<double>] [-p|--pool=<int>] -r|--reference=<ref.fa(.gz,.xz)> [-r|--reference=<ref.fa(.gz,.xz)>]... <seqs.fa(.gz,.xz)> [-o|--output=<without suffix>]

  -h, --help                       print a longer help and exit
  -v, --version                    print version and exit
  -x, --acgt                       considers only ACGT sites (i.e. unambiguous SNP differences), more permissive and faster
  -k, --keep_resolved              when excluding redundant query seqs, keep the more resolved (instead of default, less resolved)
  -d, --distance=<int>             ball radius, i.e. refs within this distance to any query seq are kept
  -t, --trim=<int>                 number of sites to trim from both ends (default=0, suggested for sarscov2=230)
  -A, --ref_ambiguity=<double>     maximum allowed ambiguity for REFERENCE sequence to be excluded (default=0.5)
  -a, --query_ambiguity=<double>   maximum allowed ambiguity for QUERY sequence to be excluded (default=0.5)
  -p, --pool=<int>                 Pool size, i.e. how many reference seqs are queued to be processed in parallel (larger than number of threads, defaults to 64 per thread)
  -r, --reference=<ref.fa(.gz,.xz)> aligned reference sequences (can be several files)
  <seqs.fa(.gz,.xz)>               aligned query sequences
  -o, --output=<without suffix>    prefix of xzipped output alignment with subset of ref sequences
```

## uvaia_uvaia_legacy

### Tool Description
Search query sequences against reference ones to describe closest ones (legacy version).

### Metadata
- **Docker Image**: quay.io/biocontainers/uvaia:2.0.1--heee599d_3
- **Homepage**: https://github.com/quadram-institute-bioscience/uvaia
- **Package**: https://anaconda.org/channels/bioconda/packages/uvaia/overview
- **Validation**: PASS

### Original Help Text
```text
Error when reading arguments from command line:
uvaia_legacy: missing option -r|--reference=[ref.fa(.gz,.xz)]
uvaia_legacy: missing option [query.fa(.gz,.xz)]
uvaia 2.0.1 
Search query sequences against reference ones to describe closest ones
This program relies on aligned sequences (queries and references must have same size)
The complete syntax is:

 uvaia_legacy  [-h|--help] [-v|--version] [-n|--nbest=<int>] [-m|--nmax=<int>] [--trim=<int>] [-A|--ref_ambiguity=<double>] [-a|--query_ambiguity=<double>] -r|--reference=[ref.fa(.gz,.xz)] [-o|--output=[chosen_refs.fa.xz]] [-t|--nthreads=<int>] [query.fa(.gz,.xz)]

  -h, --help                       print a longer help and exit
  -v, --version                    print version and exit
  -n, --nbest=<int>                number of best reference sequences per query to show (default=8)
  -m, --nmax=<int>                 max number of best reference sequences when several optimal (default=2 x nbest)
  --trim=<int>                     number of sites to trim from both ends (default=0, suggested for sarscov2=230)
  -A, --ref_ambiguity=<double>     maximum allowed ambiguity for REFERENCE sequence to be excluded (default=0.5)
  -a, --query_ambiguity=<double>   maximum allowed ambiguity for QUERY sequence to be excluded (default=0.5)
  -r, --reference=[ref.fa(.gz,.xz)] *aligned* reference sequences (raw or compressed with gzip, xz, etc.)
  -o, --output=[chosen_refs.fa.xz] XZIPPED (LZMA) output reference sequences (default is to not save sequences)
  -t, --nthreads=<int>             suggested number of threads (default is to let system decide; I may not honour your suggestion btw)
  [query.fa(.gz,.xz)]              *aligned* sequences to search for neighbour references
```

