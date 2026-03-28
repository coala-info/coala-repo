### Navigation

* [index](../genindex/ "General Index")
* [next](Daijin_tutorial/ "4. Tutorial for Daijin") |
* [previous](../Installation/ "2. Installation") |
* [Mikado](../) »

# 3. Tutorial[¶](#tutorial "Permalink to this headline")

This tutorial will guide you through a simple analysis of Mikado, using a small amount of data coming from an
experiment on *Arabidopsis thaliana*. RNA-Seq data was obtained from [study PRJEB7093 on ENA](http://www.ebi.ac.uk/ena/data/view/PRJEB7093), aligned with STAR [[STAR]](../References/#star) against the [TAIR10](http://www.arabidopsis.org)
reference genome, and assembled with four different programs. For this small example, we are going to focus on a
small genomic region: Chr5, from 26,575,364 to 26,614,205.

During this analysis, you will require the following files:

* [`chr5.fas.gz`](../_downloads/173dd79886d4425ae7e812d9bc58ee1d/chr5.fas.gz): a FASTA file containing the Chr5 of *A. thaliana*.
* [`reference.gff3`](../_downloads/689c2117eb7c2691c0d05488270efcb2/reference.gff3): a GFF3 file with the annotation of the genomic slice we are interested in, for
  comparison purposes.
* [`junctions.bed`](../_downloads/0648d48cb43e7a6a5c387fd39952d4ff/junctions.bed): a BED12 file of reliable splicing junctions in the region, identified
  using Portcullis [[Portcullis]](../References/#portcullis)
* [`class.gtf`](../_downloads/cb827a5dbba3cde2e6574b8b121ce5c3/class.gtf): a GTF file of transcripts assembled using CLASS [[Class2]](../References/#class2)
* [`cufflinks.gtf`](../_downloads/5d74b4869e21af9d0542fc7f69983813/cufflinks.gtf): a GTF file of transcripts assembled using Cufflinks [[Cufflinks]](../References/#cufflinks)
* [`stringtie.gtf`](../_downloads/09ec805d131b9571d291901a280b10c8/stringtie.gtf): a GTF file of transcripts assembled using Stringtie [[StringTie]](../References/#stringtie)
* [`trinity.gff3`](../_downloads/47352be06e42c43e792315f0a9a445ae/trinity.gff3): a GFF3 file of transcripts assembled using Trinity [[Trinity]](../References/#trinity) and aligned using GMAP [[GMAP]](../References/#gmap)
* [`orfs.bed`](../_downloads/2beef91999aaa6a0f6dd28eb964aec49/orfs.bed): a BED12 file containing the ORFs of the above transcripts, derived using TransDecoder [[Trinity]](../References/#trinity)
* [`uniprot_sprot_plants.fasta.gz`](../_downloads/ad7b6bfe92c92dde26358a55f66b36a6/uniprot_sprot_plants.fasta.gz): a FASTA file containing the plant proteins released with SwissProt
  [[Uniprot]](../References/#uniprot)

All of this data can also be found in the `sample_data` directory of the [Mikado source](https://www.github.com/EI-CoreBioinformatics/Mikado).

You will also require the following software:

* a functioning installation of SQLite.
* a functioning version of BLAST+ [[Blastplus]](../References/#blastplus).
* a functioning version of Prodigal [[Prodigal]](../References/#prodigal).

## 3.1. Creating the configuration file for Mikado[¶](#creating-the-configuration-file-for-mikado "Permalink to this headline")

In the first step, we need to create a configuration file to drive Mikado. To do so, we will first create a
tab-delimited file describing our assemblies (class.gtf, cufflinks.gtf, stringtie.gtf, trinity.gff3):

```
class.gtf       cl      True            False   False   True
cufflinks.gtf   cuff    True            False   False   True
stringtie.gtf   st      True    1       False   True    True
trinity.gff3    tr      False   -0.5    False   False   True
reference.gff3  at      True    5       True    False   False
pacbio.bam      pb      True    1       False   False   False
```

In this file, the first three fields define the following:

#. The file location and name (if no folder is specified, Mikado will look for each file in the current working
directory)
#. An alias associated with the file, which has to be unique
#. A binary flag (`True` / `False`) indicating whether the assembly is strand-specific or not

These fields are then followed by a series of **optional** fields:

1. A score associated with that sample. All transcripts associated with the label will have their score corrected by
   the value on this field. So eg. in this example all Stringtie models will receive an additional point, and all
   Trinity models will be penalised by half a point. Class and Cufflinks have no special bonus or malus associated.
2. A binary flag (`True` / `False`) defining whether the sample is a reference or not.
3. A binary flag (`True` / `False`) defining whether to exclude redundant models or not.
4. A binary flag (`True` / `False`) indicating whether Mikado prepare should strip the CDS of faulty models, but
   otherwise keep their cDNA structure in the final output (`True`) or whether instead it should completely discard
   such models (`False`).
5. A binary flag (`True` / `False`) instructing Mikado about whether the chimera split routine should be skipped
   for these models (`True`) or if instead it should proceed normally (`False`).

Finally, we will create the configuration file itself using `mikado configure`:

```
mikado configure --list list.txt --reference chr5.fas.gz --mode permissive --scoring plants.yaml  --copy-scoring
```

plants.yaml –junctions junctions.bed -bt uniprot\_sprot\_plants.fasta configuration.yaml

This will create a configuration.yaml file with the parameters that were specified on the command line. This is
[simplified configuration file](../Usage/Configure/#conf-anatomy), containing all the necessary parameters for the Mikado run. It
will also copy the `plants.yaml` file from the Mikado installation to your current working directory.

Hint

Mikado can accept compressed genome FASTA files, like in this example, as long as they have been compressed
with BGZip rather than the vanilla UNIX GZip.

* *–list list.txt*: this part of the command line instructs Mikado to read the file we just created to understand
  where the input files are and how to treat them.
* *–scoring*: the scoring file to use. Mikado ships with two pre-calculated scoring files, plant.yaml and

mammalian.yaml
\* *–copy-scoring*: instruct Mikado to copy the scoring file from the installation directory to the current
directory, so that the experimenter can modify it as needed.
\* *–reference chr5.fas*: this part of the command line instructs Mikado on the location of the genome file.
\* *–mode permissive*: the mode in which Mikado will treat cases of chimeras. See the :ref:[`](#id13)documentation

> <chimera\_splitting\_algorithm>` for details.

* *–junctions junctions.bed*: this part of the command line instructs Mikado to consider this file as the source of
  reliable splicing junctions.
* *-bt uniprot\_sprot\_plants.fasta*: this part of the command line instructs Mikado to consider this file as the BLAST
  database which will be used for deriving homology information.

Hint

The *–copy-scoring* argument is usually not necessary, however, it allows you to easily inspect the

[scoring file](../Scoring_files/#scoring-files) we are going to use during this run.

Hint

Mikado provides a handful of pre-configured scoring files for different species. However, we do recommend

inspecting and tweaking your scoring file to cater to your species. We provide a guide on how to create your own
configuration files [here](Scoring_tutorial/#configure-scoring-tutorial).

## 3.2. Mikado prepare[¶](#mikado-prepare "Permalink to this headline")

The subsequent step involves running `mikado prepare` to create a [sorted, non-redundant GTF with all the
input assemblies](../Usage/Prepare/#prepare). As we have already created a configuration file with all the details regarding the input
files, this will require us only to issue the command:

```
mikado prepare --json-conf configuration.yaml
```

This command will create three files:

1. *mikado\_prepared.gtf*: one of the two main output files. This is a sorted, non-redundant GTF containing the transcripts from the four input GTFs
2. *mikado\_prepared.fasta*: a FASTA file of the transcripts present in *mikado\_prepared.gtf*.
3. *prepare.log*: the log of this step. This should look like the following, minus the timestamps:

   ```
   2016-08-10 13:53:58,443 - prepare - prepare.py:67 - INFO - setup - MainProcess - Command line: /usr/users/ga002/venturil/py351/bin/mikado prepare --json-conf configuration.yaml
   2016-08-10 13:53:58,967 - prepare - prepare.py:206 - INFO - perform_check - MainProcess - Finished to analyse 95 transcripts (93 retained)
   2016-08-10 13:53:58,967 - prepare - prepare.py:405 - INFO - prepare - MainProcess - Finished
   ```

At the end of this phase, you should have 93 candidate transcripts, as 2 were redundant.

## 3.3. BLAST of the candidate transcripts[¶](#blast-of-the-candidate-transcripts "Permalink to this headline")

Although it is not strictly necessary, Mikado benefits from integrating homology data from BLAST. Mikado requires this data to be provided either in XML or ASN format (in the latter case, `blast_formatter` will be used to convert it in-memory to XML).

To create this file, we will proceed as follows:

1. Uncompress the SwissProt database:

   > ```
   > gzip -dc uniprot_sprot_plants.fasta.gz > uniprot_sprot_plants.fasta
   > ```
2. Prepare the database for the BLAST:

   > ```
   > makeblastdb -in uniprot_sprot_plants.fasta -dbtype prot -parse_seqids > blast_prepare.log
   > ```
3. Execute the BLAST, asking for XML output, and compress it to limit space usage.

   > ```
   > blastx -max_target_seqs 5 -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send
   > ```

evalue bitscore ppos btop”
:   -num\_threads 10 -query mikado\_prepared.fasta -db uniprot\_sprot\_plants.fasta -out mikado\_prepared.blast.tsv

This will produce the `mikado_prepared.blast.tsv` file, which contains the homology information for the run.

Warning

Mikado requires a **custom** tabular file from BLAST, as we rely on the information on extra fields such
as e.g. `btop`. Therefore the custom fields following `-outfmt 6` are **not** optional.

## 3.4. ORF calculation for the transcripts[¶](#orf-calculation-for-the-transcripts "Permalink to this headline")

Many of the metrics used by Mikado to evaluate and rank transcripts rely on the definition or their coding regions
(CDS). It is therefore *highly recommended* to use an ORF predictor to define the coding regions for each transcript
identified by mikado prepare. We directly support two different products:

* Prodigal, a fast ORF predictor, capable of calculating thousands of
  ORFs in seconds. However, as it was originally developed for ORF calling in bacterial genomes, it may occasionally
  not provide the best possible answer.
* TransDecoder, a slower ORF predictor that is however more
  specialised for eukaryotes.

For this tutorial we are going to use Prodigal. Using it is very straighforward:

```
prodigal -i mikado_prepared.fasta -g 1 -o mikado.orfs.gff3 -f gff
```

Warning

Prodigal by default uses the ‘Bacterial’ codon translation table, which is of course not appropriate at
all for our eukariote genome. Therefore, it is essential to set `-g 1` on the command line.
By the same token, as prodigal normally would output the CDS prediction in GenBank format (currently not
supported by Mikado), we have to instruct Prodigal to emit its CDS predictions in GFF format.

## 3.5. Mikado serialise[¶](#mikado-serialise "Permalink to this headline")

This step involves running `mikado serialise` to create a SQLite database with all the information that mikado
needs to perform its analysis. As most of the parameters are already specified inside the configuration file, the
command line is quite simple:

```
mikado serialise --json-conf configuration.yaml --xml mikado_prepared.blast.tsv --orfs mikado.orfs.gff3
```

–blast\_targets uniprot\_sprot\_plants.fasta –junctions junctions.bed

After mikado serialise has run, it will have created two files:

1. `mikado.db`, the SQLite database that will be used by `pick` to perform its analysis.
2. `serialise.log`, the log of the run.

If you inspect the SQLite database `mikado.db`, you will see it contains nine different tables:

```
$ sqlite3 mikado.db ".tables"
chrom             hit               orf
external          hsp               query
external_sources  junctions         target
```

These tables contain the information coming from the genome FAI, the BLAST XML, the junctions BED file,
the ORFs BED file, and finally the input transcripts and the proteins. There are two additional tables (`external`
and `external_sources`) which in other runs would contain information on additional data, provided as tabular files.

For more details on the database structure, please refer to the section on [this step](../Usage/Serialise/#serialise) in this
documentation.

## 3.6. Mikado pick[¶](#mikado-pick "Permalink to this headline")

Finally, during this step `mikado pick` will integrate the data present in the database with the positional and
structural data present in the GTF file [to select the best transcript models](../Usage/Pick/#pick). The command line to be
issued is the following:

```
mikado pick --configuration configuration.yaml --subloci_out mikado.subloci.gff3
```

At this step, we have to specify only some parameters for `pick` to function:

* *–configuration*: the configuration file. This is the only compulsory option.
* *–subloci\_out*: the partial results concerning the *subloci* step during the selection process will be written to

`mikado.subloci.gff3`.

`mikado pick` will produce the following output files:

* `mikado.loci.gff3`, `mikado.loci.metrics.tsv`, `mikado.loci.scores.tsv`: the proper output files. These contain the location of the selected transcripts, their metrics, and their scores. Please see [this section for details](../Usage/Pick/#pick-output).
* `mikado.subloci.gff3`, `mikado.subloci.metrics.tsv`, `mikado.subloci.scores.tsv`: these files contain the same type of information as those above, but for the *subloci* stage. As such, all the transcripts in the input files are represented, not just those that are going to be selected as the best.
* *mikado\_pick.log*: the log file for this operation.

## 3.7. Comparing files with the reference[¶](#comparing-files-with-the-reference "Permalink to this headline")

Finally, we can compare our files to the original reference annotation, and see how our results are compared to those. To do so, we will use [Mikado compare](../Usage/Compare/#compare).
The first step is to index the reference annotation to make the comparisons faster:

```
mikado compare -r reference.gff3 --index
```

This will create a new file, `reference.gff3.midx`. If you inspect with eg. `zless`, you will notice it is a SQLite database, describing the locations and components of each gene on the annotation. Now that we have indexed the reference, we can perform the comparisons we are interested in:

1. Reference vs. the input transcripts:

```
mikado compare -r reference.gff3 -p mikado_prepared.gt