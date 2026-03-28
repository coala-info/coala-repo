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

## Retrieving SNV CADD scores via tabix

In theory, it is very simple to retrieve SNV CADD scores without downloading
the whole genome data set via Tabix:

```
#Specify score file link
SCORE_FILE=https://krishna.gs.washington.edu/download/CADD/v1.4/GRCh37/whole_genome_SNVs_inclAnno.tsv.gz
#Download Tabix Index
INDEX=IndexFile
wget -c $SCORE_FILE.tbi -O $INDEX
#Retrieve variant scores
tabix $SCORE_FILE $INDEX 22:43451446-43451447
```

## The CADD API for retrieving SNV scores

**Please note that this API is still experimental and not thought to be used for
retrieving thousands or millions of variants. For extensive use, please use
our [online](/score) or [offline](/download) scoring or
[contact](/contact) us. Thank you!**

In addition to retrieving CADD scores via tabix (see above), we also provide
a webAPI. It is currently possible to retrieve SNVs at a position with or
without reference and alternate base and to retrieve all SNV in a genome range.

All API requests consist of a CADD version and the genome coordinate. The
available CADD versions are `v1.0` to `v1.3`,
the two 1.4 releases `GRCh37-v1.4` and `GRCh38-v1.4`,
`GRCh38-v1.5`, `GRCh37-v1.6`
and `GRCh38-v1.6`, and latest releases `GRCh37-v1.7`
and `GRCh38-v1.7`.
If you require annotations, you can add `_inclAnno` to the version
string.

### Single position access

The request path for SNV access is
`https://cadd.gs.washington.edu/api/v1.0/<CADD-version>/<chrom>:<pos>`
which returns a json list of the three SNV at that position:

```
curl -i https://cadd.gs.washington.edu/api/v1.0/v1.3/5:2003402

HTTP/1.0 200 OK
Content-Type: application/json
Content-Length: 410
Server: Werkzeug/0.11.15 Python/2.7.13
Date: Tue, 31 Jul 2018 19:04:18 GMT

[
  {
    "Alt": "A",
    "Chrom": "5",
    "PHRED": "0.850",
    "Pos": "2003402",
    "RawScore": "-0.251851",
    "Ref": "C"
  },
  ...
]
```

If you are requesting a single SNV with reference and alternate base given,
you can do so via
`https://cadd.gs.washington.edu/api/v1.0/<CADD-version>/<chrom>:<pos>_<ref>_<alt>`
which returns just a single SNV object in a list. Note that this returns an
empty list when ref or alt are not available.

### Range access

Range access is similar to our [web SNV-range](/snv-range) access
with the same limitation to 100 bases. It can be accessed via
`https://cadd.gs.washington.edu/api/v1.0/<chrom>:<start>-<end>`.
In contrast to the single position access, this returns a list of lists where
the first item contains the field names.

```
curl -i https://cadd.gs.washington.edu/api/v1.0/GRCh38-v1.4/22:44044001-44044002

HTTP/1.0 200 OK
Content-Type: application/json
Content-Length: 615
Server: Werkzeug/0.11.15 Python/2.7.13
Date: Tue, 31 Jul 2018 19:17:44 GMT

[
  [
    "Chrom",
    "Pos",
    "Ref",
    "Alt",
    "RawScore",
    "PHRED"
  ],
  [
    "22",
    "44044001",
    "T",
    "A",
    "0.121712",
    "2.838"
  ],
  ...
]
```

© University of Washington, Hudson-Alpha Institute for Biotechnology and Berlin Institute
of Health at Charité - Universitätsmedizin Berlin 2013-2023. All rights reserved.

[Terms and Conditions](http://www.washington.edu/online/terms/) and the [Online Privacy Statement](http://www.washington.edu/online/privacy/) of the University of
Washington apply.