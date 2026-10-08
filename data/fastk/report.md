# fastk CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fastk_FastK | PASS |  |
| fastk_Fastcat | PASS |  |
| fastk_Fastcp | PASS |  |
| fastk_Fastmerge | PASS |  |
| fastk_Fastmv | PASS |  |
| fastk_Fastrm | PASS |  |
| fastk_Haplex | PASS | synthetic data: a planted heterozygous site is found; the real test data has none (0 sites) |
| fastk_Histex | PASS |  |
| fastk_Homex | PASS |  |
| fastk_KmerMap | PASS |  |
| fastk_Logex | PASS |  |
| fastk_Profex | PASS |  |
| fastk_Symmex | PASS |  |
| fastk_Tabex | PASS |  |
| fastk_Vennex | Failed | tool bug: Vennex crashes with a segmentation fault and writes histogram files with corrupted names |

## fastk_FastK

### Tool Description
FastK is a tool for k-mer counting and analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastk:1.2--h71df26d_1
- **Homepage**: https://github.com/thegenemyers/FASTK
- **Package**: https://anaconda.org/channels/bioconda/packages/fastk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fastk/overview
- **Total Downloads**: 6.7K
- **Last updated**: 2026-02-07
- **GitHub**: https://github.com/thegenemyers/FASTK
- **Stars**: N/A
### Original Help Text
```text
Usage: FastK [-k<int(40)>] [-t[<int(1)>]] [-p[:<table>[.ktab]]] [-c] [-bc<int>]
             [-v] [-N<path_name>] [-P<dir($TMPDIR)>] [-M<int(12)>] [-T<int(4)>]
                 <source>[.cram|.[bs]am|.db|.dam|.f[ast][aq][.gz] ...

      -v: Verbose mode, output statistics as proceed.
      -T: Use -T threads.
      -N: Use given path for output directory and root name prefix.
      -P: Place block level sorts in directory -P.
      -M: Use -M GB of memory in downstream sorting steps of KMcount.

      -k: k-mer size.
      -t: Produce table of sorted k-mers & counts >= level specified
      -p: Produce sequence count profiles (w.r.t. table if given)
     -bc: Ignore prefix of each read of given length (e.g. bar code)
      -c: Homopolymer compress every sequence
```

## fastk_Tabex

### Tool Description
Tabex is a tool for extracting k-mers from k-mer tables.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastk:1.2--h71df26d_1
- **Homepage**: https://github.com/thegenemyers/FASTK
- **Package**: https://anaconda.org/channels/bioconda/packages/fastk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: Tabex [-1AC] [-t<int>] <source>[.ktab] [ <address>[-<address>] ]

          <address> = <int> | <dna:string>

      -t: Trim all k-mers with counts less than threshold
      -A: Output tab-delimited ASCII
      -C: Check sorting
      -1: Produce 1-code as output.
```

## fastk_Profex

### Tool Description
Profex

### Metadata
- **Docker Image**: quay.io/biocontainers/fastk:1.2--h71df26d_1
- **Homepage**: https://github.com/thegenemyers/FASTK
- **Package**: https://anaconda.org/channels/bioconda/packages/fastk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: Profex [-1Az] <source_root>[.prof] [ <read:int>[-(<read:int>|#)] ... ]

      -1: Produce 1-code as output.
      -A: tab-delimited ASCII as output.
      -z: Compress runs and ignore zeros.
```

## fastk_Logex

### Tool Description
Logex

### Metadata
- **Docker Image**: quay.io/biocontainers/fastk:1.2--h71df26d_1
- **Homepage**: https://github.com/thegenemyers/FASTK
- **Package**: https://anaconda.org/channels/bioconda/packages/fastk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: Logex  [-T<int(4)>] [-[hH][<int(1)>:]<int(32767)>]
                <output:name=expr> ... <source_root>[.ktab] ...

      -T: Use -T threads.
      -h: Generate histograms.
      -H: Generate histograms only, no tables.
```

## fastk_Fastcat

### Tool Description
Concatenates FastK histograms, tables or profiles of different runs into one.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastk:1.2--h71df26d_1
- **Homepage**: https://github.com/thegenemyers/FASTK
- **Package**: https://anaconda.org/channels/bioconda/packages/fastk/overview
- **Validation**: PASS

### Original Help Text
```text

Usage: Fastcat [-vk] [-htp] <target> <source>[.hist|.ktab|.prof] ...

      -v: Print progress as you go.
      -k: Keep source files (requires copying all parts).

      -h: Produce a merged histogram.
      -t: Produce a merged k-mer table.
      -p: Produce a merged profile.
```

## fastk_Fastcp

### Tool Description
Copies a FastK histogram, table or profile with all its hidden part files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastk:1.2--h71df26d_1
- **Homepage**: https://github.com/thegenemyers/FASTK
- **Package**: https://anaconda.org/channels/bioconda/packages/fastk/overview
- **Validation**: PASS

### Original Help Text
```text

Usage: Fastcp [-inf] <source> <dest>

      -i: prompt for each (stub) overwrite.
      -n: do not overwrite existing files.
      -f: force operation quietly
