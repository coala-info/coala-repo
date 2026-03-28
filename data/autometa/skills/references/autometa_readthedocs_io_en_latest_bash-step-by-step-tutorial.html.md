[Autometa](index.html)

latest

* [Getting Started](getting-started.html)
* [🍏 Nextflow Workflow 🍏](nextflow-workflow.html)
* [🐚 Bash Workflow 🐚](bash-workflow.html)
* 📓 Bash Step by Step Tutorial 📓
  + [1. Length filter](#length-filter)
  + [2. Coverage calculation](#coverage-calculation)
    - [from SPAdes](#from-spades)
    - [from alignments.bed](#from-alignments-bed)
    - [from alignments.bam](#from-alignments-bam)
    - [from alignments.sam](#from-alignments-sam)
    - [from paired-end reads](#from-paired-end-reads)
  + [3. Generate Open Reading Frames (ORFs)](#generate-open-reading-frames-orfs)
  + [4. Single copy markers](#single-copy-markers)
  + [5. Taxonomy assignment](#taxonomy-assignment)
    - [5.1 BLASTP](#blastp)
    - [5.2 Lowest Common Ancestor (LCA)](#lowest-common-ancestor-lca)
    - [5.3 Majority vote](#majority-vote)
    - [5.4 Split kingdoms](#split-kingdoms)
  + [6. K-mer counting](#k-mer-counting)
    - [Advanced Usage](#advanced-usage)
  + [7. Binning](#binning)
    - [Advanced Usage](#advanced-usage-binning)
  + [8. Unclustered recruitment (Optional)](#unclustered-recruitment-optional)
    - [Advanced Usage](#advanced-usage-unclustered-recruitment)
* [Databases](databases.html)
* [Examining Results](examining-results.html)
* [Benchmarking](benchmarking.html)
* [Installation](installation.html)
* [Autometa Python API](autometa-python-api.html)
* [Usage](scripts/usage.html)
* [How to contribute](how-to-contribute.html)
* [Autometa modules](Autometa_modules/modules.html)
* [Legacy Autometa](legacy-autometa.html)
* [License](license.html)

[Autometa](index.html)

* 📓 Bash Step by Step Tutorial 📓
* [Edit on GitHub](https://github.com/KwanLab/Autometa/blob/main/docs/source/bash-step-by-step-tutorial.rst)

---

# 📓 Bash Step by Step Tutorial 📓[](#bash-step-by-step-tutorial "Permalink to this heading")

Here is the step by step tutorial of on running the entire pipeline manually through Bash.
This is helpful in case you have your own files or just want to run a specific step.

If you would like to set up a run of the whole pipeline through Bash, see the [Bash Workflow](bash-workflow.html#bash-workflow) section.

Before running anything make sure you have activated the conda environment using
`mamba activate autometa`.

See the Autometa Package Installation page for details on setting up your conda environment.

I will be going through this tutorial using the 78Mbp test dataset which can be found here <https://drive.google.com/drive/u/2/folders/1McxKviIzkPyr8ovj8BG7n_IYk-QfHAgG>.
You only need to download `metagenome.fna.gz` from the above link and save it at a directory as per your liking. I’m saving it in `$HOME/tutorial/test_data/`.
For instructions on how to download the dataset using command-line see the “Using command-line” section on [Benchmarking](benchmarking.html#benchmarking) page.

## 1. Length filter[](#length-filter "Permalink to this heading")

The first step when running Autometa is the length filtering. This would remove any contigs that are below the length cutoff. This is useful in removing the noise from the data,
as small contigs may have ambiguous kmer frequencies. The default cutoff if 3,000bp, ie. any contig that is smaller than 3,000bp would be removed.

Note

It is important that you alter the cutoff based on your N50. If your N50 is really small, e.g. 500bp (pretty common for soil assemblies),
then you might want to lower your cutoff to somewhere near N50. The tradeoff with lowering the length cutoff, however, is a greater number of
contigs which may make it more difficult for the dataset to be binned. As was shown in the [Autometa](https://academic.oup.com/nar/article/47/10/e57/5369936) paper,
as assembly quality degrades so does the binning performance.

Use the following command to run the length-filter step:

```
autometa-length-filter \
    --assembly $HOME/tutorial/test_data/78mbp_metagenome.fna \
    --cutoff 3000 \
    --output-fasta $HOME/tutorial/78mbp_metagenome.filtered.fna \
    --output-stats $HOME/tutorial/78mbp_metagenome.stats.tsv \
    --output-gc-content $HOME/tutorial/78mbp_metagenome.gc_content.tsv
```

Let us dissect the above command:

| Flag | Input arguments | Requirement |
| --- | --- | --- |
| `--assembly` | Path to metagenome assembly (nucleotide fasta) file | Required |
| `--cutoff` | Length cutoff for the filtered assembly. Default is 3,000bp | Optional |
| `--output-fasta` | Path to filtered metagenomic assembly that would be used for binning | Required |
| `--output-stats` | Path to assembly statistics table | Optional |
| `--output-gc-content` | Path to assembly contigs’ GC content and length stats table | Optional |

You can view the complete command-line options using `autometa-length-filter -h`

The above command generates the following files:

| File | Description |
| --- | --- |
| 78mbp\_metagenome.filtered.fna | Length filtered metagenomic assembly to be used for binning |
| 78mbp\_metagenome.stats.tsv | Table describing the filtered metagenome assembly statistics |
| 78mbp\_metagenome.gc\_content.tsv | Table of GC content and length of each contig in the filtered assembly |

## 2. Coverage calculation[](#coverage-calculation "Permalink to this heading")

Coverage calculation for each contig is done to provide another parameter to use while clustering contigs.

### from SPAdes[](#from-spades "Permalink to this heading")

If you have used SPAdes to assemble your metagenome, you can use the following command to generate the coverage table:

```
autometa-coverage \
    --assembly $HOME/tutorial/78mbp_metagenome.fna \
    --out $HOME/tutorial/78mbp_metagenome.coverages.tsv \
    --from-spades
```

### from alignments.bed[](#from-alignments-bed "Permalink to this heading")

If you have assembled your metagenome using some other assembler you can use one of the following commands to generate the coverage table.

```
# If you have already made a bed file
autometa-coverage \
    --assembly $HOME/tutorial/78mbp_metagenome.filtered.fna \
    --bed 78mbp_metagenome.bed \
    --out $HOME/tutorial/78mbp_metagenome.coverages.tsv \
    --cpus 40
```

### from alignments.bam[](#from-alignments-bam "Permalink to this heading")

```
# If you have already made an alignment (bam file)
autometa-coverage \
    --assembly $HOME/tutorial/78mbp_metagenome.filtered.fna \
    --bam 78mbp_metagenome.bam \
    --out $HOME/tutorial/78mbp_metagenome.coverages.tsv \
    --cpus 40
```

### from alignments.sam[](#from-alignments-sam "Permalink to this heading")

```
# If you have already made an alignment (sam file)
autometa-coverage \
    --assembly $HOME/tutorial/78mbp_metagenome.filtered.fna \
    --sam 78mbp_metagenome.sam \
    --out $HOME/tutorial/78mbp_metagenome.coverages.tsv \
    --cpus 40
```

### from paired-end reads[](#from-paired-end-reads "Permalink to this heading")

You may calculate coverage using forward and reverse reads with the assembled metagenome.

```
autometa-coverage \
    --assembly $HOME/tutorial/78mbp_metagenome.filtered.fna \
    --fwd-reads fwd_reads_1.fastq \
    --rev-reads rev_reads_1.fastq \
    --out $HOME/tutorial/78mbp_metagenome.coverages.tsv \
    --cpus 40
```

In case you have multiple forward and reverse read pairs supply a comma-delimited list.

```
autometa-coverage \
    --assembly $HOME/tutorial/78mbp_metagenome.filtered.fna \
    --fwd-reads fwd_reads_1.fastq,fwd_reads_2.fastq \
    --rev-reads rev_reads_1.fastq,rev_reads_2.fastq \
    --out $HOME/tutorial/78mbp_metagenome.coverages.tsv \
    --cpus 40
```

Note

1. No spaces should be used when providing the forward and reverse reads.
2. The lists of forward and reverse reads should be in the order corresponding to their respective reads pair.

Let us dissect the above commands:

| Flag | Function |
| --- | --- |
| `--assembly` | Path to length filtered metagenome assembly |
| `--from-spades` | If the input assembly is generated using SPades then extract k-mer coverages from contig IDs |
| `--bed` | Path to alignments BED file |
| `--bed` | Path to alignments BAM file |
| `--sam` | Path to alignments SAM file |
| `--fwd-reads` | Path to forward reads |
| `--rev-reads` | Path to reverse reads |
| `--cpus` | Number of CPUs to use (default is to use all available CPUs) |
| `--out` | Path to coverage table of each contig |

You can view the complete command-line options using `autometa-coverage -h`

The above command would generate the following files:

| File | Description |
| --- | --- |
| 78mbp\_metagenome.coverages.tsv | Table with read or k-mer coverage of each contig in the metagenome |

## 3. Generate Open Reading Frames (ORFs)[](#generate-open-reading-frames-orfs "Permalink to this heading")

ORF calling using prodigal is performed here. The ORFs are needed for single copy marker gene detection and for taxonomic assignment.

Use the following command to run the ORF calling step:

```
autometa-orfs \
    --assembly $HOME/tutorial/78mbp_metagenome.filtered.fna \
    --output-nucls $HOME/tutorial/78mbp_metagenome.orfs.fna \
    --output-prots $HOME/tutorial/a78mbp_metagenome.orfs.faa \
    --cpus 40
```

Let us dissect the above command:

| Flag | Function |
| --- | --- |
| `--assembly` | Path to length filtered metagenome assembly |
| `--output-nucls` | Path to nucleic acid sequence of ORFs |
| `--output-prots` | Path to amino acid sequence of ORFs |
| `--cpus` | Number of CPUs to use (default is to use all available CPUs) |

You can view the complete command-line options using `autometa-orfs -h`

The above command would generate the following files:

| File | Description |
| --- | --- |
| 78mbp\_metagenome.orfs.fna | Nucleic acid fasta file of ORFs |
| 78mbp\_metagenome.orfs.faa | Amino acid fasta file of ORFs |

## 4. Single copy markers[](#single-copy-markers "Permalink to this heading")

Autometa uses single-copy markers to guide clustering, and does not assume that recoverable genomes will necessarily be “complete”. You first need to download the single-copy markers.

```
# Create a markers directory to hold the marker genes
mkdir -p $HOME/Autometa/autometa/databases/markers

# Change the default download path to the directory created above
autometa-config \
    --section databases \
    --option markers \
    --value $HOME/Autometa/autometa/databases/markers

# Download single-copy marker genes
autometa-update-databases --update-markers

# hmmpress the marker genes
hmmpress -f $HOME/Autometa/autometa/databases/markers/bacteria.single_copy.hmm
hmmpress -f $HOME/Autometa/autometa/databases/markers/archaea.single_copy.hmm
```

Use the following command to annotate contigs containing single-copy marker genes:

```
autometa-markers \
    --orfs $HOME/tutorial/78mbp_metagenome.orfs.faa \
    --kingdom bacteria \
    --hmmscan $HOME/tutorial/78mbp_metagenome.hmmscan.tsv \
    --out $HOME/tutorial/78mbp_metagenome.markers.tsv \
    --parallel \
    --cpus 4 \
    --seed 42
```

Let us dissect the above command:

| Flag | Function | Requirement |
| --- | --- | --- |
| `--orfs` | Path to fasta file containing amino acid sequences of ORFS | Required |
| `--kingdom` | Kingdom to search for markers. Choices bacteria (default) and archaea | Optional |
| `--hmmscan` | Path to hmmscan output table containing the respective kingdom single-copy marker annotations | Required |
| `--out` | Path to write filtered annotated markers corresponding to kingdom | Required |
| `--parallel` | Use hmmscan parallel option (default: False) | Optional |
| `--cpus` | Number of CPUs to use (default is to use all available CPUs) | Optional |
| `--seed` | Seed to set random state for hmmscan. (default: 42) | Optional |

You can view the complete command-line options using `autometa-markers -h`

The above command would generate the following files:

| File | Description |
| --- | --- |
| 78mbp\_metagenome.hmmscan.tsv | hmmscan output table containing the respective kingdom single-copy marker annotations |
| 78mbp\_metagenome.markers.tsv | Annotated marker table corresponding to the particular kingdom |

## 5. Taxonomy assignment[](#taxonomy-assignment "Permalink to this heading")

### 5.1 BLASTP[](#blastp "Permalink to this heading")

Autometa assigns a taxonomic rank to each contig and then takes only the contig belonging to the specified kingdom (either bacteria or archaea) for binning.
We found that in host-associated metagenomes, this step vastly improves the binning performance of Autometa (and other pipelines) because less eukaryotic
or viral contigs will be placed into bacterial bins.

The first step for contig taxonomy assignment is a local alignment search of the ORFs against a reference database. This can be accelerated using [diamond](https://github.com/bbuchfink/diamond).

Create a diamond formatted database of the NCBI non-redundant (nr.gz) protein database.

```
diamond makedb \
    --in $HOME/Autometa/autometa/databases/ncbi/nr.gz \
    --db $HOME/Autometa/autometa/databases/ncbi/nr \
    --threads 40
```

Breaking down the above command:

| Flag | Function |
| --- | --- |
| –in | Path to nr database |
| –db | Path to diamond formated nr database |
| -p | Number of processors to use |

Note

`diamond makedb` will append `.dmnd` to the provided path of `--db`.

i.e. `--db /path/to/nr` will become `/path/to/nr.dmnd`

Run diamond blastp using the following command:

```
diamond blastp \
    --query $HOME/tutorial/78mbp_metagenome.orfs.faa \
    --db $HOME/Autometa/autometa/databases/ncbi/nr.dmnd \
    --evalue 1e-5 \
    --max-target-seqs 200 \
    --threads 40 \
    --outfmt 6 \
    --out $HOME/tutorial/78mbp_metagenome.blastp.tsv
```

Breaking down the above command:

| Flag | Function |
| --- | --- |
| –query | Path to query sequence. Here, amino acid sequence of ORFs |
| –db | Path to diamond formatted nr database |
| –evalue | Maximum expected value to report an alignment |
| –max-target-seqs | Maximum number of target sequences per query to report alignments for |
| –threads | Number of processors to use |
| –outfmt | Output format of BLASTP results |
| –out | Path to BLASTP results |

To see the complete list of acceptable output formats see Diamond [GitHub Wiki](https://github.com/bbuchfink/diamond/wiki/3.-Command-line-options#output-options). A complete list of all command-line options for Diamond can be found on its [GitHub Wiki](https://github.com/bbuchfink/diamond/wiki/3.-Command-line-options).

Caution

Autometa only parses output format 6 provided above as: `--outfmt 6`

The above command would generate the blastP table (`78mbp_metagenome.blastp.tsv`) in output format 6

### 5.2 Lowest Common Ancestor (LCA)[](#lowest-common-ancestor-lca "Permalink to this heading")

The second step in taxon assignment is determining each ORF’s lowest common ancestor (LCA).
This step uses the blastp results generated in the previous step to generate a table having the LCA of each ORF. As a default only
the blastp hits (subject accessions) which are within 10% of the top