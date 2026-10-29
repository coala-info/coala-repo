# wgatools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| wgatools_call | Failed | tool bug: soft-masked (lowercase) bases in the real LAST MAF are called as SNPs with REF equal to ALT (A to A); other SNPs and the INV calls are right. The chain format option is not supported |
| wgatools_chain2maf | PASS | real chain ShiftBack.chain with chrM and shifted chrM FASTA gives MAF rows with equal target and query sequence (8569 and 8000 bp) |
| wgatools_chain2paf | PASS | real chain ShiftBack.chain (Sarek, chrM) gives two PAF records with correct coordinates |
| wgatools_chunk | PASS | chunks of 5000 give 11 blocks; aligned target bases total 30201, same as the input |
| wgatools_dotplot | PASS | csv overview mode gives one row per PAF block with correct coordinates and identity |
| wgatools_filter | PASS | min block size 1000 keeps the 2 PAF records of 8649 and 20948 bp and drops the 4 short ones |
| wgatools_maf2chain | Failed | tool bug: for minus-strand queries the chain query end is wrong (end 20973 for a 20948 bp block), so the chain header does not match its block sizes |
| wgatools_maf2paf | PASS | LAST MAF to PAF on the nf-core SARS-CoV-2 contigs; 6 blocks, paf2maf rebuilds the original MAF exactly; note: lowercase (soft-masked) bases count as mismatches in NM and cg |
| wgatools_maf2sam | Failed | tool bug: DEV command writes a fixed example SAM (sq0 to sq2 with a noodles-sam comment) that ignores the input MAF |
| wgatools_maf_ext | PASS | region MT192765.1:100-200 gives 2 blocks; the target row equals the genome bases 100-200 |
| wgatools_maf_index | PASS | index JSON written next to the MAF lists 4 sequences and the 6 aligned intervals |
| wgatools_paf2chain | Failed | tool bug: for minus-strand queries the chain query end is wrong (same fault as maf2chain) |
| wgatools_paf2maf | PASS | PAF from maf2paf plus real genome and contig FASTA gives a MAF identical to the original LAST MAF |
| wgatools_pafcov | Failed | tool bug: per-base coverage skips mismatch (X) bases, so 12 of 30201 aligned bases get coverage 0 |
| wgatools_pafpseudo | PASS | pseudo-MAF of the target with the 3 contigs placed on it; contig bases and mismatches match the PAF (combined FASTA with .fai) |
| wgatools_rename | PASS | prefixes ref_ and ctg_ are added to the sequence names of all rows |
| wgatools_stat | PASS | per-block table: 3 or 6 mismatches match the PAF CIGARs; note: the chain format is not implemented (visible error); lowercase bases count as mismatches |
| wgatools_validate | PASS |  |

## wgatools_validate

### Tool Description
Validate and fix query&target position in PAF file by CIGAR

### Metadata
- **Docker Image**: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
- **Homepage**: https://github.com/wjwei-handsome/wgatools
- **Package**: https://anaconda.org/channels/bioconda/packages/wgatools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/wgatools/overview
- **Total Downloads**: 4.1K
- **Last updated**: 2025-11-06
- **GitHub**: https://github.com/wjwei-handsome/wgatools
- **Stars**: N/A
### Original Help Text
```text
Validate and fix query&target position in PAF file by CIGAR
Examples:
wgatools validate wrong.paf // output report to STDOUT
wgatools validate wrong.paf -f happy.paf -o fix.report

Usage: wgatools validate [OPTIONS] [INPUT]

Arguments:
  [INPUT]  Input PAF File, None for STDIN

Options:
  -f, --fix <FIX>  Fixed output file, None for NOT FIX, `-` will mix newoutput & information
  -h, --help       Print help

GLOBAL:
  -o, --outfile <OUTFILE>  Output file ("-" for stdout), file name ending in .gz/.bz2/.xz will be compressed automatically [default: -]
  -r, --rewrite            Bool, if rewrite output file [default: false]
  -t, --threads <THREADS>  Threads, default 1 [default: 1]
  -v, --verbose...         Logging level [-v: Info, -vv: Debug, -vvv: Trace, defalut: Warn]
```