```

## fastk_Fastmerge

### Tool Description
Merges FastK histograms or k-mer tables of different runs.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastk:1.2--h71df26d_1
- **Homepage**: https://github.com/thegenemyers/FASTK
- **Package**: https://anaconda.org/channels/bioconda/packages/fastk/overview
- **Validation**: PASS

### Original Help Text
```text

Usage: Fastmerge [-ht] [-T<int(4)>] [#<int(1)>] [-P<dir(/tmp)>] [-S<N:int>of<D:int>]
                 <target> <source>[.hist|.ktab] ...

      -h: Produce a merged histogram.
      -t: Produce a merged k-mer table.

      -T: Use -T threads.
      -#: Produce -# parts per thread.
      -P: Cache table inputs to this directory.
      -S: Divide into D slices and do slice N in [1,D].
```

## fastk_Fastmv

### Tool Description
Moves a FastK histogram, table or profile with all its hidden part files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastk:1.2--h71df26d_1
- **Homepage**: https://github.com/thegenemyers/FASTK
- **Package**: https://anaconda.org/channels/bioconda/packages/fastk/overview
- **Validation**: PASS

### Original Help Text
```text

Usage: Fastmv [-inf] <source> <dest>

      -i: prompt for each (stub) overwrite.
      -n: do not overwrite existing files.
      -f: force operation quietly
```

## fastk_Fastrm

### Tool Description
Deletes FastK histograms, tables or profiles with all their hidden part files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastk:1.2--h71df26d_1
- **Homepage**: https://github.com/thegenemyers/FASTK
- **Package**: https://anaconda.org/channels/bioconda/packages/fastk/overview
- **Validation**: PASS

### Original Help Text
```text

Usage: Fastrm [-if] <source> ...

      -i: prompt for each (stub) deletion
      -f: force operation quietly
```

## fastk_Haplex

### Tool Description
Finds heterozygous k-mer pairs in a k-mer table (deprecated by the authors).

### Metadata
- **Docker Image**: quay.io/biocontainers/fastk:1.2--h71df26d_1
- **Homepage**: https://github.com/thegenemyers/FASTK
- **Package**: https://anaconda.org/channels/bioconda/packages/fastk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: Haplex  -H [-g<int>:<int>] <source>[.ktab]

      -g: Accept only haplotypes with count in given range (inclusive).
```

## fastk_Histex

### Tool Description
Shows a k-mer count histogram made by FastK.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastk:1.2--h71df26d_1
- **Homepage**: https://github.com/thegenemyers/FASTK
- **Package**: https://anaconda.org/channels/bioconda/packages/fastk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: Histex [-1] [-kAG] [-h[<int(1)>:]<int(-G?1000:100)>] <source_root>[.hist]

      -h: Output histogram of counts in range given
      -k: Output histogram of k-mer instance counts (vs. unique k-mers)
      -A: Output in simple tab-delimited ASCII format
      -G: Output an ASCII format histogram especially for GeneScope.FK
      -1: Output in 1-code
```

## fastk_Homex

### Tool Description
Estimates error rates from a k-mer table.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastk:1.2--h71df26d_1
- **Homepage**: https://github.com/thegenemyers/FASTK
- **Package**: https://anaconda.org/channels/bioconda/packages/fastk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: Homex -e<int> -g<int>:<int> <source_root>[.ktab]

      -e: Counts <= this value are considered errors.
      -g: Counts in this range are considered correct.
```

## fastk_KmerMap

### Tool Description
Produces a BED file of the target regions covered by the k-mers of a table.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastk:1.2--h71df26d_1
- **Homepage**: https://github.com/thegenemyers/FASTK
- **Package**: https://anaconda.org/channels/bioconda/packages/fastk/overview
- **Validation**: PASS

### Original Help Text
```text

Usage: KmerMap [-vm] [-T<int(4)>] [-P<dir(/tmp)> <kmers>[.ktab] <target>[."dna"] <out:bed>

      -v: verbose output to stderr
      -m: merge overlapping k-mer hits

      -T: number of threads to use
      -P: Place all temporary files in directory -P.
```

## fastk_Symmex

### Tool Description
Adds the reverse complement k-mers to a k-mer table.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastk:1.2--h71df26d_1
- **Homepage**: https://github.com/thegenemyers/FASTK
- **Package**: https://anaconda.org/channels/bioconda/packages/fastk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: Symmex  [-v] [-T<int(4)>] [-P<dir(/tmp)] <source_root>[.ktab] <dest_root>[.ktab]

      -v: Verbose mode, output statistics as proceed.
      -T: Use -T threads.
      -P: Place all temporary files in directory -P.
```

## fastk_Vennex

### Tool Description
Shows a Venn diagram table of k-mer counts shared between k-mer tables.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastk:1.2--h71df26d_1
- **Homepage**: https://github.com/thegenemyers/FASTK
- **Package**: https://anaconda.org/channels/bioconda/packages/fastk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: Vennex [-h[<int(1)>:]<int(100)>] <source_1>[.ktab] <source_2>[.ktab] ...
```

## Metadata
- **Skill**: generated
