# perl-bio-bigfile CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| perl-bio-bigfile_bigWigToWig.pl | PASS |  |
| perl-bio-bigfile_index_bigwigset.pl | PASS |  |
| perl-bio-bigfile_wigToBigWig.pl | PASS |  |

## perl-bio-bigfile_wigToBigWig.pl

### Tool Description
Convert an ASCII wiggle file to an indexed bigWig file

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-bio-bigfile:1.07--pl5321h41f7678_7
- **Homepage**: https://metacpan.org/pod/Bio::DB::BigFile
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-bio-bigfile/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/wigToBigWig.pl in.wig chrom.sizes out.bw
Where in.wig is in one of the ascii wiggle formats, but not including track lines
and chrom.sizes is two column: <chromosome name> <size in bases>
and out.bw is the output indexed big wig file.
```

## perl-bio-bigfile_bigWigToWig.pl

### Tool Description
Dump the contents of a bigWig file as a table

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-bio-bigfile:1.07--pl5321h41f7678_7
- **Homepage**: https://metacpan.org/pod/Bio::DB::BigFile
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-bio-bigfile/overview
- **Validation**: PASS

### Original Help Text
```text
x does not exist at /usr/local/bin/bigWigToWig.pl line 15.
```

## perl-bio-bigfile_index_bigwigset.pl

### Tool Description
Create a skeleton metadata.index file for a directory of bigWig files

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-bio-bigfile:1.07--pl5321h41f7678_7
- **Homepage**: https://metacpan.org/pod/Bio::DB::BigFile
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-bio-bigfile/overview
- **Validation**: PASS

### Original Help Text
```text
Can't call method "read" on an undefined value at /usr/local/lib/perl5/5.32/site_perl/Bio/DB/BigWigSet.pm line 201.
```

## Metadata
- **Skill**: generated

