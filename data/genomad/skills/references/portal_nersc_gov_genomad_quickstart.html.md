Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark mode

[ ]
[ ]

Hide navigation sidebar

Hide table of contents sidebar

Toggle site navigation sidebar

[geNomad](index.html)

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

[![Light Logo](_static/figures/logo_light.svg)
![Dark Logo](_static/figures/logo_light.svg)](index.html)

* [geNomad](index.html)

Using geNomad

* [Installation](installation.html)
* Quickstart
* [The geNomad pipeline](pipeline.html)
* [Frequently asked questions](faq.html)

Theory

* [Hybrid classification framework and score aggregation](score_aggregation.html)
* [Marker-based classification features](marker_features.html)
* [Neural network-based classification](nn_classification.html)
* [Provirus identification](provirus_identification.html)
* [Taxonomic assignment of virus genomes](taxonomic_assignment.html)
* [Score calibration](score_calibration.html)
* [Post-classification filtering](post_classification_filtering.html)

Back to top

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Quickstart[#](#quickstart "Permalink to this heading")

If you are running geNomad for the first time, follow the steps below to learn how to download geNomad’s database, execute the virus and plasmid prediction pipeline, and interpret the results. If you want to understand exactly what is going on when you are executing geNomad, check out the [Pipeline](pipeline.html) page.

## Downloading the database[#](#downloading-the-database "Permalink to this heading")

geNomad depends on a database that contains the profiles of the markers that are used to classify sequences, their taxonomic information, their functional annotation, etc. So, you should first download the database to your current directory:

```
genomad download-database .
```

The database will be contained within the `genomad_db` directory. If you prefer, you can also download the database from [Zenodo](https://zenodo.org/record/14886553) and extract it manually.

## Executing geNomad[#](#executing-genomad "Permalink to this heading")

Now you are ready to go! geNomad works by executing a series of modules sequentially (you can find more information about this in the [pipeline documentation](pipeline.html)), but we provide a convenient `end-to-end` command that will execute the entire pipeline for you in one go.

In this example, we will use an *Klebsiella pneumoniae* genome ([GCF\_009025895.1](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_009025895.1/)) as input. You can use any FASTA file containing nucleotide sequences as input. geNomad will work for isolate genomes, metagenomes, and metatranscriptomes.

The command to execute geNomad is structured like this:

```
genomad end-to-end [OPTIONS] INPUT OUTPUT DATABASE
```

So, to run the full geNomad pipeline (`end-to-end` command), taking a nucleotide FASTA file (`GCF_009025895.1.fna.gz`) and the database (`genomad_db`) as input, we will execute the following command:

```
genomad end-to-end --cleanup --splits 8 GCF_009025895.1.fna.gz genomad_output genomad_db
```

The results will be written inside the `genomad_output` directory.

Some notes about the parameters

* The `--cleanup` option was used to force geNomad to delete intermediate files that were generated during the execution. This will save you some storage space.
* The `--splits 8` parameter was used here to make it possible to run this example in a notebook. geNomad searches a big database of protein profiles that take up a lot of space in memory. To prevent the execution from failing due to insufficient memory, we can use the `--splits` parameter to split the search into chuncks. If you are running geNomad in a big server you might not need to split your search, increasing the execution speed.
* Note that the input FASTA file that was used as input is compressed. This is possible because geNomad supports input files compressed as `.gz`, `.bz2`, or `.xz`.

Controlling the classification stringency

By default, geNomad applies a series of post-classification filters to remove likely false positives. For example, sequences are required to have a plasmid or virus score of at least 0.7 and sequences shorter than 2,500 bp are required to encode at least one hallmark gene. If you want to disable the post-classification filters, add the `--relaxed` flag to your command. On the other hand, if you want to be very conservative with your classification, you may use the `--conservative` flag. This will make the post-classification filters more aggressive, preventing sequences without strong support from being classified as plasmid or virus. You can check out the default, relaxed, and conservative post-classification filters [here](post_classification_filtering.html#default-parameters-and-presets).

## Understanding the outputs[#](#understanding-the-outputs "Permalink to this heading")

In this example, the results of geNomad’s analysis will be written to the `genomad_output` directory, which will look like this:

```
genomad_output
├── GCF_009025895.1_aggregated_classification
├── GCF_009025895.1_aggregated_classification.log
├── GCF_009025895.1_annotate
├── GCF_009025895.1_annotate.log
├── GCF_009025895.1_find_proviruses
├── GCF_009025895.1_find_proviruses.log
├── GCF_009025895.1_marker_classification
├── GCF_009025895.1_marker_classification.log
├── GCF_009025895.1_nn_classification
├── GCF_009025895.1_nn_classification.log
├── GCF_009025895.1_summary
╰── GCF_009025895.1_summary.log
```

As mentioned above, geNomad works by executing several modules sequentially. Each one of these will produce a log file (`<prefix>_<module>.log`) and a subdirectory (`<prefix>_<module>`).

For this example, we will only look at the files within `GCF_009025895.1_summary`. The `<prefix>_summary` directory contains files that summarize the results that were generated across the pipeline. If you just want a list of the plasmids and viruses identified in your input, this is what you are looking for.

```
genomad_output
╰── GCF_009025895.1_summary
    ├── GCF_009025895.1_plasmid.fna
    ├── GCF_009025895.1_plasmid_genes.tsv
    ├── GCF_009025895.1_plasmid_proteins.faa
    ├── GCF_009025895.1_plasmid_summary.tsv
    ├── GCF_009025895.1_summary.json
    ├── GCF_009025895.1_virus.fna
    ├── GCF_009025895.1_virus_genes.tsv
    ├── GCF_009025895.1_virus_proteins.faa
    ╰── GCF_009025895.1_virus_summary.tsv
```

First, let’s look at `GCF_009025895.1_virus_summary.tsv`:

| seq\_name | length | topology | coordinates | n\_genes | genetic\_code | virus\_score | fdr | n\_hallmarks | marker\_enrichment | taxonomy |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| NZ\_CP045015.1|provirus\_2885510\_2934610 | 49101 | Provirus | 2885510-2934610 | 69 | 11 | 0.9776 | NA | 14 | 76.0892 | Viruses;Duplodnaviria;Heunggongvirae;Uroviricota;Caudoviricetes;; |
| NZ\_CP045015.1|provirus\_3855947\_3906705 | 50759 | Provirus | 3855947-3906705 | 79 | 11 | 0.9774 | NA | 16 | 75.1552 | Viruses;Duplodnaviria;Heunggongvirae;Uroviricota;Caudoviricetes;; |
| NZ\_CP045018.1 | 51887 | No terminal repeats | NA | 57 | 11 | 0.9774 | NA | 14 | 67.7749 | Viruses;Duplodnaviria;Heunggongvirae;Uroviricota;Caudoviricetes;; |

This tabular file lists all the viruses that geNomad found in your input and gives you some convenient information about them. Here’s what each column contains:

* **`seq_name`:** The identifier of the sequence in the input FASTA file. Proviruses will have the following name scheme: `<sequence_identifier>|provirus_<start_coordinate>_<end_coordinate>`.
* **`length`:** Length of the sequence (or the provirus, in the case of integrated viruses).
* **`topology`:** Topology of the viral sequence. Possible values are: `No terminal repeats`, `DTR` (direct terminal repeats), `ITR` (inverted terminal repeats), or `Provirus` (viruses integrated in host genomes).
* **`coordinates`:** 1-indexed coordinates of the provirus region within host sequences. Will be `NA` for viruses that were not predicted to be integrated.
* **`n_genes`:** Number of genes encoded in the sequence.
* **`genetic_code`:** Predicted genetic code. Possible values are: 11 (standard code for Bacteria and Archaea), 4 (recoded TGA stop codon), or 15 (recoded TAG stop codon).
* **`virus_score`:** A measure of how confident geNomad is that the sequence is a virus. Sequences that have scores close to 1.0 are more likely to be viruses than the ones that have lower scores.
* **`fdr`:** The [estimated false discovery rate (FDR) of the classification](score_calibration.html#fdr-computation) (that is, the expected proportion of false positives among the sequences up to this row). To estimate FDRs geNomad requires [score calibration](score_calibration.html), which is turned off by default. Therefore, this column will only contain `NA` values in this example.
* **`n_hallmarks`:** Number of genes that matched a hallmark geNomad marker. Hallmarks are genes that were previously associated with viral function and their presence is a strong indicative that the sequence is indeed a virus.
* **`marker_enrichment`:** A score that represents the total enrichment of viral markers in the sequence. The value goes as the number of virus markers in the sequence increases, so sequences with multiple markers will have higher score. Chromosome and plasmid markers will reduce the score.
* **`taxonomy`:** Taxonomic assignment of the virus genome. Lineages follow the taxonomy contained in [ICTV's Taxonomy Release MSL39](https://ictv.global/sites/default/files/VMR/VMR_MSL39.v4_20241106.xlsx). Viruses can be taxonomically assigned up to the family level, but not to specific genera or species within that family. The taxonomy is presented with a fixed number of fields (corresponding to taxonomic ranks) separated by semicolons, with empty fields left blank.

In our example, geNomad identified several proviruses integrated into the *K. pneumoniae* genome and one extrachromosomal phage. Since they all have high scores and marker enrichment, we can be confident that these are indeed viruses. They were all predicted to use the genetic code 11 and were assigned to the *Caudoviricetes* class, which contains all the tailed bacteriphages. In the `taxonomy` field for these viruses, after *Caudoviricetes*, there are two consecutive semicolons because geNomad could only assign them to the class level, leaving the order and family ranks empty.

Another important file is `GCF_009025895.1_virus_genes.tsv`. During its execution, geNomad annotates the genes encoded by the input sequences using a database of chromosome, plasmid, and virus-specific markers. The `<prefix>_virus_genes.tsv` file summarizes the annotation of the genes encoded by the identified viruses.

| gene | start | end | length | strand | gc\_content | genetic\_code | rbs\_motif | marker | evalue | bitscore | uscg | plasmid\_hallmark | virus\_hallmark | taxid | taxname | annotation\_conjscan | annotation\_amr | annotation\_accessions | annotation\_description |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| NZ\_CP045018.1\_1 | 1 | 399 | 399 | 1 | 0.536 | 11 | None | GENOMAD.108715.VP | 2.54E-32 | 123 | 0 | 0 | 1 | 2561 | Caudoviricetes | NA | NA | PF05100;COG4672;TIGR01600 | Phage minor tail protein L |
| NZ\_CP045018.1\_2 | 401 | 1111 | 711 | 1 | 0.568 | 11 | AGGAG | GENOMAD.168265.VP | 9.28E-47 | 170 | 0 | 0 | 0 | 2561 | Caudoviricetes | NA | NA | PF14464;COG1310;K21140;TIGR02256 | Proteasome lid subunit RPN8/RPN11, contains Jab1/MPN domain metalloenzyme (JAMM) motif |
| NZ\_CP045018.1\_3 | 1143 | 1493 | 351 | 1 | 0.382 | 11 | AGGAG | GENOMAD.147875.VV | 1.50E-14 | 71 | 0 | 0 | 0 | 2561 | Caudoviricetes | NA | NA | COG5633;TIGR03066 | NA |
| NZ\_CP045018.1\_4 | 1509 | 2120 | 612 | 1 | 0.477 | 11 | GGA/GAG/AGG | GENOMAD.143103.VP | 1.96E-50 | 179 | 0 | 0 | 1 | 2561 | Caudoviricetes | NA | NA | PF06805;COG4723;TIGR01687 | Phage-related protein, tail component |
| NZ\_CP045018.1\_5 | 2183 | 13516 | 11334 | 1 | 0.566 | 11 | None | GENOMAD.159864.VP | 1.23E-268 | 923 | 0 | 0 | 0 | 2561 | Caudoviricetes | NA | NA | PF12421;PF09327 | Fibronectin type III protein |
| NZ\_CP045018.1\_6 | 13585 | 15084 | 1500 | 1 | 0.55 | 11 | AGGAG | GENOMAD.195756.VP | 2.02E-14 | 79 | 0 | 0 | 0 | 2561 | Caudoviricetes | NA | NA | NA | NA |
| NZ\_CP045018.1\_7 | 15163 | 16128 | 966 | -1 | 0.469 | 11 | GGAGG | NA | NA | NA | 0 | 0 | 0 | 1 | NA | NA | NA | NA | NA |

The columns in this file are:

* **`gene`:** Identifier of the gene (`<sequence_name>_<gene_number>`). Usually, gene numbers start with 1 (first gene in the sequence). However, genes encoded by prophages integrated in the middle of the host chromosome may start with a different number, depending on it’s position within the chromosome.
* **`start`:** 1-indexed start coordinate of the gene.
* **`end`:** 1-indexed end coordinate of the gene.
* **`length`:** Length of the gene locus (in base pairs).
* **`strand`:** Strand that encodes the gene. Can be 1 (direct strand) or -1 (reverse strand).
* **`gc_content`:** GC content of the gene locus.
* **`genetic_code`:** Predicted genetic code (see details in the explanation of the summary file).
* **`rbs_motif`:** Detected motif of the ribosome-binding site.
* **`marker`:** Best matching geNomad marker. If this gene doesn’t match any markers, the value will be `NA`.
* **`evalue`:** E-value of the alignment between the protein encoded by the gene and the best matching geNomad marker.
* **`bitscore`:** Bitscore of the alignment between the protein encoded by the gene and the best matching geNomad marker.
* **`uscg`:** Whether the marker assigned to this gene corresponds to a universal single-copy gene (UCSG, as defined in [BUSCO v5](https://busco.ezlab.org/)). These genes are expected to be found in chromosomes and are rare in plasmids and viruses. Can be 1 (gene is USCG) or 0 (gene is not USCG).
* **`plasmid_hallmark`:** Whether the marker assigned to this gene represents a plasmid hallmark.
* **`virus_hallmark`:** Whether the marker assigned to this gene represents a virus hallmark.
* **`taxid`:** Taxonomic identifier of the marker assigned to this gene (you can ignore this as it is meant to be used internally by geNomad).
* **`taxname`:** Name of the taxon associated with the assigned geNomad marker. In this example, we can see that the annotated proteins are all characteristic of *Caudoviricetes* (which is why the provirus was assigned to this class).
* **`annotation_conjscan`:** If the marker that matched the gene is a conjugation-related gene (as defined in [CONJscan](https://link.springer.com/protocol/10.1007/978-1-4939-9877-7_19)) this field will show which CONJscan acession was assigned to the marker.
* **`annotation_amr`:** If the marker that matched the gene was annotated with an antimicrobial resistance (AMR) function (as defined in [NCBIfam-AMRFinder](https://www.ncbi