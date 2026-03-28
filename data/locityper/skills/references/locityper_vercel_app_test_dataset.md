[Locityper](/)[AboutAbout](/about)[GitHubGitHub (opens in a new tab)](https://github.com/tprodanov/locityper)

* [Introduction](/)
* [Installation](/install)
* [Test dataset](/test_dataset)
* [Commands](/commands)
* [Input/Output](/input_output)
* [Method description](/descr)
* [Avalable data](/available_data)

Light

[Report bug/Ask question (opens in a new tab)](https://github.com/tprodanov/locityper/issues)Scroll to top

Test dataset

Please download test data from [zenodo (opens in a new tab)](https://doi.org/10.5281/zenodo.11068260) and extract files with
`tar xf test_data.tar.gz`. The directory follows the following structure:

- test\_data/
  * hprc.vcf.gz
  * loci.bed
  * reads/
    + 1.fastq.gz
    + 2.fastq.gz

`hprc.vcf.gz` contains a subset of pangenomic VCF file (see [here](/input_output#vcf)).
Target loci are described by a four-column file `loci.bed`.

In this example, we have GRCh38 reference genome at `genome.fa`.
Such reference genome can be downloaded [here (opens in a new tab)](https://www.gencodegenes.org/human/) (Genome sequence, primary assembly,
[direct link (opens in a new tab)](https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_46/GRCh38.primary_assembly.genome.fa.gz)).
Please index the genome and construct *k*-mer counts ([instructions](/input_output#jellyfish)):

```
samtools faidx genome.fa
jellyfish count --canonical --lower-count 2 --out-counter-len 2 --mer-len 25 \
    --threads 8 --size 3G --output counts.jf genome.fa
```

Then, you can create the database of loci using

```
locityper target -d db -v hprc.vcf.gz -r genome.fa -j counts.jf -L loci.bed
```

Most importantly, this command will produce locus haplotypes:

- db/loci/
  * MUC16/haplotypes.fa.gz
  * MUC6/haplotypes.fa.gz

Next, please run WGS dataset preprocessing:

```
locityper preproc -i reads/{1,2}.fastq.gz -r genome.fa -j counts.jf -o bg
```

This command will align a fraction of the reads to a part of chromosome 17 in order to identify
background read depth distribution and error profiles.

Finally, you can run targeted genotyping with

```
locityper genotype -i reads/{1,2}.fastq.gz -d db -p bg -o gts
```

This will produce genotype predictions:

- gts/loci/
  * MUC16/res.json.gz
  * MUC6/res.json.gz

You can find output file descriptions [here](/input_output#out).
In addition, you can summarize JSON files in one CSV file with

```
/path/to/locityper/extra/into_csv.py -i ./gts -o gts.csv
```

Note: `into_csv` takes the first segment after `.` as sample name, so sample name in the output CSV file will be `gts`.

Due to non-determenistic steps within Locityper, results may differ. Sample CSV file may look like this:

```
sample  locus  genotype             quality  total_reads  unexpl_reads  weight_dist  warnings
gts     MUC6   HG00621.1,HG00621.2  108.8    3738         1             0.00000      *
gts     MUC16  HG00621.1,HG00621.2  585.8    13969        16            0.00000      *
```

In total, all steps should take 2–4 minutes.

[Installation](/install "Installation")[Commands](/commands "Commands")

Light

---

[Timofey Prodanov. Locityper documentation (2024).](https://github.com/tprodanov/locityper-docs)

[Created using the Nextra theme.](https://nextra.site)