[ganon2](..)

* [ganon2](..)

* [Quick Start](../start/)

* [Parameters](../params/)

* [Databases (ganon build)](../default_databases/)

* Custom databases (ganon build-custom)
  + [Non-standard files/headers with --input-file](#non-standard-filesheaders-with-input-file)
    - [Examples of --input-file using the default --input-target file](#examples-of-input-file-using-the-default-input-target-file)
      * [List of files](#list-of-files)
      * [List of files with alternative names](#list-of-files-with-alternative-names)
      * [Files and taxonomy](#files-and-taxonomy)
      * [Files, taxonomy and specialization](#files-taxonomy-and-specialization)
    - [Examples of --input-file using --input-target sequence](#examples-of-input-file-using-input-target-sequence)
      * [Sequences and taxonomy](#sequences-and-taxonomy)
      * [Sequences, taxonomy and specialization](#sequences-taxonomy-and-specialization)
  + [Examples](#examples)
    - [HumGut](#humgut)
    - [Plasmid, Plastid and Mitochondrion from RefSeq](#plasmid-plastid-and-mitochondrion-from-refseq)
    - [UniVec, UniVec\_core](#univec-univec_core)
    - [MGnify genome catalogues (MAGs)](#mgnify-genome-catalogues-mags)
    - [Pathogen detection FDA-ARGOS](#pathogen-detection-fda-argos)
    - [BLAST databases (nt env\_nt nt\_prok ...)](#blast-databases-nt-env_nt-nt_prok)
    - [Files from genome\_updater](#files-from-genome_updater)
  + [Parameter details](#parameter-details)
    - [False positive and size (--max-fp, --filter-size)](#false-positive-and-size-max-fp-filter-size)
    - [minimizers (--window-size, --kmer-size)](#minimizers-window-size-kmer-size)
    - [Target file or sequence (--input-target)](#target-file-or-sequence-input-target)
    - [Build level (--level)](#build-level-level)
    - [Genome sizes (--genome-size-files)](#genome-sizes-genome-size-files)
    - [Retrieving info (--ncbi-sequence-info, --ncbi-file-info)](#retrieving-info-ncbi-sequence-info-ncbi-file-info)

* [Classification (ganon classify)](../classification/)

* [Reports (ganon report)](../reports/)

* [Table (ganon table)](../table/)

* [Output files](../outputfiles/)

* [Tutorials](../tutorials/)

[ganon2](..)

* Custom databases (ganon build-custom)

---

# Custom databases[:)](#custom-databases "Permanent link")

Besides the automated download and build (`ganon build`) ganon provides a highly customizable build procedure (`ganon build-custom`) to create databases from local sequence files. The usage of this procedure depends on the configuration of your files:

* Filename like `GCA_002211645.1_ASM221164v1_genomic.fna.gz`: genomic fasta files in the NCBI standard, with assembly accession in the beginning of the filename. Provide the files with the `--input` parameter. ganon will try to retrieve all necessary information to build the database.
* Headers like `>NC_006297.1 Bacteroides fragilis YCH46 ...`: sequence headers are in the NCBI standard, with sequence accession in after `>` and with a space afterwards (or line break). Provide the files with the `--input` parameter and set `--input-target sequence`. ganon will try to retrieve all necessary information to build the database.
* For non-standard filenames and headers, [follow this](#non-standard-filesheaders-with-input-file)

Warning

`--input-target sequence` will be slower to build and will use more disk space, since files have be re-written separately for each sequence. More information about building by file or sequence can be found [here](#target-file-or-sequence-input-target).

The `--level` is a important parameter that will define the (max.) classification level for the database ([more infos](#build-level-level)):

* `--level file` or `sequence` -> default behavior (depending on `--input-target`), use file/sequence as classification target
* `--level assembly` -> will retrieve assembly related to the file/sequence, use assembly as classification target
* `--level leaves` or `species`,`genus`,... -> group input by taxonomy, use tax. nodes at the rank chosen as classification target

More infos about other parameters [here](#parameter-details).

## Non-standard files/headers with `--input-file`[:)](#non-standard-filesheaders-with-input-file "Permanent link")

Alternatively to the automatic input methods, it is possible to manually define the input with either standard or **non-standard filenames, accessions and headers** to build custom databases with `--input-file`. This file should contain the following fields (tab-separated):

`file [<tab> target <tab> node <tab> specialization <tab> specialization_name].`

* `file`: relative or full path to the sequence file
* `target`: any unique text to name the file, to be used in the taxonomy
* `node`: taxonomic node (e.g. taxid) to link entry with taxonomy
* `specialization`: creates a specialized taxonomic level with a custom name, allowing files to be grouped
* `specialization_name`: a name for the specialization, to be used in the taxonomy

Warning

the `target` and `specialization` fields (2nd and 4th col) cannot be the same as the `node` (3rd col)

Below you find example of `--input-file`. Note they are slightly different depending on the `--input-target` chosen. They need to be *tab-separated* to be properly parsed (tsv).

### Examples of `--input-file` using the default `--input-target file`[:)](#examples-of-input-file-using-the-default-input-target-file "Permanent link")

#### List of files[:)](#list-of-files "Permanent link")

```
sequences.fasta
others.fasta
```

No taxonomic information is provided so `--taxonomy skip` should be set. The classification against the generated database will be performed at file level (`--level file`), since that is the only available information given.

#### List of files with alternative names[:)](#list-of-files-with-alternative-names "Permanent link")

```
sequences.fasta  sequences
others.fasta     others
```

Just like above, but with a specific name to be used for each file.

#### Files and taxonomy[:)](#files-and-taxonomy "Permanent link")

```
sequences.fasta  sequences  562
others.fasta     others     623
```

The classification max. level against this database will depend on the value set for `--level`:

* `--level file` -> use the file (named with target) with node as parent
* `--level leaves` or `species`,`genus`,... -> files are grouped by taxonomy

#### Files, taxonomy and specialization[:)](#files-taxonomy-and-specialization "Permanent link")

```
sequences.fasta  sequences  562  ID44444  Escherichia coli TW10119
others.fasta     others     623  ID55555  Shigella flexneri 1a
```

The classification max. level against this database will depend on the value set for `--level`:

* `--level custom` -> use the specialization (named with specialization\_name) with node as parent
* `--level file` -> use the file (named with target) as a tax. node as parent
* `--level leaves` or `species`,`genus`,... -> files are grouped by taxonomy

### Examples of `--input-file` using `--input-target sequence`[:)](#examples-of-input-file-using-input-target-sequence "Permanent link")

To provide a tabular information for every sequence in your files, you need to use the `target` field (2nd col.) of the `--input-file` to input sequence headers. For example:

#### Sequences and taxonomy[:)](#sequences-and-taxonomy "Permanent link")

```
sequences.fasta  NZ_CP054001.1  562
sequences.fasta  NZ_CP117955.1  623
others.fasta     header1        666
others.fasta     header2        666
```

The classification max. level against this database will depend on the value set for `--level`:

* `--level sequence` -> use the sequence header with node as parent
* `--level assembly` -> will attempt to retrieve the assembly related to the sequence with node as parent
* `--level leaves` or `species`,`genus`,... -> files are grouped by taxonomy

#### Sequences, taxonomy and specialization[:)](#sequences-taxonomy-and-specialization "Permanent link")

```
sequences.fasta  NZ_CP054001.1  562  ID44444  Escherichia coli TW10119
sequences.fasta  NZ_CP117955.1  623  ID55555  Shigella flexneri 1a
others.fasta     header1        666  StrainA  My Strain
others.fasta     header2        666  StrainA  My Strain
```

The classification max. level against this database will depend on the value set for `--level`:

* `--level custom` -> use the specialization (named with specialization\_name) with node as parent
* `--level sequence` -> use the sequence header with node as parent
* `--level leaves` or `species`,`genus`,... -> files are grouped by taxonomy

## Examples[:)](#examples "Permanent link")

Below you will find some examples from commonly used repositories for metagenomics analysis with `ganon build-custom`:

### HumGut[:)](#humgut "Permanent link")

Collection of >30000 genomes from healthy human metagenomes. [Article](https://microbiomejournal.biomedcentral.com/articles/10.1186/s40168-021-01114-w)/[Website](https://arken.nmbu.no/~larssn/humgut/).

```
# Download sequence files
wget --quiet --show-progress "http://arken.nmbu.no/~larssn/humgut/HumGut.tar.gz"
tar xf HumGut.tar.gz

# Download taxonomy and metadata files
wget "https://arken.nmbu.no/~larssn/humgut/ncbi_nodes.dmp"
wget "https://arken.nmbu.no/~larssn/humgut/ncbi_names.dmp"
wget "https://arken.nmbu.no/~larssn/humgut/HumGut.tsv"
# Generate --input-file from metadata
tail -n+2 HumGut.tsv | awk -F"\t" '{print "fna/"$21"\t"$1"\t"$6}' > HumGut_ganon_input_file.tsv

# Build ganon database
ganon build-custom --input-file HumGut_ganon_input_file.tsv --taxonomy-files ncbi_nodes.dmp ncbi_names.dmp --db-prefix HumGut --level strain --threads 32
```

Similarly using GTDB taxonomy files:

```
# Download taxonomy files
wget "https://arken.nmbu.no/~larssn/humgut/gtdb_nodes.dmp"
wget "https://arken.nmbu.no/~larssn/humgut/gtdb_names.dmp"

# Build ganon database
ganon build-custom --input-file HumGut_ganon_input_file.tsv --taxonomy-files gtdb_nodes.dmp gtdb_names.dmp --db-prefix HumGut_gtdb --level strain --threads 32
```

Note

There is no need to use ganon's gtdb integration here since GTDB files in NCBI format are available

### Plasmid, Plastid and Mitochondrion from RefSeq[:)](#plasmid-plastid-and-mitochondrion-from-refseq "Permanent link")

Extra repositories from RefSeq release not included as default databases. [Website](https://www.ncbi.nlm.nih.gov/refseq/).

```
# Download sequence files
wget -A genomic.fna.gz -m -nd --quiet --show-progress "ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/plasmid/"
wget -A genomic.fna.gz -m -nd --quiet --show-progress "ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/plastid/"
wget -A genomic.fna.gz -m -nd --quiet --show-progress "ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/mitochondrion/"

ganon build-custom --input plasmid.* plastid.* mitochondrion.* --db-prefix ppm --level species --threads 8 --input-target sequence
```

### UniVec, UniVec\_core[:)](#univec-univec_core "Permanent link")

"UniVec is a non-redundant database of sequences commonly attached to cDNA or genomic DNA during the cloning process." [Website](https://ftp.ncbi.nlm.nih.gov/pub/UniVec/README.uv). Useful to screen for vector and linker/adapter contamination. UniVec\_core is a sub-set of the UniVec selected to reduce the false positive hits from real biological sources.

```
# UniVec
wget -O "UniVec.fasta" --quiet --show-progress "ftp://ftp.ncbi.nlm.nih.gov/pub/UniVec/UniVec"
echo -e "UniVec.fasta\tUniVec\t81077" > UniVec_ganon_input_file.tsv
ganon build-custom --input-file UniVec_ganon_input_file.tsv --db-prefix UniVec --level leaves --threads 8 --skip-genome-size

# UniVec_Core
wget -O "UniVec_Core.fasta" --quiet --show-progress "ftp://ftp.ncbi.nlm.nih.gov/pub/UniVec/UniVec_Core"
echo -e "UniVec_Core.fasta\tUniVec_Core\t81077" > UniVec_Core_ganon_input_file.tsv
ganon build-custom --input-file UniVec_Core_ganon_input_file.tsv --db-prefix UniVec_Core --level leaves --threads 8 --skip-genome-size
```

Note

All UniVec entries in the examples are categorized as [Artificial Sequence](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=81077) (NCBI txid:81077). Some are completely artificial but others may be derived from real biological sources. More information in this [link](https://ftp.ncbi.nlm.nih.gov/pub/UniVec/README.vector.origins).

### MGnify genome catalogues (MAGs)[:)](#mgnify-genome-catalogues-mags "Permanent link")

"Genome catalogues are biome-specific collections of metagenomic-assembled and isolate genomes". [Article](https://ftp.ebi.ac.uk/pub/databases/metagenomics/mgnify_genomes/)/[Website](https://www.ebi.ac.uk/metagenomics/browse/genomes)/[FTP](https://ftp.ebi.ac.uk/pub/databases/metagenomics/mgnify_genomes/).

Currently available genome catalogues (2024-02-09): `chicken-gut` `cow-rumen` `honeybee-gut` `human-gut` `human-oral` `human-vaginal` `marine` `mouse-gut` `non-model-fish-gut` `pig-gut` `zebrafish-fecal`

*List currently available entries `curl --silent --list-only ftp://ftp.ebi.ac.uk/pub/databases/metagenomics/mgnify_genomes/`*

Example on how to download and build the `human-oral` catalog:

```
# Download metadata
wget "https://ftp.ebi.ac.uk/pub/databases/metagenomics/mgnify_genomes/human-oral/v1.0.1/genomes-all_metadata.tsv"

# Download sequence files with 12 threads
tail -n+2 genomes-all_metadata.tsv | cut -f 1,20 | xargs -P 12 -n2 sh -c 'curl --silent ${1}| gzip -d | sed -e "1,/##FASTA/ d" | gzip > ${0}.fna.gz'

# Generate ganon input file
tail -n+2 genomes-all_metadata.tsv | cut -f 1,15  | tr ';' '\t' | awk -F"\t" '{tax="1";for(i=NF;i>1;i--){if(length($i)>3){tax=$i;break;}};print $1".fna.gz\t"$1"\t"tax}' > ganon_input_file.tsv

# Build ganon database
ganon build-custom --input-file ganon_input_file.tsv --db-prefix mgnify_human_oral_v101 --taxonomy gtdb --level leaves --threads 8
```

Note

MGnify genomes catalogues will be build with GTDB taxonomy.

### Pathogen detection FDA-ARGOS[:)](#pathogen-detection-fda-argos "Permanent link")

A collection of >1400 "microbes that include biothreat microorganisms, common clinical pathogens and closely related species". [Article](https://www.ncbi.nlm.nih.gov/bioproject/231221)/[Website](https://www.ncbi.nlm.nih.gov/bioproject/231221)/[BioProject](https://www.ncbi.nlm.nih.gov/bioproject/231221).

```
# Download sequence files
wget https://ftp.ncbi.nlm.nih.gov/genomes/refseq/assembly_summary_refseq.txt
grep "strain=FDAARGOS" assembly_summary_refseq.txt > fdaargos_assembly_summary.txt
genome_updater.sh -e fdaargos_assembly_summary.txt -f "genomic.fna.gz" -o download -m -t 12

# Build ganon database
ganon build-custom --input download/ --input-recursive --db-prefix fdaargos --ncbi-file-info download/assembly_summary.txt --level assembly --threads 32
```

Note

The example above uses [genome\_updater](https://github.com/pirovc/genome_updater) to download files

### BLAST databases (nt env\_nt nt\_prok ...)[:)](#blast-databases-nt-env_nt-nt_prok "Permanent link")

BLAST databases. [Website](https://blast.ncbi.nlm.nih.gov/Blast.cgi)/[FTP](https://f