[fuc](index.html)

latest

Contents:

* [README](readme.html)
* [Glossary](glossary.html)
* [CLI](cli.html)
* [API](api.html)
* [Tutorials](tutorials.html)
* Changelog
  + [0.38.0 (2024-06-16)](#id1)
  + [0.37.0 (2023-09-09)](#id2)
  + [0.36.0 (2022-08-12)](#id3)
  + [0.35.0 (2022-07-12)](#id4)
  + [0.34.0 (2022-06-08)](#id5)
  + [0.33.1 (2022-05-03)](#id6)
  + [0.32.0 (2022-04-02)](#id7)
  + [0.31.0 (2022-03-01)](#id8)
  + [0.30.0 (2022-02-05)](#id9)
  + [0.29.0 (2021-12-19)](#id10)
  + [0.28.0 (2021-12-05)](#id11)
  + [0.27.0 (2021-11-20)](#id12)
  + [0.26.0 (2021-10-24)](#id13)
  + [0.25.0 (2021-10-09)](#id14)
  + [0.24.0 (2021-10-02)](#id15)
  + [0.23.0 (2021-09-21)](#id16)
  + [0.22.0 (2021-09-04)](#id17)
  + [0.21.0 (2021-08-16)](#id18)
  + [0.20.0 (2021-08-07)](#id19)
  + [0.19.0 (2021-07-31)](#id20)
  + [0.18.0 (2021-07-20)](#id21)
  + [0.17.0 (2021-07-08)](#id22)
  + [0.16.0 (2021-07-02)](#id23)
  + [0.15.0 (2021-06-24)](#id24)
  + [0.14.0 (2021-06-20)](#id25)
  + [0.13.0 (2021-06-16)](#id26)
  + [0.12.0 (2021-06-12)](#id27)
  + [0.11.0 (2021-06-10)](#id28)
  + [0.10.0 (2021-06-03)](#id29)
  + [0.9.0 (2021-06-01)](#id30)
  + [0.8.0 (2021-05-27)](#id31)
  + [0.7.0 (2021-05-23)](#id32)
  + [0.6.0 (2021-05-16)](#id33)
  + [0.5.0 (2021-05-06)](#id34)
  + [0.4.1 (2021-05-03)](#id35)
  + [0.3.2 (2021-04-30)](#id36)
  + [0.2.0 (2021-04-26)](#id37)
  + [0.1.4 (2021-04-21)](#id38)

[fuc](index.html)

* Changelog
* [Edit on GitHub](https://github.com/sbslee/fuc/blob/main/docs/changelog.rst)

---

# Changelog[](#changelog "Permalink to this heading")

## 0.38.0 (2024-06-16)[](#id1 "Permalink to this heading")

* Update `pyvcf.has_chr_prefix()` method to ignore the HLA contigs for GRCh38.
* [#71](https://github.com/sbslee/fuc/issues/71): Deprecate `common.plot_cytobands()` method.

## 0.37.0 (2023-09-09)[](#id2 "Permalink to this heading")

* [#67](https://github.com/sbslee/fuc/issues/67): Fix bug in `pymaf.MafFrame.plot_waterfall()` method where `count=1` was causing color mismatch.
* Add new submodule `pychip`.
* Add new method `common.reverse_complement()`.
* Fix bug in `common.extract_sequence()` method where a long DNA sequence output was truncated.
* [#68](https://github.com/sbslee/fuc/issues/68): Refresh the variant consequences database from Ensembl VEP. The database’s latest update was on May 31, 2021.

## 0.36.0 (2022-08-12)[](#id3 "Permalink to this heading")

* `fuc` now has a citation! Please refer to the publication “[ClinPharmSeq: A targeted sequencing panel for clinical pharmacogenetics implementation](https://doi.org/10.1371/journal.pone.0272129)” by Lee et al., 2022 (Steven is the first author). Fore more details, see the Citation section in README.
* Update `pyvcf` submodule to accept “sites-only” VCF.
* Add new method `pyvcf.VcfFrame.filter_gsa()`.
* Add new method `pyvcf.VcfFrame.duplicated()`.
* Add new optional argument `to_csv` to `pymaf.MafFrame.plot_regplot_tmb()` method.
* Add new optional argument `count` to `pymaf.MafFrame.plot_mutated_matched()` method.

## 0.35.0 (2022-07-12)[](#id4 "Permalink to this heading")

* Fix bug in `pyvcf.VcfFrame.pseudophase()` method.
* Add new methods `pyvcf.VcfFrame.diploidize()` and `pyvcf.gt_diploidize()`.
* Update `pyvcf.VcfFrame.get_af()` method to handle situations where there are multiple records with the same `REF` allele.
* Add new method `pymaf.MafFrame.plot_regplot_tmb()`.
* Rename `pyvcf.VcfFrame.plot_regplot()` method to `pyvcf.VcfFrame.plot_regplot_tmb()` and `pymaf.MafFrame.plot_regplot()` method to `pymaf.MafFrame.plot_regplot_gene()`.

## 0.34.0 (2022-06-08)[](#id5 "Permalink to this heading")

* Add new optional argument `--stranded` to **ngs-quant** command.
* Add new method `pycov.CovFrame.merge()`.
* Add new method `pycov.merge()`.
* [#61](https://github.com/sbslee/fuc/issues/61): Update `pymaf.MafFrame.from_vcf()` method to automatically detect CSQ field in INFO column (thanks [@lbeltrame](https://github.com/lbeltrame)).
* [#63](https://github.com/sbslee/fuc/issues/63): Update `pyvcf.VcfFrame.sort()` method to handle contigs that are not pre-defined.

## 0.33.1 (2022-05-03)[](#id6 "Permalink to this heading")

* Add new method `pybam.index()` which simply wraps `pysam.index()` method.
* Update **bam-index** command to use `pybam.index()` method.
* Add new method `pybam.slice()`.
* Update **bam-slice** command to use `pybam.slice()` method.
* Update **ngs-bam2fq** and **ngs-fq2bam** commands to allow users to run in local environment.
* Update **ngs-fq2bam** command to handle cases where input FASTQ does not have information on flowcell and barcode.
* Update `pyvcf.call()` method to run more efficiently.

## 0.32.0 (2022-04-02)[](#id7 "Permalink to this heading")

* Add new optional argument `filter_off` to `pykallisto.KallistoFrame` constructor, which is useful for generating a simple count or tpm matrix.
* Add new optional argument `--dir-path` to **vcf-call** command for storing intermediate files.
* Add new optional argument `--gap_frac` to **vcf-call** command so that users can control indel calling sensitivity.
* Add new optional argument `--group-samples` to **vcf-call** command so that users can group samples into populations and apply the HWE assumption within but not across the populations.
* Fix minor bug in `pyvcf.call()` method when `pybed.BedFrame` object is given as `regions`.

## 0.31.0 (2022-03-01)[](#id8 "Permalink to this heading")

* Fix bug in `pykallisto.KallistoFrame.compute_fold_change()` method.
* Add new method `pyvcf.call()` and new command **vcf-call**.
* Combine optional arguments `bam` and `fn` into single positional argument `bams` for `pycov.CovFrame.from_bam()` method. The same goes for **bam-depth** command (combine `--bam` and `--fn` into `bams`).
* Combine optional arguments `bed` and `region` into single optional argument `regions` for `pycov.CovFrame.from_bam()` method. The same goes for **bam-depth** command (combine `--bed` and `--region` into `--regions`).
* Update `pycov.CovFrame.from_bam()` method and **bam-depth** command to automatically handle the ‘chr’ string.
* Rename `pyvcf.VcfFrame.variants()` method to `pyvcf.VcfFrame.to_variants()`.
* Add new optional arguments `force` and `missing` to `pyvcf.row_updateinfo()` method.
* Add new method `pyvcf.gt_ploidy()`.
* Update `pyvcf.gt_polyp()` method to use `pyvcf.gt_ploidy()` method internally.
* [#53](https://github.com/sbslee/fuc/issues/53): Add new methods to compute AC/AN/AF in the INFO column: `pyvcf.row_computeinfo()` and `pyvcf.VcfFrame.compute_info()`.
* [#54](https://github.com/sbslee/fuc/issues/54): Update `pyvcf.VcfFrame.cfilter_empty()` method so that users can control missingness threshold for filtering samples.
* Rename `pyvcf.VcfFrame.cfilter_empty()` method to `pyvcf.VcfFrame.empty_samples()`.
* Update `common.sort_regions()` method to support regions containing an ALT contig (e.g. chr16\_KI270854v1\_alt).

## 0.30.0 (2022-02-05)[](#id9 "Permalink to this heading")

* Update **fuc-find** command to allow users to control whether to use recursive retrieving.
* Add new command **ngs-trim**.
* Add new command **ngs-quant**.
* Add new submodule `pykallisto`.
* Update `pycov.CovFrame.from_bam()` method to use filename as sample name when the SM tag is missing.
* Add new method `pyvcf.row_phased()`. From now on, it’s used to get the `pyvcf.VcfFrame.phased` property.
* Add new method `pyvcf.split()` and **vcf-split** command for splitting VCF by individual.
* Update `pyvcf.merge()` method, `pyvcf.VcfFrame.merge()` method, and **vcf-merge** command to automatically handle the ‘chr’ string.

## 0.29.0 (2021-12-19)[](#id10 "Permalink to this heading")

* Add new property `pyvcf.VcfFrame.phased`.
* Update `pyvcf.VcfFrame.slice()` method to automatically handle the ‘chr’ string.
* Add new argument `--thread` to **ngs-hc** command. This argument will be used to set `--native-pair-hmm-threads` for GATK’s **HaplotypeCaller** command, `--reader-threads` for GATK’s **GenomicsDBImport** command, and `-XX:ParallelGCThreads` and `-XX:ConcGCThreads` for Java.
* Add new argument `--batch` to **ngs-hc** command. This argument will be used to set `--batch-size` for GATK’s **GenomicsDBImport** command.
* Update **ngs-bam2fq** command to fix the SGE issue that outputs an error like `Unable to run job: denied: "XXXXX" is not a valid object name (cannot start with a digit)`.
* Update **ngs-hc** command so that when `--posix` is set, it will use `--genomicsdb-shared-posixfs-optimizations` argument from GATK’s **GenomicsDBImport** command in addition to exporting relevant shell variable (i.e. `export TILEDB_DISABLE_FILE_LOCKING=1`).
* Add new argument `--job` to **ngs-fq2bam** command.
* Update **ngs-fq2bam** command so that BAM creation step and BAM processing step are now in one step.
* Update **ngs-fq2bam** command so that `--thread` is now also used to set `-XX:ParallelGCThreads` and `-XX:ConcGCThreads` for Java.
* Add new method `common.parse_list_or_file()`.

## 0.28.0 (2021-12-05)[](#id11 "Permalink to this heading")

* Update `pyvcf.VcfFrame.filter_empty()` method so that users can choose a varying number of missing genotypes as threshold.
* Add new method `pyvcf.plot_af_correlation()`.
* Update **bam-slice** command to support BED file as input for specifying regions. Additionally, from now on, the command will automatically handle the annoying ‘chr’ prefix.
* Add new method `pycov.CovFrame.matrix_uniformity()`.
* Fix bug in `pyvcf.slice()` method when the input region is missing start or end.
* Add new command **ngs-bam2fq**.
* Add new command **fa-filter**.
* Update `pycov.CovFrame.plot_region()` and `pyvcf.VcfFrame.plot_region()` methods to raise an error if the CovFrame/VcfFrame is empty.
* Update `pyvcf.VcfFrame.filter_*()` methods so that they don’t raise an error when the VcfFrame is empty (i.e. will return the empty VcfFrame).
* Update `common.plot_exons()` method to not italicize text by default (use `name='$text$'` to italicize).
* Add new argument `--posix` to **ngs-hc** command.
* Add new method `common.AnnFrame.subset()`.
* Update `common.AnnFrame.plot_annot()` method to raise an error if user provides an invalid group in `group_order`.
* Add new method `pymaf.MafFrame.get_gene_concordance()`.

## 0.27.0 (2021-11-20)[](#id12 "Permalink to this heading")

* Rename `file` argument to `vcf` for **vcf-slice** command.
* Add new command **vcf-index**.
* Add new method `pyvcf.has_chr_prefix()`.
* Add new command `common.update_chr_prefix()`.
* Update `pyvcf.slice()` method to automatically handle the ‘chr’ prefix.
* Fix bug caused by a typo in `pyvcf.VcfFrame.filter_sampany()` method.

## 0.26.0 (2021-10-24)[](#id13 "Permalink to this heading")

* Add new method `pybam.count_allelic_depth()`.
* Update `common.parse_variant()` method to handle position-only strings as input (e.g. ‘22-42127941-G-A’ vs. ‘22-42127941’).
* Add new command **bam-aldepth**.
* Rename `pybam.has_chr()` method to `pybam.has_chr_prefix()`.
* Rename `pybed.BedFrame.chr_prefix()`, `pycov.CovFrame.chr_prefix()`, `pyvcf.VcfFrame.chr_prefix()` methods to `pybed.BedFrame.update_chr_prefix()`, `pycov.CovFrame.update_chr_prefix()`, `pyvcf.VcfFrame.update_chr_prefix()`.
* Add new properties `pybed.BedFrame.has_chr_prefix`, `pycov.CovFrame.has_chr_prefix`, `pyvcf.VcfFrame.has_chr_prefix`.
* Add new method `pyvcf.slice()`.
* Add new method `pyvcf.VcfFrame.from_string()`.
* Remove `nrows` argument from `pyvcf.VcfFrame.from_file()` method.
* Add new argument `regions` to `pyvcf.VcfFrame.from_file()` method.
* Add new property `pybed.BedFrame.shape`.
* Add new method `pybed.BedFrame.to_regions()`.
* Add new method `pybed.BedFrame.from_regions()`.
* Update `pyvcf.VcfFrame.from_file()` method to accept BED data to specify regions of interest.
* Update **vcf-slice** command to run significantly faster by allowing random access.
* Add new method `common.sort_regions()`.
* Fix minor bug in `pyvcf.VcfFrame.get_af()` method when the variant of interest does not exist in VcfFrame.

## 0.25.0 (2021-10-09)[](#id14 "Permalink to this heading")

* Add new method `common.sort_variants()`.
* Add new method `pyvcf.VcfFrame.variants()`.
* Add new method `pymaf.MafFrame.variants()`.
* Add new method `pymaf.MafFrame.subset()`.
* Add new method `pymaf.MafFrame.calculate_concordance()`.
* Add new method `pymaf.MafFrame.copy()`.
* Add new method `pymaf.MafFrame.filter_indel()`.
* Add new method `pymaf.MafFrame.plot_comparison()`.

## 0.24.0 (2021-10-02)[](#id15 "Permalink to this heading")

* Add new command **fuc-bgzip**.
* Add new command **tabix-index**.
* Fix bug in `pyvcf.VcfFrame.from_file()` method when `meta_only` is `True`.
* Update `pyvcf.VcfFrame.from_file()` method to extract VCF headers as well when `meta_only` is `True`.
* Add new command **tabix-slice**.
* Update `pyvcf.VcfFrame.chr_prefix()`, `pybed.BedFrame.chr_prefix()`, and `pycov.CovFrame.chr_prefix()` methods to skip lines that already have `chr` string when `mode='add'`.
* Add new methods `common.rename()` and `pycov.CovFrame.rename()`.
* Add new command **cov-rename**.
* Add new method `pyvcf.gt_het()`.
* Add new method `pyvcf.gt_pseudophase()`.

## 0.23.0 (2021-09-21)[](#id16 "Permalink to this heading")

* Update `pycov.CovFrame` class to ensure that the `Chromosome` column is always string.
* Update `pycov.CovFrame.from_file()` method to accept file-like object as input as well.
* Add new argument `metadata` to `pyvcf.VcfFrame.strip()` method.
* Update `pyvcf.VcfFrame.from_file()` method to accept file-like object as input as well.
* Add new method `pycov.CovFrame.mask_bed()`.
* Add new method `pycov.CovFrame.chr_prefix()`.
* Add new property `contigs` to `pybed.BedFrame` class.
* Add new method `pybed.BedFrame.chr_prefix()`.
* Add new methods `pybed.BedFrame.copy_meta()` and `pybed.BedFrame.sort()`.
* Add new method `pybed.BedFrame.merge()`.
* Add new property `empty` to `pyvcf.VcfFrame` class.
* Fix minor bug in `pyvcf.VcfFrame.strip()` method when sample genotypes don’t have the same number of fields as FORMAT.
* Add new method `pycov.CovFrame.subset()` method.
* Add new method `common.color_print()`.
* Add new method `pycov.concat()`.
* Add new command **cov-concat**.
* Update `pyvcf.VcfFrame` to enforce the dtypes.
* Update `pyvcf.VcfFrame.add_af()` method to output allele fraction for each ALT allele.
* Fix bug in `pyvcf.VcfFrame.add_af()` method when the sum of allelic depths is 0.
* Add new method `pyvcf.VcfFrame.get_af()`.

## 0.22.0 (2021-09-04)[](#id17 "Permalink to this heading")

* Update `pyvcf.VcfFrame.from_file()` method to be more memory efficient by pre-specifying data type for each VCF column.
* Update `pyvcf.VcfFrame.from_file()` method to raise error if one or more VCF columns are missing, except for the FORMAT column (i.e. “sites-only” VCFs).
* Add new property `sites_only` to `pyvcf.VcfFrame`.
* Update `pyvcf.VcfFrame.merge()` method to handle sites-only VCFs.
* Add new method `pyvcf.Vc