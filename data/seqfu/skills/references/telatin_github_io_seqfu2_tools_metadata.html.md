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
2. seqfu metadata

# seqfu metadata

Given one (or more) directories containing sequencing reads, this tool produces a metadata file by extracting the ID from the filename and optionally adding file paths or read counts.

## Usage

```
Usage:
  metadata [options] [<dir>...]
  metadata formats

Prepare mapping files from directory containing FASTQ files

Options:
  -1, --for-tag STR      String found in filename of forward reads [default: _R1]
  -2, --rev-tag STR      String found in filename of forward reads [default: _R2]
  -s, --split STR        Separator used in filename to identify the sample ID [default: _]
  --pos INT...           Which part of the filename is the Sample ID [default: 1]

  -f, --format TYPE      Output format: dadaist, irida, manifest,... list to list [default: manifest]
  -p, --add-path         Add the reads absolute path as column
  -c, --counts           Add the number of reads as a property column (experimental)
  -t, --threads INT      Number of simultaneously opened files (legacy: ignored)
  --pe                   Enforce paired-end reads (not supported)
  --ont                  Long reads (Oxford Nanopore) [default: false]

  GLOBAL OPTIONS
  --abs                  Force absolute path
  --basename             Use basename instead of full path
  --force-tsv            Force '\t' separator, otherwise selected by the format
  --force-csv            Force ',' separator, otherwise selected by the format
  -R, --rand-meta INT    Add a random metadata column with INT categories

  FORMAT SPECIFIC OPTIONS
  -P, --project INT      Project ID (only for irida)
  --meta-split STR       Separator in the SampleID to extract metadata, used in MetaPhage [default: _]
  --meta-part INT        Which part of the SampleID to extract metadata, used in MetaPhage [default: 1]
  --meta-default STR     Default value for metadata, used in MetaPhage [default: Cond]

  -v, --verbose          Verbose output
  --debug                Debug output
  -h, --help             Show this help
```

## Output formats

SeqFu metadata now supports the following output formats:

1. **manifest**: Used as import manifest for [Qiime2](https://qiime2.org/) artifacts.
2. **qiime1**: Forward-compatible [Qiime1](http://qiime.org/) mapping file.
3. **qiime2**: [Qiime2](https://qiime2.org/) metadata file.
4. **dadaist**: [Dadaist2](https://quadram-institute-bioscience.github.io/dadaist2) compatible metadata.
5. **lotus**: [Lotus](http://lotus2.earlham.ac.uk/) mapping file (tested with Lotus1).
6. **irida**: [IRIDA uploader](https://github.com/phac-nml/irida-uploader) sample sheet. Requires `-P PROJECTID`.
7. **metaphage**: [MetaPhage](https://mattiapandolfovr.github.io/MetaPhage) metadata file. Use `--meta-split`, `--meta-part`, and `--meta-default` to customize a Treatment column.
8. **ampliseq**: [nf-core/ampliseq](https://nf-co.re/ampliseq) metadata file.
9. **rnaseq**: [nf-core/rnaseq](https://nf-co.re/rnaseq) metadata file.
10. **bactopia**: [Bactopia](https://bactopia.github.io/) FOFN (File of File Names) file.
11. **mag**: [nf-core/mag](https://nf-co.re/mag) metadata file.

## New Features

* Support for `--format bactopia` to generate Bactopia FOFN files.
* Added `--ont` option for long reads (Oxford Nanopore Technology).
* Enhanced support for various bioinformatics pipelines (ampliseq, rnaseq, mag).

## Examples

### Manifest (default)

```
seqfu metadata ./MiSeq_SOP/
```

Output:

```
sample-id	forward-absolute-filepath	reverse-absolute-filepath
F3D0	/Users/telatin/MiSeq_SOP/F3D0_S188_L001_R1_001.fastq.gz	/Users/telatin/MiSeq_SOP/F3D0_S188_L001_R2_001.fastq.gz
F3D1	/Users/telatin/MiSeq_SOP/F3D1_S189_L001_R1_001.fastq.gz	/Users/telatin/MiSeq_SOP/F3D1_S189_L001_R2_001.fastq.gz
...
```

### Qiime1 mapping file

```
seqfu metadata MiSeq_SOP -f qiime1 --add-path --counts
```

Output:

```
#SampleID	Counts	Paths
F3D0	7793	F3D0_S188_L001_R1_001.fastq.gz,F3D0_S188_L001_R2_001.fastq.gz
F3D1	5869	F3D1_S189_L001_R1_001.fastq.gz,F3D1_S189_L001_R2_001.fastq.gz
...
```

### IRIDA uploader

```
seqfu metadata -f irida -P 123 data/pe/
```

Output:

```
Sample_Name,Project_ID,File_Forward,File_Reverse
sample1,123,sample1_R1.fq.gz,sample1_R2.fq.gz
sample2,123,sample2_R1.fq.gz,sample2_R2.fq.gz
```

### Bactopia FOFN

```
seqfu metadata -f bactopia data/pe/
```

For ONT data, add `--ont`

Output:

```
sample	runtype	r1	r2
sample1	paired-end	/path/to/data/pe/sample1_R1.fq.gz	/path/to/data/pe/sample1_R2.fq.gz
sample2	paired-end	/path/to/data/pe/sample2_R1.fq.gz	/path/to/data/pe/sample2_R2.fq.gz
```

## Notes

* Use `--add-path` to include full file paths in the output (when supported by the format).
* The `--counts` option adds read counts to the output (experimental feature, not supported by all formats).
* Format-specific options (like `--project` for IRIDA) are required for certain output types.
* Use `--verbose` for detailed processing information and `--debug` for troubleshooting.

For more information on each format and its specific options, please refer to the respective tool’s documentation.

---

[Back to top](#top)

Copyright © 2019-2025 Andrea Telatin. Distributed by an [MIT license](https://github.com/telatin/seqfu2/blob/main/LICENSE).

This site uses [Just the Docs](https://github.com/just-the-docs/just-the-docs), a documentation theme for Jekyll.