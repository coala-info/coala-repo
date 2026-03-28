[Locityper](/)[AboutAbout](/about)[GitHubGitHub (opens in a new tab)](https://github.com/tprodanov/locityper)

* [Introduction](/)
* [Installation](/install)
* [Test dataset](/test_dataset)
* [Commands](/commands)
* [Input/Output](/input_output)
* [Method description](/descr)
* [Avalable data](/available_data)

Light

On This Page

* [Locityper genotypes for 1KGP](#locityper-genotypes-for-1kgp)
* [Target loci database](#target-loci-database)
* [Background parameters for the full 1KGP cohort](#background-parameters-for-the-full-1kgp-cohort)
* [Locityper benchmarking](#locityper-benchmarking)
* [Trio concordance](#trio-concordance)
* [Benchmarking HLA/KIR calling](#benchmarking-hlakir-calling)
* [Variant calling comparison](#variant-calling-comparison)

[Report bug/Ask question (opens in a new tab)](https://github.com/tprodanov/locityper/issues)Scroll to top

Avalable data

You can find Locityper genotype predictions and preprocessed data for the 1000 genomes project (1KGP) samples,
as well as benchmarking data at [Zenodo (opens in a new tab)](https://doi.org/10.5281/zenodo.10977559).

## Locityper genotypes for 1KGP

Genotyping results can be found in the `1kgp_genotypes.csv.gz` file with the following columns:

* `sample`, `locus`,
* `genotype`: Primary genotype prediction,
* `quality`: Phred-scale probability of a non-primary genotype (possibly very similar) being correct,
* `total_reads`: How many reads were recruited for genotyping this locus,
* `unexpl_reads`: How many reads were not explained by the primary genotype,
* `weight_dist`: Weighted distance between the primary genotype prediction and other genotypes.
  Here, distance was calculated as the Jaccard distance between multisets of (15,15)-minimizers.
  Distances are weighted according to the secondary genotype probabilities.
* `warnings`: Other heuristic warnings.

Genotypes were calculated using Locityper `v0.14.4-0` based on 3202 Illumina WGS datasets.

## Target loci database

A database of 327 target loci can be found by decompressing `db_327.tar.gz`.
For each locus, the following files can be useful:

* `ref.bed`: reference coordinates of the locus,
* `discarded_haplotypes.txt`: haplotypes, identical to others and discarded from futher analysis,
* `haplotypes.fa.gz`: all unique HPRC haplotypes for the locus,
* `haplotypes.paf.gz`: pairwise alignments of all haplotypes to each other.

## Background parameters for the full 1KGP cohort

Locityper-preprocessed background parameters for 3202 Illumina WGS datasets can be found in `bg-1kgp.tar.gz`.
After decompressing, corresponding directories used during genotyping as `locityper genotype ... -p bg-1kgp/SAMPLE`.

## Locityper benchmarking

Locityper benchmarking results can be found in the `locityper-benchmarking.tar.gz` archive.
Except for the trio comparison, benchmarking was performed based on the HPRC samples using Locityper `v0.14.2-4`.

`QV` subdirectory contains 9 files, of them 4 `full_*` files with Locityper evaluation using full reference panel,
`loo_*` files for Locityper in the leave-one-out (LOO) configuration,
and `nygc.csv.gz` for evaluating NYGC 1KGP call set haplotypes.

Each file has three lines for each sample and locus: based on the `query_type` column, two `hap` lines represent haplotype evaluation and `gt` line shows diploid genotype evaluation.
In addition to previously explained columns, the files may have following columns:

* `edit`, `size`: edit distance and alignment size in the haplotype/genotype alignment,
* `div = edit / size`,
* `qv`: Phred-like transformation of `div`,
* `avail_*`: in the LOO-setting, what is the similarity between the actual and the closest available haplotypes/genotypes in the LOO database.

### Trio concordance

Trio concordance based on the 1KGP samples can be found in the `trio_conc.csv.gz` file.
For each child (`indiv` column) and each locus the file shows concordance between child-parent haplotypes/genotypes.
Last (`expl`) column explains which child-parent haplotype pairs were matched together.

### Benchmarking HLA/KIR calling

HLA/KIR results can be found in the `HLA` subfolder.
`immuannot.csv.gz` contains baseline HLA/KIR annotation for the HPRC samples.
`alleles1` and `alleles2` represent alleles on the first and second haplotype of the corresponding samples.
If a haplotype contains a novel allele, it can be annotated with several close alleles, combined via `|`.

Three other files evaluate HLA/KIR calling accuracy, where each sample and locus can be written several times, according to the number of haplotypes.
For Locityper, column `qual` is either zero or one: latter if there are no warnings, weighted distance is at most 30, and there are less than 1000 or less than 20% unexplained reads.

Accuracy column shows how many allele fields were matched, while `base_length` shows how many fields there are in the baseline allele.
Finally, `avail` column shows if this the first two baseline fields are available in the LOO setting.

### Variant calling comparison

Variant calling comparison between Locityper, 1KGP and Pangenie can be found in the `varcall-eval.csv.gz` file.
There, number of true/false positive/negative variant calls are shown for each combination of locus,tool,sample, variant type and quality threshold (0/1/10).

[Method description](/descr "Method description")

Light

---

[Timofey Prodanov. Locityper documentation (2024).](https://github.com/tprodanov/locityper-docs)

[Created using the Nextra theme.](https://nextra.site)