## wgatools_pafcov

### Tool Description
Calculate coverage for PAF file

### Metadata
- **Docker Image**: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
- **Homepage**: https://github.com/wjwei-handsome/wgatools
- **Package**: https://anaconda.org/channels/bioconda/packages/wgatools/overview
- **Validation**: PASS

### Original Help Text
```text
Calculate coverage for PAF file

Usage: wgatools pafcov [OPTIONS] [INPUT]

Arguments:
  [INPUT]  Input PAF File, None for STDIN

Options:
  -h, --help  Print help

GLOBAL:
  -o, --outfile <OUTFILE>  Output file ("-" for stdout), file name ending in .gz/.bz2/.xz will be compressed automatically [default: -]
  -r, --rewrite            Bool, if rewrite output file [default: false]
  -t, --threads <THREADS>  Threads, default 1 [default: 1]
  -v, --verbose...         Logging level [-v: Info, -vv: Debug, -vvv: Trace, defalut: Warn]
```

## wgatools_paf2chain

### Tool Description
Convert PAF format to Chain format

### Metadata
- **Docker Image**: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
- **Homepage**: https://github.com/wjwei-handsome/wgatools
- **Package**: https://anaconda.org/channels/bioconda/packages/wgatools/overview
- **Validation**: PASS

### Original Help Text
```text
Convert PAF format to Chain format

Usage: wgatools paf2chain [OPTIONS] [INPUT]

Arguments:
  [INPUT]  Input PAF File, None for STDIN

Options:
  -h, --help  Print help

GLOBAL:
  -o, --outfile <OUTFILE>  Output file ("-" for stdout), file name ending in .gz/.bz2/.xz will be compressed automatically [default: -]
  -r, --rewrite            Bool, if rewrite output file [default: false]
  -t, --threads <THREADS>  Threads, default 1 [default: 1]
  -v, --verbose...         Logging level [-v: Info, -vv: Debug, -vvv: Trace, defalut: Warn]
```

## wgatools_chain2maf

### Tool Description
Convert Chain format to MAF format

### Metadata
- **Docker Image**: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
- **Homepage**: https://github.com/wjwei-handsome/wgatools
- **Package**: https://anaconda.org/channels/bioconda/packages/wgatools/overview
- **Validation**: PASS

### Original Help Text
```text
Convert Chain format to MAF format

Usage: wgatools chain2maf [OPTIONS] --target <TARGET> --query <QUERY> [INPUT]

Arguments:
  [INPUT]  Input Chain File, None for STDIN

Options:
  -t, --target <TARGET>  Input target FASTA File, required
  -q, --query <QUERY>    Input query FASTA File, required
  -h, --help             Print help

GLOBAL:
  -o, --outfile <OUTFILE>  Output file ("-" for stdout), file name ending in .gz/.bz2/.xz will be compressed automatically [default: -]
  -r, --rewrite            Bool, if rewrite output file [default: false]
  -t, --threads <THREADS>  Threads, default 1 [default: 1]
  -v, --verbose...         Logging level [-v: Info, -vv: Debug, -vvv: Trace, defalut: Warn]
```

## wgatools_filter

### Tool Description
Filter records for Alignment file

### Metadata
- **Docker Image**: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
- **Homepage**: https://github.com/wjwei-handsome/wgatools
- **Package**: https://anaconda.org/channels/bioconda/packages/wgatools/overview
- **Validation**: PASS

