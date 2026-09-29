Build a Custom Reference for Cell Ranger (mkref) | Official 10x Genomics Support

[10x Genomics Homepage](/)

* Products
* Resources
* [Support Hub](/support)
* Company
* [Search](/search)

[Order status](/store/order-status)

[Store](/store)

[10x Genomics Homepage](/)

[Order status](/store/order-status)

[Store](/store)

* Products
* Resources
* [Support Hub](/support)
* Company
* [Search](/search)

* [Order Status](/store/order-status)
* [Store](/store)

[Support home](/support)[Cell Ranger](/support/software/cell-ranger/latest)[Tutorials](/support/software/cell-ranger/latest/tutorials)

Build a Custom Reference for Cell Ranger (mkref)

[Cell Ranger](/support/software/cell-ranger/latest)

---

* [Overview](/support/software/cell-ranger/latest)
* [Getting Started](/support/software/cell-ranger/latest/getting-started)
* [Supported Libraries](/support/software/cell-ranger/latest/resources/supported-libraries)
* [Download Center](/support/software/cell-ranger/downloads)
* [Cloud Analysis](https://cloud.10xgenomics.com/cloud-analysis)
* [Cell Ranger Commands](/support/software/cell-ranger/latest/resources/cr-command-line-arguments)
* [Analysis](/support/software/cell-ranger/latest/analysis)
  + Inputs

    * [Inputs Overview](/support/software/cell-ranger/latest/analysis/inputs/cr-inputs-overview)
    * [Generating FASTQs](/support/software/cell-ranger/latest/analysis/inputs/cr-direct-demultiplexing)
    * [Specifying FASTQs](/support/software/cell-ranger/latest/analysis/inputs/cr-specifying-fastqs)
    * [Libraries CSV](/support/software/cell-ranger/latest/analysis/inputs/cr-libraries-csv)
    * [Feature Reference CSV](/support/software/cell-ranger/latest/analysis/inputs/cr-feature-ref-csv)
    * [Multi Config CSV](/support/software/cell-ranger/latest/analysis/inputs/cr-multi-config-csv-opts)
    * [Custom Reference with mkref](/support/software/cell-ranger/latest/analysis/inputs/cr-3p-references)
    * [Custom V(D)J Reference](/support/software/cell-ranger/latest/analysis/inputs/cr-5p-references)
  + Running Pipelines

    * [Choosing a Pipeline](/support/software/cell-ranger/latest/analysis/running-pipelines/cr-choosing-a-pipeline)
    * [Computing Options](/support/software/cell-ranger/latest/analysis/running-pipelines/cr-choosing-how-to-run)
    * Primary Analysis
    * [multi (3'/5'/Flex)](/support/software/cell-ranger/latest/analysis/running-pipelines/cr-multi)
    * [count (GEX + Antibody/CRISPR)](/support/software/cell-ranger/latest/analysis/running-pipelines/cr-gex-count)
    * [vdj (VDJ-T/B only)](/support/software/cell-ranger/latest/analysis/running-pipelines/cr-5p-vdj)
    * Secondary Analysis
    * [Data Integration Workflows](/support/software/cell-ranger/latest/analysis/running-pipelines/cr-data-integration)
    * [Cell Annotation (annotate)](/support/software/cell-ranger/latest/analysis/running-pipelines/cr-cell-annotation-pipeline)
    * [Custom Analysis (reanalyze)](/support/software/cell-ranger/latest/analysis/running-pipelines/cr-3p-reanalyze)
  + Outputs

    * [Overview](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-overview)
    * [Web Summary](/support/software/cell-ranger/latest/analysis/cr-outputs-web-summary)
    * [QC Report](/support/software/cell-ranger/latest/analysis/cr-outputs-qc-report)
    * [Metrics](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-metrics)
    * [Feature-Barcode Matrices](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-matrices)
    * [BAM](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-bam)
    * [Molecule Info (H5)](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-molecule-info)
    * [Secondary Analysis](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-secondary-analysis)
    * [Cell Type Annotations](/support/software/cell-ranger/latest/analysis/outputs/cr-cell-annotation-outputs)
    * [Results of aggr](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-aggr-outputs)
    * Library types
    * [Flex (Singleplex & Multiplex)](/support/software/cell-ranger/latest/analysis/outputs/cr-flex-outputs-frp)
    * [3'/5' Singleplex (GEX + VDJ + FB)](/support/software/cell-ranger/latest/analysis/outputs/cr-5p-outputs-overview-multi)
    * [3'/5' Sample Multiplexing (GEX + VDJ + FB)](/support/software/cell-ranger/latest/analysis/outputs/cr-3p-outputs-cellplex)
    * [Gene Expression](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-gex-overview)
    * [Antibody Capture](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-ab-overview)
    * [CRISPR Guide Capture](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-crispr-overview)
    * [VDJ-T/B](/support/software/cell-ranger/latest/analysis/outputs/cr-5p-outputs-overview-vdj)
* [Tutorials](/support/software/cell-ranger/latest/tutorials)
* [Algorithms](/support/software/cell-ranger/latest/algorithms-overview)
* [Advanced](/support/software/cell-ranger/latest/advanced)
* [Troubleshooting](/support/software/cell-ranger/latest/resources/cr-troubleshooting)
* [Miscellaneous](/support/software/cell-ranger/latest/miscellaneous)
* [Release Notes](/support/software/cell-ranger/latest/release-notes)
* [Q&A](https://kb.10xgenomics.com/hc/en-us)
* [Glossary](/support/software/cell-ranger/latest/resources/cr-glossary)
* [Datasets](/support/software/cell-ranger/latest/getting-started/cr-datasets)
* [Loupe Browser](/support/software/loupe-browser/latest)

Version

v10.1 (Latest)

[View source code](https://github.com/10XGenomics/cellranger)

Build a Custom Reference for Cell Ranger (mkref)
------------------------------------------------

### Overview

10x Genomics provides [pre-built references](/support/software/cell-ranger/downloads) for human and mouse genomes to use with Cell Ranger. Researchers can make custom reference genomes for additional species or add custom marker genes of interest to the reference, e.g. GFP. The following tutorial outlines the steps to build a custom reference using the [cellranger mkref](/support/software/cell-ranger/latest/analysis/inputs/cr-3p-references) pipeline.

### Find the input files

This tutorial follows the same steps used to create the [10x Genomics pre-built references for human and mouse](/support/software/cell-ranger/downloads). These steps can be found on this page: [Build Notes for Reference Packages](/support/software/cell-ranger/downloads/cr-ref-build-steps).

First, locate the reference genome FASTA and GTF files for your species. If the species is available from the [Ensembl database](https://www.ensembl.org/index.html), we recommend using the files from there. The GTF files from Ensembl contain optional tags that make filtering easy. If your species of interest is not available from Ensembl, GTF and FASTA files from other sources can also work. Note that a GTF file is required, while a GFF file is not supported. (See [GFF/GTF File Format - Definition and supported options](http://www.ensembl.org/info/website/upload/gff.html))

This tutorial generates a custom reference for the zebrafish, *Danio rerio*.

The files needed are located on Ensembl (check this [page](https://www.ensembl.org/Danio_rerio/Info/Index) for any reference updates).

Navigate to the *Gene annotation* section of the Ensembl website and click on the *Download GTF* link. This takes you to an [FTP site](http://ftp.ensembl.org/pub/release-105/gtf/danio_rerio) with a list of GTF files available. Select the file called `Danio_rerio.GRCz11.105.gtf.gz`. This is the GTF annotation file for this species. All species in Ensembl have similar files available to download. For more information on the GTF files in Ensembl, read the `README` file at the FTP site.

Right-click the link to copy the address, paste the URL into the command line, and download using the `wget` command:

The file is approximately 20 MB and takes less than a minute to download depending on your system.

```
Copy

wget http://ftp.ensembl.org/pub/release-105/gtf/danio_rerio/Danio_rerio.GRCz11.105.gtf.gz
```

Decompress the file with the `gunzip` command:

```
Copy

gunzip Danio_rerio.GRCz11.105.gtf.gz
```

Next, navigate back to the [Ensembl page for Danio rerio](https://www.ensembl.org/Danio_rerio/Info/Index) and click on 'Download FASTA' to access the [FTP site](http://ftp.ensembl.org/pub/release-105/fasta/danio_rerio) containing several types of FASTA files. Select the dna/ directory to access the [directory with genome files](http://ftp.ensembl.org/pub/release-105/fasta/danio_rerio/dna). Download the FASTA file containing all the chromosomes together in the genome, which has primary assembly in the filename. Right-click on the link to copy the address. Paste the URL into the command line and download it with the `wget` command:

The file is approximately 400 MB and takes several minutes to download, depending on your system.

```
Copy

wget http://ftp.ensembl.org/pub/release-105/fasta/danio_rerio/dna/Danio_rerio.GRCz11.dna.primary_assembly.fa.gz
```

Decompress the file with the gunzip command:

```
Copy

gunzip Danio_rerio.GRCz11.dna.primary_assembly.fa.gz
```

### Filter the GTF

GTF files can contain entries for non-polyA transcripts that overlap with protein-coding gene models. These entries can cause reads to be flagged as mapped to multiple genes (multi-mapped) because of the overlapping annotations. In the case where reads are flagged as multi-mapped, they are not counted. See these resources for further information:

* [Check for multi-mapped reads](/support/software/cell-ranger/latest/analysis/inputs/cr-3p-references#check-for-multi-mapped-reads-04ef39)
* [Which reads are considered for UMI counting by Cell Ranger?](https://kb.10xgenomics.com/hc/en-us/articles/115003710383-Which-reads-are-considered-for-UMI-counting-by-Cell-Ranger)

To remove these entries from the GTF, add this filter argument to the mkgtf command: `--attribute=gene_biotype:protein_coding` (see [list of accepted biotypes](/support/software/cell-ranger/latest/analysis/inputs/cr-3p-references#filter-with-mkgtf-f4a9b6)). [All of the filters](/support/software/cell-ranger/downloads/cr-ref-build-steps) used to build references are listed on the support site. If you are using a GTF file that does not contain gene\_biotype attributes or is missing other entries, don't worry too much; there may still be enough information to build a reference. A minimal GTF file only needs to contain exon features for protein coding genes.

Set up the command:

```
Copy

cellranger mkgtf \
    Danio_rerio.GRCz11.105.gtf \
    Danio_rerio.GRCz11.105.filtered.gtf \
    --attribute=gene_biotype:protein_coding
```

This will output the file `Danio_rerio.GRCz11.105.filtered.gtf`, which will be used in the next step.

Reference transcriptiomes available for many non-traditional model organisms may not have the same level of annotation seen for tranditional models (e.g. human and mouse). Therefore, the filtering options used to build the 10x human and mouse (pre-built) references may differ from those shown here. Visit the [reference build notes page](/support/software/cell-ranger/downloads/cr-ref-build-steps) to see what additional filters were used.

### Setup the command for cellranger mkref

Now that you have the genome FASTA and filtered GTF files needed, set up the command to run the `cellranger mkref` pipeline.

The following is the command:

```
Copy

cellranger mkref \
    --genome=Drerio_genome \
    --fasta=Danio_rerio.GRCz11.dna.primary_assembly.fa \
    --genes=Danio_rerio.GRCz11.105.filtered.gtf
```

### Run cellranger mkref

Run the command. This can take several hours, depending on your system. If you are working on a shared computing environment such as an HPC cluster, submit this as a job to prevent competing with other users for resources.

A successful `mkref` run should conclude with this message:

```
Copy

>>> Reference successfully created! <<<

You can now specify this reference on the command line:
cellranger --transcriptome=/Danio.rerio_genome ...
```

The reference was successfully created, as noted in the output message above, in the directory specified by the `--genome` flag (`Danio.rerio_genome` in this case). If you do not see this message, an error likely occurred. Please copy the error message and send an email to [support@10xgenomics.com](mailto:support@10xgenomics.com). The outputs are organized like this:

```
Copy

├── fasta
    │   ├── genome.fa
    │   └── genome.fa.fai
    ├── genes
    │   └── genes.gtf.gz
    ├── reference.json
    └── star
        ├── chrLength.txt
        ├── chrNameLength.txt
        ├── chrName.txt
        ├── chrStart.txt
        ├── exonGeTrInfo.tab
        ├── exonInfo.tab
        ├── geneInfo.tab
        ├── Genome
        ├── genomeParameters.txt
        ├── SA
        ├── SAindex
        ├── sjdbInfo.txt
        ├── sjdbList.fromGTF.out.tab
        ├── sjdbList.out.tab
        └── transcriptInfo.tab
```

### Add a marker gene to the FASTA and GTF

There are cases where the publicly available GTF and FASTA files will not contain information for some of the genes expressed in a given sample. A transgenic sample is a good example of when you would not expect a gene of interest to be in the reference. In this example, the common marker gene, [Green Fluorescent Protein (GFP)](https://www.uniprot.org/uniprotkb/P42212/entry) (used as an [in-vivo fluorescent reporter for gene expression](https://www.science.org/doi/10.1126/science.8303295)) is added to the reference. This method of adding genes to a reference has been reported to work for detecting genes from viral infections provided the detected transcripts are poly-adenylated.

**Note**: This is only one of many mRNA sequences available encoding for GFP. Make sure to use the sequence-specific for your assay. Depending on your experimental set-up, you may want to include a 3' UTR sequence, see the [advanced reference section](/support/software/cell-ranger/latest/analysis/inputs/cr-3p-references#adding-one-or-more-genes-to-your-reference-304f27) for more information.

For this example, we use a full [GFP sequence from GenBank](https://www.ncbi.nlm.nih.gov/nuccore/L29345.1). The sequence below runs 5' to 3' and the sequence highlighted in blue is the untranslated region (UTR):

```
Copy

>L29345.1 Aequorea victoria green-fluorescent protein (GFP) mRNA, complete cds
TACACACGAATAAAAGATAACAAAGATGAGTAAAGGAGAAGAACTTTTCACTGGAGTTGTCCCAATTCTT
GTTGAATTAGATGGCGATGTTAATGGGCAAAAATTCTCTGTCAGTGGAGAGGGTGAAGGTGATGCAACAT
ACGGAAAACTTACCCTTAAATTTATTTGCACTACTGGGAAGCTACCTGTTCCATGGCCAACACTTGTCAC
TACTTTCTCTTATGGTGTTCAATGCTTTTCAAGATACCCAGATCATATGAAACAGCATGACTTTTTCAAG
AGTGCCATGCCCGAAGGTTATGTACAGGAAAGAACTATATTTTACAAAGATGACGGGAACTACAAGACAC
GTGCTGAAGTCAAGTTTGAAGGTGATACCCTTGTTAATAGAATCGAGTTAAAAGGTATTGATTTTAAAGA
AGATGGAAACATTCTTGGACACAAAATGGAATACAACTATAACTCACATAATGTATACATCATGGCAGAC
AAACCAAAGAATGGAATCAAAGTTAACTTCAAAATTAGACACAACATTAAAGATGGAAGCGTTCAATTAG
CAGACCATTATCAACAAAATACTCCAATTGGCGATGGCCCTGTCCTTTTACCAGACAACCATTACCTGTC
CACACAATCTGCCCTTTCCAAAGATCCCAACGAAAAGAGAGATCACATGATCCTTCTTGAGTTTGTAACA
GCTGCTGGGATTACACATGGCATGGATGAACTATACAAATAAATGTCCAGACTTCCAATTGACACTAAAG
TGTCCGAACAATTACTAAATTCTCAGGGTTCCTGGTTAAATTCAGGCTGAGACTTTATTTATATATTTAT
AGATTCATTAAAATTTTATGAATAATTTATTGATGTTATTAATAGGGGCTATTTTCTTATTAAATAGGCT
ACTGGAGTGTAT
```

Copy and paste this sequence and save as a text file called `GFP_orig.fa`. The header of this file looks like the following:

```
Copy

>L29345.1 Aequorea victoria green-fluorescent protein (GFP) mRNA, complete cds
```

There are special characters such as spaces in the header (all text after the >) of this FASTA sequence. These can be problematic for downstream applications. It can be helpful to change the header to be more informative and also to remove these characters. The following command opens the file and uses the stream editor (`sed`) function to search for a pattern (the original header), replace it with new text ("GFP"), then directs the output to a new output file, `GFP.fa`.

```
Copy

cat GFP_orig.fa | sed s/L29345\.\1\ Aequorea\ victoria\ green\-fluorescent\ protein\ \(GFP\)\ mRNA\,\ complete\ cds/GFP/ > GFP.fa
```

Note: Another option is to open the `GFP_orig.fa` file with a text editor, such as [nano](https://astrobiomike.github.io/unix/working-with-files-and-dirs#a-terminal-text-editor), then manually edit the header and save the file as `GFP.fa`. Choose whichever method of changing the header you feel most comfortable with.

Now the FASTA file `GFP.fa` looks like the following:

```
Copy

>GFP
TACACACGAATAAAAGATAACAAAGATGAGTAAAGGAGAAGAACTTTTCACTGGAGTTGTCCCAATTCTT
GTTGAATTAGATGGCGATGTTAATGGGCAAAAATTCTCTGTCAGTGGAGAGGGTGAAGGTGATGCAACAT
ACGGAAAACTTACCCTTAAATTTATTTGCACTACTGGGAAGCTACCTGTTCCATGGCCAACACTTGTCAC
TACTTTCTCTTATGGTGTTCAATGCTTTTCAAGATACCCAGATCATATGAAACAGCATGACTTTTTCAAG
AGTGCCATGCCCGAAGGTTATGTACAGGAAAGAACTATATTTTACAAAGATGACGGGAACTACAAGACAC
GTGCTGAAGTCAAGTTTGAAGGTGATACCCTTGTTAATAGAATCGAGTTAAAAGGTATTGATTTTAAAGA
AGATGGAAACATTCTTGGACACAAAATGGAATACAACTATAACTCACATAATGTATACATCATGGCAGAC
AAACCAAAGAATGGAATCAAAGTTAACTTCAAAATTAGACACAACATTAAAGATGGAAGCGTTCAATTAG
CAGACCATTATCAACAAAATACTCCAATTGGCGATGGCCCTGTCCTTTTACCAGACAACCATTACCTGTC
CACACAATCTGCCCTTTCCAAAGATCCCAACGAAAAGAGAGATCACATGATCCTTCTTGAGTTTGTAACA
GCTGCTGGGATTACACATGGCATGGATGAACTATACAAATAAATGTCCAGACTTCCAATTGACACTAAAG
TGTCCGAACAATTACTAAATTCTCAGGGTTCCTGGTTAAATTCAGGCTGAGACTTTATTTATATATTTAT
AGATTCATTAAAATTTTATGAATAATTTATTGATGTTATTAATAGGGGCTATTTTCTTATTAAATAGGCT
ACTGGAGTGTAT
```

To find the number of bases in this sequence, we will use the `grep -v "^>"` command to search all lines that don't start with the `>` character, which removes line returns with `tr -d "\n"` so they aren't counted, and then counts the number of characters with the command `wc -c`. Each command is sent to the next step with the pipe `|` command.

The results of this command show there are 922 bases. This is important to know for the next step.

```
Copy

cat GFP.fa | grep -v "^>" | tr -d "\n" | wc -c
```

Now, make a custom GTF for GFP with the following command. This command uses the function `echo -e` (prints everything in quotes; the `-e` enables interpretation of the backslash, e.g. `\t`). Use `\t` to insert the tabs that separate the [9 columns of information required for GTF](https://useast.ensembl.org/info/website/upload/gff.html).

```
Copy

echo -e 'GFP\tunknown\texon\t1\t922\t.\t+\t.\tgene_id "GFP"; transcript_id "GFP"; gene_name "GFP"; gene_biotype "protein_coding";' > GFP.gtf
```

This is what the `GFP.gtf` file looks like with the cat `GFP.gtf` command:

```
Copy

GFP     unknown exon    1       922     .       +       .       gene_id "GFP"; transcript_id "GFP"; gene_name "GFP"; gene_biotype "protein_coding";
```

Next, add the `GFP.fa` to the end of the *D. rerio* genome FASTA. But first, make a copy so that the original is unchanged.

```
Copy

cp Danio_rerio.GRCz11.dna.primary_assembly.fa Danio_rerio.GRCz11.dna.primary_assembly_GFP.fa
```

Then, append the `GFP.fa` to the end of the `Danio_rerio.GRCz11.dna`.primary\_assembly\_GFP.fa file. The `>>` means append. Note: Do not use `>`, which overwrites the original file.

```
Copy

cat GFP.fa >> Danio_rerio.GRCz11.dna.primary_assembly_GFP.fa
```

To confirm that the GFP entry was added to the FASTA file, use the `grep ">"` command to search for lines with the `>` character:

```
Copy

grep ">" Danio_rerio.GRCz11.dna.primary_assembly_GFP.fa
```

The output looks similar to the following:

```
Copy

>1 dna:chromosome chromosome:GRCz11:1:1:59578282:1 REF
>10 dna:chromosome chromosome:GRCz11:10:1:45420867:1 REF
>11 dna:chromosome chromosome:GRCz11:11:1:45484837:1 REF
>12 dna:chromosome chromosome:GRCz11:12:1:49182954:1 REF
>13 dna:chromosome chromosome:GRCz11:13:1:52186027:1 REF
>14 dna:chromosome chromosome:GRCz11:14:1:52660232:1 REF
>15 dna:chromosome chromosome:GRCz11:15:1:48040578:1 REF
>16 dna:chromosome chromosome:GRCz11:16:1:55266484:1 REF
>17 dna:chromosome chromosome:GRCz11:17:1:53461100:1 REF
>18 dna:chromosome chromosome:GRCz11:18:1:51023478:1 REF
>19 dna:chromosome chromosome:GRCz11:19:1:48449771:1 REF
>2 dna:chromosome chromosome:GRCz11:2:1:59640629:1 REF
>20 dna:chromosome chromosome:GRCz11:20:1:55201332:1 REF
>21 dna:chromosome chromosome:GRCz11:21:1:45934066:1 REF
>22 dna:chromosome chromosome:GRCz11:22:1:39133080:1 REF
>23 dna:chromosome chromosome:GRCz11:23:1:46223584:1 REF
>24 dna:chromosome chromosome:GRCz11:24:1:42172926:1 REF
>25 dna:chromosome chromosome:GRCz11:25:1:37502051:1 REF
>3 dna:chromosome chromosome:GRCz11:3:1:62628489:1 REF
>4 dna:chromosome chromosome:GRCz11:4:1:78093715:1 REF
>5 dna:chromosome chromosome:GRCz11:5:1:72500376:1 REF
>6 dna:chromosome chromosome:GRCz11:6:1:60270059:1 REF
>7 dna:chromosome chromosome:GRCz11:7:1:74282399:1 REF
>8 dna:chromosome chromosome:GRCz11:8:1:54304671:1 REF
>9 dna:chromosome chromosome:GRCz11:9:1:56459846:1 REF
>MT dna:chromosome chromosome:GRCz11:MT:1:16596:1 REF
>KN149696.2 dna:scaffold scaffold:GRCz11:KN149696.2:1:368252:1 REF
>KN147651.2 dna:scaffold scaffold:GRCz11:KN147651.2:1:351968:1 REF
>KN149690.1 dna:scaffold scaffold:GRCz11:KN149690.1:1:343018:1 REF
>KN149686.1 dna:scaffold scaffold:GRCz11:KN149686.1:1:260365:1 REF
>KN147652.2 dna:scaffold scaffold:GRCz11:KN147652.2:1:252640:1 REF
>KN149688.2 dna:scaffold scaffold:GRCz11:KN149688.2:1:252035:1 REF
>KN149691.1 dna:scaffold scaffold:GRCz11:KN149691.1:1:233193:1 REF
...

>GFP
```

You can also count the number of contigs in the FASTA. There should now be 994 contigs including the extra GFP.

```
Copy

grep -c "^>" Danio_rerio.GRCz11.dna.primary_assembly_GFP.fa
```

Use the `cp` command to make a copy of the original GTF and modify the name to contain GFP. Then use the `cat` command to append the contents of `GFP.gtf` to the end of the renamed copy of the filtered *D. rerio* GTF.

```
Copy

cp Danio_rerio.GRCz11.105.filtered.gtf Danio_rerio.GRCz11.105.filtered.GFP.gtf
cat GFP.gtf >> Danio_rerio.GRCz11.105.filtered.GFP.gtf
```

Check the file with the following command:

```
Copy

tail Danio_rerio.GRCz11.105.filtered.GFP.gtf
```

The output looks similar to the following with the GTF entry as the last line of the file:

```
Copy

MT  RefSeq  start_codon 15308   15310   .   +   0   gene_id "ENSDARG00000063924"; gene_version "3"; transcript_id "ENSDART00000093625"; transcript_version "3"; exon_number "1"; gene_name "mt-cyb"; gene_source "RefSeq"; gene_biotype "protein_coding"; transcript_name "mt-cyb-201"; transcript_source "RefSeq"; transcript_biotype "protein_coding";
GFP unknown exon    1   922 .   +   .   gene_id "GFP"; transcript_id "GFP"; gene_name "GFP"; gene_biotype "protein_coding";
```

Now use the `Danio_rerio.GRCz11.105.filtered.GFP.gtf` and `Danio_rerio.GRCz11.dna.primary_assembly_GFP.fa` files as inputs to the `cellranger mkref` pipeline:

```
Copy

cellranger mkref --genome=Drerio_genome \
    --fasta=Danio_rerio.GRCz11.dna.primary_assembly_GFP.fa \
    --genes=Danio_rerio.GRCz11.105.filtered.GFP.gtf
```

This outputs a custom reference directory called `Danio.rerio_genome_GFP/`.

### Reference build instructions for Rhesus macaque

10x Genomics provides public datasets for the [Rhesus Macaque, *Macaca mulatta*](/datasets/10-k-monkey-pbm-cs-multiplexed-2-cm-os-3-1-standard-6-0-0). Although the reference is not offered for download, you can build it following these instructions. FASTQ and GTF files are downloaded from Ensembl in the "Gene annotation" section (check this [page](https://useast.ensembl.org/Macaca_mulatta/Info/Index) for any reference updates). Please note that we have chosen a "toplevel" or primary assemblies FASTA file because it contains primary contigs and no non-chromosomal or haplotype contigs.

```
Copy

#Download FASTA

wget http://ftp.ensembl.org/pub/release-105/fasta/macaca_mulatta/dna/Macaca_mulatta.Mmul_10.dna.toplevel.fa.gz
gunzip Macaca_mulatta.Mmul_10.dna.toplevel.fa.gz

#Download GTF

wget http://ftp.ensembl.org/pub/release-105/gtf/macaca_mulatta/Macaca_mulatta.Mmul_10.105.gtf.gz
gunzip Macaca_mulatta.Mmul_10.105.gtf.gz
```

```
Copy

#Filter GTF

cellranger mkgtf \
Macaca_mulatta.Mmul_10.105.gtf Macaca_mulatta.Mmul_10.105.filtered.gtf \
--attribute=gene_biotype:protein_coding \
--attribute=gene_biotype:lncRNA \
--attribute=gene_biotype:antisense \
--attribute=gene_biotype:IG_LV_gene \
--attribute=gene_biotype:IG_V_gene \
--attribute=gene_biotype:IG_V_pseudogene \
--attribute=gene_biotype:IG_D_gene \
--attribute=gene_biotype:IG_J_gene \
--attribute=gene_biotype:IG_J_pseudogene \
--attribute=gene_biotype:IG_C_gene \
--attribute=gene_biotype:IG_C_pseudogene \
--attribute=gene_biotype:TR_V_gene \
--attribute=gene_biotype:TR_V_pseudogene \
--attribute=gene_biotype:TR_D_gene \
--attribute=gene_biotype:TR_J_gene \
--attribute=gene_biotype:TR_J_pseudogene \
--attribute=gene_biotype:TR_C_gene
```

```
Copy

#Run mkref

cellranger mkref \
--genome=Mmul_10 \
--fasta=Macaca_mulatta.Mmul_10.dna.toplevel.fa \
--genes=Macaca_mulatta.Mmul_10.105.filtered.gtf \
--ref-version=1.0.0
```

### Reference build instructions for Norwegian rat

10x Genomics provides public datasets for the [Norwegian Rat, *Rattus norvegicus*](/datasets/10-k-rat-pbm-cs-multiplexed-2-cm-os-3-1-standard-6-0-0). Although the reference is not offered for download, you can build it following these instructions. FASTQ and GTF files are downloaded from Ensembl in the "Gene annotation" section (check this [page](https://www.ensembl.org/Rattus_norvegicus/Info/Index) for any reference updates).

```
Copy

#Download fasta

wget http://ftp.ensembl.org/pub/release-105/fasta/rattus_norvegicus/dna/Rattus_norvegicus.mRatBN7.2.dna.toplevel.fa.gz
gunzip Rattus_norvegicus.mRatBN7.2.dna.toplevel.fa.gz

#Download GTF

wget http://ftp.ensembl.org/pub/release-105/gtf/rattus_norvegicus/Rattus_norvegicus.mRatBN7.2.105.gtf.gz
gunzip Rattus_norvegicus.mRatBN7.2.105.gtf.gz
```

```
Copy

#Filter GTF

cellranger mkgtf \
Rattus_norvegicus.mRatBN7.2.105.gtf Rattus_norvegicus.mRatBN7.2.105.filtered.gtf \
--attribute=gene_biotype:protein_coding \
--attribute=gene_biotype:lncRNA \
--attribute=gene_biotype:antisense \
--attribute=gene_biotype:IG_LV_gene \
--attribute=gene_biotype:IG_V_gene \
--attribute=gene_biotype:IG_V_pseudogene \
--attribute=gene_biotype:IG_D_gene \
--attribute=gene_biotype:IG_J_gene \
--attribute=gene_biotype:IG_J_pseudogene \
--attribute=gene_biotype:IG_C_gene \
--attribute=gene_biotype:IG_C_pseudogene \
--attribute=gene_biotype:TR_V_gene \
--attribute=gene_biotype:TR_V_pseudogene \
--attribute=gene_biotype:TR_D_gene \
--attribute=gene_biotype:TR_J_gene \
--attribute=gene_biotype:TR_J_pseudogene \
--attribute=gene_biotype:TR_C_gene
```

```
Copy

#Run mkref

cellranger mkref \
--genome=mRatBN7 \
--fasta=Rattus_norvegicus.mRatBN7.2.dna.toplevel.fa \
--genes=Rattus_norvegicus.mRatBN7.2.105.filtered.gtf \
--ref-version=1.0.0
```

On This Page
============

* [Overview](#overview)
* [Find the input files](#getfiles)
* [Filter the GTF](#getfiles-1)
* [Setup the command for cellranger mkref](#mkrefsetup)
* [Run cellranger mkref](#runmkref)
* [Add a marker gene to the FASTA and GTF](#add-marker-gene)
* [Reference build instructions for Rhesus macaque](#macaque_6.0.0)
* [Reference build instructions for Norwegian rat](#rat_6.0.0)

---

### Company

* [About us](/company)
* [Investors](https://investors.10xgenomics.com/overview/default.aspx)
* [Careers](https://careers.kula.ai/10xgenomics)
* [Contact](/contact)
* [News](/news)
* [Distributors](/distributors)

### Platforms

* [Chromium Single Cell](/platforms/chromium)
* [Atera In Situ](/platforms/atera)
* [Visium Spatial](/platforms/visium)
* [Xenium In Situ](/platforms/xenium)

### Resources

* [Datasets](/datasets)
* [Publications](/publications)
* [Support Hub](/support)
* [Blog](/blog)
* [Compatible Products](/compatible-products)
* [Certifications & Compliance](/support/certifications-and-compliance)

### Legal Notices

* [Privacy Policy](/legal/privacy-policy)
* [Terms of Use](/legal/terms-of-use)
* [Other Legal Notices](/legal/legal-notices)

### Manage Preferences

* [Email Preferences](https://pages.10xgenomics.com/subscription.html)
* [Manage Cookie Preferences](#)
* [Do Not Sell or Share My Personal Information](#)

### Questions? We're here to help

* [support@10xgenomics.com](mailto:support@10xgenomics.com)
* [+1 925 401 7300](tel:+19254017300)

[Sign Up for Product and Support Updates](/subscribe)

### Follow us on social media

© 2026 10x Genomics. All Rights Reserved.

[English](/support)[中文](/cn/support)[日本語](/jp/support)