[ ]
[ ]

[Skip to content](#reference-module)

SADIE

Reference Database

Initializing search

[jwillis0720/sadie](https://github.com/jwillis0720/sadie "Go to repository")

SADIE

[jwillis0720/sadie](https://github.com/jwillis0720/sadie "Go to repository")

* [SADIE](..)
* [ ]

  Reference Database

  [Reference Database](./)

  Table of contents
  + [Germline Gene Gateway](#germline-gene-gateway)

    - [Examples of how to use the G3 API](#examples-of-how-to-use-the-g3-api)
  + [Generating AIRR Reference Database](#generating-airr-reference-database)
  + [The reference YAML](#the-reference-yaml)
  + [Generating AIRR database with Reference Class](#generating-airr-database-with-reference-class)
* [ ]

  AIRR Sequence Annotation

  AIRR Sequence Annotation
  + [Annotating](../annotation/)
  + [Advanced Annotation Methods](../advanced_annotation/)
  + [Visualization](../visualization/)
* [Sequence Numbering](../renumbering/)
* [BCR/TCR Objects](../models/)
* [Clustering](../clustering/)
* [Contributing to SADIE](../contribute/)

Table of contents

* [Germline Gene Gateway](#germline-gene-gateway)

  + [Examples of how to use the G3 API](#examples-of-how-to-use-the-g3-api)
* [Generating AIRR Reference Database](#generating-airr-reference-database)
* [The reference YAML](#the-reference-yaml)
* [Generating AIRR database with Reference Class](#generating-airr-database-with-reference-class)

# Reference Module[¶](#reference-module "Permanent link")

The SADIE reference module abstracts the underlying reference data used by the [AIRR](../annotation/) and [Numbering](../renumbering/) modules. Both of these modules use external database files. Their organization (particularly by AIRR, which ports [IGBlast](https://www.ncbi.nlm.nih.gov/igblast/)) can be extremely complicated. Making a new reference database is a tedious and time-consuming task. This module provides a simple interface for making your own reference databases.

Builtin reference

SADIE ships with a reference database that contains the most common species along with functional genes. The average user will not need to use this module as the database is comprehensive. You can see each entry by looking either directly at the paths used `src/sadie/airr/data/` for AIRR and `src/sadie/anarci/data` for the renumbering module. Another convenient way to look at the reference database is to view the [reference.yml](https://github.com/jwillis0720/sadie/blob/master/src/sadie/reference/data/reference.yml). More on how that file is structured will be [provided](#the-reference-yaml).

## Germline Gene Gateway[¶](#germline-gene-gateway "Permanent link")

New germline gene segments are being discovered at a rapid pace. To meet the needs of this changing landscape, SADIE gets all of the germline gene info from a programmatic API called the [Germline Gene Gateway](https://g3.jordanrwillis.com/docs/). This API is hosted as a free service. It consists of germline genes from [IMGT](https://www.imgt.org) as well as custom genes that have been annotated and cataloged by programs such as [IGDiscover](http://docs.igdiscover.se/en/stable/). To explore the API, visit the [Germline Gene Gateway](https://g3.jordanrwillis.com/docs/). This RESTful API conforms to the [OpenAPI 3.0](https://swagger.io/specification/) specification.

### Examples of how to use the G3 API[¶](#examples-of-how-to-use-the-g3-api "Permanent link")

The following examples show how to pull genes programmatically using the command line utilities `curl`, `wget` and the `requests` library in Python. It will fetch the first 5 V-Gene segments in IMGT notation.

The output will be a JSON file containing the V-Gene segment and all relevant information needed by SADIE to write out databases needed by the AIRR and Numbering modules.

human\_v.json

```
    [
        {
            "_id": "608b90908e6710a05b587046",
            "source": "imgt",
            "common": "human",
            "gene": "IGHV1-18*01",
            "label": "V-REGION",
            "gene_segment": "V",
            "receptor": "IG",
            "sequence": "CAGGTTCAGCTGGTGCAGTCTGGAGCTGAGGTGAAGAAGCCTGGGGCCTCAGTGAAGGTCTCCTGCAAGGCTTCTGGTTACACCTTTACCAGCTATGGTATCAGCTGGGTGCGACAGGCCCCTGGACAAGGGCTTGAGTGGATGGGATGGATCAGCGCTTACAATGGTAACACAAACTATGCACAGAAGCTCCAGGGCAGAGTCACCATGACCACAGACACATCCACGAGCACAGCCTACATGGAGCTGAGGAGCCTGAGATCTGACGACACGGCCGTGTATTACTGTGCGAGAGA",
            "latin": "Homo_sapiens",
            "imgt": {
                "sequence": "CAGGTTCAGCTGGTGCAGTCTGGAGCTGAGGTGAAGAAGCCTGGGGCCTCAGTGAAGGTCTCCTGCAAGGCTTCTGGTTACACCTTTACCAGCTATGGTATCAGCTGGGTGCGACAGGCCCCTGGACAAGGGCTTGAGTGGATGGGATGGATCAGCGCTTACAATGGTAACACAAACTATGCACAGAAGCTCCAGGGCAGAGTCACCATGACCACAGACACATCCACGAGCACAGCCTACATGGAGCTGAGGAGCCTGAGATCTGACGACACGGCCGTGTATTACTGTGCGAGAGA",
                "sequence_gapped": "CAGGTTCAGCTGGTGCAGTCTGGAGCT...GAGGTGAAGAAGCCTGGGGCCTCAGTGAAGGTCTCCTGCAAGGCTTCTGGTTACACCTTT............ACCAGCTATGGTATCAGCTGGGTGCGACAGGCCCCTGGACAAGGGCTTGAGTGGATGGGATGGATCAGCGCTTAC......AATGGTAACACAAACTATGCACAGAAGCTCCAG...GGCAGAGTCACCATGACCACAGACACATCCACGAGCACAGCCTACATGGAGCTGAGGAGCCTGAGATCTGACGACACGGCCGTGTATTACTGTGCGAGAGA",
                "sequence_gapped_aa": "QVQLVQSGA.EVKKPGASVKVSCKASGYTF....TSYGISWVRQAPGQGLEWMGWISAY..NGNTNYAQKLQ.GRVTMTTDTSTSTAYMELRSLRSDDTAVYYCAR",
                "fwr1": "CAGGTTCAGCTGGTGCAGTCTGGAGCTGAGGTGAAGAAGCCTGGGGCCTCAGTGAAGGTCTCCTGCAAGGCTTCT",
                "fwr1_aa": "QVQLVQSGAEVKKPGASVKVSCKAS",
                "fwr1_start": 0,
                "fwr1_end": 74,
                "cdr1": "GGTTACACCTTTACCAGCTATGGT",
                "cdr1_aa": "GYTFTSYG",
                "cdr1_start": 75,
                "cdr1_end": 98,
                "fwr2": "ATCAGCTGGGTGCGACAGGCCCCTGGACAAGGGCTTGAGTGGATGGGATGG",
                "fwr2_aa": "ISWVRQAPGQGLEWMGW",
                "fwr2_start": 99,
                "fwr2_end": 149,
                "cdr2": "ATCAGCGCTTACAATGGTAACACA",
                "cdr2_aa": "ISAYNGNT",
                "cdr2_start": 150,
                "cdr2_end": 173,
                "fwr3": "AACTATGCACAGAAGCTCCAGGGCAGAGTCACCATGACCACAGACACATCCACGAGCACAGCCTACATGGAGCTGAGGAGCCTGAGATCTGACGACACGGCCGTGTATTACTGT",
                "fwr3_aa": "NYAQKLQGRVTMTTDTSTSTAYMELRSLRSDDTAVYYC",
                "fwr3_start": 174,
                "fwr3_end": 287,
                "cdr3": "GCGAGAGA",
                "cdr3_aa": "AR",
                "cdr3_start": 288,
                "cdr3_end": 295,
                "imgt_functional": "F",
                "contrived_functional": "F"
            }
        },
        {
            "_id": "608b90908e6710a05b587048",
            "source": "imgt",
            "common": "human",
            "gene": "IGHV1-18*02",
            "label": "V-REGION",
            "gene_segment": "V",
            "receptor": "IG",
            "sequence": "CAGGTTCAGCTGGTGCAGTCTGGAGCTGAGGTGAAGAAGCCTGGGGCCTCAGTGAAGGTCTCCTGCAAGGCTTCTGGTTACACCTTTACCAGCTATGGTATCAGCTGGGTGCGACAGGCCCCTGGACAAGGGCTTGAGTGGATGGGATGGATCAGCGCTTACAATGGTAACACAAACTATGCACAGAAGCTCCAGGGCAGAGTCACCATGACCACAGACACATCCACGAGCACAGCCTACATGGAGCTGAGGAGCCTAAGATCTGACGACACGGCC",
            "latin": "Homo_sapiens",
            "imgt": {
                "sequence": "CAGGTTCAGCTGGTGCAGTCTGGAGCTGAGGTGAAGAAGCCTGGGGCCTCAGTGAAGGTCTCCTGCAAGGCTTCTGGTTACACCTTTACCAGCTATGGTATCAGCTGGGTGCGACAGGCCCCTGGACAAGGGCTTGAGTGGATGGGATGGATCAGCGCTTACAATGGTAACACAAACTATGCACAGAAGCTCCAGGGCAGAGTCACCATGACCACAGACACATCCACGAGCACAGCCTACATGGAGCTGAGGAGCCTAAGATCTGACGACACGGCC",
                "sequence_gapped": "CAGGTTCAGCTGGTGCAGTCTGGAGCT...GAGGTGAAGAAGCCTGGGGCCTCAGTGAAGGTCTCCTGCAAGGCTTCTGGTTACACCTTT............ACCAGCTATGGTATCAGCTGGGTGCGACAGGCCCCTGGACAAGGGCTTGAGTGGATGGGATGGATCAGCGCTTAC......AATGGTAACACAAACTATGCACAGAAGCTCCAG...GGCAGAGTCACCATGACCACAGACACATCCACGAGCACAGCCTACATGGAGCTGAGGAGCCTAAGATCTGACGACACGGCC",
                "sequence_gapped_aa": "QVQLVQSGA.EVKKPGASVKVSCKASGYTF....TSYGISWVRQAPGQGLEWMGWISAY..NGNTNYAQKLQ.GRVTMTTDTSTSTAYMELRSLRSDDTA",
                "fwr1": "CAGGTTCAGCTGGTGCAGTCTGGAGCTGAGGTGAAGAAGCCTGGGGCCTCAGTGAAGGTCTCCTGCAAGGCTTCT",
                "fwr1_aa": "QVQLVQSGAEVKKPGASVKVSCKAS",
                "fwr1_start": 0,
                "fwr1_end": 74,
                "cdr1": "GGTTACACCTTTACCAGCTATGGT",
                "cdr1_aa": "GYTFTSYG",
                "cdr1_start": 75,
                "cdr1_end": 98,
                "fwr2": "ATCAGCTGGGTGCGACAGGCCCCTGGACAAGGGCTTGAGTGGATGGGATGG",
                "fwr2_aa": "ISWVRQAPGQGLEWMGW",
                "fwr2_start": 99,
                "fwr2_end": 149,
                "cdr2": "ATCAGCGCTTACAATGGTAACACA",
                "cdr2_aa": "ISAYNGNT",
                "cdr2_start": 150,
                "cdr2_end": 173,
                "fwr3": "AACTATGCACAGAAGCTCCAGGGCAGAGTCACCATGACCACAGACACATCCACGAGCACAGCCTACATGGAGCTGAGGAGCCTAAGATCTGACGACACGGCC",
                "fwr3_aa": "NYAQKLQGRVTMTTDTSTSTAYMELRSLRSDDTA",
                "fwr3_start": 174,
                "fwr3_end": 275,
                "cdr3": "",
                "cdr3_aa": "",
                "cdr3_start": null,
                "cdr3_end": null,
                "imgt_functional": "F",
                "contrived_functional": "F"
            }
        },
        {
            "_id": "608b90908e6710a05b587049",
            "source": "imgt",
            "common": "human",
            "gene": "IGHV1-18*03",
            "label": "V-REGION",
            "gene_segment": "V",
            "receptor": "IG",
            "sequence": "CAGGTTCAGCTGGTGCAGTCTGGAGCTGAGGTGAAGAAGCCTGGGGCCTCAGTGAAGGTCTCCTGCAAGGCTTCTGGTTACACCTTTACCAGCTATGGTATCAGCTGGGTGCGACAGGCCCCTGGACAAGGGCTTGAGTGGATGGGATGGATCAGCGCTTACAATGGTAACACAAACTATGCACAGAAGCTCCAGGGCAGAGTCACCATGACCACAGACACATCCACGAGCACAGCCTACATGGAGCTGAGGAGCCTGAGATCTGACGACATGGCCGTGTATTACTGTGCGAGAGA",
            "latin": "Homo_sapiens",
            "imgt": {
                "sequence": "CAGGTTCAGCTGGTGCAGTCTGGAGCTGAGGTGAAGAAGCCTGGGGCCTCAGTGAAGGTCTCCTGCAAGGCTTCTGGTTACACCTTTACCAGCTATGGTATCAGCTGGGTGCGACAGGCCCCTGGACAAGGGCTTGAGTGGATGGGATGGATCAGCGCTTACAATGGTAACACAAACTATGCACAGAAGCTCCAGGGCAGAGTCACCATGACCACAGACACATCCACGAGCACAGCCTACATGGAGCTGAGGAGCCTGAGATCTGACGACATGGCCGTGTATTACTGTGCGAGAGA",
                "sequence_gapped": "CAGGTTCAGCTGGTGCAGTCTGGAGCT...GAGGTGAAGAAGCCTGGGGCCTCAGTGAAGGTCTCCTGCAAGGCTTCTGGTTACACCTTT............ACCAGCTATGGTATCAGCTGGGTGCGACAGGCCCCTGGACAAGGGCTTGAGTGGATGGGATGGATCAGCGCTTAC......AATGGTAACACAAACTATGCACAGAAGCTCCAG...GGCAGAGTCACCATGACCACAGACACATCCACGAGCACAGCCTACATGGAGCTGAGGAGCCTGAGATCTGACGACATGGCCGTGTATTACTGTGCGAGAGA",
                "sequence_gapped_aa": "QVQLVQSGA.EVKKPGASVKVSCKASGYTF....TSYGISWVRQAPGQGLEWMGWISAY..NGNTNYAQKLQ.GRVTMTTDTSTSTAYMELRSLRSDDMAVYYCAR",
                "fwr1": "CAGGTTCAGCTGGTGCAGTCTGGAGCTGAGGTGAAGAAGCCTGGGGCCTCAGTGAAGGTCTCCTGCAAGGCTTCT",
                "fwr1_aa": "QVQLVQSGAEVKKPGASVKVSCKAS",
                "fwr1_start": 0,
                "fwr1_end": 74,
                "cdr1": "GGTTACACCTTTACCAGCTATGGT",
                "cdr1_aa": "GYTFTSYG",
                "cdr1_start": 75,
                "cdr1_end": 98,
                "fwr2": "ATCAGCTGGGTGCGACAGGCCCCTGGACAAGGGCTTGAGTGGATGGGATGG",
                "fwr2_aa": "ISWVRQAPGQGLEWMGW",
                "fwr2_start": 99,
                "fwr2_end": 149,
                "cdr2": "ATCAGCGCTTACAATGGTAACACA",
                "cdr2_aa": "ISAYNGNT",
                "cdr2_start": 150,
                "cdr2_end": 173,
                "fwr3": "AACTATGCACAGAAGCTCCAGGGCAGAGTCACCATGACCACAGACACATCCACGAGCACAGCCTACATGGAGCTGAGGAGCCTGAGATCTGACGACATGGCCGTGTATTACTGT",
                "fwr3_aa": "NYAQKLQGRVTMTTDTSTSTAYMELRSLRSDDMAVYYC",
                "fwr3_start": 174,
                "fwr3_end": 287,
                "cdr3": "GCGAGAGA",
                "cdr3_aa": "AR",
                "cdr3_start": 288,
                "cdr3_end": 295,
                "imgt_functional": "F",
                "contrived_functional": "F"
            }
        },
        {
            "_id": "608b90908e6710a05b58704b",
            "source": "imgt",
            "common": "human",
            "gene": "IGHV1-18*04",
            "label": "V-REGION",
            "gene_segment": "V",
            "receptor": "IG",
            "sequence": "CAGGTTCAGCTGGTGCAGTCTGGAGCTGAGGTGAAGAAGCCTGGGGCCTCAGTGAAGGTCTCCTGCAAGGCTTCTGGTTACACCTTTACCAGCTACGGTATCAGCTGGGTGCGACAGGCCCCTGGACAAGGGCTTGAGTGGATGGGATGGATCAGCGCTTACAATGGTAACACAAACTATGCACAGAAGCTCCAGGGCAGAGTCACCATGACCACAGACACATCCACGAGCACAGCCTACATGGAGCTGAGGAGCCTGAGATCTGACGACACGGCCGTGTATTACTGTGCGAGAGA",
            "latin": "Homo_sapiens",
            "imgt": {
                "sequence": "CAGGTTCAGCTGGTGCAGTCTGGAGCTGAGGTGAAGAAGCCTGGGGCCTCAGTGAAGGTCTCCTGCAAGGCTTCTGGTTACACCTTTACCAGCTACGGTATCAGCTGGGTGCGACAGGCCCCTGGACAAGGGCTTGAGTGGATGGGATGGATCAGCGCTTACAATGGTAACACAAACTATGCACAGAAGCTCCAGGGCAGAGTCACCATGACCACAGACACATCCACGAGCACAGCCTACATGGAGCTGAGGAGCCTGAGATCTGACGACACGGCCGTGTATTACTGTGCGAGAGA",
                "sequence_gapped": "CAGGTTCAGCTGGTGCAGTCTGGAGCT...GAGGTGAAGAAGCCTGGGGCCTCAGTGAAGGTCTCCTGCAAGGCTTCTGGTTACACCTTT............ACCAGCTACGGTATCAGCTGGGTGCGACAGGCCCCTGGACAAGGGCTTGAGTGGATGGGATGGATCAGCGCTTAC......AATGGTAACACAAACTATGCACAGAAGCTCCAG...GGCAGAGTCACCATGACCACAGACACATCCACGAGCACAGCCTACATGGAGCTGAGGAGCCTGAGATCTGACGACACGGCCGTGTATTACTGTGCGAGAGA",
                "sequence_gapped_aa": "QVQLVQSGA.EVKKPGASVKVSCKASGYTF....TSYGISWVRQAPGQGLEWMGWISAY..NGNTNYAQKLQ.GRVTMTTDTSTSTAYMELRSLRSDDTAVYYCAR",
                "fwr1": "CAGGTTCAGCTGGTGCAGTCTGGAGCTGAGGTGAAGAAGCCTGGGGCCTCAGTGAAGGTCTCCTGCAAGGCTTCT",
                "fwr1_aa": "QVQLVQSGAEVKKPGASVKVSCKAS",
                "fwr1_start": 0,
                "fwr1_end": 74,
                "cdr1": "GGTTACACCTTTACCAGCTACGGT",
                "cdr1_aa": "GYTFTSYG",
                "cdr1_start": 75,
                "cdr1_end": 98,
                "fwr2": "ATCAGCTGGGTGCGACAGGCCCCTGGACAAGGGCTTGAGTGGATGGGATGG",
                "fwr2_aa": "ISWVRQAPGQGLEWMGW",
                "fwr2_start": 99,
                "fwr2_end": 149,
                "cdr2": "ATCAGCGCTTACAATGGTAACACA",
                "cdr2_aa": "ISAYNGNT",
                "cdr2_start": 150,
                "cdr2_end": 173,
                "fwr3": "AACTATGCACAGAAGCTCCAGGGCAGAGTCACCATGACCACAGACACATCCACGAGCACAGCCTACATGGAGCTGAGGAGCCTGAGATCTGACGACACGGCCGTGTATTACTGT",
                "fwr3_aa": "NYAQKLQGRVTMTTDTSTSTAYMELRSLRSDDTAVYYC",
                "fwr3_start": 174,
                "fwr3_end": 287,
                "cdr3": "GCGAGAGA",
                "cdr3_aa": "AR",
                "cdr3_start": 288,
                "cdr3_end": 295,
                "imgt_functional": "F",
                "contrived_functional": "F"
            }
        },
        {
            "_id": "608b90908e6710a05b587053",
            "source": "imgt",
            "common": "human",
            "gene": "IGHV1-2*01",
            "label": "V-REGION",
            "gene_segment": "V",
            "receptor": "IG",
            "sequence": "CAGGTGCAGCTGGTGCAGTCTGGGGCTGAGGTGAAGAAGCCTGGGGCCTCAGTGAAGGTCTCCTGCAAGGCTTCTGGATACACCTTCACCGGCTACTAT