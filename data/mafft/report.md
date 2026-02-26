# mafft CWL Generation Report

## mafft

### Tool Description
Multiple Sequence Alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/mafft:7.525--h031d066_1
- **Homepage**: http://mafft.cbrc.jp/alignment/software/
- **Package**: https://anaconda.org/channels/bioconda/packages/mafft/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mafft/overview
- **Total Downloads**: 1.3M
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
/usr/local/bin/mafft: Cannot open -help.

------------------------------------------------------------------------------
  MAFFT v7.525 (2024/Mar/13)
  https://mafft.cbrc.jp/alignment/software/
  MBE 30:772-780 (2013), NAR 30:3059-3066 (2002)
------------------------------------------------------------------------------
High speed:
  % mafft in > out
  % mafft --retree 1 in > out (fast)

High accuracy (for <~200 sequences x <~2,000 aa/nt):
  % mafft --maxiterate 1000 --localpair  in > out (% linsi in > out is also ok)
  % mafft --maxiterate 1000 --genafpair  in > out (% einsi in > out)
  % mafft --maxiterate 1000 --globalpair in > out (% ginsi in > out)

If unsure which option to use:
  % mafft --auto in > out

--op # :         Gap opening penalty, default: 1.53
--ep # :         Offset (works like gap extension penalty), default: 0.0
--maxiterate # : Maximum number of iterative refinement, default: 0
--clustalout :   Output: clustal format, default: fasta
--reorder :      Outorder: aligned, default: input order
--quiet :        Do not report progress
--thread # :     Number of threads (if unsure, --thread -1)
--dash :         Add structural information (Rozewicki et al, submitted)
```

