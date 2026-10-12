# pairix CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pairix | PASS | Index file identical to the reference .px2, a region query and the chromosome list match the data. |
| pairix_fragment_4dnpairs | PASS | synthetic data: evenly spaced restriction-site file (the image has no default); frag columns computed. |
| pairix_juicer_shortform2pairs | PASS | Output matches the repository sample or the input line counts. |
| pairix_merged_nodup2pairs | PASS | Output matches the repository sample or the input line counts. |
| pairix_old_merged_nodup2pairs | PASS | Output matches the repository sample or the input line counts. |
| pairix_pairs_merger | PASS | Output matches the repository sample or the input line counts. |
| pairix_streamer_1d | PASS | Output matches the repository sample or the input line counts. |

## pairix

### Tool Description
PAIRs file IndeXer

### Metadata
- **Docker Image**: quay.io/biocontainers/pairix:0.3.9--py312h4711d71_0
- **Homepage**: https://github.com/4dn-dcic/pairix
- **Package**: https://anaconda.org/channels/bioconda/packages/pairix/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pairix/overview
- **Total Downloads**: 173.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/4dn-dcic/pairix
- **Stars**: N/A
### Original Help Text
```text
Program: pairix (PAIRs file IndeXer)
Version: 0.3.8

Usage:   pairix <in.pairs.gz> [region1 [region2 [...]]]

Options: -p STR     preset: pairs, merged_nodups, old_merged_nodups, gff, bed, sam, vcf, psltbl [gff]
         -s INT     sequence name column [1]
         -d INT     second sequence name column [null]
         -b INT     start1 column [4]
         -e INT     end1 column; can be identical to '-b' [5]
         -u INT     start2 column [null]
         -v INT     end2 column; can be identical to '-u' [null or identical to the start2 specified by -u]
         -T         delimiter is space instead of tab.
         -L         query region is not a string but a file listing query regions
         -S INT     skip first INT lines [0]
         -c CHAR    symbol for comment/meta lines [#]
         -w CHAR    symbol for query region separator [|]
         -r FILE    replace the header with the content of FILE [null]
         -0         zero-based coordinate
         -h         print also the header lines
         -H         print only the header lines
         -B         print only the number of bgzf blocks for existing chromosome (pairs)
         -W         print only the region split character
         -Y         Only check if the file is a triangle (i.e. a chromosome pair occurs only in one direction (e.g. if chr1|chr2 exists, chr2|chr1 doesn't))
         -l         list chromosome names
         -n         print only the total line count (same as gunzip -c | wc -l but much faster)
         -f         force to overwrite the index
         -a         autoflip query when the matching chromosome pair doesn't exist
         --help     print usage with exit 0
```

## pairix_pairs_merger

### Tool Description
Merge several sorted, indexed pairs files into one sorted stream.

### Metadata
- **Docker Image**: quay.io/biocontainers/pairix:0.3.9--py312h4711d71_0
- **Homepage**: https://github.com/4dn-dcic/pairix
- **Package**: https://anaconda.org/channels/bioconda/packages/pairix/overview
- **Validation**: PASS

### Original Help Text
```text
Program: pairs_merger
Version: 0.3.8

Usage:   pairs_merger <in1.pairs.gz> <in2.pairs.gz> <in3.pairs.gz> ... | bgzip -c  > out.pairs.gz
```

## pairix_streamer_1d

### Tool Description
Convert a file sorted by chr1-chr2-pos1-pos2 to a stream sorted by chr1-pos1.

### Metadata
- **Docker Image**: quay.io/biocontainers/pairix:0.3.9--py312h4711d71_0
- **Homepage**: https://github.com/4dn-dcic/pairix
- **Package**: https://anaconda.org/channels/bioconda/packages/pairix/overview
- **Validation**: PASS

### Original Help Text
```text
Program: streamer_1d
Version: 0.3.8

Resorter (convert a file sorted by chr1-chr2-pos1-pos2 to a stream sorted by chr1-pos1)

Usage:   streamer_1d in.2d.pairs.gz > out.1d.pairs
Usage:   streamer_1d in.2d.pairs.gz | bgzip -c  > out.1d.pairs.gz
```

## pairix_merged_nodup2pairs

### Tool Description
Convert Juicer merged_nodups.txt to 4DN pairs format.

### Metadata
- **Docker Image**: quay.io/biocontainers/pairix:0.3.9--py312h4711d71_0
- **Homepage**: https://github.com/4dn-dcic/pairix
- **Package**: https://anaconda.org/channels/bioconda/packages/pairix/overview
- **Validation**: PASS

### Original Help Text
```text
usage: /usr/local/bin/merged_nodup2pairs.pl [-s|--split_sort <nsplit>] [-m|--mapq <max_removed_mapq> merged_nodups.txt chrom_size outprefix
Requires sort and bgzip
```

## pairix_old_merged_nodup2pairs

### Tool Description
Convert old-format Juicer merged_nodups.txt to 4DN pairs format.

### Metadata
- **Docker Image**: quay.io/biocontainers/pairix:0.3.9--py312h4711d71_0
- **Homepage**: https://github.com/4dn-dcic/pairix
- **Package**: https://anaconda.org/channels/bioconda/packages/pairix/overview
- **Validation**: PASS

### Original Help Text
```text
usage: /usr/local/bin/old_merged_nodup2pairs.pl [-s|--split_sort <nsplit>] [-m|--mapq <max_removed_mapq> merged_nodups.txt chrom_size outprefix
Requires sort and bgzip
```

## pairix_juicer_shortform2pairs

### Tool Description
Convert Juicer short-form files to 4DN pairs format.

### Metadata
- **Docker Image**: quay.io/biocontainers/pairix:0.3.9--py312h4711d71_0
- **Homepage**: https://github.com/4dn-dcic/pairix
- **Package**: https://anaconda.org/channels/bioconda/packages/pairix/overview
- **Validation**: PASS

### Original Help Text
```text
usage: /usr/local/bin/juicer_shortform2pairs.pl [-s|--split_sort <nsplit>] input.txt chrom_size outprefix
Requires sort and bgzip
```

## pairix_fragment_4dnpairs

### Tool Description
Add restriction-fragment columns to a 4DN pairs file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pairix:0.3.9--py312h4711d71_0
- **Homepage**: https://github.com/4dn-dcic/pairix
- **Package**: https://anaconda.org/channels/bioconda/packages/pairix/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fragment_4dnpairs.pl [--allow-replacement] <infile> <outfile> [site file]
 <infile>: file in intermediate format to calculate statistics on
 <outfile>: output, results of fragment search
 [site file]: list of restriction sites, one line per chromosome (default DpnII hg19)
 --allow-replacement : allows replacing existing frag1/frag2 columns. Default: abort if the columns already exist.
```
