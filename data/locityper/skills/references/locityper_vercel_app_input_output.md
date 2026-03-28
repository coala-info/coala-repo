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

* [Input files](#input-files)
* [Pangenome VCF file](#pangenome-vcf-file)
* [Jellyfish k-mer counts](#jellyfish-k-mer-counts)
* [List of input files](#list-of-input-files)
* [Output files](#output-files)
* [Results in a JSON format](#results-in-a-json-format)
* [Converting to a CSV format](#converting-to-a-csv-format)
* [Filtering Locityper predictions](#filtering-locityper-predictions)
* [Converting to VCF](#converting-to-vcf)
* [Converting to FASTA](#converting-to-fasta)

[Report bug/Ask question (opens in a new tab)](https://github.com/tprodanov/locityper/issues)Scroll to top

Input/Output

## Input files

### Pangenome VCF file

Locityper can automatically extract locus alleles from the pangenome reference,
stored in a VCF file with non-overlapping variants.
Such pangenome VCF file can be created, for example, with
[Minigraph-Cactus (opens in a new tab)](https://github.com/ComparativeGenomicsToolkit/cactus/blob/master/doc/pangenome.md).
Alternatively, it can be created using [PAV (opens in a new tab)](https://github.com/EichlerLab/pav).

Existing Minigraph-Cactus VCF file exists for the HPRC cohort,
see [here (opens in a new tab)](https://github.com/human-pangenomics/hpp_pangenome_resources#minigraph-cactus) (*Raw VCF*).
Specifically for Minigraph-Cactus, VCF file needs to be transformed such that no variants overlap each other
using [vcfbub (opens in a new tab)](https://github.com/pangenome/vcfbub):

```
vcfbub -l 0 -i hprc-v1.1-mc-grch38.raw.vcf.gz | bgzip > hprc-v1.1-grch38.vcf.gz
tabix -p vcf hprc-v1.1-grch38.vcf.gz
```

By default, Locityper forbids overlapping variants, unless `--ignore-overl` is used (since `v0.15.2`).
Nevertheless, ignoring overlapping variants leads to lost information, as only one of the overlapping variants
can be used (Locityper always uses the first one).

### Jellyfish *k*-mer counts

Locityper utilizes *k*-mer counts across the refernece genome,
calculated using [Jellyfish (opens in a new tab)](https://github.com/gmarcais/Jellyfish/).
You can use the following code to obtain them (for example for *k* = 25):

```
jellyfish count --canonical --lower-count 2 --out-counter-len 2 --mer-len 25 \
    --threads 8 --size 3G --output counts.jf genome.fa
```

### List of input files

Locityper `preproc`, `genotype` and `recruit` commands allow multiple input files for a single dataset.
You can specify them by repeating `-i/-a` arguments:

```
locityper preproc -i readsA.fq.gz -i readsB.fq.gz ...
locityper preproc -i readsA1.fq.gz readsA2.fq.gz \
    -i readsB1.fq.gz readsB2.fq.gz ...
locityper preproc -a readsA.bam -a readsB.bam --no-index ...
```

Input files of different types (`-i` and `-a`) are not allowed, as well as multiple mapped BAM/CRAM files.

⚠️

All of the files must correspond to the same sample, same sequencing technology and should have roughly the same
characteristics (read length, error rates).

⚠️

Please make sure to use the same input files for genotyping as for preprocessing.

Alternatively, you can specify an input list of files with `-I list.txt` where each line follows the format
`<flag> <file> [<file2>]`.
Specifically, lines can be

* Two paired-end files: `p reads1.fq.gz reads2.fq.gz` or `p reads*.fq.gz`,
* Interleaved paired-end file: `pi reads.fq.gz` (same as `-i reads.fq.gz --interleaved`),
* Single-end FASTA/Q file: `s reads.fq.gz`,
* Alignment and mapped BAM/CRAM file: `a alns.bam`,
  can optionally specify `bai/crai` index path in third column,
* Unmapped BAM/CRAM file: `u reads.bam` (same as `-a reads.bam --no-index`).
* Unmapped interleaved BAM/CRAM file: `ui reads.bam` (same as `-a reads.bam --no-index --interleaved`).

Multiple lines are allowed, but all must have the same flag.

## Output files

### Results in a JSON format

For each locus, Locityper creates a `res.json.gz` output file with the following information:

* `genotype`: predicted genotype.
* `quality`: quality of a predicted genotype, calculated as a Phred-probability of error.
  If there are many very similar genotypes, quality may be low.
  We advise users to instead focus on the number of unexplained reads and weighted distance (see below).
* `total_reads`: total number of reads, used to identify locus genotype,
* `unexpl_reads`: number of reads that map well to some haplotypes, but not to the predicted haplotype,
* `weight_dist`: sum distance from the primary prediction to other genotypes.
  Distances are weighted by the predicted probabilities.
  Distances between genotypes are approximated using Jaccard distance between minimizer multisets.
* `warnings`: optional field that specifies heuristic warnings, raised by Locityper after genotyping.
* `options`: Several top genotype predictions, along with their probabilities and likelihood mean and standard deviation.

### Converting to a CSV format

In order to convert JSON to a CSV file, you can use the following script:

```
/path/to/locityper/extra/into_csv.py \
    -i analysis/./* -o gts.csv
```

In this examples, multiple samples were processed, with output folders located at
`analysis/sample1`, `analysis/sample2`, etc.
First folder name after `.` is taken as the sample name.
Output CSV file contains similar information to the JSON file, with exception for the top predicted genotypes.
In addition, output file can be automatically compressed (`-o gts.csv.gz`).

### Filtering Locityper predictions

Currently, we use the following strategy to filter out potentially incorrect Locityper genotypes
(any of the statements are true):

* Any warnings present,
* **or** weighted distance ≥ 30,
* **or** ≥ 1000 total reads **and** unexplained reads ≥ 20% of total reads.

### Converting to VCF

Locityper predictions can be converted into a VCF file based on an [existing pangenome VCF](/input_output#vcf).
For that, please run

```
/path/to/locityper/extra/into_vcf.py -i gts.csv -d db \
    -v pangenome.vcf -g GRCh38 -o out-dir
```

⚠️

Note that Locityper is not a variant caller, and instead predicts overall haplotype structure.
Therefore, individual variants may not be accurate, especially short variants.

### Converting to FASTA

*New in v0.16.5*

In addition to a VCF file, you can generate predicted haplotypes in a FASTA file.
To do so, please run

```
/path/to/locityper/extra/into_fasta.py -i gts.csv -d db -o out-dir
```

Each entry in the output files will be described in the following way:

```
>SAMPLE HAPLOTYPE qual=XX ...
```

[Commands](/commands "Commands")[Method description](/descr "Method description")

Light

---

[Timofey Prodanov. Locityper documentation (2024).](https://github.com/tprodanov/locityper-docs)

[Created using the Nextra theme.](https://nextra.site)