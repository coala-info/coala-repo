Toggle menu

[MetaGraph

MetaGraph](/)

MetaGraph Service Status

[Search](/search)[Results](/results)[Examples](/examples)[Databases](/indexes)[Team](/team)[Pubs](/pubs)

[Docs](/docs)[Help](/help)[GitHub](https://github.com/ratschlab/metagraph)Toggle theme

MetaGraph. Advancing biological sequence analysis.

©2019-2026 [BMI LAB](https://bmi.inf.ethz.ch/) | [ETH ZURICH](https://ethz.ch/) | [PRIVACY](/privacy) | [IMPRINT](/imprint)

# Database Indexes

Annotated de Bruijn graph indexes over petabases of public sequence data.

919,817,278

Total Accessions

47,483,952 GB

Sequences Indexed

13

Available Online

of 17 total

11

Searches Completed

in the last 24 hours

0

Active Searches

queued or running

Available Databases

Compressed sequence indexes spanning viruses, bacteria, fungi, plants, animals, and humans. Each row represents a searchable labeled de Bruijn graph over public sequence collections.

| Database | Accessions | Indexed Sequences (TB) | Index Size (GB) | Online Status | Features | S3 Location |
| --- | --- | --- | --- | --- | --- | --- |
| [GnomAD](https://gnomad.broadinstitute.org/)  Human reference genome and variation | 29 | 0.003 | 11 | OK (#0) | DNATaxonomic ID |

How to Download Index Files

Access MetaGraph indexes via AWS S3 for local analysis using the [MetaGraph command line tool](/docs)

All indexes are hosted on AWS S3 for public access. Install the [AWS CLI](https://aws.amazon.com/cli/) following the [installation guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) (supports Windows, macOS, Linux).

Example commands:

`# List available objects in a bucket
aws s3 ls s3://metagraph/refseq/ --no-sign-request

# Download a specific file
aws s3 cp s3://metagraph/refseq/file.dbg . --no-sign-request

# Sync an entire directory
aws s3 sync s3://metagraph/refseq/ ./local-refseq/ --no-sign-request`

The `--no-sign-request` flag indicates public access without AWS credentials.

Align

|  |
| --- |
| `s3://metagraph/gnomad` |

|  |  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- |
| [MetaSUB](https://metasub.org/)  MetaSUB urban microbiome dataset (k=41) | 4,220 | 7.2 | 47 | Download only | DNASample MetadataGeocoordinatesCity ContextAlign | `s3://metagraph/metasub_k41` |

|  |  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- |
| [MetaSUB k=19](https://metasub.org/)  MetaSUB urban microbiome dataset with k=19 | 4,220 | 7.2 | 206 | Download only | DNASample MetadataGeocoordinatesCity ContextAlign | `s3://metagraph/metasub_k19` |

|  |  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- |
| [RefSeq](https://www.ncbi.nlm.nih.gov/refseq/)  NCBI Reference Sequences (33M accessions, with coordinates) | 32,881,371 | 1.7 | 475 | OK (#0) | DNATaxonomic IDAlignCoordinates | `s3://metagraph/refseq/` |

|  |  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- |
| [SRA fungi](https://www.ncbi.nlm.nih.gov/sra)  SRA fungi raw sequences | 121,900 | 162 | 112 | OK (#0) | DNARNATaxonomic IDSample MetadataAlign | `s3://metagraph/fungi/` |

|  |  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- |
| [SRA human](https://www.ncbi.nlm.nih.gov/sra)  SRA human raw sequences | 436,494 | 725 | 2,564 | OK (#0) | DNARNATaxonomic IDSample MetadataAlign | `s3://metagraph/human/` |

|  |  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- |
| [SRA Logan contigs](https://github.com/IndexThePlanet/Logan)  SRA Logan contigs | 24,561,858 | 42,828 | 100,925 | OK (#0) | DNARNATaxonomic IDSample Metadata | `s3://metagraph/all_sra` |

|  |  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- |
| [SRA metagut](https://www.ncbi.nlm.nih.gov/sra)  SRA Metagut | 241,384 | 156 | 2,726 | OK (#0) | DNARNATaxonomic IDSample MetadataAlign | `s3://metagraph/metagut/` |

|  |  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- |
| [SRA metazoa](https://www.ncbi.nlm.nih.gov/sra)  SRA Metazoa raw sequences | 805,220 | 1,999 | 4,997 | OK (#0) | DNARNATaxonomic IDSample MetadataAlign | `s3://metagraph/metazoa/` |

|  |  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- |
| [SRA metazoa 1k](https://www.ncbi.nlm.nih.gov/sra)  SRA Metazoa 1K raw sequences | 67,390 | 119 | 413 | Download only | DNARNATaxonomic IDSample MetadataAlign | `s3://metagraph/metazoa/` |

|  |  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- |
| [SRA microbe](https://www.ncbi.nlm.nih.gov/sra)  SRA Microbe raw sequences | 446,506 | 221 | 57 | OK (#0) | DNARNATaxonomic IDSample MetadataAlign | `s3://metagraph/microbe/` |

|  |  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- |
| [SRA mus musculus](https://www.ncbi.nlm.nih.gov/sra)  SRA Mus musculus raw sequences | 57,938 | 147 | 292 | OK (#0) | DNARNATaxonomic IDSample MetadataAlign | `s3://metagraph/mouse` |

|  |  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- |
| [SRA plants](https://www.ncbi.nlm.nih.gov/sra)  SRA plants raw sequences | 531,714 | 1,109 | 2,031 | OK (#0) | DNARNATaxonomic IDSample MetadataAlign | `s3://metagraph/plants/` |

|  |  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- |
| [Tara Oceans](https://www.ocean-microbiome.org/)  Marine metagenome genomes from global ocean survey | 318,205,057 | 0.062 | 163 | Download only | DNAAlign | `s3://metagraph/tara_oceans/` |

|  |  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- |
| [UHGG All](https://www.ebi.ac.uk/metagenomics/genome-catalogues/human-gut)  UHGG All contigs | 286,997 | 0.71 | 52 | OK (#0) | DNATaxonomic IDSample MetadataGeocoordinatesAlign | `s3://metagraph/uhgg_all/` |

|  |  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- |
| [UHGG catalog](https://www.ebi.ac.uk/metagenomics/genome-catalogues/human-gut)  UHGG Catalog | 4,644 | 0.011 | 3 | OK (#0) | DNATaxonomic IDSample MetadataGeocoordinatesAlign | `s3://metagraph/uhgg_catalogue/` |

|  |  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- |
| [UniParc](https://www.uniprot.org/help/uniparc)  UniProt Archive - comprehensive protein sequence database | 541,160,336 | 0.21 | 169 | OK (#0) | Amino AcidsTaxonomic IDCoordinates | `s3://metagraph/uniparc` |