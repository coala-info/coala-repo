[![CADD logo](/static/icon.png)

# CADD - Combined Annotation Dependent Depletion](/)

* [News](/news "Recent updates")
* [Score](/score "Upload a vcf file for variant scoring")
* [SNV](#popover-snv)

  + [Single](/snv "Lookup for single SNV")
  + [Range](/snv-range "SNV range lookup")
* [Downloads](/download "Data downloads for offline scoring")
* [About](#popover-about)

  + [Information](/info "About CADD")
  + [API](/api "Information about the CADD API")
  + [Genome Browser](/genome-browser "Information about displaying CADD scores in UCSC Genome Browser")
  + [Links](/links "Links to CADD related resources")
  + [Contact](/contact "Contact")
* (Alt. site:
  [![Visit German site](/static/DE-flag.png)](https://cadd.bihealth.org/))

***Note:* Scoring of VCF files with CADD v1.7 is still rather slow if many new
variants need to be calculated from scratch (e.g., if many insertion/deletion or multi-nucleotide substitutions
are included). If possible use the pre-scored whole genome and pre-calculated indel files directly where possible.**

CADD scores are freely available for all non-commercial applications. If you are
planning on using them in a commercial application, please obtain a [license](https://els2.comotion.uw.edu/product/cadd-scores). If you have questions, please [contact us](/contact).

**Due to the large file sizes, we highly recommend a download manager or another tool that allows you to continue
interrupted downloads (e.g. wget -c).
Note that the latest versions also have a separate download option via the install script.**

# CADD v1.7 [[release notes]](/static/ReleaseNotes_CADD_v1.7.pdf)

## Offline scoring scripts for v1.7

|  |  |  |
| --- | --- | --- |
| [Scripts and README for offline installation](https://github.com/kircherlab/CADD-scripts/) | [file (701K)](https://github.com/kircherlab/CADD-scripts/archive/v1.7.zip) |  |

## Genome build GRCh38 / hg38

| Description | Link (Size) | Tabix Index (Size) |
| --- | --- | --- |
| All possible SNVs of GRCh38/hg38 | [US](https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh38/whole_genome_SNVs.tsv.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.7/GRCh38/whole_genome_SNVs.tsv.gz) (81G) | [US](https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh38/whole_genome_SNVs.tsv.gz.tbi) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.7/GRCh38/whole_genome_SNVs.tsv.gz.tbi) (2.6M) |
| All possible SNVs of GRCh38/hg38 incl. all annotations | [US](https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh38/whole_genome_SNVs_inclAnno.tsv.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.7/GRCh38/whole_genome_SNVs_inclAnno.tsv.gz) (625G) | [US](https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh38/whole_genome_SNVs_inclAnno.tsv.gz.tbi) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.7/GRCh38/whole_genome_SNVs_inclAnno.tsv.gz.tbi) (2.7M) |
| All gnomAD release 4.0 InDels (from genomes only) to initiate a local setup | [US](https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh38/gnomad.genomes.r4.0.indel.tsv.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.7/GRCh38/gnomad.genomes.r4.0.indel.tsv.gz) (1.2G) | [US](https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh38/gnomad.genomes.r4.0.indel.tsv.gz.tbi) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.7/GRCh38/gnomad.genomes.r4.0.indel.tsv.gz.tbi) (1.8M) |
| All gnomAD release 4.0 InDels (from genomes only) incl. all annotations to initiate a local setup | [US](https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh38/gnomad.genomes.r4.0.indel_inclAnno.tsv.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.7/GRCh38/gnomad.genomes.r4.0.indel_inclAnno.tsv.gz) (11G) | [US](https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh38/gnomad.genomes.r4.0.indel_inclAnno.tsv.gz.tbi) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.7/GRCh38/gnomad.genomes.r4.0.indel_inclAnno.tsv.gz.tbi) (2.6M) |
| MD5Sums | [US](https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh38/MD5SUMs) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.7/GRCh38/MD5SUMs) |  |
| All GRCh38 annotations required for offline installation | [US](https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh38/GRCh38_v1.7.tar.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.7/GRCh38/GRCh38_v1.7.tar.gz) (336G) |  |

## Genome build GRCh37 / hg19

| Description | Link (Size) | Tabix Index (Size) |
| --- | --- | --- |
| All possible SNVs of GRCh37/hg19 | [US](https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh37/whole_genome_SNVs.tsv.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.7/GRCh37/whole_genome_SNVs.tsv.gz) (79G) | [US](https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh37/whole_genome_SNVs.tsv.gz.tbi) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.7/GRCh37/whole_genome_SNVs.tsv.gz.tbi) (2.6M) |
| All possible SNVs of GRCh37/hg19 incl. all annotations | [US](https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh37/whole_genome_SNVs_inclAnno.tsv.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.7/GRCh37/whole_genome_SNVs_inclAnno.tsv.gz) (562G) | [US](https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh37/whole_genome_SNVs_inclAnno.tsv.gz.tbi) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.7/GRCh37/whole_genome_SNVs_inclAnno.tsv.gz.tbi) (2.7M) |
| Liftover gnomAD v4 InDels (from genomes and exomes) to initiate a local setup | [US](https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh37/gnomad.genomes-exomes.r4.0.indel.tsv.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.7/GRCh37/gnomad.genomes-exomes.r4.0.indel.tsv.gz) (1.4G) | [US](https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh37/gnomad.genomes-exomes.r4.0.indel.tsv.gz.tbi) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.7/GRCh37/gnomad.genomes-exomes.r4.0.indel.tsv.gz.tbi) (1.9M) |
| Liftover gnomAD v4 InDels (from genomes and exomes) incl. all annotations to initiate a local setup | [US](https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh37/gnomad.genomes-exomes.r4.0.indel_inclAnno.tsv.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.7/GRCh37/gnomad.genomes-exomes.r4.0.indel_inclAnno.tsv.gz) (10G) | [US](https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh37/gnomad.genomes-exomes.r4.0.indel_inclAnno.tsv.gz.tbi) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.7/GRCh37/gnomad.genomes-exomes.r4.0.indel_inclAnno.tsv.gz.tbi) (2.5M) |
| MD5Sums | [US](https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh37/MD5SUMs) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.7/GRCh37/MD5SUMs) |  |
| All GRCh37 annotations required for offline installation | [US](https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh37/GRCh37_v1.7.tar.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.7/GRCh37/GRCh37_v1.7.tar.gz) (261G) |  |