### Original Help Text
```text
Filter records for Alignment file

Usage: wgatools filter [OPTIONS] [INPUT]

Arguments:
  [INPUT]  Input Alignment File, None for STDIN

Options:
  -f, --format <FORMAT>
          Input File format, [default: maf] [possible values: maf, paf, chain]
  -b, --min-block-size <MIN_BLOCK_SIZE>
          Min block size [default: 0]
  -q, --min-query-size <MIN_QUERY_SIZE>
          Min query size, usually for contigs [default: 0]
  -a, --min-align-size <MIN_ALIGN_SIZE>
          Min align size for query-target pair, only for all-to-all alignment paf
  -h, --help
          Print help

GLOBAL:
  -o, --outfile <OUTFILE>  Output file ("-" for stdout), file name ending in .gz/.bz2/.xz will be compressed automatically [default: -]
  -r, --rewrite            Bool, if rewrite output file [default: false]
  -t, --threads <THREADS>  Threads, default 1 [default: 1]
  -v, --verbose...         Logging level [-v: Info, -vv: Debug, -vvv: Trace, defalut: Warn]
```

## wgatools_paf2maf

### Tool Description
Convert PAF format to MAF format

### Metadata
- **Docker Image**: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
- **Homepage**: https://github.com/wjwei-handsome/wgatools
- **Package**: https://anaconda.org/channels/bioconda/packages/wgatools/overview
- **Validation**: PASS

### Original Help Text
```text
Convert PAF format to MAF format

Usage: wgatools paf2maf [OPTIONS] --target <TARGET> --query <QUERY> [INPUT]

Arguments:
  [INPUT]  Input PAF File, None for STDIN

Options:
  -g, --target <TARGET>  Input target FASTA File, required
  -q, --query <QUERY>    Input query FASTA File, required
  -h, --help             Print help

GLOBAL:
  -o, --outfile <OUTFILE>  Output file ("-" for stdout), file name ending in .gz/.bz2/.xz will be compressed automatically [default: -]
  -r, --rewrite            Bool, if rewrite output file [default: false]
  -t, --threads <THREADS>  Threads, default 1 [default: 1]
  -v, --verbose...         Logging level [-v: Info, -vv: Debug, -vvv: Trace, defalut: Warn]
```

## wgatools_maf2chain

### Tool Description
Convert MAF format to Chain format

### Metadata
- **Docker Image**: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
- **Homepage**: https://github.com/wjwei-handsome/wgatools
- **Package**: https://anaconda.org/channels/bioconda/packages/wgatools/overview
- **Validation**: PASS

### Original Help Text
```text
Convert MAF format to Chain format

Usage: wgatools maf2chain [OPTIONS] [INPUT]

Arguments:
  [INPUT]  Input MAF File, None for STDIN

Options:
  -q, --query-name <QUERY_NAME>  Query name when multiple query in MAF, None for first query
  -h, --help                     Print help

GLOBAL:
  -o, --outfile <OUTFILE>  Output file ("-" for stdout), file name ending in .gz/.bz2/.xz will be compressed automatically [default: -]
  -r, --rewrite            Bool, if rewrite output file [default: false]
  -t, --threads <THREADS>  Threads, default 1 [default: 1]
  -v, --verbose...         Logging level [-v: Info, -vv: Debug, -vvv: Trace, defalut: Warn]
```

## wgatools_maf2sam

### Tool Description
DEV: maf2sam

### Metadata
- **Docker Image**: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
- **Homepage**: https://github.com/wjwei-handsome/wgatools
- **Package**: https://anaconda.org/channels/bioconda/packages/wgatools/overview
- **Validation**: PASS

### Original Help Text
```text
DEV: maf2sam

Usage: wgatools maf2sam [OPTIONS] [INPUT]

Arguments:
  [INPUT]  Input MAF File, None for STDIN

Options:
  -h, --help  Print help

GLOBAL:
  -o, --outfile <OUTFILE>  Output file ("-" for stdout), file name ending in .gz/.bz2/.xz will be compressed automatically [default: -]
  -r, --rewrite            Bool, if rewrite output file [default: false]
  -t, --threads <THREADS>  Threads, default 1 [default: 1]
  -v, --verbose...         Logging level [-v: Info, -vv: Debug, -vvv: Trace, defalut: Warn]
```

## wgatools_call

### Tool Description
Call Variants from MAF/PAF file

### Metadata
- **Docker Image**: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
- **Homepage**: https://github.com/wjwei-handsome/wgatools
- **Package**: https://anaconda.org/channels/bioconda/packages/wgatools/overview
- **Validation**: PASS

