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

* [Target loci](#target-loci)
* [Locus extension](#locus-extension)
* [Preprocessing WGS dataset](#preprocessing-wgs-dataset)
* [BAM/CRAM files](#bamcram-files)
* [Multiple threads](#multiple-threads)
* [Subsampling](#subsampling)
* [Using similar datasets](#using-similar-datasets)
* [Multiple datasets](#multiple-datasets)
* [Genotyping WGS](#genotyping-wgs)
* [Genotyping in a weighted mode](#genotyping-in-a-weighted-mode)
* [Custom BED file for recruiting reads](#custom-bed-file-for-recruiting-reads)
* [Solver parameters](#solver-parameters)
* [Recruiting reads](#recruiting-reads)
* [Additional arguments](#additional-arguments)
* [Multiple loci](#multiple-loci)
* [Aligning medium-size sequences](#aligning-medium-size-sequences)
* [Pruning target haplotypes](#pruning-target-haplotypes)

[Report bug/Ask question (opens in a new tab)](https://github.com/tprodanov/locityper/issues)Scroll to top

Commands

Please find the description of prerequisite files [here](/input_output#in).

We will propose the following directory structure (press on folders to expand):

- db/
- bg/
  * <sample>/
- analysis/
  * <sample>/

## Target loci

Database with target loci can be constructed using `locityper target` command (can also use `add`).
First of all, locus alleles can be extracted [from a pangenome VCF file](/input_output#vcf):

```
locityper target -d db -r reference.fa -j counts.jf \
    -v pangenome.vcf.gz -l locus_name chr:start-end
```

where `reference.fa` is the reference genome and `counts.jf` are Jellyfish *k*-mer counts for the same reference
([more details](/input_output#jellyfish)).

By default, Locityper considers all available haplotypes, including the reference.
Reference haplotype name is either inferred, on needs to be provided with `-g NAME`.
Additionally, you can discard some haplotypes with `--leave-out` argument.

Regions can also be supplied with a four-column BED file using `-L` argument.
Furthermore, `-l/-L` arguments can be used together and can be repeated multiple times:

```
locityper target -d db -r reference.fa -j counts.jf \
    -v pangenome.vcf.gz -l locus1 chr:start-end \
    -L loci2.bed -L loci3.bed -l locus4 chr:start-end
```

Alternatively, locus alleles can be **directly provided using a FASTA file**.

```
locityper target -d db -r reference.fa -j counts.jf \
    -l locus_name chr:start-end alleles.fa
```

Note, that you still need to provide region coordinates in the reference genome.
This is needed to evaluate off-target *k*-mer counts.
Path to alleles can also be provided in a fifth column of the input BED file (`-L`).

If you don't know exact region coordinates, you can align locus alleles to the reference genome with

```
minimap2 -cx asm20 genome.fa alleles.fa | \
    awk '{ printf("%s:%d-%d\n",$6,$8+1,$9) }' | \
    sort | uniq -c | sort -k1,1nr | head -n20
```

This will produce a list of possible reference coordinates ranked by the number of alleles.
You can then select the most common coordinates / largest region at your discretion.

You can freely add more loci to an existing database using the same commands.

### Locus extension

When constructing locus database from a pangenome VCF file,
Locityper tries to extend the locus such that the new boundaries do not overlap any input variants.
This process may fail if there are very long pangenomic bubbles overlapping the locus.
In such cases, we recommend increasing allowed extension size (`-e`) or
manually providing locus sequences / manually specifying bigger input region.

Additionally, after locus extension it may happen that several target loci start overlapping.
To check that, you can run

```
/path/to/locityper/extra/check_overlaps.py db [--move]
```

This command will list all overlapping target regions.
With `--move` argument, the script will move all redundant loci (completely covered by other target locus)
to `db/redundant`.

Since `v1.1.0`, Locityper allows multiple boundary extensions (default `20k 50k 200k`).
When one extension iteration fails, a bigger threshold is checked.

## Preprocessing WGS dataset

Before locus genotyping can be performed, WGS dataset needs to be preprocessed.
For that, please use

```
locityper preproc -i reads1.fastq [reads2.fastq] \
    -r reference.fa -j counts.jf -o bg/SAMPLE
```

This command creates output directory `bg/SAMPLE` for this specific sample.
If you use long reads, please specify technology with `--tech` argument.

Input files can have FASTA or FASTQ format, and can be uncompressed or compressed with `gzip`, `bgzip` or `lz4`.

During sample preprocessing Locityper examines read alignments to a long *simple* region in the reference genome
without significant duplications or other structural variantions.
Locityper attempts to automatically identify the genome version, however, if this does not happen,
please use `-b/--bg-region` to provide such region (preferable ≥3 Mb).
By default, the following regions are used: `chr17:72950001-77450000` *(CHM13)*,
`chr17:72062001-76562000` *(GRCh38)* and `chr17:70060001-74560000` *(GRCh37)*.

You can examine already preprocessed directory with

```
locityper preproc --describe -o bg/SAMPLE
```

### BAM/CRAM files

If you already have read mappings to the whole genome, you can use them via

```
locityper preproc -a aligned.bam -r reference.fa -j counts.jf -o bg/SAMPLE
```

In some cases, reads are stored in an unmapped BAM/CRAM format.
In cases like that you can use arguments `-a reads.bam --no-index`.
For interleaved paired-end BAM/CRAM file, please use `-^` flag.
Non-interleaved paired-end unmapped BAM/CRAM files are not supported.

In addition, you can provide a list of files using `-I/--in-list` argument,
please see description [here](/input_output#in_list).

### Multiple threads

For compressed input files (including BAM/CRAM), decompression often takes significant time,
which prevents efficient parallelization.
Consequently, it is often more efficient to process multiple samples in parallel,
each using a single thread (`-@ 1`).

### Subsampling

*This part was changed in Locityper `v0.16`.*

Locityper allows dataset subsampling (`--subsample`) during the preprocessing, as a way to speed up the process.
Depending on the dataset and input coverage, small subsampling factors may produce inaccurate read depth estimates.

### Using similar datasets

You can estimate WGS characteristics using an already preprocessed file (`-~/--like`).
Preprocessing using existing dataset is significantly faster, but may produce incorrect results
if datasets have noticeably different characteristics.

```
locityper preproc -i/-a input -~ bg/OTHER_SAMPLE \
    -r reference.fa -j counts.jf -o bg/SAMPLE
```

⚠️

Please use this feature with care if you are certain that the two datasets are similar
(produced with the same sequencing technology and similar library preparation).

This method still requires a couple minutes to count the number of reads in the dataset.
You can also use `--filesize` argument for immediate preprocessing
by simply comparing file sizes with a previously processed dataset.

⚠️

Both datasets must have the same file format (for example `fastq.gz`)
and similar read name structure. Even different read name lengths may lead to incorrect predictions.

### Multiple datasets

If you plan to analyze a large number of WGS datasets, we advise to first benchmark the optimal configuration
with the number of threads (`-@`), recruiting threads (`--recr-threads`) and subsampling rates (`--subsample`).
Additionally, as the datasets are probably similar, it usually makes sense to use the
similar-dataset feature (including `--filesize` argument).
Nevertheless, you can additionally fully preprocess several randomly selected datasets
and compare predicted parameters (`--describe`) with those, obtained using a similar dataset.

## Genotyping WGS

In order to genotype a dataset, please run

```
locityper genotype -i/-a/-I input -d db -p bg/SAMPLE -o analysis/SAMPLE
```

You can limit genotyping to a subset of loci using `--subset-loci` argument.
Additionally, one can specify genotype priors using `--priors`.

Please find descriptions of the output files [here](/input_output#out).

### Genotyping in a weighted mode

Since `v0.17` Locityper allows users to specify weights for subregions of locus haplotypes.
This can be used to upweight exons and downweights introns and intergenic sequence;
or to generally upweight specific subregions, known to have high functional importance.

To do so, please run

```
locityper genotype ... --reg-weights paths.txt
```

with a file with two columns `<locus> <path to BED file>`.
Corresponding BED files should have columns `<haplotype> <start> <end> <weight>`,
where the weight ranges between 0 and 1.
Note that all haplotypes must be fully covered by the BED file, otherwise Locityper will raise an error.

For a single locus, you can use the following bash tricks:

```
locityper genotype ... --reg-weights <(echo "LOCUS PATH")
# OR
locityper genotype ... --reg-weights <<<"LOCUS PATH"
```

⚠️

Please make sure that all haplotypes are properly annotated
(for example there are exons on each haplotype), otherwise
locus genotyping may be biased.

### Custom BED file for recruiting reads

By default, when genotyping an indexed BAM/CRAM file, Locityper recruits reads based on the BED file in `db/loci/<LOCUS>/ref.bed`. However, since `v1.2.0` you can specify a custom BED file for read recruitment (`--recr-bed`), which would cover, for example, other repeat copies of the locus, or specify coordinates for a different reference genome. When corresponding BED files are located in `db/loci/*/name.bed` you can use `--recr-bed @@name.bed` and use `--recr-bed @name.bed` when they are located at the root of the database (`db/name.bed`). Additionally, Locityper always examines unmapped reads and optionally examines reads mapped to short contigs (`--recr-alt-len`). Please disable this feature if you already included all relevant contigs in the BED file.

### Solver parameters

To speed up genotyping, Locityper uses multiple increasingly accurate solving steps.
First, during a *filtering* step, locus is genotyped based on read alignments, without accounting for read depth.
This is a very fast, but inaccurate procedure. Afterwards, by default, 5000 genotypes are processed using
Greedy Solver (1 attempt per genotype). Finally, Simulated Annealing is run on 20 top genotypes
with 20 optimization attempts per genotype. This setup can be reproduced using arguments
`-S greedy:i=5k,a=1 -S anneal:i=20,a=20`. Each `-S` argument specifies the solver name:
greedy; anneal; highs; or gurobi (last two require the [ilp](/install#ilp) feature).
Then `-i=N` specifies the number of top genotypes, processed during this step and
`-a=N` specifies the number of optimization attempts.

Solvers can have additional arguments, which can specified through comma with `key=value` format:

* Stochastic greedy:
  + `x0`/`start`: possible values `best` or `random` [best];
  + `s`/`sample`: sample size during each greedy iteration [10];
  + `p`/`plato`: how many iterations without improvement are allowed [100].
* Simulated annealing:
  + `n`/`steps`: how many steps of simulated annealing (allow switch to a worse likelihood) [20k];
  + `p`/`plato`: after or during annealing, how many steps without improvement are allowed [10k],
  + `P`/`prob`: initially, significantly bad read reassignments happen at this probability [0.5],
* HiGHs:
  + `m`/`mode`: possible values `choose`/`simplex`/`ipm` (see HiGHs manual) [simplex].

## Recruiting reads

Locityper implements quick read recruitment to one or multiple target loci.
This ability can be utilized independently using a flexible `locityper recruit` module.

If you want to recruit reads for one locus (multiple locus haplotypes allowed), please use the following command:
please you

```
locityper recruit -i/-a/-I input -s targets.fa -o recruited.fastq
```

For paired-end reads, output reads will be interleaved, however, most tools can process interleaved reads.

Note: you can use the same command if you do not need information, where each read is recruited to.
Then, you can simply concatenate all haplotype FASTA files and run the command above.

### Additional arguments

By default, all *(k,w)*-minimizers from input haplotypes are collected.
Then, reads with appropriate number of matches are recruited.
Minimizer size and match fraction are controlled by `-m` and `-M` arguments, but can be specified using
preset argument (`-x`) based on your sequencing technology.
Note that preset overrides `-m`, `-M` and `-c` values, if they were set before it.

Input minimizers are not filtered by default. However, you can either manually mask them with Ns in the input haplotypes,
or provide [Jellyfish counts file](/input_output#jellyfish) using `-j` argument.
Then, all *k*-mers that appear too many times (`-t`) across the genome, are automatically masked.

Finally, if you recruit reads from a mapped BAM/CRAM file, consider providing regions file (`-R`) to speed up read recruitment.
Then, only reads with primary alignments to these regions are recruited, as well as reads from alternative contigs (`--alt-contig`)
and unmapped reads.

### Multiple loci

Suppose, there are target haplotypes in `target/gene1.fa`, `target/gene2.fa` and `target/gene3.fa`
and you want to put recruited reads to `output/*.fastq`. Then, please run

```
locityper recruit -i/-a/-I input -s target/{}.fa -o output/{}.fastq
```

Then, all possible `target/*.fa` files will be found and processed.
Recruited read filenames will mirror loci names, for example reads,
recruited to `gene1`, will be placed to `output/gene1.fastq`.

If you have one input FASTA file, but still want to recruit reads to multiple loci, you can use `-S` argument:

```
locityper recruit -i/-a/-I input -S multi_targets.fa -o output/{}.fastq
```

Sequence names in `multi_targets.fa` must follow format `locus*anything_else`, where `locus` can be repeated multiple times.

Finally, you can provide a two column file of input FASTA and output FASTQ files with

```
locityper recruit -i/-a/-I input -l list
```

Since `v1.2.0` it is possible to output all reads into a single (possibly gzipped) fastq file,
even when multiple target loci are present.
In addition, you can now specify `--distinct` when using `-S single_input.fa`.
This tells Locityper to treat each Fasta sequence as a separate target, with its own minimizers.
Unfortunately, be wary of a large memory usage when too many targets are used.

## Aligning medium-size sequences

Locityper provides ability to [globally align (opens in a new tab)](https: