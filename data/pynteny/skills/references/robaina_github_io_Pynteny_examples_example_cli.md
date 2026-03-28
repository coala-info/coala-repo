[Pynteny](../..)

* [Home](../..)

Subcommands

* [Search](../../subcommands/search/)
* [Build](../../subcommands/build/)
* [Parse](../../subcommands/parse/)
* [Download](../../subcommands/download/)

Examples

* [Example CLI](./)
* [Example API](../example_api/)
* [Sus operon](../example_sus/)

References

* [API references](../../references/api/)

[Pynteny](../..)

* »
* Examples »
* Example CLI
* [Edit on GitHub](https://github.com/Robaina/Pynteny/edit/master/docs/examples/example_cli.ipynb)

---

![logo](https://user-images.githubusercontent.com/21340147/192824830-dcbe8d09-2b10-431d-bd9a-b4624192dcc9.png)

[Semidán Robaina](https://github.com/Robaina), September 2022.

In this Notebook, we will use Pynteny through its command-line interface to find candidate peptide sequences beloging to the *sox* operon within unannotated, fully sequenced, genomes of marine prokaryotic organisms. Note that we could have conducted the same search through [Pynteny's python API](example_api.ipynb). Find more info in the [documentation pages](https://robaina.github.io/Pynteny/). Let's start by importing some required modules.

In [1]:

Copied!

```
from pathlib import Path
from IPython.display import display, HTML
import pandas as pd
```

from pathlib import Path
from IPython.display import display, HTML
import pandas as pd

## Download PGAP profile HMM database[¶](#Download-PGAP-profile-HMM-database)

First, let's download [PGAP](https://academic.oup.com/nar/article/49/D1/D1020/6018440)'s profile HMM database from the NCBI webpage. To this end, we will use pynteny subcommand `download`, which will unzip and store files in the specified output directory. The metadata file will be parsed and filtered to remove HMM entries that are not available in the downloaded database (this is to avoid possible downstream errors).

In [22]:

Copied!

```
%%bash

pynteny download --outdir data/hmms --unpack
```

%%bash
pynteny download --outdir data/hmms --unpack

## Build peptide sequence database[¶](#Build-peptide-sequence-database)

For this example, we are going to use the [MAR reference](https://mmp2.sfb.uit.no/marref/) database (currently version *v7*), a collection of 970 fully sequenced prokaryotic genomes from the marine environment. Specifically, we will use the assembly data file containing the assembled nucleotide sequences.

Our final goal is to build a peptide sequence database in a single FASTA file where each record corresponds to an inferred ORF, which will display the positional information (i.e. ORF number within the parent contig as well as the DNA strand). To this end, we will run pynteny's subcommand `build`, which will take care of:

* Predict and translate ORFs with prodigal
* Label each ORF with a unique identifier and add positional metadata (with respect to the parent contig)

To follow this example, you should have previously downloaded the assembly data file, `assembly.fa`, from [MAR ref](https://mmp2.sfb.uit.no/marref/). Here is what the first lines of `assembly.fa` look like, each record corresponds to a single, assembled genome:

In [2]:

Copied!

```
%%bash

head -n 4 data/MARref_v7/assembly.fa
```

%%bash
head -n 4 data/MARref\_v7/assembly.fa

```
>CP000435.1 Synechococcus sp. CC9311, complete genome
ACATCGTTTCCCCTGTTTCCACAAGACCTACTACGGCTGTTTTCGTAGTTCTTTTAAGAGAATAAAAACAGCCCTAAAGC
CGGGGAACACGAAAAAAACGTGAAACCATTGCGCTTCTCCCTTGCCTGTGAAATTGTGAGGAGAGATTTGTTCACGCCGT
TGACTCGGACCTCATGAAATTGGTCTGTTCCCAGGCAGAACTCAACGCAGCTCTGCAGTTGGTCAGTCGGGCTGTCGCCT
```

Let's run `pynteny build` to generate a peptide database labeled with positional information. The labels are organized following the structure:

`<genome ID>__<contig ID>_<gene position>_<locus start>_<locus end>_<strand>`

where gene position, locus start, and locus end are taken with respect to the contig.

In [18]:

Copied!

```
%%bash

pynteny build \
    --data data/MARref_v7/assembly.fa \
    --outfile data/labeled_marref.fasta
```

%%bash
pynteny build \
--data data/MARref\_v7/assembly.fa \
--outfile data/labeled\_marref.fasta

Here are some position-labeled predicted peptides corresponding to the assembled genome displayed above (`CP000435.1`):

In [5]:

Copied!

```
%%bash

grep -A 1 "CP000435.1" data/labeled_marref.fasta | head -n 6
```

%%bash
grep -A 1 "CP000435.1" data/labeled\_marref.fasta | head -n 6

```
>CP000435.1_1__CP000435.1_1_174_1331_pos
MKLVCSQAELNAALQLVSRAVASRPTHPVLANVLLTADAGTDRLSLTGFDLNLGIQTSLAASVDTSGAVTLPARLLGEIVSKLSSDSPVSLSSDAGADQVELTSSSGSYQMRGMPADDFPELPLVENGTALRVDPASLLKALRATLFASSGDEAKQLLTGVHLRFNQKRLEAASTDGHRLAMLTVEDALQAEISAEESEPDELAVTLPARSLREVERLMASWKGGDPVSLFCERGQVVVLAADQMVTSRTLEGTYPNYRQLIPDGFSRTIDLDRRAFISALERIAVLADQHNNVVRIATEPATGLVQISADAQDVGSGSESLPAEINGDAVQIAFNARYVLDGLKAMDCDRVRLSCNAPTTPAILTPANDDPGLTYLVMPVQIRT*
>CP000435.1_2__CP000435.1_2_1435_2148_pos
MAWMHPPVHRLLGWVSRPSALRTSRDVWRLDQCRGFDDQQVFVKGAPAEADQITLDRLPTLLDADLLNADGERVGIIADLAFLPASGQISHYLVARSDPRLPGTSRWRLLPDRIVDQQPGLVSSAIHELDDLPLARASVRQDFLQRSRHWREQLQQFGDRAGERLEGWLEEPPWDEPPAVSDVASSYSSTAAPTVDPLDDWDDGDWTDAPRVERGRSVRNDPTDRNDWPDHEEDPWV*
>CP000435.1_3__CP000435.1_3_2185_4518_pos
MTQSSHAVAAFDLGAALRQEGLTETDYSEIQRRLGRDPNRAELGMFGVMWSEHCCYRNSRPLLSGFPTEGPRILVGPGENAGVVDLGEGHHLAFKVESHNHPSAVEPFQGAATGVGGILRDIFTMGARPIALLNALRFGPLDEPATRGLVEGVVAGIAHYGNCVGVPTVGGEVAFDPSYRGNPLVNAMALGLMETDEIVRSGAAGVGNPVVYVGSTTGRDGMGGASFASAELSADSLDDRPAVQVGDPFLEKGLIEACLEAFQSGDVVAAQDMGAAGLTCSCSEMAAKGDVGVELDLDRVPAREKGMTAYEFLLSESQERMLFVVRAGREEQLMQRFRRWGLQAAVVGRVLEEKVVRVLQHGAVAAEVPARALAEDTPINKHELLSEPPDDIQTHWTWRESDLPSPAIDRDWNADLLRLLDDPTIASKRWIYRQYDQQVLANTVIRAGGADAAVVRLRPQQGDASLQMSQRGVAATLDCPNRWVALDPERGAIAAVAEAARNLSCVGAQPIAVTDNLNFPSPETSKGYWQLAMACRGLSHACRSMGTPVTGGNVSLYNETRADDGSLQPIHPTPVVGMVGLVEDLDRSGGLAWRQPGDFVVLLGVSTDEEGNESVGLAGSSYQGAVHGLLTGRPPSVDLELEGQVQALVRQAFAQGVLASAHDSSDGGLAVALAESTLASGLGVDLNLPHRSARLDRVLFAEGGARIVVSVRAEQRSAWHSLVASQEHRSVPVTEIGTVADHGCFRLAVEKHPVIDLAVETLREQYEQAVPRRLGAV*
```

## Search synteny structure in MAR ref[¶](#Search-synteny-structure-in-MAR-ref)

Finally, we are going to use pynteny's `search` subcommand to search for a specific syntenic block within the previously built peptide database. Specifically, we are interested in the [*sox* operon](https://link.springer.com/article/10.1007/s00253-016-8026-2#Fig1):

```
>soxX 0 >soxY 0 >soxZ 0 >soxA 0 >soxB 0 >soxC
```

We this synteny structure, we are searching for peptide sequences matching the profile HMM corresponding to these gene symbols, which are also arranged in this particular order, all in the positive (sense) strand, as indicated by `>`, and which are located exactly next to each other in the same contig (no ORFs allowed between them, as indicated by a maximum number of in-between ORFs of 0 in all cases.)

In [10]:

Copied!

```
%%bash

pynteny parse \
    --synteny_struc ">soxX 0 >soxY 0 >soxZ 0 >soxA 0 >soxB 0 >soxC" \
    --hmm_meta data/hmms/hmm_meta.tsv
```

%%bash
pynteny parse \
--synteny\_struc ">soxX 0 >soxY 0 >soxZ 0 >soxA 0 >soxB 0 >soxC" \
--hmm\_meta data/hmms/hmm\_meta.tsv

```
    ____              __
   / __ \__  ______  / /____  ____  __  __
  / /_/ / / / / __ \/ __/ _ \/ __ \/ / / /
 / ____/ /_/ / / / / /_/  __/ / / / /_/ /
/_/    \__, /_/ /_/\__/\___/_/ /_/\__, /
      /____/                     /____/

Synteny-based Hmmer searches made easy, v0.0.2
Semidán Robaina Estévez (srobaina@ull.edu.es), 2022

2022-09-29 15:19:30,733 | INFO: Translated
 ">soxX 0 >soxY 0 >soxZ 0 >soxA 0 >soxB 0 >soxC"
 to
 ">TIGR04485.1 0 >TIGR04488.1 0 >TIGR04490.1 0 >(TIGR01372.1|TIGR04484.1) 0 >(TIGR01373.1|TIGR04486.1) 0 >TIGR04555.1"
 according to provided HMM database metadata
```

We see that `pynteny parse` has found a number of profile HMMs matching the gene symbols in the provided synteny structure. Additionally, in two cases it has found two HMMs matching a single gene symbol, which are displayed within parentheses and separated by "|":

`>TIGR04485.1 0 >TIGR04488.1 0 >TIGR04490.1 0 >(TIGR01372.1|TIGR04484.1) 0 >(TIGR01373.1|TIGR04486.1) 0 >TIGR04555.1`

In these cases, `pynteny search` will match sequences by either or all of the HMMs in each group within parentheses.

Alright, now that we know that our HMM database contains models for all the gene symbols in our synteny structure, let's run `pynteny search` to find matches in our peptide sequence database.

Some notes:

* Since we are using gene symbols instead of HMM names, we need to add the flag `--gene_ids`
* We could have directly input the synteny string composed of HMM names. In that case, we wouldn't need to provide the path to the HMM metadata file (`--hmm_meta`) and we would remove the flag `--gene_ids`
* Providing a path to the HMM database directory (`--hmm_dir`) is optional. If not provided, then pynteny will download and store the PGAP HMM database (only once if not previously downloaded) and use it to run the search. A custom HMM database provided in `--hmm_dir`will override pynteny's default database
* We can also manually download the PGAP HMM database with the subcommand `pynteny download`

In [6]:

Copied!

```
%%bash

pynteny search \
    --synteny_struc ">soxX 0 >soxY 0 >soxZ 0 >soxA 0 >soxB 0 >soxC" \
    --data data/labeled_marref.fasta \
    --outdir example_cli/results/ \
    --hmm_dir data/hmms/hmm_PGAP \
    --hmm_meta data/hmms/hmm_meta.tsv \
    --gene_ids
```

%%bash
pynteny search \
--synteny\_struc ">soxX 0 >soxY 0 >soxZ 0 >soxA 0 >soxB 0 >soxC" \
--data data/labeled\_marref.fasta \
--outdir example\_cli/results/ \
--hmm\_dir data/hmms/hmm\_PGAP \
--hmm\_meta data/hmms/hmm\_meta.tsv \
--gene\_ids

```
    ____              __
   / __ \__  ______  / /____  ____  __  __
  / /_/ / / / / __ \/ __/ _ \/ __ \/ / / /
 / ____/ /_/ / / / / /_/  __/ / / / /_/ /
/_/    \__, /_/ /_/\__/\___/_/ /_/\__, /
      /____/                     /____/

Synteny-based Hmmer searches made easy, v0.0.2
Semidán Robaina Estévez (srobaina@ull.edu.es), 2022

2022-09-29 15:11:25,776 | INFO: Finding matching HMMs for gene symbols
2022-09-29 15:11:25,947 | INFO: Found the following HMMs in database for given structure:
>TIGR04485.1 0 >TIGR04488.1 0 >TIGR04490.1 0 >(TIGR01372.1|TIGR04484.1) 0 >(TIGR01373.1|TIGR04486.1) 0 >TIGR04555.1
2022-09-29 15:11:26,134 | INFO: Searching database by synteny structure
2022-09-29 15:11:26,135 | INFO: Running Hmmer
2022-09-29 15:14:35,607 | INFO: Filtering results by synteny structure
2022-09-29 15:15:58,818 | INFO: Writing matching sequences to FASTA files
2022-09-29 15:16:03,511 | INFO: Finished!
```

Pynteny has generated a number of output files in the provided output directory. HMMER3 hit results are stored within the subdirectory `hmmer_outputs`. The main output file, `synteny_matched.tsv` contains the labels of the matched sequences grouped by synteny block and sorted by gene number within their parent contig. The remaining (FASTA) files contain the retrieved peptide sequences for each gene symbol / HMM name in the synteny structure.

In [8]:

Copied!

```
output_files = sorted([
    file.name for file in Path("example_cli/").iterdir()
])

output_files
```

output\_files = sorted([
file.name for file in Path("example\_cli/").iterdir()
])
output\_files

Out[8]:

```
['hmmer_outputs',
 'soxA_TIGR04484.1_hits.fasta',
 'soxB_TIGR04486.1_hits.fasta',
 'soxC_TIGR04555.1_hits.fasta',
 'soxX_TIGR04485.1_hits.fasta',
 'soxY_TIGR04488.1_hits.fasta',
 'soxZ_TIGR04490.1_hits.fasta',
 'synteny_matched.tsv']
```

## Displaying the first synteny match[¶](#Displaying-the-first-synteny-match)

So far, we have identified sequences (putatively) belonging to the sox operon in the MAR ref database. However, we don't know to which organisms these sequences belong. Luckily, the MAR ref database provides a metadata file that contains GTDB taxonomical information for each genome. Let's extract that info and add it to Pynteny's output table.

In [67]:

Copied!

```
# Assign species (GTDB) to each genome ID
meta = pd.read_csv("data/MARref_v7/MarRef_1.7.tsv", sep="\t")

def assign_tax(genome_id: str) -> str:
    try:
        return meta.loc[
            meta['acc:genbank'].str.contains(f'ena.embl:{genome_id.split(".")[0]}'), 'tax:gtdb_classification'
            ].item().split(">")[-1]
    except:
        return ""

df = pd.read_csv("example_cli/results/synteny_matched.tsv", sep="\t")
df["taxonomy"] = df.contig.apply(assign_tax)

# Display main results
till_row = 5
display_cols = ["gene_id", "contig", "gene_symbol", "gene_number", "locus", "strand", "hmm", "taxonomy"]
display(HTML(df.loc[:till_row, display_cols].to_html()))
```

# Assign species (GTDB) to each genome ID
meta = pd.read\_csv("data/MARref\_v7/MarRef\_1.7.tsv", sep="\t")
def assign\_tax(genome\_id: str) -> str:
try:
return meta.loc[
meta['acc:genbank'].str.contains(f'ena.embl:{genome\_id.split(".")[0]}'), 'tax:gtdb\_classification'
].item().split(">")[-1]
except:
return ""
df = pd.read\_csv("example\_cli/results/synteny\_matched.tsv", sep="\t")
df["taxonomy"] = df.contig.apply(assign\_tax)
# Display main results
till\_row = 5
display\_cols = ["gene\_id", "contig", "gene\_symbol", "gene\_number", "locus", "strand", "hmm", "taxonomy"]
display(HTML(df.loc[:till\_row, display\_cols].to\_html()))

|  | gene\_id | gene\_symbol | gene\_number | locus | strand | hmm | taxonomy |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 0 | CP000031.2\_985 | soxX | 985 | (1045616, 1046089) | pos | TIGR04485.1 | s\_\_Ruegeria\_B pomeroyi |
| 1 | CP000031.2\_986 | soxY | 986 | (1046132, 1046548) | pos | TIGR04488.1 | s\_\_Ruegeria\_B pomeroyi |
| 2 | CP000031.2\_987 | soxZ | 987 | (1046582, 1046911) | pos | TIGR04490.1 | s\_\_Ruegeria\_B pomeroyi |
| 3 | CP000031.2\_988 | soxA | 988 | (1046989, 1047840) | pos | TIGR04484.1 | s\_\_Ruegeria\_B pomeroyi |
| 4 | CP000031.2\_989 | soxB | 989 | (1047975, 1049645) | pos | TIGR04486.1 | s\_\_Ruegeria\_B pomeroyi |
| 5 | CP000031.2\_990 | soxC | 990 | (1049724, 1051007) | pos | TIGR04555.1 | s\_\_Ruegeria\_B pomeroyi |

Displayed above the first synteny match in our peptide database, we see that all peptides are located within the same parent contig and respect the positional restrictions of our input synteny structure. Furthermore, all sequences belong to *Ruegeria pomeroyii*, and alphaproteobacteria of the family *Rhodobacteraceae*.

Additional notes:

* The previous results are strand-specific (all ORFs must be located in the positive or *sense* strand). However, we could have made them strand-agnostic by omitting the strand symbols in the synteny structure (i.e., using `soxX 0 soxY 0 soxZ 0 soxA 0 soxB 0 soxC`)
* We could have made the search even more general dropping the constraint on the arrangement by adding the flag `pynteny search --unordered`. In which case, Pynteny would match any group of 6 ORFs corresponding to the provided HMM names, located in the same contig and adjacent to each other, but not necessarily arranged in the same order displayed by the synteny structure. In other words, `--unordered` enables searching for "true" synteny, as opposed to the, more restrictive, collinearity.