### Original Help Text
```text
Call Variants from MAF/PAF file

Usage: wgatools call [OPTIONS] [INPUT]

Arguments:
  [INPUT]  Input MAF/PAF File

Options:
  -n, --sample <SAMPLE>            Sample name [default: sample]
  -s, --snp                        If call SNP
  -i, --inv                        If call Inversion
  -l, --svlen <SVLEN>              SV length cutoff [default: 50]
  -f, --format <FORMAT>            [default: maf] [possible values: maf, paf, chain]
      --target <TARGET>            Input target FASTA File, required if input is PAF
  -q, --query <QUERY>              Input query FASTA File, required if input is PAF
      --query-name <QUERY_NAME>    query name when multiple query in MAF, None for first query
      --query-regex <QUERY_REGEX>  Query name regex when multiple query in MAF, None for first query If multiple query names in a block match, the first will be used The --query-regex must match the entire query name in the MAF in order to be considered a match. example: --query-regex "^hg002#.*"
  -c, --chunk-size <CHUNK_SIZE>    Chunk size for MAF Caller [default: 1000000]
  -h, --help                       Print help

GLOBAL:
  -o, --outfile <OUTFILE>  Output file ("-" for stdout), file name ending in .gz/.bz2/.xz will be compressed automatically [default: -]
  -r, --rewrite            Bool, if rewrite output file [default: false]
  -t, --threads <THREADS>  Threads, default 1 [default: 1]
  -v, --verbose...         Logging level [-v: Info, -vv: Debug, -vvv: Trace, defalut: Warn]
```

## wgatools_maf_index

### Tool Description
Build index for MAF file

### Metadata
- **Docker Image**: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
- **Homepage**: https://github.com/wjwei-handsome/wgatools
- **Package**: https://anaconda.org/channels/bioconda/packages/wgatools/overview
- **Validation**: PASS

### Original Help Text
```text
Build index for MAF file

Usage: wgatools maf-index [OPTIONS] <INPUT>

Arguments:
  <INPUT>  Input MAF File

Options:
  -h, --help  Print help

GLOBAL:
  -o, --outfile <OUTFILE>  Output file ("-" for stdout), file name ending in .gz/.bz2/.xz will be compressed automatically [default: -]
  -r, --rewrite            Bool, if rewrite output file [default: false]
  -t, --threads <THREADS>  Threads, default 1 [default: 1]
  -v, --verbose...         Logging level [-v: Info, -vv: Debug, -vvv: Trace, defalut: Warn]
```

## wgatools_stat

### Tool Description
Statistics for Alignment file

### Metadata
- **Docker Image**: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
- **Homepage**: https://github.com/wjwei-handsome/wgatools
- **Package**: https://anaconda.org/channels/bioconda/packages/wgatools/overview
- **Validation**: PASS

### Original Help Text
```text
Statistics for Alignment file

Usage: wgatools stat [OPTIONS] [INPUT]

Arguments:
  [INPUT]  Input Alignment File, None for STDIN

Options:
  -f, --format <FORMAT>          Input File format, [default: maf] [possible values: maf, paf, chain]
  -e, --each                     Show each block's statistics, default: false
  -q, --query-name <QUERY_NAME>  Query name when multiple query in MAF, None for first query
  -h, --help                     Print help

GLOBAL:
  -o, --outfile <OUTFILE>  Output file ("-" for stdout), file name ending in .gz/.bz2/.xz will be compressed automatically [default: -]
  -r, --rewrite            Bool, if rewrite output file [default: false]
  -t, --threads <THREADS>  Threads, default 1 [default: 1]
  -v, --verbose...         Logging level [-v: Info, -vv: Debug, -vvv: Trace, defalut: Warn]
```

## wgatools_chain2paf

### Tool Description
Convert Chain format to PAF format

### Metadata
- **Docker Image**: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
- **Homepage**: https://github.com/wjwei-handsome/wgatools
- **Package**: https://anaconda.org/channels/bioconda/packages/wgatools/overview
- **Validation**: PASS