# CADD-splice: v1.6 [[release notes]](/static/ReleaseNotes_CADD_v1.6.pdf)

## Offline scoring scripts for v1.6

|  |  |  |
| --- | --- | --- |
| [Scripts and README for offline installation](https://github.com/kircherlab/CADD-scripts/) | [file (360K)](https://github.com/kircherlab/CADD-scripts/archive/v1.6.post1.zip) |  |

## Genome build GRCh38 / hg38

| Description | Link (Size) | Tabix Index (Size) |
| --- | --- | --- |
| All possible SNVs of GRCh38/hg38 | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh38/whole_genome_SNVs.tsv.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh38/whole_genome_SNVs.tsv.gz) (81G) | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh38/whole_genome_SNVs.tsv.gz.tbi) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh38/whole_genome_SNVs.tsv.gz.tbi) (2.6M) |
| All possible SNVs of GRCh38/hg38 incl. all annotations | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh38/whole_genome_SNVs_inclAnno.tsv.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh38/whole_genome_SNVs_inclAnno.tsv.gz) (313G) | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh38/whole_genome_SNVs_inclAnno.tsv.gz.tbi) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh38/whole_genome_SNVs_inclAnno.tsv.gz.tbi) (2.7M) |
| All gnomad release 3.0 InDels to initiate a local setup | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh38/gnomad.genomes.r3.0.indel.tsv.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh38/gnomad.genomes.r3.0.indel.tsv.gz) (1.1G) | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh38/gnomad.genomes.r3.0.indel.tsv.gz.tbi) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh38/gnomad.genomes.r3.0.indel.tsv.gz.tbi) (1.8M) |
| All gnomad release 3.0 InDels incl. all annotations to initiate a local setup | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh38/gnomad.genomes.r3.0.indel_inclAnno.tsv.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh38/gnomad.genomes.r3.0.indel_inclAnno.tsv.gz) (7.2G) | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh38/gnomad.genomes.r3.0.indel_inclAnno.tsv.gz.tbi) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh38/gnomad.genomes.r3.0.indel_inclAnno.tsv.gz.tbi) (2.5M) |
| All gnomad release 3.0 SNVs | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh38/gnomad.genomes.r3.0.snv.tsv.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh38/gnomad.genomes.r3.0.snv.tsv.gz) (5.9G) | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh38/gnomad.genomes.r3.0.snv.tsv.gz.tbi) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh38/gnomad.genomes.r3.0.snv.tsv.gz.tbi) (2.4M) |
| MD5Sums | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh38/MD5SUMs) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh38/MD5SUMs) |  |
| All GRCh38 annotations required for offline installation | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh38/annotationsGRCh38_v1.6.tar.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh38/annotationsGRCh38_v1.6.tar.gz) (206G) |  |

