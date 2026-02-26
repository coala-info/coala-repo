# uvaia CWL Generation Report

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

