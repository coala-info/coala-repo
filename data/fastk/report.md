# fastk CWL Generation Report

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


## fastk_Histex

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastk:1.2--h71df26d_1
- **Homepage**: https://github.com/thegenemyers/FASTK
- **Package**: https://anaconda.org/channels/bioconda/packages/fastk/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Histex: -- is an illegal option
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