### Original Help Text
```text
Convert Chain format to PAF format

Usage: wgatools chain2paf [OPTIONS] [INPUT]

Arguments:
  [INPUT]  Input Chain File, None for STDIN

Options:
  -h, --help  Print help

GLOBAL:
  -o, --outfile <OUTFILE>  Output file ("-" for stdout), file name ending in .gz/.bz2/.xz will be compressed automatically [default: -]
  -r, --rewrite            Bool, if rewrite output file [default: false]
  -t, --threads <THREADS>  Threads, default 1 [default: 1]
  -v, --verbose...         Logging level [-v: Info, -vv: Debug, -vvv: Trace, defalut: Warn]
```

## wgatools_chunk

### Tool Description
Chunk MAF file by length

### Metadata
- **Docker Image**: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
- **Homepage**: https://github.com/wjwei-handsome/wgatools
- **Package**: https://anaconda.org/channels/bioconda/packages/wgatools/overview
- **Validation**: PASS

### Original Help Text
```text
Chunk MAF file by length

Usage: wgatools chunk [OPTIONS] --length <LENGTH> [INPUT]

Arguments:
  [INPUT]  Input MAF File, None for STDIN

Options:
  -l, --length <LENGTH>  Chunk by length
  -h, --help             Print help

GLOBAL:
  -o, --outfile <OUTFILE>  Output file ("-" for stdout), file name ending in .gz/.bz2/.xz will be compressed automatically [default: -]
  -r, --rewrite            Bool, if rewrite output file [default: false]
  -t, --threads <THREADS>  Threads, default 1 [default: 1]
  -v, --verbose...         Logging level [-v: Info, -vv: Debug, -vvv: Trace, defalut: Warn]
```

## wgatools_dotplot

### Tool Description
Plot dotplot for Alignment file

### Metadata
- **Docker Image**: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
- **Homepage**: https://github.com/wjwei-handsome/wgatools
- **Package**: https://anaconda.org/channels/bioconda/packages/wgatools/overview
- **Validation**: PASS

### Original Help Text
```text
Plot dotplot for Alignment file

Usage: wgatools dotplot [OPTIONS] [INPUT]

Arguments:
  [INPUT]  Input Alignment File, None for STDIN

Options:
  -f, --format <FORMAT>          Input File format, [default: maf] [possible values: maf, paf, chain]
      --out-format <OUT_FORMAT>  Output format [default: html] [possible values: html, json, csv]
  -m, --mode <MODE>              Plot mode, BaseLevel or Overview [default: base-level] [possible values: base-level, overview]
  -d, --no-identity              do not show identity in Overview mode, default: false
  -l, --length <LENGTH>          Skip segment with length less than cutoff in BaseLevel mode, default: 0
  -q, --query-name <QUERY_NAME>  Query name when multiple query in MAF, None for first query
      --color <COLOR>            Custom colors for CIGAR types in format "M:#FF0000,I:#00FF00,D:#0000FF,MR:#111111"
  -h, --help                     Print help

GLOBAL:
  -o, --outfile <OUTFILE>  Output file ("-" for stdout), file name ending in .gz/.bz2/.xz will be compressed automatically [default: -]
  -r, --rewrite            Bool, if rewrite output file [default: false]
  -t, --threads <THREADS>  Threads, default 1 [default: 1]
  -v, --verbose...         Logging level [-v: Info, -vv: Debug, -vvv: Trace, defalut: Warn]
```

## wgatools_rename

### Tool Description
Rename MAF records with prefix

### Metadata
- **Docker Image**: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
- **Homepage**: https://github.com/wjwei-handsome/wgatools
- **Package**: https://anaconda.org/channels/bioconda/packages/wgatools/overview
- **Validation**: PASS

