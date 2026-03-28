[MAVIS](index.html)

2.2.6

* [About](about.html)
* Inputs
  + [Reference Input Files](#reference-input-files)
    - [Reference Genome](#reference-genome)
    - [Template Metadata](#template-metadata)
    - [Masking File](#masking-file)
    - [Annotations](#annotations)
      * [Generating the Annotations from Ensembl](#generating-the-annotations-from-ensembl)
    - [DGV (Database of Genomic Variants) Annotations](#dgv-database-of-genomic-variants-annotations)
    - [Aligner Reference](#aligner-reference)
  + [MAVIS standard input file format](#mavis-standard-input-file-format)
    - [Required Columns](#required-columns)
    - [Optional Columns](#optional-columns)
    - [Summary by Pipeline Step](#summary-by-pipeline-step)
* [Supported Dependencies](supported_dependencies.html)
* [Running the Pipeline](pipeline.html)
* [Configuration and Settings](configuration.html)
* [Resource Requirements](performance.html)
* [Theory and Models](theory.html)
* [Illustrations](illustrations.html)
* [Guidelines for Contributors](development.html)
* [Package Documentation](package.html)
* [Glossary](glossary.html)

[MAVIS](index.html)

* [Docs](index.html) »
* Inputs
* [View page source](_sources/mavis_input.rst.txt)

---

# Inputs[¶](#inputs "Permalink to this headline")

## Reference Input Files[¶](#reference-input-files "Permalink to this headline")

There are several reference files that are required for full functionality of the MAVIS pipeline. If the same
reference file will be reused often then the user may find it helpful to set reasonable defaults. Default values
for any of the reference file arguments can be [configured through environment variables](configuration.html#config-environment).

To improve the install experience for the users, different configurations of the MAVIS annotations file have been made available. These files can be downloaded below, or if the required configuration is not available, [instructions on generating the annotations file](reference.html#generate-reference-annotations) can be found below.

| File Name (Type/Format) | Environment Variable | Download |
| --- | --- | --- |
| [reference genome](reference.html#reference-files-reference-genome) ([fasta](glossary.html#term-fasta)) | `MAVIS_REFERENCE_GENOME` | [![](_static/Ic_cloud_download_48px.svg)GRCh37/Hg19](http://hgdownload.cse.ucsc.edu/goldenPath/hg19/bigZips/chromFa.tar.gz)  [![](_static/Ic_cloud_download_48px.svg)GRCh38](http://hgdownload.cse.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz) |
| [annotations](reference.html#reference-files-annotations) ([JSON](glossary.html#term-json)) | `MAVIS_ANNOTATIONS` | [![](_static/Ic_cloud_download_48px.svg)GRCh37/Hg19 + Ensembl69](http://www.bcgsc.ca/downloads/mavis/ensembl69_hg19_annotations.json)  [![](_static/Ic_cloud_download_48px.svg)GRCh38 + Ensembl79](http://www.bcgsc.ca/downloads/mavis/ensembl79_hg38_annotations.json) |
| [masking](reference.html#reference-files-masking) (text/tabbed) | `MAVIS_MASKING` | [![](_static/Ic_cloud_download_48px.svg)GRCh37/Hg19](http://www.bcgsc.ca/downloads/mavis/hg19_masking.tab)  [![](_static/Ic_cloud_download_48px.svg)GRCh38](http://www.bcgsc.ca/downloads/mavis/GRCh38_masking.tab) |
| [template metadata](reference.html#reference-files-template-metadata) (text/tabbed) | `MAVIS_TEMPLATE_METADATA` | [![](_static/Ic_cloud_download_48px.svg)GRCh37/Hg19](http://hgdownload.cse.ucsc.edu/goldenPath/hg19/database/cytoBand.txt.gz)  [![](_static/Ic_cloud_download_48px.svg)GRCh38](http://hgdownload.cse.ucsc.edu/goldenPath/hg38/database/cytoBand.txt.gz) |
| [DGV annotations](reference.html#reference-files-dgv-annotations) (text/tabbed) | `MAVIS_DGV_ANNOTATION` | [![](_static/Ic_cloud_download_48px.svg)GRCh37/Hg19](http://www.bcgsc.ca/downloads/mavis/dgv_hg19_variants.tab)  [![](_static/Ic_cloud_download_48px.svg)GRCh38](http://www.bcgsc.ca/downloads/mavis/dgv_hg38_variants.tab) |
| [aligner reference](reference.html#reference-files-aligner-reference) | `MAVIS_ALIGNER_REFERENCE` | [![](_static/Ic_cloud_download_48px.svg)GRCh37/Hg19 2bit (blat)](http://hgdownload.cse.ucsc.edu/goldenPath/hg19/bigZips/hg19.2bit)  [![](_static/Ic_cloud_download_48px.svg)GRCh38 2bit (blat)](http://hgdownload.cse.ucsc.edu/goldenPath/hg38/bigZips/hg38.2bit) |

If the environment variables above are set they will be used as the default values when any step of the pipeline
script is called (including generating the template config file)

### Reference Genome[¶](#reference-genome "Permalink to this headline")

These are the sequence files in fasta format that are used in aligning and generating the fusion sequences.

### Template Metadata[¶](#template-metadata "Permalink to this headline")

This is the file which contains the band information for the chromosomes. This is only used during visualization.

The structure of the file should look something like this

```
chr1    0       2300000 p36.33  gneg
chr1    2300000 5400000 p36.32  gpos25
chr1    5400000 7200000 p36.31  gneg
chr1    7200000 9200000 p36.23  gpos25
chr1    9200000 12700000        p36.22  gneg
```

### Masking File[¶](#masking-file "Permalink to this headline")

The masking file is a tab delimited file which contains regions that we should ignore calls in.
This can be used to filter out regions with known false positives, bad mapping, centromeres, telomeres etc.
An example of the expected format is shown below. The file should have four columns: chr, start, end and name.

```
#chr    start   end     name
chr1    0       2300000 centromere
chr1    9200000 12700000        telomere
```

The pre-built masking files in the downloads table above are telomere regions, centromere regions (based on the cytoband file),
and nspan regions (computed with tools/find\_repeats.py).

Masking is not required (can provide a header-only file), but is recommended as it will improve performance and specificity.

### Annotations[¶](#annotations "Permalink to this headline")

This is a custom file format. It is a [JSON](glossary.html#term-json) file which contains the gene, transcript, exon,
translation and protein domain positional information

Pre-built annotation files can be downloaded above. The ‘best transcript’ flag is based on an in-house model.
We have also pre-built the ensembl annotations file including non-coding transcripts below.

Warning

It is worth noting that using the reference annotation file including
the non-coding genes will require an increase in the default amount of memory for the annotation step due
to the increased size of the annotations file. On our standard COLO829 we increased the default memory
for the annotation step from 12G to 18G.

[![](_static/Ic_cloud_download_48px.svg)GRCh37/Hg19 + Ensembl69 (includes non-coding genes)](http://www.bcgsc.ca/downloads/mavis/ensembl69_hg19_annotations_with_ncrna.json)

Warning

the `load_reference_genes()` will
only load valid translations. If the cds sequence in the annotation is not
a multiple of `CODON_SIZE` or if a
reference genome (sequences) is given and the cds start and end are not
M and \* amino acids as expected the translation is not loaded

Example of the [JSON](glossary.html#term-json) file structure can be seen below

```
[
    {
        "name": string,
        "start": int,
        "end": int
        "aliases": [string, string, ...],
        "transcripts": [
            {
                "name": string,
                "start": int,
                "end": int,
                "exons": [
                    {"start": int, "end": int, "name": string},
                    ...
                ],
                "cdna_coding_start": int,
                "cdna_coding_end": int,
                "domains": [
                    {
                        "name": string,
                        "regions": [
                            {"start" aa_start, "end": aa_end}
                        ],
                        "desc": string
                    },
                    ...
                ]
            },
            ...
        ]
    },
    ...
}
```

The provided files were generated with [Ensembl](theory.html#yates-2016), however it can be generated from any database with the
necessary information so long as the above [JSON](glossary.html#term-json) structure is respected.

#### Generating the Annotations from [Ensembl](theory.html#yates-2016)[¶](#generating-the-annotations-from-ensembl "Permalink to this headline")

There is a helper script included with mavis to facilitate generating the custom annotations
file from an instance of the [Ensembl](theory.html#yates-2016) database. This uses the [Ensembl](theory.html#yates-2016) perl api to connect and
pull information from the database. This has been tested with both Ensembl69 and Ensembl79.

Instructions for downloading and installing the perl api can be found on the [ensembl site](http://www.ensembl.org/info/docs/api/api_installation.html)

1. **Make sure the ensembl perl api modules are added to the PERL5LIB environment variable**

Also ensure that the tools directory is on the PERL5LIB path so that the TSV.pm module can be found

```
INSTALL_PATH=$(pwd)
PERL5LIB=${PERL5LIB}:$HOME/ensembl_79/bioperl-live
PERL5LIB=${PERL5LIB}:$HOME/ensembl_79/ensembl/modules
PERL5LIB=${PERL5LIB}:$HOME/ensembl_79/ensembl-compara/modules
PERL5LIB=${PERL5LIB}:$HOME/ensembl_79/ensembl-variation/modules
PERL5LIB=${PERL5LIB}:$HOME/ensembl_79/ensembl-funcgen/modules
# include tools/TSV.pm module
PERL5LIB=${PERL5LIB}:$INSTALL_PATH/tools
export PERL5LIB
```

2. **Run the perl script**

The below instructions are shown running from inside the tools directory to avoid prefixing the script name, but it is not required
to be run from here provided the above step has been executed correctly.

you can view the help menu by running

```
perl generate_ensembl_json.pl
```

you can override the default parameters (based on hard-coded defaults or environment variable content) by providing arguments
to the script itself

```
perl generate_ensembl_json.pl --best_transcript_file /path/to/best/transcripts/file --output /path/to/output/json/file.json
```

or if you have configured the environment variables as given in step 2, then simply provide the output path

```
perl generate_ensembl_json.pl --output /path/to/output/json/file.json
```

### [DGV (Database of Genomic Variants)](theory.html#macdonald-2014) Annotations[¶](#dgv-database-of-genomic-variants-annotations "Permalink to this headline")

The DGV annotations file contains regions corresponding to what is found in the database of genomic variants. This is
used to annotate events that are found in healthy control samples and therefore may not be of interest
if looking for somatic events.

The above (downloads table) files were generated from from [DGV](http://dgv.tcag.ca/dgv/app/download)
and reformatted to have 4 columns after download. We used awk to convert the raw file

```
awk '{print $2"\t"$3"\t"$4"\t"$1} GRCh37_hg19_variants_2016-05-15.txt > dgv_hg19_variants.tab
```

Note in hg19 the column is called “name” and in hg38 the column is called “variantaccession”.
An example is shown below

```
#chr     start   end     name
1       1       2300000 nsv482937
1       10001   22118   dgv1n82
1       10001   127330  nsv7879
```

### Aligner Reference[¶](#aligner-reference "Permalink to this headline")

The aligner reference file is the reference genome file used by the aligner during the validate stage. For example,
if [blat](glossary.html#term-blat) is the aligner then this will be a [2bit](glossary.html#term-2bit) file.

## MAVIS standard input file format[¶](#mavis-standard-input-file-format "Permalink to this headline")

These requirements pertain to the columns of input files from the various tools you want to merge. The input files
should be tab-delimited text files. Comments at the top of may be included. Comments should begin with two hash marks.
They will be ignored when the file is read

```
## This is a comment
```

The header row contains the column names and is the first row following the comments (or the first row if no comments
are included). Optionally the header row may (or may not) begin with a hash which will be stripped out on read

```
## This is a comment
## this is another comment
# this is the header row
```

A simple input file might look as follows

```
## File created at: 2018-01-02
## Generated by: MAVIS v1.0.0
#break1_chromosome  break1_position_start   break1_position_end break2_chromosome break2_position_start break2_position_end
X   1234    1234    X   77965   77965
```

### Required Columns[¶](#required-columns "Permalink to this headline")

* [break1\_chromosome](glossary.html#term-break1-chromosome)
* [break1\_position\_start](glossary.html#term-break1-position-start)
* [break1\_position\_end](glossary.html#term-break1-position-end) (can be the same as break1\_position\_start)
* [break2\_chromosome](glossary.html#term-break2-chromosome)
* [break2\_position\_start](glossary.html#term-break2-position-start)
* [break2\_position\_end](glossary.html#term-break2-position-end) (can be the same as break2\_position\_start)

### Optional Columns[¶](#optional-columns "Permalink to this headline")

Optional Columns that are not given as input will be added with default (or command line parameter options) during
the clustering stage of MAVIS as some are required for subsequent pipeline steps

* [break1\_strand](glossary.html#term-break1-strand) (defaults to not-specified during clustering)
* [break1\_orientation](glossary.html#term-break1-orientation) (expanded to all possible values during clustering)
* [break2\_strand](glossary.html#term-break2-strand) (defaults to not-specified during clustering)
* [break2\_orientation](glossary.html#term-break2-orientation) (expanded to all possible values during clustering)
* [opposing\_strands](glossary.html#term-opposing-strands) (expanded to all possible values during clustering)
* [stranded](glossary.html#term-stranded) (defaults to False during clustering)
* [library](glossary.html#term-library) (defaults to command line library parameter during clustering)
* [protocol](glossary.html#term-protocol) (defaults to command line protocol parameter during clustering)
* [tools](glossary.html#term-tools) (defaults to an empty string during clustering)

### Summary by Pipeline Step[¶](#summary-by-pipeline-step "Permalink to this headline")

The different pipeline steps of MAVIS have different input column requirements. These are summarized below (for the
pipeline steps which can act as the pipeline start)

| column name | cluster | annotate | validate |
| --- | --- | --- | --- |
| [break1\_chromosome](glossary.html#term-break1-chromosome) | ✔ | ✔ | ✔ |
| [break1\_position\_start](glossary.html#term-break1-position-start) | ✔ | ✔ | ✔ |
| [break1\_position\_end](glossary.html#term-break1-position-end) | ✔ | ✔ | ✔ |
| [break2\_chromosome](glossary.html#term-break2-chromosome) | ✔ | ✔ | ✔ |
| [break2\_position\_start](glossary.html#term-break2-position-start)