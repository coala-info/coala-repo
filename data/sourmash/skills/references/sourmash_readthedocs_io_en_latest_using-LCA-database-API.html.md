# Using the `LCA_Database` API[¶](#Using-the-LCA_Database-API "Link to this heading")

`LCA_Database` objects combine a fast in-memory storage of signatures indexed by their hash values, with taxonomic lineage storage. They are limited to storing scaled DNA signatures with a single ksize; the scaled and ksize values are specified at creation.

## Running this notebook.[¶](#Running-this-notebook. "Link to this heading")

You can run this notebook interactively via mybinder; click on this button: [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/dib-lab/sourmash/latest?labpath=doc%2Fusing-LCA-database-API.ipynb)

A rendered version of this notebook is available at [sourmash.readthedocs.io](https://sourmash.readthedocs.io) under “Tutorials and notebooks”.

You can also get this notebook from the [doc/ subdirectory of the sourmash github repository](https://github.com/dib-lab/sourmash/tree/latest/doc). See [binder/environment.yaml](https://github.com/dib-lab/sourmash/blob/latest/binder/environment.yml) for installation dependencies.

## What is this?[¶](#What-is-this? "Link to this heading")

This is a Jupyter Notebook using Python 3. If you are running this via [binder](https://mybinder.org), you can use Shift-ENTER to run cells, and double click on code cells to edit them.

Contact: C. Titus Brown, ctbrown@ucdavis.edu. Please [file issues on GitHub](https://github.com/dib-lab/sourmash/issues/) if you have any questions or comments!

### Creating an `LCA_Database` object[¶](#Creating-an-LCA_Database-object "Link to this heading")

Create an `LCA_Database` like so:

```
[1]:
```

```
import sourmash

db = sourmash.lca.LCA_Database(ksize=31, scaled=1000)
```

Create signatures for some genomes, load them, and add them:

```
[2]:
```

```
!sourmash sketch dna -p k=31,scaled=1000 genomes/*
```

```
== This is sourmash version 4.8.2. ==
== Please cite Brown and Irber (2016), doi:10.21105/joss.00027. ==

computing signatures for files: genomes/akkermansia.fa, genomes/shew_os185.fa, genomes/shew_os223.fa
Computing a total of 1 signature(s) for each input.
skipping genomes/akkermansia.fa - already done
skipping genomes/shew_os185.fa - already done
skipping genomes/shew_os223.fa - already done
```

```
[3]:
```

```
sig1 = sourmash.load_one_signature("akkermansia.fa.sig", ksize=31)
sig2 = sourmash.load_one_signature("shew_os185.fa.sig", ksize=31)
sig3 = sourmash.load_one_signature("shew_os223.fa.sig", ksize=31)
```

```
[4]:
```

```
db.insert(sig1, ident="akkermansia")
db.insert(sig2, ident="shew_os185")
db.insert(sig3, ident="shew_os223")
```

```
[4]:
```

```
490
```

### Run `search` and `gather` via the `Index` API[¶](#Run-search-and-gather-via-the-Index-API "Link to this heading")

```
[5]:
```

```
from pprint import pprint

pprint(db.search(sig1, threshold=0.1))
```

```
[Result(score=1.0, signature=SourmashSignature('CP001071.1 Akkermansia muciniphila ATCC BAA-835, complete genome', 6822e0b7), location=None)]
```

```
[6]:
```

```
pprint(db.search(sig2, threshold=0.1))
```

```
[Result(score=1.0, signature=SourmashSignature('NC_009665.1 Shewanella baltica OS185, complete genome', b47b13ef), location=None),
 Result(score=0.22846441947565543, signature=SourmashSignature('NC_011663.1 Shewanella baltica OS223, complete genome', ae6659f6), location=None)]
```

```
[7]:
```

```
pprint(db.best_containment(sig3))
```

```
Result(score=1.0, signature=SourmashSignature('NC_011663.1 Shewanella baltica OS223, complete genome', ae6659f6), location=None)
```

### Retrieve all signatures with `signatures()`[¶](#Retrieve-all-signatures-with-signatures() "Link to this heading")

```
[8]:
```

```
for i in db.signatures():
    print(i)
```

```
CP001071.1 Akkermansia muciniphila ATCC BAA-835, complete genome
NC_009665.1 Shewanella baltica OS185, complete genome
NC_011663.1 Shewanella baltica OS223, complete genome
```

### Access identifiers and names[¶](#Access-identifiers-and-names "Link to this heading")

The list of (unique) identifiers in the database can be accessed via the attribute `ident_to_idx`, which maps to integer identifiers; identifiers can also retrieve full names, which are taken from `sig.name()` upon insertion.

```
[9]:
```

```
pprint(db._ident_to_idx.keys())
```

```
dict_keys(['akkermansia', 'shew_os185', 'shew_os223'])
```

```
[10]:
```

```
pprint(db._ident_to_name)
```

```
{'akkermansia': 'CP001071.1 Akkermansia muciniphila ATCC BAA-835, complete '
                'genome',
 'shew_os185': 'NC_009665.1 Shewanella baltica OS185, complete genome',
 'shew_os223': 'NC_011663.1 Shewanella baltica OS223, complete genome'}
```

### Access hash values directly[¶](#Access-hash-values-directly "Link to this heading")

The attribute `_hashval_to_idx` contains a mapping from individual hash values to sets of `idx` indices.

See the method `_find_signatures()` for an example of how this is used in `search` and `gather`.

```
[11]:
```

```
print(f"{len(db._hashval_to_idx)} hash values total in this database")
```

```
1300 hash values total in this database
```

```
[12]:
```

```
all_idx = set()
for idx_set in db._hashval_to_idx.values():
    all_idx.update(idx_set)
print(f"belonging to signatures with idx {all_idx}")
```

```
belonging to signatures with idx {0, 1, 2}
```

```
[13]:
```

```
first_three_hashvals = list(db._hashval_to_idx)[:3]
```

```
[14]:
```

```
for hashval in first_three_hashvals:
    print(f"hashval {hashval} belongs to idxs {db._hashval_to_idx[hashval]}")
```

```
hashval 17302105753387 belongs to idxs {0}
hashval 95741036335406 belongs to idxs {0}
hashval 165640715598232 belongs to idxs {0}
```

```
[15]:
```

```
query_idx = 2
hashval_set = set()
for hashval, idx_set in db._hashval_to_idx.items():
    if query_idx in idx_set:
        hashval_set.add(hashval)

print(f"{len(hashval_set)} hashvals belong to query idx {query_idx}")

ident = db._idx_to_ident[query_idx]
print(f"query idx {query_idx} matches to ident {ident}")

name = db._ident_to_name[ident]
print(f"query idx {query_idx} matches to name {name}")
```

```
490 hashvals belong to query idx 2
query idx 2 matches to ident shew_os223
query idx 2 matches to name NC_011663.1 Shewanella baltica OS223, complete genome
```

### Lineage storage and retrieval[¶](#Lineage-storage-and-retrieval "Link to this heading")

```
[16]:
```

```
from sourmash.lca.lca_utils import LineagePair
```

```
[17]:
```

```
superkingdom = LineagePair("superkingdom", "Bacteria")
phylum = LineagePair("phylum", "Verrucomicrobia")
klass = LineagePair("class", "Verrucomicrobiae")

lineage = (superkingdom, phylum, klass)
```

```
[18]:
```

```
db = sourmash.lca.LCA_Database(ksize=31, scaled=1000)
db.insert(sig1, lineage=lineage)
```

```
[18]:
```

```
499
```

```
[19]:
```

```
# by default, the identifier is the signature name --
ident = sig1.name
idx = db._ident_to_idx[ident]
print(f"ident '{ident}' has idx {idx}")

lid = db._idx_to_lid[idx]
print(f"lid for idx {idx} is {lid}")

lineage = db._lid_to_lineage[lid]
display = sourmash.lca.display_lineage(lineage)
print(f"lineage for lid {lid} is {display}")
```

```
ident 'CP001071.1 Akkermansia muciniphila ATCC BAA-835, complete genome' has idx 0
lid for idx 0 is 0
lineage for lid 0 is Bacteria;Verrucomicrobia;Verrucomicrobiae
```

### Lineage manipulation[¶](#Lineage-manipulation "Link to this heading")

## Default taxonomy ranks for lineages[¶](#Default-taxonomy-ranks-for-lineages "Link to this heading")

While sourmash lineage functions can work with any taxonomy ranks and any taxonomy names, both the NCBI and GTDB taxonomies use superkingdom/phylum/etc, so there is a hard coded list availalbe via `sourmash.lca.taxlist()`.

```
[20]:
```

```
print(list(sourmash.lca.taxlist()))
```

```
['superkingdom', 'phylum', 'class', 'order', 'family', 'genus', 'species', 'strain']
```

Given a taxonomy as a list, you can then construct a lineage like so:

```
[21]:
```

```
linstr1 = [
    "Bacteria",
    "Verrucomicrobia",
    "Verrucomicrobiae",
    "Verrucomicrobiales",
    "Akkermansiaceae",
    "Akkermansia",
    "Akkermansia muciniphila",
    "Akkermansia muciniphila ATCC BAA-835",
]

lineage1 = [LineagePair(*pair) for pair in zip(sourmash.lca.taxlist(), linstr1)]
pprint(lineage1)
```

```
[LineagePair(rank='superkingdom', name='Bacteria'),
 LineagePair(rank='phylum', name='Verrucomicrobia'),
 LineagePair(rank='class', name='Verrucomicrobiae'),
 LineagePair(rank='order', name='Verrucomicrobiales'),
 LineagePair(rank='family', name='Akkermansiaceae'),
 LineagePair(rank='genus', name='Akkermansia'),
 LineagePair(rank='species', name='Akkermansia muciniphila'),
 LineagePair(rank='strain', name='Akkermansia muciniphila ATCC BAA-835')]
```

```
[22]:
```

```
# display lineages as strings with 'sourmash.lca.display_lineage()'
sourmash.lca.display_lineage(lineage1)
```

```
[22]:
```

```
'Bacteria;Verrucomicrobia;Verrucomicrobiae;Verrucomicrobiales;Akkermansiaceae;Akkermansia;Akkermansia muciniphila;Akkermansia muciniphila ATCC BAA-835'
```

### sourmash lowest-common-ancestor functions[¶](#sourmash-lowest-common-ancestor-functions "Link to this heading")

The LCA functionality available in sourmash is built around some simple lineage manipulation functions – `build_tree` and `find_lca`.

First, let’s define some more lineages –

```
[23]:
```

```
linstr2 = [
    "Bacteria",
    "Proteobacteria",
    "Gammaproteobacteria",
    "Alteromonadales",
    "Shewanellaceae",
    "Shewanella",
    "Shewanella baltica",
    "Shewanella baltica OS185",
]
lineage2 = [LineagePair(*pair) for pair in zip(sourmash.lca.taxlist(), linstr2)]

linstr3 = [
    "Bacteria",
    "Proteobacteria",
    "Gammaproteobacteria",
    "Alteromonadales",
    "Shewanellaceae",
    "Shewanella",
    "Shewanella baltica",
    "Shewanella baltica OS223",
]
lineage3 = [LineagePair(*pair) for pair in zip(sourmash.lca.taxlist(), linstr3)]

print("lineage2 is", sourmash.lca.display_lineage(lineage2))
print("lineage3 is", sourmash.lca.display_lineage(lineage3))
```

```
lineage2 is Bacteria;Proteobacteria;Gammaproteobacteria;Alteromonadales;Shewanellaceae;Shewanella;Shewanella baltica;Shewanella baltica OS185
lineage3 is Bacteria;Proteobacteria;Gammaproteobacteria;Alteromonadales;Shewanellaceae;Shewanella;Shewanella baltica;Shewanella baltica OS223
```

Now, build a tree structure that collapses these lineages where it can, and run some LCA analyses. Lineages 1 and 2 collapse to superkingdom:

```
[24]:
```

```
tree = sourmash.lca.build_tree([lineage1, lineage2])
sourmash.lca.find_lca(tree)
```

```
[24]:
```

```
((LineagePair(rank='superkingdom', name='Bacteria'),), 2)
```

while lineages 2 and 3 collapse to species:

```
[25]:
```

```
tree = sourmash.lca.build_tree([lineage2, lineage3])
sourmash.lca.find_lca(tree)
```

```
[25]:
```

```
((LineagePair(rank='superkingdom', name='Bacteria'),
  LineagePair(rank='phylum', name='Proteobacteria'),
  LineagePair(rank='class', name='Gammaproteobacteria'),
  LineagePair(rank='order', name='Alteromonadales'),
  LineagePair(rank='family', name='Shewanellaceae'),
  LineagePair(rank='genus', name='Shewanella'),
  LineagePair(rank='species', name='Shewanella baltica')),
 2)
```

### Convenience functions let you make use of LCA\_Database stored lineages[¶](#Convenience-functions-let-you-make-use-of-LCA_Database-stored-lineages "Link to this heading")

First, let’s create a database from 3 signatures, and this time we’ll store lineages in there:

```
[26]:
```

```
db = sourmash.lca.LCA_Database(ksize=31, scaled=1000)
db.insert(sig1, lineage=lineage1)
db.insert(sig2, lineage=lineage2)
db.insert(sig3, lineage=lineage3)
```

```
[26]:
```

```
490
```

Now, for any collection of hashes, you can retrieve all the lineage assignments into a dictionary: `{ hashval: set of lineages }`

```
[27]:
```

```
assignments = sourmash.lca.gather_assignments(sig2.minhash.get_mins(), [db])
print("num hashvals:", len(assignments))
```

```
num hashvals: 494
```

```
/var/folders/6s/_f373w1d6hdfjc2kjstq97s80000gp/T/ipykernel_3384/490137846.py:1: DeprecatedWarning: get_mins is deprecated as of 3.5 and will be removed in 5.0. Use .hashes property instead.
  assignments = sourmash.lca.gather_assignments(sig2.minhash.get_mins(), [db])
```

For example, this particular hashvalue belongs to two different lineages:

```
[28]:
```

```
assignments[196037984804395]
```

```
[28]:
```

```
{(LineagePair(rank='superkingdom', name='Bacteria'),
  LineagePair(rank='phylum', name='Proteobacteria'),
  LineagePair(rank='class', name='Gammaproteobacteria'),
  LineagePair(rank='order', name='Alteromonadales'),
  LineagePair(rank='family', name='Shewanellaceae'),
  LineagePair(rank='genus', name='Shewanella'),
  LineagePair(rank='species', name='Shewanella baltica'),
  LineagePair(rank='strain', name='Shewanella baltica OS185')),
 (LineagePair(rank='superkingdom', name='Bacteria'),
  LineagePair(rank='phylum', name='Proteobacteria'),
  LineagePair(rank='class', name='Gammaproteobacteria'),
  LineagePair(rank='order', name='Alteromonadales'),
  LineagePair(rank='family', name='Shewanellaceae'),
  LineagePair(rank='genus', name='Shewanella'),
  LineagePair(rank='species', name='Shewanella baltica'),
  LineagePair(rank='strain', name='Shewanella baltica OS223'))}
```

sourmash also includes functions to summarize assignments by counting the number of times a particular lineage occurs; this is used by `sourmash lca classify` and `sourmash lca summarize`.

```
[29]:
```

```
counter = sourmash.lca.count_lca_for_assignments(assignments)

# count_lca_for_assignments returns a collections.Counter object
for lineage, count in counter.most_common():
    print(f"{count} hashes have LCA: {sourmash.lca.display_lineage(lineage)}")
```

```
311 hashes have LCA: Bacteria;Proteobacteria;Gammaproteobacteria;Alteromonadales;Shewanellaceae;Shewanella;Shewanella baltica;Shewanella baltica OS185
183 hashes have LCA: Bacteria;Proteobacteria;Gammaproteobacteria;Alteromonadales;Shewanellaceae;Shewanella;Shewanella baltica
```

### Other pointers[¶](#Other-pointers "Link to this heading")

[Sourmash: a practical guide](https://sourmash.readthedocs.io/en/latest/using-sourmash-a-guide.html)

[Classifying signatures taxonomically](https://sourmash.readthedocs.io/en/latest/classifying-signatures.html)

[Pre-built search databases](https://sourmash.readthedocs.io/en/latest/databases.html)

### A full list of notebooks[¶](#A-full-list-of-notebooks "Link to this heading")

[An introduction to k-mers for genome comparison and analysis](kmers-and-minhash.html)

[Some sourmash command line examples!](sourmash-examples.html)

[Working with private collections of signatures.](sourmash-collections.html)

Using the LCA\_Database API.

[![Logo](_static/logo.png)

# sourmash](index.html)

Quickly search, compare, and analyze genomic and metagenomic data sets

### Navigation

* [Tutorials and examples](sidebar.html)
* [How-To Guides](sidebar.html#how-to-guides)
* [Frequentl