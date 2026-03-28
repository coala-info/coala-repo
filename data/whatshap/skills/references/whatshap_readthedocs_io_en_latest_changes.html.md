[whatshap](index.html)

* [Installation](installation.html)
* [User guide](guide.html)
* [Questions and Answers](faq.html)
* [Contributing](develop.html)
* [Various notes](notes.html)
* [How to cite](howtocite.html)
* Changes
  + [v2.8 (2025-06-08)](#v2-8-2025-06-08)
  + [v2.7 (2025-05-27)](#v2-7-2025-05-27)
  + [v2.6 (2025-04-11)](#v2-6-2025-04-11)
  + [v2.5 (2025-04-03)](#v2-5-2025-04-03)
  + [v2.4 (2025-01-22)](#v2-4-2025-01-22)
  + [v2.3 (2024-05-05)](#v2-3-2024-05-05)
  + [v2.2 (2024-01-26)](#v2-2-2024-01-26)
  + [v2.1 (2023-10-17)](#v2-1-2023-10-17)
  + [v2.0 (2023-06-30)](#v2-0-2023-06-30)
  + [v1.7 (2022-12-01)](#v1-7-2022-12-01)
  + [v1.6 (2022-09-06)](#v1-6-2022-09-06)
  + [v1.5 (2022-08-23)](#v1-5-2022-08-23)
  + [v1.4 (2022-04-07)](#v1-4-2022-04-07)
  + [v1.3 (2022-03-11)](#v1-3-2022-03-11)
  + [v1.2 (2021-12-08)](#v1-2-2021-12-08)
  + [v1.1 (2021-04-08)](#v1-1-2021-04-08)
  + [v1.0 (2020-06-24)](#v1-0-2020-06-24)
  + [v0.18 (2019-02-15)](#v0-18-2019-02-15)
  + [v0.17 (2018-07-20)](#v0-17-2018-07-20)
  + [v0.16 (2018-05-22)](#v0-16-2018-05-22)
  + [v0.15 (2018-04-07)](#v0-15-2018-04-07)
  + [v0.14.1 (2017-07-07)](#v0-14-1-2017-07-07)
  + [v0.14 (2017-07-06)](#v0-14-2017-07-06)
  + [v0.13 (2016-10-27)](#v0-13-2016-10-27)
  + [v0.12 (2016-07-01)](#v0-12-2016-07-01)
  + [v0.11 (2016-06-09)](#v0-11-2016-06-09)
  + [v0.10 (2016-04-27)](#v0-10-2016-04-27)
  + [v0.9 (2016-01-05)](#v0-9-2016-01-05)
  + [January 2016](#january-2016)
  + [September 2015](#september-2015)
  + [April 2015](#april-2015)
  + [February 2015](#february-2015)
  + [January 2015](#january-2015)
  + [December 2014](#december-2014)
  + [November 2014](#november-2014)
  + [June 2014](#june-2014)
  + [April 2014](#april-2014)

[whatshap](index.html)

* Changes
* [View page source](_sources/changes.rst.txt)

---

# Changes[](#changes "Link to this heading")

## v2.8 (2025-06-08)[](#v2-8-2025-06-08 "Link to this heading")

* [#546](https://github.com/whatshap/whatshap/pull/546), [#406](https://github.com/whatshap/whatshap/issues/406): `haplotag` can now be used to tag supplementary
  alignments independently of the primary alignment. For this, the option
  `--tag-supplementary` was changed to accept a haplotagging strategy,
  such as `--tag-supplementary=independent-or-skip` and
  `--tag-supplementary=independent-or-copy-primary`. The change is backwards
  compatible, that is, using only `--tag-supplementary` is equivalent to
  `--tag-supplementary=copy-primary` and sets the strategy to the previous
  one of tagging supplementary alignments the same as the primary alignment.
  See [the haplotag documentation](https://whatshap.readthedocs.io/en/latest/guide.html#haplotagging-reads-with-supplementary-alignments).
* Extended support for supplementary alignments to the `polyphase` module.
* [#608](https://github.com/whatshap/whatshap/issues/608): Fixed bug in `polyphase` that could lead to phasable variants
  not being phased in multi-sample VCFs.

## v2.7 (2025-05-27)[](#v2-7-2025-05-27 "Link to this heading")

* Fixed build configuration, which due to changes in setuptoools, made
  the wheels much slower (because they were compiled without optimization).
  This only affected the wheels, not the Bioconda packages.

## v2.6 (2025-04-11)[](#v2-6-2025-04-11 "Link to this heading")

* [#586](https://github.com/whatshap/whatshap/issues/586), [#600](https://github.com/whatshap/whatshap/pull/600): Fixed bug where some paired-end reads were
  incorrectly skipped, which could lead to fewer phased variants.

## v2.5 (2025-04-03)[](#v2-5-2025-04-03 "Link to this heading")

* [#587](https://github.com/whatshap/whatshap/issues/587): Fixed bug when computing distances between aligned reads
  which could lead to some reads being ignored.

## v2.4 (2025-01-22)[](#v2-4-2025-01-22 "Link to this heading")

* [#554](https://github.com/whatshap/whatshap/issues/554): Added `--exclude-chromosome` option (can be used multiple
  times) to most subcommands (`phase`, `haplotag`, `genotype` etc.)
* [#537](https://github.com/whatshap/whatshap/issues/537): Fixed a crash when running `haplotag` on CRAM files.
* [#545](https://github.com/whatshap/whatshap/pull/545): `haplotagphase` now supports multi-allelic variants.
* [#579](https://github.com/whatshap/whatshap/issues/579): Fix `--supplementary-distance` option to `phase` not
  working.
* Reduced processing time of BAM files by about 33% when using realignment.

## v2.3 (2024-05-05)[](#v2-3-2024-05-05 "Link to this heading")

* [#521](https://github.com/whatshap/whatshap/pull/521): Added `haplotagphase` command. The command adds phase information to variants
  based on haplotagged reads.
  Contributed by Nikolai Karpov (@nkkarpov) and Mitchell Robert Vollger (@mrvollger).
* [#516](https://github.com/whatshap/whatshap/issues/516): Added `--use-supplementary` option to `phase`. Use this to use supplementary
  alignments for phasing (previously, supplementary alignments would be ignored).
  Contributed by Nikolai Karpov (@nkkarpov).

## v2.2 (2024-01-26)[](#v2-2-2024-01-26 "Link to this heading")

* [#496](https://github.com/whatshap/whatshap/issues/496): Fixed a segmentation fault in `polyphase`.
* [#498](https://github.com/whatshap/whatshap/issues/498): Fixed a numeric overflow in the scoring phase of `polyphase`.
  It could occur for variants with extremely high coverages (i.e. >200X).
* [#472](https://github.com/whatshap/whatshap/issues/472): Fixed various warnings and assertion violations when running
  `polyphase`.
* [#214](https://github.com/whatshap/whatshap/issues/214): Added support for ploidies greater than two to `whatshap
  split`.
* Added another algorithm for diploid phasing, which is a heuristic version of
  the default algorithm. Since it has not been tested extensively, we recommend
  the old algorithm for productive use, especially for pedigree phasing. Main
  benefit is support for higher coverages and/or larger pedigrees at the cost
  of not solving the underlying MEC model to optimality anymore. The heuristic
  is accessible via the parameter `--algorithm=heuristic`.

## v2.1 (2023-10-17)[](#v2-1-2023-10-17 "Link to this heading")

* We added *k*-merald, a new method for allele detection
  based on *k*-mer alignment. Instead of using a fixed cost value,
  *k*-merald derives *k*-mer mismatch penalties using the error profiles
  generated by `whatshap learn`. *k*-merald is available as an alternative
  to the edit-distance-based allele detection.
* WhatsHap can now be used to generate sequencing error profiles for a
  specific technology using `whatshap learn`.
* [#470](https://github.com/whatshap/whatshap/issues/470): Avoid ZeroDivisionError in `whatshap stats` when there
  are no heterozygous or no phased variants.
* [#485](https://github.com/whatshap/whatshap/issues/485): Fixed a KeyError: ‘parse\_vcf’ in `whatshap polyphase` when a
  full chromosome is skipped.

## v2.0 (2023-06-30)[](#v2-0-2023-06-30 "Link to this heading")

* [#346](https://github.com/whatshap/whatshap/issues/346): Phasing of indels (and other non-SNVs) is now enabled by
  default. This previously required specifying the `--indels` option,
  which not all users knew about and were thus unnecessarily getting
  suboptimal phasing results. The option is now ignored and leads to a
  warning. An `--only-snvs` option was added that restores the old behavior.
  This change applies to the following subcommands: `phase`, `haplotype`,
  `polyphase`, `polyphasegenetic`.

  Since this is a backwards incompatible change (when not using `--indels`
  already), the major version has been increased.
* [#425](https://github.com/whatshap/whatshap/issues/425): Haplotagging CRAM files should now work in more cases with
  `haplotag`.
* [#427](https://github.com/whatshap/whatshap/issues/427): `polyphase` did not phase indels, even if explicitly told.
* [#432](https://github.com/whatshap/whatshap/pull/432): `polyphase` can use existing phasing information in VCF when
  using the `--use-prephasing` flag. Still very experimental.
* [#439](https://github.com/whatshap/whatshap/issues/439): `polyphasegenetic` now handles pedigree information more
  robustly and properly detects available ILP solvers.
* [#449](https://github.com/whatshap/whatshap/issues/449): Fixed runtime issues for ploidies above 4, if no pre-phasing
  is used.
* [#450](https://github.com/whatshap/whatshap/pull/450): `polyphase` now supports multi-allelic variants.
* [#457](https://github.com/whatshap/whatshap/issues/457): `haplotag` now also tags alignments marked as duplicate.
* [#466](https://github.com/whatshap/whatshap/issues/466): Inconsistent runtime measurements now lead to a warning and
  no longer to a crash.
* This is the last WhatsHap release to support Python 3.7.

## v1.7 (2022-12-01)[](#v1-7-2022-12-01 "Link to this heading")

* [#379](https://github.com/whatshap/whatshap/pull/379): Added the ability to do polyploid phasing with pedigree information.
  This is implemented in a new `polyphasegenetic` subcommand.
* [#143](https://github.com/whatshap/whatshap/issues/143): `whatshap stats` now outputs the fraction of heterozygous variants that are phased.
* [#410](https://github.com/whatshap/whatshap/pull/410): `haplotag` gained support for tagging data with ploidy greater
  than two (use option `--ploidy`).
* [#400](https://github.com/whatshap/whatshap/issues/400): Fixed artificial overinflation of block length stats in `whatshap stats`.
* [#418](https://github.com/whatshap/whatshap/pull/418): Fixed problem in `stats` where NaN values caused ValuError
* [#416](https://github.com/whatshap/whatshap/pull/416): Clarified in the docs what `stats` considers as “phased”.
* [#207](https://github.com/whatshap/whatshap/issues/207): Enable comma-separated chromosomes as argument to `whatshap stats`.
* [#412](https://github.com/whatshap/whatshap/pull/412): Changed `stats` to compute all length statistics on split blocks
* [#399](https://github.com/whatshap/whatshap/pull/399): Formatted `stats` output so that long values are right-aligned with all other values.

## v1.6 (2022-09-06)[](#v1-6-2022-09-06 "Link to this heading")

* [#384](https://github.com/whatshap/whatshap/pull/384): Fixed how interleaved phase blocks in `whatshap stats` are split
  when computing NG50 values. This allows NG50 values to be larger than before.
  Thanks to @pontushojer.
* [#385](https://github.com/whatshap/whatshap/pull/385): Speed up `whatshap stats` when used with `--chromosomes` by avoiding to
  read in the entire VCF. Thanks to @pontushojer.
* [#387](https://github.com/whatshap/whatshap/pull/387): `whatshap haplotag` got some optimizations and is now about 20% faster.
  Thanks to @pontushojer.
* [#397](https://github.com/whatshap/whatshap/issues/397): Fixed `whatshap haplotag` to include reads not assigned to a contig
  (unmapped) in the output (unless the `--region` option is used).

## v1.5 (2022-08-23)[](#v1-5-2022-08-23 "Link to this heading")

* Providing a reference FASTA (with `--reference` or `-r`)
  is now mandatory even for `whatshap haplotag`. It was already
  mandatory for `whatshap phase`. In both cases, this is to prevent
  accidentally getting bad results because allele detection through
  realignment (which usually performs better) is only possible if a
  reference is provided. Use `--no-reference` explicitly to fall
  back to the less accurate algorithm.
* [#394](https://github.com/whatshap/whatshap/issues/394): Fixed `whatshap phase` option `--recombination--list`
  not working.
* [#371](https://github.com/whatshap/whatshap/issues/371): `whatshap split` crashed when attempting to split
  reads in a FASTQ file by haplotype.
* [#377](https://github.com/whatshap/whatshap/pull/377): Speed-up of about 20-30% for `whatshap polyphase` via
  some optimizations in the read clustering algorithm.
* Removed the deprecated `--pigz` option for `whatshap split`

## v1.4 (2022-04-07)[](#v1-4-2022-04-07 "Link to this heading")

* [#362](https://github.com/whatshap/whatshap/pull/362): `whatshap polyphase` received extensive algorithmic updates. The compatiblity with
  different data sets (species and sequencing technology) has been improved. The wall-clock time
  has been reduced by about 20-30%, depending on the input data.

## v1.3 (2022-03-11)[](#v1-3-2022-03-11 "Link to this heading")

* [#353](https://github.com/whatshap/whatshap/issues/353): Fix incorrect HS tags in `whatshap polyphase`
* [#356](https://github.com/whatshap/whatshap/issues/356): Fixed crash when reading VCF variants without `GT` fields (happens in GVCFs).
* [#352](https://github.com/whatshap/whatshap/pull/352): `whatshap haplotag` has gained option `--output-threads` for setting the
  number of compression threads, significantly reducing wall-clock time. Also, if output
  is sent to a pipe, uncompressed BAM is written. Thanks to @cjw85.

## v1.2 (2021-12-08)[](#v1-2-2021-12-08 "Link to this heading")

* [#208](https://github.com/whatshap/whatshap/issues/208): Fix `phase --merge-reads`. This option has never worked correctly and just led to
  `whatshap phase` taking a very long time and in some cases even crashing. With the fix, the
  option should work as intended, but we have not evaluated how much it improves phasing results.
* [#337](https://github.com/whatshap/whatshap/issues/337): Add `--skip-missing-contigs` option to `whatshap haplotag`
* [#335](https://github.com/whatshap/whatshap/pull/335): Add option `--ignore-sample-name` to `whatshap compare` (thanks to Pontus Höjer)
* [#342](https://github.com/whatshap/whatshap/issues/342): Fix `whatshap compare` crashing on VCFs with genotypes with an unknown allele
  (where `GT` is `1|.` or similar).
* [#343](https://github.com/whatshap/whatshap/issues/343): `whatshap stats` now reads the chromosome lengths (for N50 computation) from
  the VCF header, no need to use `--chr-lengths`.

## v1.1 (2021-04-08)[](#v1-1-2021-04-08 "Link to this heading")

* [#223](https://github.com/whatshap/whatshap/issues/223): Fix `haplotag --ignore-linked-reads` not working
* [#241](https://github.com/whatshap/whatshap/issues/241): Fix some `polyphase` problems.
* [#249](https://github.com/whatshap/whatshap/issues/249): Fix crash in the `haplotag` command on reading a VCF with the
  `PS` tag set to `.`.
* [#251](https://github.com/whatshap/whatshap/issues/251): Allow `haplotag` to correctly write to standard output.
* [#207](https://github.com/whatshap/whatshap/issues/207): Allow multiple `--chromosome` arguments to `stats`.
* The file created with `--output-read-list` was not correctly tab-separated.
* [#248](https://github.com/whatshap/whatshap/issues/248): Remove `phase --full-genotyping` option. Instead, use `whatshap genotype`
  followed by `whatshap phase`.
* [#289](https://github.com/whatshap/whatshap/issues/289): Fix parsing of GVCFs (with dots in the ALT column)
* [#265](https://github.com/whatshap/whatshap/pull/265): `polyphase` can now work in parallel

## v1.0 (2020-06-24)[](#v1-0-20