### Original Help Text
```text
Rename MAF records with prefix

Usage: wgatools rename [OPTIONS] --prefixs <PREFIXS> [INPUT]

Arguments:
  [INPUT]  Input MAF File, None for STDIN

Options:
  -p, --prefixs <PREFIXS>  prefix for rename, split by ',' ordered by input
  -h, --help               Print help

GLOBAL:
  -o, --outfile <OUTFILE>  Output file ("-" for stdout), file name ending in .gz/.bz2/.xz will be compressed automatically [default: -]
  -r, --rewrite            Bool, if rewrite output file [default: false]
  -t, --threads <THREADS>  Threads, default 1 [default: 1]
  -v, --verbose...         Logging level [-v: Info, -vv: Debug, -vvv: Trace, defalut: Warn]
```

## wgatools_maf2paf

### Tool Description
Convert MAF format to PAF format

### Metadata
- **Docker Image**: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
- **Homepage**: https://github.com/wjwei-handsome/wgatools
- **Package**: https://anaconda.org/channels/bioconda/packages/wgatools/overview
- **Validation**: PASS

### Original Help Text
```text
Convert MAF format to PAF format

Usage: wgatools maf2paf [OPTIONS] [INPUT]

Arguments:
  [INPUT]  Input MAF File, None for STDIN

Options:
  -q, --query-name <QUERY_NAME>  Query name when multiple query in MAF, None for first query
  -h, --help                     Print help

GLOBAL:
  -o, --outfile <OUTFILE>  Output file ("-" for stdout), file name ending in .gz/.bz2/.xz will be compressed automatically [default: -]
  -r, --rewrite            Bool, if rewrite output file [default: false]
  -t, --threads <THREADS>  Threads, default 1 [default: 1]
  -v, --verbose...         Logging level [-v: Info, -vv: Debug, -vvv: Trace, defalut: Warn]
```

## wgatools_pafpseudo

### Tool Description
Generate pesudo-maf for divergence analysis from PAF file

### Metadata
- **Docker Image**: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
- **Homepage**: https://github.com/wjwei-handsome/wgatools
- **Package**: https://anaconda.org/channels/bioconda/packages/wgatools/overview
- **Validation**: PASS

### Original Help Text
```text
Generate pesudo-maf for divergence analysis from PAF file

Usage: wgatools pafpseudo [OPTIONS] [INPUT]

Arguments:
  [INPUT]  Input PAF File, None for STDIN

Options:
  -f, --fasta <FASTA>    Input FASTA File with index(support .gz), if None, just output `N`,`1`,`0`,`-`
  -g, --target <TARGET>  select target for output
  -h, --help             Print help

GLOBAL:
  -o, --outfile <OUTFILE>  Output file ("-" for stdout), file name ending in .gz/.bz2/.xz will be compressed automatically [default: -]
  -r, --rewrite            Bool, if rewrite output file [default: false]
  -t, --threads <THREADS>  Threads, default 1 [default: 1]
  -v, --verbose...         Logging level [-v: Info, -vv: Debug, -vvv: Trace, defalut: Warn]
```

## wgatools_maf_ext

### Tool Description
Extract specific region from MAF file with index

### Metadata
- **Docker Image**: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
- **Homepage**: https://github.com/wjwei-handsome/wgatools
- **Package**: https://anaconda.org/channels/bioconda/packages/wgatools/overview
- **Validation**: PASS

### Original Help Text
```text
Extract specific region from MAF file with index

Usage: wgatools maf-ext [OPTIONS] [INPUT]

Arguments:
  [INPUT]  Input MAF File, None for STDIN

Options:
  -r, --regions <REGIONS>  Input regions
  -f, --file <FILE>        Input regions file
  -h, --help               Print help

GLOBAL:
  -o, --outfile <OUTFILE>  Output file ("-" for stdout), file name ending in .gz/.bz2/.xz will be compressed automatically [default: -]
  -r, --rewrite            Bool, if rewrite output file [default: false]
  -t, --threads <THREADS>  Threads, default 1 [default: 1]
  -v, --verbose...         Logging level [-v: Info, -vv: Debug, -vvv: Trace, defalut: Warn]
```

## Metadata
- **Skill**: generated
