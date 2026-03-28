[Skip to main content](#main-content)   Link      Menu      Expand       (external link)    Document      Search       Copy       Copied

* [Home](/seqfu2/)
* [Installation](/seqfu2/installation)
* [Overview](/seqfu2/intro)
* [Core Tools](/seqfu2/tools/README.html)
  + [seqfu bases](/seqfu2/tools/bases.html)
  + [seqfu cat](/seqfu2/tools/cat.html)
  + [seqfu check](/seqfu2/tools/check.html)
  + [seqfu count](/seqfu2/tools/count.html)
  + [seqfu deinterleave](/seqfu2/tools/deinterleave.html)
  + [seqfu derep](/seqfu2/tools/derep.html)
  + [seqfu grep](/seqfu2/tools/grep.html)
  + [seqfu head](/seqfu2/tools/head.html)
  + [seqfu interleave](/seqfu2/tools/interleave.html)
  + [seqfu lanes](/seqfu2/tools/lanes.html)
  + [seqfu less](/seqfu2/tools/less.html)
  + [seqfu list](/seqfu2/tools/list.html)
  + [seqfu merge](/seqfu2/tools/merge.html)
  + [seqfu metadata](/seqfu2/tools/metadata.html)
  + [seqfu qual](/seqfu2/tools/qual.html)
  + [seqfu rc](/seqfu2/tools/rc.html)
  + [seqfu rotate](/seqfu2/tools/rotate.html)
  + [seqfu sort](/seqfu2/tools/sort.html)
  + [seqfu stats](/seqfu2/tools/stats.html)
  + [seqfu tabulate](/seqfu2/tools/tabulate.html)
  + [seqfu tail](/seqfu2/tools/tail.html)
  + [seqfu tofasta](/seqfu2/tools/tofasta.html)
  + [seqfu trim](/seqfu2/tools/trim.html)
  + [seqfu view](/seqfu2/tools/view.html)
  + [seqfu orf](/seqfu2/tools/orf.html)
  + [seqfu tabcheck](/seqfu2/tools/tabcheck.html)
* [Usage Guide](/seqfu2/usage)
* [Utilities](/seqfu2/utilities/README.html)
  + [fu-16Sregion](/seqfu2/utilities/fu-16Sregion.html)
  + [fu-cov](/seqfu2/utilities/fu-cov.html)
  + [fu-homocom](/seqfu2/utilities/fu-homocomp.html)
  + [fu-index](/seqfu2/utilities/fu-index.html)
  + [fu-msa](/seqfu2/utilities/fu-msa.html)
  + [fu-multirelabel](/seqfu2/utilities/fu-multirelabel.html)
  + [fu-nanotags](/seqfu2/utilities/fu-nanotags.html)
  + [fu-orf](/seqfu2/utilities/fu-orf.html)
  + [fu-primers](/seqfu2/utilities/fu-primers.html)
  + [fu-shred](/seqfu2/utilities/fu-shred.html)
  + [fu-sw](/seqfu2/utilities/fu-sw.html)
  + [fu-tabcheck](/seqfu2/utilities/fu-tabcheck.html)
  + [fu-virfilter](/seqfu2/utilities/fu-virfilter.html)
* [Helper Utilities](/seqfu2/scripts/README.html)
  + [fu-pecheck](/seqfu2/scripts/fu-pecheck.html)
  + [fu-split](/seqfu2/scripts/fu-split.html)
* [About](/seqfu2/about)
* [Releases](/seqfu2/releases/README.html)
  + [History](/seqfu2/releases/history.html)

This site uses [Just the Docs](https://github.com/just-the-docs/just-the-docs), a documentation theme for Jekyll.

Search SeqFu Documentation

* [GitHub Repository](https://github.com/telatin/seqfu2)
* [Report Issue](https://github.com/telatin/seqfu2/issues)

1. [Core Tools](/seqfu2/tools/README.html)
2. seqfu orf

# seqfu orf

Extract open reading frames (ORFs) from nucleotide sequences (FASTA/FASTQ, gzipped supported).

`seqfu orf` is the preferred command.
 The legacy binary `fu-orf` is still available and accepts the same options.

```
orf - extract ORF from nucleotide sequences

Usage:
  orf [options] <InputFile>
  orf [options] -1 File_R1.fq
  orf [options] -1 File_R1.fq -2 File_R2.fq
  orf --help | --codes

Input files:
  -1, --R1 FILE           First paired end file
  -2, --R2 FILE           Second paired end file

ORF Finding and Output options:
  -m, --min-size INT      Minimum ORF size (aa) [default: 25]
  -p, --prefix STRING     Rename reads using this prefix
  -r, --scan-reverse      Also scan reverse complemented sequences
  -c, --code INT          NCBI Genetic code to use [default: 1]
  -l, --min-read-len INT  Minimum read length to process [default: 25]
  -t, --translate         Consider input CDS

Paired-end options:
  -j, --join              Attempt Paired-End joining
  --min-overlap INT       Minimum PE overlap [default: 12]
  --max-overlap INT       Maximum PE overlap [default: 200]
  --min-identity FLOAT    Minimum sequence identity in overlap [default: 0.80]

Other options:
  --codes                 Print NCBI genetic codes and exit
  --pool-size INT         Reads per batch [default: 250]
  --in-flight-batches INT Max buffered batches before flush; 0 = auto [default: 0]
  --verbose               Print verbose log
  --debug                 Print debug log
  --help                  Show help
```

## Notes

* `--max-overlap` is a hard cap during paired-end overlap scan.
* `--in-flight-batches` controls memory/throughput balance:
  + lower values use less RAM
  + higher values can improve throughput
  + `0` enables automatic sizing

## Examples

Single input file:

```
seqfu orf --min-size 500 data/orf.fa.gz
```

Paired-end reads:

```
seqfu orf --min-size 29 -1 data/illumina_1.fq.gz -2 data/illumina_2.fq.gz
```

Paired-end with join and tighter memory budget:

```
seqfu orf -j --min-size 29 --in-flight-batches 4 -1 data/illumina_1.fq.gz -2 data/illumina_2.fq.gz
```

Legacy equivalent:

```
fu-orf --min-size 29 -1 data/illumina_1.fq.gz -2 data/illumina_2.fq.gz
```

## Genetic codes

Use `--code` to select an NCBI genetic code.
 Run `seqfu orf --codes` (or `fu-orf --codes`) to print supported codes.

---

[Back to top](#top)

Copyright © 2019-2025 Andrea Telatin. Distributed by an [MIT license](https://github.com/telatin/seqfu2/blob/main/LICENSE).

This site uses [Just the Docs](https://github.com/just-the-docs/just-the-docs), a documentation theme for Jekyll.