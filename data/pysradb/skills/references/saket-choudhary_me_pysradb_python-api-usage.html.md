Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

[Skip to content](#furo-main-content)

[pysradb 3.0.0.dev0 documentation](index.html)

[![Logo](_static/pysradb_v3.png)

pysradb 3.0.0.dev0 documentation](index.html)

* [Installation](installation.html)
* [Quickstart](quickstart.html)
* [CLI](cmdline.html)
* Python API
* [Case Studies](case_studies.html)
* [Tutorials & Notebooks](notebooks.html)
* [API Documentation](commands.html)
* [Contributing](contributing.html)
* [Credits](authors.html)
* [History](history.html)
* [pysradb](modules.html)[ ]

Back to top

[View this page](_sources/python-api-usage.md.txt "View this page")

# Python API[¶](#python-api "Link to this heading")

## Use Case 1: Fetch the metadata table (SRA-runtable)[¶](#use-case-1-fetch-the-metadata-table-sra-runtable "Link to this heading")

The simplest use case of [pysradb]{.title-ref} is when you know the SRA
project ID (SRP) and would simply want to fetch the metadata associated
with it. This is generally reflected in the
[SraRunTable.txt]{.title-ref} that you get from NCBI’s website. See an
[example](https://www.ncbi.nlm.nih.gov/Traces/study/?acc=SRP098789) of a
SraRunTable.

```
from pysradb import SRAweb
client = SRAweb()
df = client.sra_metadata('SRP098789')
df.head()
```

```
===============  ====================  ======================================================================  =============  ========  =================  ==============  ================  ==============  ============  ==========  ========  ============  ===============
study_accession  experiment_accession                             experiment_title                             run_accession  taxon_id  library_selection  library_layout  library_strategy  library_source  library_name    bases      spots    adapter_spec  avg_read_length
===============  ====================  ======================================================================  =============  ========  =================  ==============  ================  ==============  ============  ==========  ========  ============  ===============
SRP098789        SRX2536403            GSM2475997: 1.5 Ã‚ÂµM PF-067446846, 10 min, rep 1; Homo sapiens; OTHER  SRR5227288         9606  other              SINGLE -        OTHER             TRANSCRIPTOMIC                2104142750  42082855                             50
SRP098789        SRX2536404            GSM2475998: 1.5 Ã‚ÂµM PF-067446846, 10 min, rep 2; Homo sapiens; OTHER  SRR5227289         9606  other              SINGLE -        OTHER             TRANSCRIPTOMIC                2082873050  41657461                             50
SRP098789        SRX2536405            GSM2475999: 1.5 Ã‚ÂµM PF-067446846, 10 min, rep 3; Homo sapiens; OTHER  SRR5227290         9606  other              SINGLE -        OTHER             TRANSCRIPTOMIC                2023148650  40462973                             50
SRP098789        SRX2536406            GSM2476000: 0.3 Ã‚ÂµM PF-067446846, 10 min, rep 1; Homo sapiens; OTHER  SRR5227291         9606  other              SINGLE -        OTHER             TRANSCRIPTOMIC                2057165950  41143319                             50
SRP098789        SRX2536407            GSM2476001: 0.3 Ã‚ÂµM PF-067446846, 10 min, rep 2; Homo sapiens; OTHER  SRR5227292         9606  other              SINGLE -        OTHER             TRANSCRIPTOMIC                3027621850  60552437                             50
===============  ====================  ======================================================================  =============  ========  =================  ==============  ================  ==============  ============  ==========  ========  ============  ===============
```

The metadata is returned as a [pandas]{.title-ref} dataframe and hence
allows you to perform all regular select/query operations available
through [pandas]{.title-ref}.

## Use Case 2: Downloading an entire project arranged experiment wise[¶](#use-case-2-downloading-an-entire-project-arranged-experiment-wise "Link to this heading")

Once you have fetched the metadata and made sure, this is the project
you were looking for, you would want to download everything at once.
NCBI follows this hiererachy: [SRP => SRX => SRR]{.title-ref}. Each
[SRP]{.title-ref} (project) has multiple [SRX]{.title-ref} (experiments)
and each [SRX]{.title-ref} in turn has multiple [SRR]{.title-ref} (runs)
inside it. We want to mimick this hiereachy in our downloads. The reason
to do that is simple: in most cases you care about [SRX]{.title-ref} the
most, and would want to “merge” your SRRs in one way or the other.
Having this hierearchy ensures your downstream code can handle such
cases easily, without worrying about which runs (SRR) need to be merged.

We strongly recommend installing [aspera-client]{.title-ref} which uses
UDP and is [designed to be faster](http://www.skullbox.net/tcpudp.php).

```
from pysradb import SRAweb
client = SRAweb()
df = client.sra_metadata('SRP017942')
client.download(df)
```

## Use Case 3: Downloading a subset of experiments[¶](#use-case-3-downloading-a-subset-of-experiments "Link to this heading")

Often, you need to process only a smaller set of samples from a project
(SRP). Consider this project which has data spanning four assays.

```
df = client.sra_metadata('SRP000941')
print(df.library_strategy.unique())
['ChIP-Seq' 'Bisulfite-Seq' 'RNA-Seq' 'WGS' 'OTHER']
```

But, you might be only interested in analyzing the [RNA-seq]{.title-ref}
samples and would just want to download that subset. This is simple
using [pysradb]{.title-ref} since the metadata can be subset just as you
would subset a dataframe in pandas.

```
df_rna = df[df.library_strategy == 'RNA-Seq']
client.download(df=df_rna, out_dir='/pysradb_downloads')()
```

## Use Case 4: Getting cell-type/treatment information from sample\_attributes[¶](#use-case-4-getting-cell-type-treatment-information-from-sample-attributes "Link to this heading")

Cell type/tissue informations is usually hidden in the
[sample\_attributes]{.title-ref} column, which can be expanded:

```
from pysradb.filter_attrs import expand_sample_attribute_columns
df = client.sra_metadata('SRP017942')
expand_sample_attribute_columns(df).head()
```

| study\_accession | experiment\_accession | experiment\_title | experiment\_attribute | sample\_attribute | run\_accession | taxon\_id | library\_selection | library\_layout | library\_strategy | library\_source | library\_name | bases | spots | adapter\_spec | avg\_read\_length | assay\_type | cell\_line | source\_name | transfected\_with | treatment |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| SRP017942 SRP017942 SRP017942 SRP017942 SRP017942 | SRX217028 SRX217029 SRX217030 SRX217031 SRX217956 | GSM1063575: 293T\_GFP; Homo sapiens; RNA-Seq GSM1063576: 293T\_GFP\_2hrs\_severe\_Heat\_Shock; Homo sapiens; RNA-Seq GSM1063577: 293T\_Hspa1a; Homo sapiens; RNA-Seq GSM1063578: 293T\_Hspa1a\_2hrs\_severe\_Heat\_Shock; Homo sapiens; RNA-Seq GSM794854: 3T3-Control-Riboseq; Mus musculus; RNA-Seq | GEO Accession: GSM1063575 GEO Accession: GSM1063576 GEO Accession: GSM1063577 GEO Accession: GSM1063578 GEO Accession: GSM794854 | source\_name: 293T cells || cell line: 293T cells || transfected with: 3XFLAG-GFP || assay type: Riboseq source\_name: 293T cells || cell line: 293T cells || transfected with: 3XFLAG-GFP || treatment: severe heat shock (44C 2 hours) || assay type: Riboseq source\_name: 293T cells || cell line: 293T cells || transfected with: 3XFLAG-Hspa1a || assay type: Riboseq source\_name: 293T cells || cell line: 293T cells || transfected with: 3XFLAG-Hspa1a || treatment: severe heat shock (44C 2 hours) || assay type: Riboseq source\_name: 3T3 cells || treatment: control || cell line: 3T3 cells || assay type: Riboseq | SRR648667 SRR648668 SRR648669 SRR648670 SRR649752 | 9606 9606 9606 9606 10090 | other other other other cDNA | SINGLE -SINGLE -SINGLE -SINGLE -SINGLE - | RNA-Seq RNA-Seq RNA-Seq RNA-Seq RNA-Seq | TRANSCRIPTOMIC TRANSCRIPTOMIC TRANSCRIPTOMIC TRANSCRIPTOMIC TRANSCRIPTOMIC |  | 1806641316 3436984836 3330909216 3622123512 594945396 | 50184481 95471801 92525256  100614542  16526261 |  | 36 36 36 36 36 | riboseq riboseq riboseq riboseq riboseq | 293t cells 293t cells 293t cells 293t cells 3t3 cells | 293t cells 293t cells 293t cells 293t cells 3t3 cells | 3xflag-gfp 3xflag-gfp 3xflag-hspa1a 3xflag-hspa1a NaN | NaN severe heat shock (44c 2 hours) NaN severe heat shock (44c 2 hours) control |

## Use Case 5: Searching for datasets[¶](#use-case-5-searching-for-datasets "Link to this heading")

Another common operation that we do on SRA is seach, plain text search.

If you want to look up for all projects where [ribosome
profiling]{.title-ref} appears somewhere in the description:

```
df = client.search_sra(search_str='"ribosome profiling"')
df.head()
```

| study\_accession | experiment\_accession | experiment\_title | run\_accession | taxon\_id | library\_selection | library\_layout | library\_strategy | library\_source | library\_name | bases | spots |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| DRP003075 | DRX019536 | Illumina Genome Analyzer IIx sequencing of SAMD00018584 | DRR021383 | 83333 | other | SINGLE - | OTHER | TRANSCRIPTOMIC | GAII05\_3 | 978776480 | 12234706 |
| DRP003075 | DRX019537 | Illumina Genome Analyzer IIx sequencing of SAMD00018585 | DRR021384 | 83333 | other | SINGLE - | OTHER | TRANSCRIPTOMIC | GAII05\_4 | 894201680 | 11177521 |
| DRP003075 | DRX019538 | Illumina Genome Analyzer IIx sequencing of SAMD00018586 | DRR021385 | 83333 | other | SINGLE - | OTHER | TRANSCRIPTOMIC | GAII05\_5 | 931536720 | 11644209 |
| DRP003075 | DRX019540 | Illumina Genome Analyzer IIx sequencing of SAMD00018588 | DRR021387 | 83333 | other | SINGLE - | OTHER | TRANSCRIPTOMIC | GAII07\_4 | 2759398700 | 27593987 |
| DRP003075 | DRX019541 | Illumina Genome Analyzer IIx sequencing of SAMD00018589 | DRR021388 | 83333 | other | SINGLE - | OTHER | TRANSCRIPTOMIC | GAII07\_5 | 2386196500 | 23861965 |

Again, the results are available as a [pandas]{.title-ref} dataframe and
hence you can perform all subset operations post your query. Your query
doesn’t need to be exact.

## Use Case 8: Finding publications (PMIDs) associated with SRA data[¶](#use-case-8-finding-publications-pmids-associated-with-sra-data "Link to this heading")

Sometimes you have SRA accessions and want to find the publications that describe the data generation.

```
from pysradb import SRAweb
client = SRAweb()

# Get PMIDs for a study accession (SRP)
pmids_df = client.srp_to_pmid('SRP002605')
pmids_df.head()
```

```
sra_accession   bioproject      pmid
SRP002605      PRJNA129385   20703300
```

You can also get PMIDs for other SRA accession types:

```
# Get PMIDs for run accessions (SRR)
srr_pmids = client.srr_to_pmid('SRR057511')

# Get PMIDs for experiment accessions (SRX)
srx_pmids = client.srx_to_pmid('SRX021967')

# Get PMIDs for sample accessions (SRS)
srs_pmids = client.srs_to_pmid('SRS079386')

# Get PMIDs for multiple accessions at once
multi_pmids = client.sra_to_pmid(['SRP002605', 'SRP016501'])
```

You can also directly query BioProject accessions for their associated publications:

```
# Get PMIDs directly from BioProject accessions
bioproject_pmids = client.fetch_bioproject_pmids(['PRJNA257197', 'PRJNA129385'])
print(bioproject_pmids)
# Output: {'PRJNA257197': ['25214632'], 'PRJNA129385': ['20703300']}
```

**Note**: This functionality relies on the cross-references maintained between BioProjects and PubMed. Not all SRA datasets have associated publications, and some publications may not be properly cross-referenced in the NCBI databases. The success rate depends on:

* Whether the authors included SRA/BioProject accessions in their manuscript
* Whether NCBI has established the cross-references
* The publication date relative to data submission

[Next

Case Studies](case_studies.html)
[Previous

CLI](cmdline.html)

Copyright © 2023, Saket Choudhary

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Python API
  + [Use Case 1: Fetch the metadata table (SRA-runtable)](#use-case-1-fetch-the-metadata-table-sra-runtable)
  + [Use Case 2: Downloading an entire project arranged experiment wise](#use-case-2-downloading-an-entire-project-arranged-experiment-wise)
  + [Use Case 3: Downloading a subset of experiments](#use-case-3-downloading-a-subset-of-experiments)
  + [Use Case 4: Getting cell-type/treatment information from sample\_attributes](#use-case-4-getting-cell-type-treatment-information-from-sample-attributes)
  + [Use Case 5: Searching for datasets](#use-case-5-searching-for-datasets)
  + [Use Case 8: Finding publications (PMIDs) associated with SRA data](#use-case-8-finding-publications-pmids-associated-with-sra-data)