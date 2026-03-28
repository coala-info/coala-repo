[Pynteny](../..)

* [Home](../..)

Subcommands

* [Search](../../subcommands/search/)
* [Build](../../subcommands/build/)
* [Parse](../../subcommands/parse/)
* [Download](../../subcommands/download/)

Examples

* [Example CLI](../example_cli/)
* [Example API](./)
* [Sus operon](../example_sus/)

References

* [API references](../../references/api/)

[Pynteny](../..)

* »
* Examples »
* Example API
* [Edit on GitHub](https://github.com/Robaina/Pynteny/edit/master/docs/examples/example_api.ipynb)

---

![logo](https://user-images.githubusercontent.com/21340147/192824830-dcbe8d09-2b10-431d-bd9a-b4624192dcc9.png)

[Semidán Robaina](https://github.com/Robaina), September 2022.

In this Notebook, we will use Pynteny through its Python API to find candidate peptide sequences beloging to the *leu* operon of *Escherichia coli*.

* Note that we could have conducted the same search through Pynteny's command-line interface. Check out a more complete example based on Pynteny's command-line interface [here](example_cli.ipynb).
* Find more info in the [documentation pages](https://robaina.github.io/Pynteny/)!

Let's start by importing some required modules.

In [1]:

Copied!

```
from pathlib import Path
from pandas import DataFrame
from pynteny.filter import SyntenyHits
from pynteny import Search, Build, Download
```

from pathlib import Path
from pandas import DataFrame
from pynteny.filter import SyntenyHits
from pynteny import Search, Build, Download

Let's now create a directory to store results

In [2]:

Copied!

```
Path("example_api/data").mkdir(exist_ok=False, parents=True)
```

Path("example\_api/data").mkdir(exist\_ok=False, parents=True)

## Download PGAP profile HMM database[¶](#Download-PGAP-profile-HMM-database)

Pynteny downloads the [PGAP](https://academic.oup.com/nar/article/49/D1/D1020/6018440)'s profile HMM database by default from the NCBI webpage when no path to a HMM database is provided. However, we can also manually download PGAP's database within Python through the class `Download`, which will unzip and store files in the specified output directory. The metadata file will be parsed and filtered to remove HMM entries that are not available in the downloaded database (this is to avoid possible downstream errors). Here is how you would run it:

In [3]:

Copied!

```
# Optional if PGAP's database has already been downloaded by Pynteny
Download(
    outdir="example_api/data/hmms",
    unpack=True
).run()
```

# Optional if PGAP's database has already been downloaded by Pynteny
Download(
outdir="example\_api/data/hmms",
unpack=True
).run()

## Build peptide sequence database[¶](#Build-peptide-sequence-database)

For this example, we are going to use the complete genome of *E. coli*'s K-12 MG1655 in genbank format. Our final goal is to build a peptide sequence database in a single FASTA file where each record corresponds to an inferred ORF, which will display the positional information (i.e. ORF number within the parent contig as well as the DNA strand). To this end, we will run pynteny's subcommand `build` within Python through the class `Build`.

Since we are providing a genome which is already annotated (genbank file), we don't need to predict and translate ORFs as in the [command-line example](example_cli.ipynb). Instead, Pynteny will directly label each ORF with a unique identifier and add positional metadata (with respect to the parent contig). The labels will be organized following the structure:

```
<genome ID>__<contig ID>_<gene position>_<locus start>_<locus end>_<strand>
```

where gene position, locus start, and locus end are taken with respect to the contig.

**NOTE**: You'll need *E. coli's* genome to follow this example. It's already downloaded in the repo (`tests/test_data/MG1655.gb`), but you can also download it [here](https://www.ncbi.nlm.nih.gov/nuccore/U00096.2).

In [4]:

Copied!

```
Build(
    data="../../tests/test_data/MG1655.gb",
    outfile="example_api/data/labelled_MG1655.fasta",
    logfile=None
).run()
```

Build(
data="../../tests/test\_data/MG1655.gb",
outfile="example\_api/data/labelled\_MG1655.fasta",
logfile=None
).run()

```
2023-01-31 10:14:01,795 | INFO: Building annotated peptide database
2023-01-31 10:14:02,289 | INFO: Parsing GenBank data.
2023-01-31 10:14:02,705 | INFO: Database built successfully!
```

## Search synteny structure in *E. coli*[¶](#Search-synteny-structure-in-E.-coli)

Finally, we are going to use pynteny class `Search` to search for a specific syntenic block within the previously built peptide database. Specifically, we are interested in the following structure:

```
<leuD 0 <leuC 1 <leuA
```

With this synteny structure, we are searching for peptide sequences matching the profile HMM corresponding to these gene symbols, which are also arranged in this particular order, all in the negative (antisense) strand, as indicated by `<`, and which are located exactly next to each other in the same contig in the case of `leuD` and `leuC`, and with at most one ORF in between in the case of `leuC` and `leuA` (as indicated by a maximum number of in-between ORFs of 0 and 1, respectively.)

First, we need to initialize the class `Search` with the appropiate parameters to conduct our synteny-aware search. Find more info about the parameters in the [wiki pages](https://github.com/Robaina/Pynteny/wiki/search).

Some notes:

* The only required parameters are `data`, the path to the position-labeled peptide database and `synteny_struc`, a string containing the definition of the synteny block to search for
* Providing a path to the HMM database directory (parameter `hmm_dir`) is optional. If not provided, then pynteny will download and store the PGAP HMM database (only once if not previously downloaded) and use it to run the search. A custom HMM database provided in `hmm_dir` will override pynteny's default database
* We can also manually download the PGAP HMM database with the subcommand `pynteny download`, or within Python through the class `Download` as shown above.

In [3]:

Copied!

```
# Initialize class
search = Search(
    data="example_api/data/labelled_MG1655.fasta",
    synteny_struc="<leuD 0 <leuC 1 <leuA",
    hmm_dir=None,
    hmm_meta=None,
    outdir="example_api/",
    prefix="",
    hmmsearch_args=None,
    gene_ids=False,
    logfile="example_api/pynteny.log",
    processes=None,
    unordered=False,
    )
```

# Initialize class
search = Search(
data="example\_api/data/labelled\_MG1655.fasta",
synteny\_struc="

In [4]:

Copied!

```
# Parse gene IDs in synteny structure according to PGAP HMM database metadata
parsed_struc = search.parse_genes(synteny_struc="<leuD 0 <leuC 1 <leuA")
```

# Parse gene IDs in synteny structure according to PGAP HMM database metadata
parsed\_struc = search.parse\_genes(synteny\_struc="

```
2022-10-04 12:02:26,644 | INFO: Translated
 "<leuD 0 <leuC 1 <leuA"
 to
 "<TIGR00171.1 0 <TIGR00170.1 1 <TIGR00973.1"
 according to provided HMM database metadata
```

We see that `pynteny parse` has found three profile HMMs matching the corresponding gene symbols in the provided synteny structure:

`<TIGR00171.1 0 <TIGR00170.1 1 <TIGR00973.1`

Alright, now that we know that our HMM database contains models for all the gene symbols in our synteny structure, let's execute `Search.run` to find matches in our peptide sequence database.

Some notes:

* We could have directly input the synteny string composed of gene symbols. In that case we would have to set `gene_ids=True` with the method `Search.update`.

In [5]:

Copied!

```
# Update parsed synteny structure and Rrun Pynteny search
search.update("synteny_struc", parsed_struc)
synhits: SyntenyHits = search.run()

synhits_df: DataFrame = synhits.hits
```

# Update parsed synteny structure and Rrun Pynteny search
search.update("synteny\_struc", parsed\_struc)
synhits: SyntenyHits = search.run()
synhits\_df: DataFrame = synhits.hits

```
2022-10-04 12:02:29,054 | INFO: Searching database by synteny structure
2022-10-04 12:02:29,054 | INFO: Running Hmmer
2022-10-04 12:02:29,055 | INFO: Reusing Hmmer results for HMM: TIGR00973.1
2022-10-04 12:02:29,058 | INFO: Reusing Hmmer results for HMM: TIGR00171.1
2022-10-04 12:02:29,060 | INFO: Reusing Hmmer results for HMM: TIGR00170.1
2022-10-04 12:02:29,062 | INFO: Filtering results by synteny structure
2022-10-04 12:02:29,091 | INFO: Writing matching sequences to FASTA files
2022-10-04 12:02:29,146 | INFO: Finished!
```

## Displaying the first synteny match[¶](#Displaying-the-first-synteny-match)

Pynteny has generated a number of output files in the provided output directory. HMMER3 hit results are stored within the subdirectory `hmmer_outputs`. The main output file, `synteny_matched.tsv` contains the labels of the matched sequences grouped by synteny block and sorted by gene number within their parent contig. The remaining (FASTA) files contain the retrieved peptide sequences for each gene symbol / HMM name in the synteny structure.

Displayed below is the first synteny match in our peptide database, we see that all peptides are located within the same parent contig and respect the positional restrictions of our input synteny structure: `<leuD 0 <leuC 1 <leuA`.

In [6]:

Copied!

```
synhits_df.head()
```

synhits\_df.head()

Out[6]:

|  | contig | gene\_id | gene\_number | locus | strand | full\_label | hmm | gene\_symbol | label | product | ec\_number |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 0 | U00096 | b0071 | 71 | (78847, 79453) | neg | b0071\_\_U00096\_71\_78847\_79453\_neg | TIGR00171.1 | leuD | leuD | 3-isopropylmalate dehydratase small subunit | 4.2.1.33 |
| 1 | U00096 | b0072 | 72 | (79463, 80864) | neg | b0072\_\_U00096\_72\_79463\_80864\_neg | TIGR00170.1 | leuC | leuC | 3-isopropylmalate dehydratase large subunit | 4.2.1.33 |
| 2 | U00096 | b0074 | 74 | (81957, 83529) | neg | b0074\_\_U00096\_74\_81957\_83529\_neg | TIGR00973.1 | leuA | leuA\_bact | 2-isopropylmalate synthase | 2.3.3.13 |

Finally, here is the KEGG genome visualization centered around the *leu* operon. Click on the image to open it in the browser, then change gene identifiers from `KID` to `Symbol` to display gene symbols. The *sox* operon is depicted in purple.

[![keeg_leu](https://user-images.githubusercontent.com/21340147/193794791-fc7643a7-4fbc-41a1-9770-2979bfc3434a.png)](https://www.genome.jp/genome/T00007?org=T00007&from=64000&to=101580&label=kid)

## Get citation[¶](#Get-citation)

We can get the citation string by calling the `cite` method:

In [11]:

Copied!

```
Search.cite()
```

Search.cite()

```
Semidán Robaina Estévez (2022). Pynteny: synteny-aware hmm searches made easy(Version 0.0.2). Zenodo. https://doi.org/10.5281/zenodo.7048685
```

[Previous](../example_cli/ "Example CLI")
[Next](../example_sus/ "Sus operon")

---

Built with [MkDocs](https://www.mkdocs.org/) using a [theme](https://github.com/readthedocs/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).

[GitHub](https://github.com/Robaina/Pynteny)
[« Previous](../example_cli/)
[Next »](../example_sus/)