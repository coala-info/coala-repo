[ ]
[ ]

[Skip to content](#airr-annotation)

SADIE

Annotating

Initializing search

[jwillis0720/sadie](https://github.com/jwillis0720/sadie "Go to repository")

SADIE

[jwillis0720/sadie](https://github.com/jwillis0720/sadie "Go to repository")

* [SADIE](..)
* [Reference Database](../reference/)
* [x]

  AIRR Sequence Annotation

  AIRR Sequence Annotation
  + [ ]

    Annotating

    [Annotating](./)

    Table of contents
    - [Single Sequence Annotation](#single-sequence-annotation)

      * [Writing Files](#writing-files)

        + [AIRR Rearrangement File](#airr-rearrangement-file)
        + [Other Output Formats](#other-output-formats)
      * [Reading Files](#reading-files)

        + [Reading an AIRR.tsv](#reading-an-airrtsv)
        + [Reading other file formats](#reading-other-file-formats)
  + [Advanced Annotation Methods](../advanced_annotation/)
  + [Visualization](../visualization/)
* [Sequence Numbering](../renumbering/)
* [BCR/TCR Objects](../models/)
* [Clustering](../clustering/)
* [Contributing to SADIE](../contribute/)

Table of contents

* [Single Sequence Annotation](#single-sequence-annotation)

  + [Writing Files](#writing-files)

    - [AIRR Rearrangement File](#airr-rearrangement-file)
    - [Other Output Formats](#other-output-formats)
  + [Reading Files](#reading-files)

    - [Reading an AIRR.tsv](#reading-an-airrtsv)
    - [Reading other file formats](#reading-other-file-formats)

# AIRR Annotation[¶](#airr-annotation "Permanent link")

Annotation is the bedrock of all immunoformatics workflows. It is the process of identifying CDRs/frameworks, levels of somatic mutation, locus use, productive rearrangements, and other features that describe the B cell receptor or T cell receptor (BCR/TCR). In the description of a BCR/TCR, how can we compare the data file output from one data pipeline to another? In other words, what if the description of a repertoire has different fields and datatypes that describe a repertoire or even a single BCR/TCR? Fear not! [The AIRR community to the rescue](https://docs.airr-community.org/en/stable/)!

---

"*AIRR Data Representations are versioned specifications that consist of a file format and a well-defined schema[...] The schema defines the data model, field names, data types, and encodings for AIRR standard objects. Strict typing enables interoperability and data sharing between different AIRR-seq analysis tools and repositories[...]*"

[The AIRR Standards 1.3 documentation](https://docs.airr-community.org/en/stable/datarep/overview.html)

---

SADIE leverages the AIRR to provide a standardized data representation for BCRs. You can read all the fields and values in the AIRR Rearrangement schema standard [here](https://docs.airr-community.org/en/stable/datarep/rearrangements.html#fields)

## Single Sequence Annotation[¶](#single-sequence-annotation "Permanent link")

```
# use Airr module
# import pandas for dataframe handling
import pandas as pd

from sadie.airr import Airr

# define a single sequence
pg9_seq = "CAGCGATTAGTGGAGTCTGGGGGAGGCGTGGTCCAGCCTGGGTCGTCCCTGAGACTCTCCTGTGCAGCGTCCGGATTCGACTTCAGTAGACAAGGCATGCACTGGGTCCGCCAGGCTCCAGGCCAGGGGCTGGAGTGGGTGGCATTTATTAAATATGATGGAAGTGAGAAATATCATGCTGACTCCGTATGGGGCCGACTCAGCATCTCCAGAGACAATTCCAAGGATACGCTTTATCTCCAAATGAATAGCCTGAGAGTCGAGGACACGGCTACATATTTTTGTGTGAGAGAGGCTGGTGGGCCCGACTACCGTAATGGGTACAACTATTACGATTTCTATGATGGTTATTATAACTACCACTATATGGACGTCTGGGGCAAAGGGACCACGGTCACCGTCTCGAGC"

# setup API  object
airr_api = Airr("human")

# run sequence and return airr table with sequence_id and sequence
airr_table = airr_api.run_single("PG9", pg9_seq)

# output object types
print(type(airr_table))
print(isinstance(airr_table, pd.DataFrame))
```

The output will contain `<class 'sadie.airr.airrtable.airrtable.AirrTable'>` and shows that the output is an instance of the `AirrTable` class.

Info

Running an AIRR method generates an AIRR table object. The AIRR table is a subclass of a [pandas dataframe](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.html) and thus can be used by any pandas method. Pandas is the workhorse of the SADIE library, so we highly encourage some rudimentary knowledge of pandas to get maximize SAIDIE functionality.

### Writing Files[¶](#writing-files "Permanent link")

#### AIRR Rearrangement File[¶](#airr-rearrangement-file "Permanent link")

To output an AIRR file, we can use the `AirrTable.to_airr()` method.

```
# import the SADIE Airr module
from sadie.airr import Airr

# define a single sequence
pg9_seq = "CAGCGATTAGTGGAGTCTGGGGGAGGCGTGGTCCAGCCTGGGTCGTCCCTGAGACTCTCCTGTGCAGCGTCCGGATTCGACTTCAGTAGACAAGGCATGCACTGGGTCCGCCAGGCTCCAGGCCAGGGGCTGGAGTGGGTGGCATTTATTAAATATGATGGAAGTGAGAAATATCATGCTGACTCCGTATGGGGCCGACTCAGCATCTCCAGAGACAATTCCAAGGATACGCTTTATCTCCAAATGAATAGCCTGAGAGTCGAGGACACGGCTACATATTTTTGTGTGAGAGAGGCTGGTGGGCCCGACTACCGTAATGGGTACAACTATTACGATTTCTATGATGGTTATTATAACTACCACTATATGGACGTCTGGGGCAAAGGGACCACGGTCACCGTCTCGAGC"

# setup API object
airr_api = Airr("human")

# run sequence and return airr table with sequence_id and sequence
airr_table = airr_api.run_single("PG9", pg9_seq)

# write airr table to tsv or tsv.gz/bz
airr_table.to_airr("PG9 AIRR.tsv")

# compress your airr table into a bzip or gzip filecxx
airr_table.to_airr("PG9 AIRR.tsv.gz")
airr_table.to_airr("PG9 AIRR.tsv.bz2")
```

The tsv file `PG9 AIRR.tsv` generated will be a tabular datafile that will resemble the following:

| sequence\_id | sequence | species | locus | stop\_codon | vj\_in\_frame | v\_frameshift | productive | rev\_comp | complete\_vdj | v\_call\_top | v\_call | d\_call\_top | d\_call | j\_call\_top | j\_call | sequence\_alignment | germline\_alignment | sequence\_alignment\_aa | germline\_alignment\_aa | v\_alignment\_start | v\_alignment\_end | d\_alignment\_start | d\_alignment\_end | j\_alignment\_start | j\_alignment\_end | v\_sequence\_alignment | v\_sequence\_alignment\_aa | v\_germline\_alignment | v\_germline\_alignment\_aa | d\_sequence\_alignment | d\_sequence\_alignment\_aa | d\_germline\_alignment | d\_germline\_alignment\_aa | j\_sequence\_alignment | j\_sequence\_alignment\_aa | j\_germline\_alignment | j\_germline\_alignment\_aa | fwr1 | fwr1\_aa | cdr1 | cdr1\_aa | fwr2 | fwr2\_aa | cdr2 | cdr2\_aa | fwr3 | fwr3\_aa | fwr4 | fwr4\_aa | cdr3 | cdr3\_aa | junction | junction\_length | junction\_aa | junction\_aa\_length | v\_score | d\_score | j\_score | v\_cigar | d\_cigar | j\_cigar | v\_support | d\_support | j\_support | v\_identity | d\_identity | j\_identity | v\_sequence\_start | v\_sequence\_end | v\_germline\_start | v\_germline\_end | d\_sequence\_start | d\_sequence\_end | d\_germline\_start | d\_germline\_end | j\_sequence\_start | j\_sequence\_end | j\_germline\_start | j\_germline\_end | fwr1\_start | fwr1\_end | cdr1\_start | cdr1\_end | fwr2\_start | fwr2\_end | cdr2\_start | cdr2\_end | fwr3\_start | fwr3\_end | fwr4\_start | fwr4\_end | cdr3\_start | cdr3\_end | np1 | np1\_length | np2 | np2\_length | liable | vdj\_nt | vdj\_aa | v\_mutation | v\_mutation\_aa | d\_mutation | d\_mutation\_aa | j\_mutation | j\_mutation\_aa | v\_penalty | d\_penalty | j\_penalty |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| PG9 | CAGCGATTAGTGGAG... | human | IGH | F | T | F | T | F | F | IGHV3-33\*05 | IGHV3-33\*05 | IGHD3-3\*01 | IGHD3-3\*01 | IGHJ6\*03 | IGHJ6\*03 | CAGCGATTAGTGGAG... | GTGCAGCTGGTGGAG... | QRLVESGGGVVQPGS... | VQLVESGGGVVQPGR... | 1 | 293 | 328 | 355 | 356 | 408 | CAGCGATTAGTGGAG... | QRLVESGGGVVQPGS... | GTGCAGCTGGTGGAG... | VQLVESGGGVVQPGR... | TATTACGATTTCTAT... | YYDFYDGYY | TATTACGATTTTTGG... | YYDFWSGYY | ACTACCACTATATGG... | YHYMDVWGKGTTVTV... | ACTACTACTACATGG... | YYYMDVWGKGTTVTV... | CAGCGATTAGTGGAG... | QRLVESGGGVVQPGS... | GGATTCGACTTCAGT... | GFDFSRQG | ATGCACTGGGTCCGC... | MHWVRQAPGQGLEWV... | ATTAAATATGATGGA... | IKYDGSEK | TATCATGCTGACTCC... | YHADSVWGRLSISRD... | TGGGGCAAAGGGACC... | WGKGTTVTVSS | GTGAGAGAGGCTGGT... | VREAGGPDYRNGYNY... | TGTGTGAGAGAGGCT... | 96 | CVREAGGPDYRNGYN... | 32 | 335.2 | 30.11 | 83.4 | 3N293M115S | 327S1N28M53S2N | 355S9N53M | 4.83e-94 | 9.579e-05 | 3.428e-20 | 86 | 82.1 | 88.7 | 1 | 293 | 4 | 296 | 328 | 355 | 2 | 29 | 356 | 408 | 10 | 62 | 1 | 72 | 73 | 96 | 97 | 147 | 148 | 171 | 172 | 285 | 376 | 408 | 286 | 375 | GGCTGGTGGGCCCGA... | 34 | nan | 0 | False | CAGCGATTAGTGGAG... | QRLVESGGGVVQPGS... | 14 | 19.5876 | 17.875 | 22.2222 | 11.3125 | 5.88235 | -1 | -1 | -2 |

This `.tsv` file is a [Rearrangement Schema compliant AIRR table](https://docs.airr-community.org/en/stable/datarep/rearrangements.html#file-format-specification). These files have certain specifications, including a `.tsv` file suffix. Since they are AIRR compliant, they can be used by other [AIRR compliant software.](https://docs.airr-community.org/en/stable/resources/rearrangement_support.html). For instance, we could use the output `.tsv` in any module in the [immcantation portal](https://immcantation.readthedocs.io/en/stable/).

#### Other Output Formats[¶](#other-output-formats "Permanent link")

While the `.tsv` AIRR table is the recognized standard for AIRR, you can also output to any other formats that [pandas supports](https://pandas.pydata.org/pandas-docs/stable/user_guide/io.html).

```
from sadie.airr import Airr

# define a single sequence
pg9_seq = "CAGCGATTAGTGGAGTCTGGGGGAGGCGTGGTCCAGCCTGGGTCGTCCCTGAGACTCTCCTGTGCAGCGTCCGGATTCGACTTCAGTAGACAAGGCATGCACTGGGTCCGCCAGGCTCCAGGCCAGGGGCTGGAGTGGGTGGCATTTATTAAATATGATGGAAGTGAGAAATATCATGCTGACTCCGTATGGGGCCGACTCAGCATCTCCAGAGACAATTCCAAGGATACGCTTTATCTCCAAATGAATAGCCTGAGAGTCGAGGACACGGCTACATATTTTTGTGTGAGAGAGGCTGGTGGGCCCGACTACCGTAATGGGTACAACTATTACGATTTCTATGATGGTTATTATAACTACCACTATATGGACGTCTGGGGCAAAGGGACCACGGTCACCGTCTCGAGC"

# setup API object
airr_api = Airr("human")

# run sequence and return airr table with sequence_id and sequence
airr_table = airr_api.run_single("PG9", pg9_seq)

# write airr table to a csv
airr_table.to_csv("PG9 AIRR.csv")

# write to a json file
airr_table.to_json("PG9 AIRR.json", orient="records")

# write to a browser friendly html file
airr_table.to_html("PG9 AIRR.html")

# write to an excel file
airr_table.to_excel("PG9 AIRR.xlsx")

# write to a parquet file that is read by spark
airr_table.to_parquet("PG9 AIRR.parquet")

# write to a feather file that has rapid IO
airr_table.to_feather("PG9 AIRR.feather")
```

Attention

Because `AirrTable` is a subclass of `pandas.DataFrame`, you can use any pandas IO methods to write to a file of your choosing. However, it must be noted that these are not official [Rearrangement Schema compliant AIRR tables](https://docs.airr-community.org/en/stable/datarep/rearrangements.html#file-format-specification). They may only be read in by software that reads those file types or be read back in by **SADIE** and probably will not work in other software that supports the AIRR standard. But, these file formats are extremely useful for much larger files.

### Reading Files[¶](#reading-files "Permanent link")

To read in an AIRR file, we have to create an `AirrTable` object.

#### Reading an AIRR.tsv[¶](#reading-an-airrtsv "Permanent link")

You can read official AIRR.tsv using the `AirrTable.from_airr()` method or with pandas and casting to an `AirrTable` object.

```
import pandas as pd

from sadie.airr import AirrTable

# use AirrTable method to convert AirrTable.tsv to an AirrTable object
pg9_path = "PG9 AIRR.tsv.gz"

airr_table = AirrTable.read_airr(pg9_path)
print(type(airr_table), isinstance(airr_table, AirrTable))

# or use pandas read_csv method
airr_table_from_pandas = AirrTable(pd.read_csv(pg9_path, sep="\t"))
print(type(airr_table_from_pandas), isinstance(airr_table_from_pandas, AirrTable))
```

Outputs:

```
<class 'sadie.airr.airrtable.airrtable.AirrTable'> True
<class 'sadie.airr.airrtable.airrtable.AirrTable'> True
True # The airr tables are equal
```

#### Reading other file formats[¶](#reading-other-file-formats "Permanent link")

Any other file formats that are readable by [pandas IO](https://pandas.pydata.org/pandas-docs/stable/user_guide/io.html) can be read in by passing them to AirrTable.

```
import pandas as pd

from sadie.airr import AirrTable

# write airr table to a csv
airr_table_1 = AirrTable(pd.read_csv("PG9 AIRR.csv"))

# write to a json file
airr_table_2 = AirrTable(pd.read_json("PG9 AIRR.json", orient="records"))

# write to an excel file
airr_table_3 = AirrTable(pd.read_excel("PG9 AIRR.xlsx"))

# write to a parquet file that is read by spark
airr_table_4 = AirrTable(pd.read_parquet("PG9 AIRR.parquet"))

# write to a feather file that has rapid IO
airr_table_5 = AirrTable(pd.read_feather("PG9 AIRR.feather"))
```

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)