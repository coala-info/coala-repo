# ropebwt3 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ropebwt3_build | PASS |  |
| ropebwt3_fa2kmer | PASS |  |
| ropebwt3_fa2line | PASS |  |
| ropebwt3_get | PASS |  |
| ropebwt3_hapdiv | PASS |  |
| ropebwt3_kount | PASS |  |
| ropebwt3_mem | PASS |  |
| ropebwt3_merge | PASS |  |
| ropebwt3_plain2fmd | PASS |  |
| ropebwt3_ssa | PASS |  |
| ropebwt3_stat | PASS |  |
| ropebwt3_suffix | PASS |  |
| ropebwt3_sw | PASS |  |

## ropebwt3_suffix

### Tool Description
Build suffix array and BWT for a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ropebwt3 suffix [options] <idx.fmr> <seq.fa> [...]
```

## ropebwt3_build

### Tool Description
Builds a BWT index for a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ropebwt3 build [options] <in.fa> [...]
Options:
  Algorithm:
    -m NUM      batch size [7G]
    -t INT      total number of threads [4]
    -p INT      #threads for sais and run sais and merge together (more RAM) [0]
    -l INT      leaf block size in B+-tree [512]
    -n INT      max number children per internal node [64]
    -2          use the ropebwt2 algorithm (libsais by default)
    -s          build BWT in the reverse lexicographical order (RLO; force -2)
    -r          build BWT in RCLO (force -2)
  Input:
    -i FILE     read existing index from FILE []
    -L          one sequence per line in the input
    -F          no forward strand
    -R          no reverse strand
  Output:
    -o FILE     output to FILE [stdout]
    -d          dump in the fermi-delta format (FMD)
    -b          dump in the ropebwt format (FMR)
    -e          dump in the BRE format
    -T          output the index in the Newick format (for debugging)
    -S FILE     save the current index to FILE after each input file []
```

## ropebwt3_merge

### Tool Description
Merge multiple FMR files into a single FMR file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ropebwt3 merge [options] <base.fmr> <other1.fmr> [...]
Options:
  -t INT     number of threads [1]
  -o FILE    output FMR to FILE [stdout]
```

## ropebwt3_plain2fmd

### Tool Description
Convert plain text to FM-index

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ropebwt3 plain2fmd [-o output.fmd] <in.txt>
```

## ropebwt3_ssa

### Tool Description
Builds a suffix array for a FM-index.

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ropebwt3 ssa [options] <in.fmd>
Options:
  -t INT     number of threads [4]
  -s INT     sample rate one SA per 2**INT bases [8]
  -o FILE    output to file [stdout]
```

## ropebwt3_get

### Tool Description
Get sequences from an FMR index

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ropebwt3 get <idx.fmr> <int> [...]
```

## ropebwt3_stat

### Tool Description
Compute statistics for an FMD-index.

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ropebwt3 stat [-M] <idx.fmd>
```

## ropebwt3_kount

### Tool Description
Count k-mers in FMD-index files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ropebwt3 kount [options] <in1.fmd> [in2.fmd [...]]
Options:
  -k INT       k-mer length [51]
  -m INT       min k-mer occurrence [100]
```

## ropebwt3_fa2line

### Tool Description
Convert FASTA file to line-based format

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ropebwt3 fa2line [options] <seq.fa> [...]
```

## ropebwt3_mem

### Tool Description
Find maximal exact matches of query sequences in an FMR/FMD index.

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
  -l INT      min MEM length [19]
  -c INT      min interval size [1]
  --old-mem   use the original MEM algorithm (for testing)
  --gap=NUM   output regions >=NUM that are not covered by MEMs [0]
  --cov       output breadth of coverage
  -t INT      number of threads [4]
  -p INT      output up to INT positions [0]
  -L          one sequence per line in the input
  -K NUM      query batch size [100m]
  -M          use mmap to load FMD
Usage: ropebwt3 mem [options] <idx.fmr> <seq.fa> [...]
```

## ropebwt3_sw

### Tool Description
Find local alignments of query sequences in an FMR/FMD index.

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
  -N INT      keep up to INT hits per DAWG node [25]
  -m INT      min alignment score [30]
  -A INT      match score [1]
  -B INT      mismatch penalty [3]
  -O INT      gap open penalty [5]
  -E INT      gap extension penalty; a k-long gap costs O+k*E [2]
  -C NUM      size of the ranking cache [65536]
  -y INT      ignore secondary hits scored INT lower than the best [-1]
  -e          end-to-end mode (forcing -k to 1)
  -j INT      min MEM length to initiate alignment [0]
  -k INT      require INT-mer match at the end of alignment [11]
  -b          align both strands (effective with --all-e2e)
  -u          write unmapped queries to PAF
  --seq       write reference sequence to the rs tag
  --all-e2e   write all end-to-end hits in a compact format (forcing -e)
  -g INT      cap the number of --all-e2e output to INT (forcing --all-e2e)
  --no-ssa    ignore the sampled suffix array
  -t INT      number of threads [4]
  -p INT      output up to INT positions [0]
  -L          one sequence per line in the input
  -K NUM      query batch size [100m]
  -M          use mmap to load FMD
Usage: ropebwt3 sw [options] <idx.fmr> <seq.fa> [...]
```

## ropebwt3_hapdiv

### Tool Description
Haplotype diversity with sliding k-mers.

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ropebwt3 hapdiv [options] <idx.fmr> <seq.fa> [...]
Options:
  -a INT      annotate sliding INT-mers [101]
  -w INT      k-mer step size for annotation [50]
  -N INT      keep up to INT hits per DAWG node [25]
  -m INT      min alignment score [30]
  -A INT      match score [1]
  -B INT      mismatch penalty [3]
  -O INT      gap open penalty [5]
  -E INT      gap extension penalty; a k-long gap costs O+k*E [2]
  -C NUM      size of the ranking cache [65536]
  -y INT      ignore secondary hits scored INT lower than the best [-1]
  -t INT      number of threads [4]
  -p INT      output up to INT positions [0]
  -L          one sequence per line in the input
  -K NUM      query batch size [100m]
  -M          use mmap to load FMD
```

## ropebwt3_fa2kmer

### Tool Description
Extract k-mers from FASTX files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
  -k INT      k-mer size [151]
  -w INT      step size [50]
Usage: ropebwt3 fa2kmer [options] <seq.fa> [...]
```

## Metadata
- **Skill**: generated
