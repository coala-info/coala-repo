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
2. seqfu bases

# seqfu bases

Counts the number of A, C, G, T and Ns in FASTA and FASTQ files.

```
Introduced in SeqFu 1.15.1 as experimental feature
```

Calculates the composition of DNA sequences

```
Usage: bases [options] [<inputfile> ...]

Print the DNA bases, and %GC content, in the input files

Options:
  -c, --raw-counts       Print counts and not ratios
  -t, --thousands        Print thousands separator
  -a, --abspath          Print absolute path
  -b, --basename         Print the basename of the file
  -n, --nice             Print terminal table
  -d, --digits INT       Number of digits to print [default: 2]
  -H, --header           Print header (auto enabled with --nice)
  -v, --verbose          Verbose output
  --debug                Debug output
  --help                 Show this help
```

### Output

The output is a table with the following columns (`-H` to print the header):

1. Filename (`-a` for absolute path, `-b` for basename)
2. Total bases (`-t` to add thousand separator)
3. Ratio of **A** bases over total bases (`-c` to print raw counts)
4. Ratio of **C** bases over total bases (`-c` to print raw counts)
5. Ratio of **G** bases over total bases (`-c` to print raw counts)
6. Ratio of **T** bases over total bases (`-c` to print raw counts)
7. Ratio of **N** bases over total bases (`-c` to print raw counts)
8. Ratio of **Other** characters (either IUPAC DNA or invalid chars) over total bases (`-c` to print raw counts)
9. %GC ratio
10. Ratio of **Uppercase** bases over total bases (if enabled by `-u`)

### Example

A simple example:

```
seqfu bases --header data/illumina_*

#Filename               Total   A       C       G       T       N       Other   %GC
data/illumina_1.fq.gz   630     18.57   18.57   18.57   18.57   18.57   0.00    59.21
data/illumina_2.fq.gz   630     21.43   21.43   21.43   21.43   21.43   0.00    60.48
data/illumina_nocomm.fq 630     18.57   18.57   18.57   18.57   18.57   0.00    59.21
```

when using `-n` the output is a nice table:

```
┌─────────────────────┬───────┬────────┬────────┬────────┬────────┬──────┬───────┬────────┬───────────┐
│ File                │ Bases │ A      │ C      │ G      │ T      │ N    │ Other │ %GC    │ Uppercase │
├─────────────────────┼───────┼────────┼────────┼────────┼────────┼──────┼───────┼────────┼───────────┤
│ data/base_at.fa     │ 33    │ 42.42  │ 0.00   │ 0.00   │ 57.58  │ 0.00 │ 0.00  │ 0.00   │ 100.00    │
│ data/bases_lower.fa │ 15    │ 33.33  │ 26.67  │ 20.00  │ 13.33  │ 6.67 │ 0.00  │ 46.67  │ 0.00      │
│ data/base_c.fa      │ 5     │ 0.00   │ 100.00 │ 0.00   │ 0.00   │ 0.00 │ 0.00  │ 100.00 │ 0.00      │
│ data/base.fa        │ 2     │ 50.00  │ 50.00  │ 0.00   │ 0.00   │ 0.00 │ 0.00  │ 50.00  │ 100.00    │
│ data/upper-none.fa  │ 7     │ 42.86  │ 14.29  │ 28.57  │ 14.29  │ 0.00 │ 0.00  │ 42.86  │ 0.00      │
│ data/base_t.fa      │ 5     │ 0.00   │ 0.00   │ 0.00   │ 100.00 │ 0.00 │ 0.00  │ 0.00   │ 0.00      │
│ data/base_a.fa      │ 5     │ 100.00 │ 0.00   │ 0.00   │ 0.00   │ 0.00 │ 0.00  │ 0.00   │ 100.00    │
│ data/upper-lower.fa │ 10    │ 50.00  │ 50.00  │ 0.00   │ 0.00   │ 0.00 │ 0.00  │ 50.00  │ 50.00     │
│ data/base_g.fa      │ 1     │ 0.00   │ 0.00   │ 100.00 │ 0.00   │ 0.00 │ 0.00  │ 100.00 │ 100.00    │
│ data/upper-only.fa  │ 9     │ 44.44  │ 11.11  │ 44.44  │ 0.00   │ 0.00 │ 0.00  │ 55.56  │ 100.00    │
│ data/base_extra.fa  │ 20    │ 50.00  │ 0.00   │ 0.00   │ 0.00   │ 0.00 │ 50.00 │ 0.00   │ 100.00    │
│ data/base_cg.fa     │ 25    │ 0.00   │ 52.00  │ 48.00  │ 0.00   │ 0.00 │ 0.00  │ 100.00 │ 100.00    │
└─────────────────────┴───────┴────────┴────────┴────────┴────────┴──────┴───────┴────────┴───────────┘
```

---

[Back to top](#top)

Copyright © 2019-2025 Andrea Telatin. Distributed by an [MIT license](https://github.com/telatin/seqfu2/blob/main/LICENSE).

This site uses [Just the Docs](https://github.com/just-the-docs/just-the-docs), a documentation theme for Jekyll.