## Genome build GRCh37 / hg19

| Description | Link (Size) | Tabix Index (Size) |
| --- | --- | --- |
| All possible SNVs of GRCh37/hg19 | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh37/whole_genome_SNVs.tsv.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh37/whole_genome_SNVs.tsv.gz) (78G) | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh37/whole_genome_SNVs.tsv.gz.tbi) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh37/whole_genome_SNVs.tsv.gz.tbi) (2.6M) |
| All possible SNVs of GRCh37/hg19 incl. all annotations | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh37/whole_genome_SNVs_inclAnno.tsv.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh37/whole_genome_SNVs_inclAnno.tsv.gz) (248G) | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh37/whole_genome_SNVs_inclAnno.tsv.gz.tbi) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh37/whole_genome_SNVs_inclAnno.tsv.gz.tbi) (2.6M) |
| 48M InDels to initiate a local setup | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh37/InDels.tsv.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh37/InDels.tsv.gz) (591M) | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh37/InDels.tsv.gz.tbi) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh37/InDels.tsv.gz.tbi) (1.7M) |
| 48M InDels incl. all annotations to initiate a local setup | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh37/InDels_inclAnno.tsv.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh37/InDels_inclAnno.tsv.gz) (3.5G) | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh37/InDels_inclAnno.tsv.gz.tbi) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh37/InDels_inclAnno.tsv.gz.tbi) (2.4M) |
| All [gnomAD](http://gnomad.broadinstitute.org) SNVs (release 2.1.1) | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh37/gnomad.genomes.r2.1.1.snv.tsv.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh37/gnomad.genomes.r2.1.1.snv.tsv.gz) (2.3G) | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh37/gnomad.genomes.r2.1.1.snv.tsv.gz.tbi) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh37/gnomad.genomes.r2.1.1.snv.tsv.gz.tbi) (2.0M) |
| All [gnomAD](http://gnomad.broadinstitute.org) InDels (release 2.1.1) | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh37/gnomad.genomes.r2.1.1.indel.tsv.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh37/gnomad.genomes.r2.1.1.indel.tsv.gz) (387M) | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh37/gnomad.genomes.r2.1.1.indel.tsv.gz.tbi) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh37/gnomad.genomes.r2.1.1.indel.tsv.gz.tbi) (1.6M) |
| MD5Sums | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh37/MD5SUMs) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh37/MD5SUMs) |  |
| All GRCh37 annotations required for offline installation | [US](https://krishna.gs.washington.edu/download/CADD/v1.6/GRCh37/annotationsGRCh37_v1.6.tar.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.6/GRCh37/annotationsGRCh37_v1.6.tar.gz) (129G) |  |

# Developmental release: v1.5 [[release notes]](/static/ReleaseNotes_CADD_v1.5.pdf)

## Offline scoring scripts for v1.4 and v1.5

|  |  |  |
| --- | --- | --- |
| [Scripts and README for offline installation](https://github.com/kircherlab/CADD-scripts/tree/CADD1.5) | [file (360K)](https://github.com/kircherlab/CADD-scripts/archive/CADD1.5.zip) |  |

## Genome build GRCh38 / hg38

| Description | Link (Size) | Tabix Index (Size) |
| --- | --- | --- |
| All possible SNVs of GRCh38/hg38 | [US](https://krishna.gs.washington.edu/download/CADD/v1.5/GRCh38/whole_genome_SNVs.tsv.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.5/GRCh38/whole_genome_SNVs.tsv.gz) (80G) | [US](https://krishna.gs.washington.edu/download/CADD/v1.5/GRCh38/whole_genome_SNVs.tsv.gz.tbi) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.5/GRCh38/whole_genome_SNVs.tsv.gz.tbi) (2.7M) |
| All possible SNVs of GRCh38/hg38 incl. all annotations | [US](https://krishna.gs.washington.edu/download/CADD/v1.5/GRCh38/whole_genome_SNVs_inclAnno.tsv.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.5/GRCh38/whole_genome_SNVs_inclAnno.tsv.gz) (292G) | [US](https://krishna.gs.washington.edu/download/CADD/v1.5/GRCh38/whole_genome_SNVs_inclAnno.tsv.gz.tbi) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.5/GRCh38/whole_genome_SNVs_inclAnno.tsv.gz.tbi) (2.7M) |
| 80M InDels to initiate a local setup | [US](https://krishna.gs.washington.edu/download/CADD/v1.5/GRCh38/InDels.tsv.gz) | [DE](https://kircherlab.bihealth.org/download/CADD/v1.5/GRCh38/InDels.tsv.gz) (948M) | [US](https: