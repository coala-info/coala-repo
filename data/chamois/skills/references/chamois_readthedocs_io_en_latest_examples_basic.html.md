[Skip to main content](#main-content)

Back to top

`Ctrl`+`K`

[![](../_static/logo.png)
![](../_static/logo.png)

CHAMOIS](../index.html)

* [User Guide](../guide/index.html)
* [Examples](index.html)
* [Figures](../figures/index.html)
* [CLI Reference](../cli/index.html)
* [API Reference](../api/index.html)
* More
  + [Preprint](https://www.biorxiv.org/content/10.1101/2025.03.13.642868)

Search
`Ctrl`+`K`

* [GitHub](https://github.com/zellerlab/CHAMOIS "GitHub")
* [PyPI](https://pypi.org/project/chamois-tool "PyPI")

Search
`Ctrl`+`K`

* [User Guide](../guide/index.html)
* [Examples](index.html)
* [Figures](../figures/index.html)
* [CLI Reference](../cli/index.html)
* [API Reference](../api/index.html)
* [Preprint](https://www.biorxiv.org/content/10.1101/2025.03.13.642868)

* [GitHub](https://github.com/zellerlab/CHAMOIS "GitHub")
* [PyPI](https://pypi.org/project/chamois-tool "PyPI")

Section Navigation

* Basic functionalities
* [Explain a prediction](explain.html)

* [Examples](index.html)
* Basic functionalities

# Basic functionalities[#](#Basic-functionalities "Link to this heading")

The easiest way to get a prediction with CHAMOIS is to run the `chamois predict` command with a query BGC given as a GenBank record. For now, let’s use [BGC0000703](https://mibig.secondarymetabolites.org/repository/BGC0000703.4/index.html#r1c1), the MIBiG BGC producing [kanamycin](https://pubchem.ncbi.nlm.nih.gov/compound/6032) in *Streptomyces kanamyceticus*. The record was pre-downloaded from MIBiG in GenBank format.

Note

This notebook calls the CHAMOIS CLI with the `chamois.cli.run` function. This is equivalent to calling the `chamois` command line in your shell, it’s only done here to integrate with the documentation generator. For instance, calling:

```
chamois.cli.run(["predict"])
```

is equivalent to running

```
$ chamois predict
```

in the console.

```
[1]:
```

```
import chamois.cli
chamois.__version__
```

```
[1]:
```

```
'0.2.2'
```

## Running predictions[#](#Running-predictions "Link to this heading")

Use the `chamois predict` command to run ChemOnt class predictions with CHAMOIS:

```
[2]:
```

```
# $ chamois predict -i data/BGC0000703.4.gbk -o data/BGC0000703.4.hdf5
chamois.cli.run(["predict", "-i", "data/BGC0000703.4.gbk", "-o", "data/BGC0000703.4.hdf5"])
```

```
     Loading embedded model
```

```
     Loading BGCs from 'data/BGC0000703.4.gbk'
```

```
     Warning install "ipywidgets" for Jupyter support
```

```
      Loaded 1 BGCs from 'data/BGC0000703.4.gbk'
```

```
     Finding genes with Pyrodigal
```

```
       Found 30 proteins in 1 clusters
```

```
   Searching protein domains with HMMER
```

```
       Found 60 domains under inclusion threshold in 30 proteins
```

```
  Predicting chemical class probabilities
```

```
   Computing information content of predictions
```

```
      Saving result probabilities to 'data/BGC0000703.4.hdf5'
```

```
[2]:
```

```
0
```

The resulting HDF5 file can be opened with the `anndata` package for further analysis:

```
[3]:
```

```
import anndata
data = anndata.read_h5ad("data/BGC0000703.4.hdf5")
data
```

```
[3]:
```

```
AnnData object with n_obs × n_vars = 1 × 539
    obs: 'source', 'length', 'genes', 'ic'
    var: 'name', 'description', 'n_positives', 'information_accretion'
    uns: 'chamois'
```

The observations (`data.obs`) store the metadata about the query BGCs:

```
[4]:
```

```
data.obs
```

```
[4]:
```

|  | source | length | genes | ic |
| --- | --- | --- | --- | --- |
| BGC0000703 | data/BGC0000703.4.gbk | 33678 | 30 | 37.269656 |

The variables (`data.var`) store the metadata about the chemical classes predicted by the CHAMOIS predictor.

```
[5]:
```

```
data.var
```

```
[5]:
```

|  | name | description | n\_positives | information\_accretion |
| --- | --- | --- | --- | --- |
| CHEMONTID:0000002 | Organoheterocyclic compounds | Compounds containing a ring with least one car... | 1325 | 0.000000 |
| CHEMONTID:0000004 | Organosulfur compounds | Organic compounds containing a carbon-sulfur b... | 170 | 0.000000 |
| CHEMONTID:0000007 | Amidines | Derivatives of oxoacids RnE(=O)OH in which the... | 35 | 5.197146 |
| CHEMONTID:0000011 | Carbohydrates and carbohydrate conjugates | Monosaccharides, disaccharides, oligosaccharid... | 341 | 2.203840 |
| CHEMONTID:0000012 | Lipids and lipid-like molecules | Fatty acids and their derivatives, and substan... | 679 | 0.000000 |
| ... | ... | ... | ... | ... |
| CHEMONTID:0004808 | Alpha-haloketones | Organic compounds contaning a halogen atom att... | 7 | 6.056831 |
| CHEMONTID:0004809 | Alpha-chloroketones | Organic compounds contaning a chlorine atom at... | 7 | -0.000000 |
| CHEMONTID:0004817 | 2-heteroaryl carboxamides | Compounds containing a heteroaromatic ring tha... | 53 | 3.881258 |
| CHEMONTID:0004830 | Dipeptides | Organic compounds containing a sequence of exa... | 62 | 2.403356 |
| CHEMONTID:0004831 | Oligopeptides | Organic compounds containing a sequence of bet... | 102 | 1.685127 |

539 rows × 4 columns

## Visualizing results[#](#Visualizing-results "Link to this heading")

The resulting file is a HDF5 format file contains the class probabilities for each of the records in the input GenBank file. The CLI can be used to quickly inspect the predicted classes:

```
[6]:
```

```
# $ chamois render -i data/BGC0000703.4.hdf5
chamois.cli.run(["render", "-i", "data/BGC0000703.4.hdf5"])
```

```
     Loading embedded model
```

```
     Loading probability predictions from 'data/BGC0000703.4.hdf5'
```

```
╭─────────────────────────────────── BGC0000703 ────────────────────────────────────╮
│ CHEMONTID:0000002 (Organoheterocyclic compounds): 0.924                           │
│ ├── CHEMONTID:0002012 (Oxanes): 0.924                                             │
│ └── CHEMONTID:0004140 (Oxacyclic compounds): 0.908                                │
│ CHEMONTID:0004150 (Hydrocarbon derivatives): 0.997                                │
│ CHEMONTID:0004557 (Organopnictogen compounds): 0.709                              │
│ CHEMONTID:0004603 (Organic oxygen compounds): 0.999                               │
│ └── CHEMONTID:0000323 (Organooxygen compounds): 0.999                             │
│     ├── CHEMONTID:0000011 (Carbohydrates and carbohydrate conjugates): 0.918      │
│     │   ├── CHEMONTID:0001540 (Monosaccharides): 0.814                            │
│     │   ├── CHEMONTID:0002105 (Glycosyl compounds): 0.744                         │
│     │   │   └── CHEMONTID:0002207 (O-glycosyl compounds): 0.744                   │
│     │   └── CHEMONTID:0003305 (Aminosaccharides): 0.918                           │
│     │       └── CHEMONTID:0000282 (Aminoglycosides): 0.918                        │
│     │           └── CHEMONTID:0001675 (Aminocyclitol glycosides): 0.918           │
│     ├── CHEMONTID:0000129 (Alcohols and polyols): 0.990                           │
│     │   ├── CHEMONTID:0001292 (Cyclic alcohols and derivatives): 0.953            │
│     │   │   └── CHEMONTID:0002509 (Cyclitols and derivatives): 0.891              │
│     │   │       └── CHEMONTID:0002510 (Aminocyclitols and derivatives): 0.876     │
│     │   ├── CHEMONTID:0001661 (Secondary alcohols): 0.969                         │
│     │   │   └── CHEMONTID:0002647 (Cyclohexanols): 0.906                          │
│     │   ├── CHEMONTID:0001670 (Tertiary alcohols): 0.516                          │
│     │   └── CHEMONTID:0002286 (Polyols): 0.721                                    │
│     └── CHEMONTID:0000254 (Ethers): 0.634                                         │
│         └── CHEMONTID:0001656 (Acetals): 0.634                                    │
│ CHEMONTID:0004707 (Organic nitrogen compounds): 0.992                             │
│ └── CHEMONTID:0000278 (Organonitrogen compounds): 0.992                           │
│     ├── CHEMONTID:0002449 (Amines): 0.971                                         │
│     │   ├── CHEMONTID:0002450 (Primary amines): 0.971                             │
│     │   │   └── CHEMONTID:0000469 (Monoalkylamines): 0.971                        │
│     │   └── CHEMONTID:0002460 (Alkanolamines): 0.745                              │
│     │       └── CHEMONTID:0001897 (1,2-aminoalcohols): 0.654                      │
│     └── CHEMONTID:0002674 (Cyclohexylamines): 0.876                               │
╰───────────────────────────────────────────────────────────────────────────────────╯
```

```
[6]:
```

```
0
```

## Screening predictions[#](#Screening-predictions "Link to this heading")

Once predictions have been made, they can be screened with a particular query metabolite to see which BGC is the most likely to predict that metabolite. Let’s try with the kanamycin as a sanity check. Molecules can be passed to `chamois compare` as either SMILES, InChi, or InChi Key.

Info

Passing a SMILES or an InChi requires the additional Python dependency `rdkit` to handle conversion to InChi Key.

```
[7]:
```

```
# $ chamois compare -i data/BGC0000703.4.hdf5 -q SBUJHOSQTJFQJX-NOAMYHISSA-N --render
chamois.cli.run(["compare", "-i", "data/BGC0000703.4.hdf5", "-q", 'SBUJHOSQTJFQJX-NOAMYHISSA-N', "--render" ])
```

```
     Loading embedded model
```

```
     Loading probability predictions from 'data/BGC0000703.4.hdf5'
```

```
  Retrieving 1 ClassyFire results for SBUJHOSQTJFQJX-NOAMYHISSA-N
```

```
   Computing distances to predictions
```

```
╭───────────── SBUJHOSQTJFQJX-NOAMYHISSA-N ─────────────╮╭─────── BGC0000703 (Jaccard=0.94 Distance=0.40) ────────╮
│ CHEMONTID:0000002 (Organoheterocyclic compounds): 1.… ││ CHEMONTID:0000002 (Organoheterocyclic compounds): 0.9… │
│ ├── CHEMONTID:0002012 (Oxanes): 1.000                 ││ ├── CHEMONTID:0002012 (Oxanes): 0.924                  │
│ └── CHEMONTID:0004140 (Oxacyclic compounds): 1.000    ││ └── CHEMONTID:0004140 (Oxacyclic compounds): 0.908     │
│ CHEMONTID:0004150 (Hydrocarbon derivatives): 1.000    ││ CHEMONTID:0004150 (Hydrocarbon derivatives): 0.997     │
│ CHEMONTID:0004557 (Organopnictogen compounds): 1.000  ││ CHEMONTID:0004557 (Organopnictogen compounds): 0.709   │
│ CHEMONTID:0004603 (Organic oxygen compounds): 1.000   ││ CHEMONTID:0004603 (Organic oxygen compounds): 0.999    │
│ └── CHEMONTID:0000323 (Organooxygen compounds): 1.000 ││ └── CHEMONTID:0000323 (Organooxygen compounds): 0.999  │
│     ├── CHEMONTID:0000011 (Carbohydrates and carbohy… ││     ├── CHEMONTID:0000011 (Carbohydrates and carbohyd… │
│     │   ├── CHEMONTID:0001540 (Monosaccharides): 1.0… ││     │   ├── CHEMONTID:0001540 (Monosaccharides): 0.814 │
│     │   ├── CHEMONTID:0002105 (Glycosyl compounds): … ││     │   ├── CHEMONTID:0002105 (Glycosyl compounds): 0… │
│     │   │   └── CHEMONTID:0002207 (O-glycosyl compou… ││     │   │   └── CHEMONTID:0002207 (O-glycosyl compoun… │
│     │   └── CHEMONTID:0003305 (Aminosaccharides): 1.… ││     │   └── CHEMONTID:0003305 (Aminosaccharides): 0.9… │
│     │       └── CHEMONTID:0000282 (Aminoglycosides):… ││     │       └── CHEMONTID:0000282 (Aminoglycosides): … │
│     │           └── CHEMONTID:0001675 (Aminocyclitol… ││     │           └── CHEMONTID:0001675 (Aminocyclitol … │
│     ├── CHEMONTID:0000129 (Alcohols and polyols): 1.… ││     ├── CHEMONTID:0000129 (Alcohols and polyols): 0.9… │
│     │   ├── CHEMONTID:0000286 (Primary alcohols): 1.… ││     │   ├── CHEMONTID:0001292 (Cyclic alcohols and de… │
│     │   ├── CHEMONTID:0001292 (Cyclic alcohols and d… ││     │   │   └── CHEMONTID:0002509 (Cyclitols and deri… │
│     │   │   └── CHEMONTID:0002509 (Cyclitols and der… ││     │   │       └── CHEMONTID:0002510 (Aminocyclitols… │
│     │   │       └── CHEMONTID:0002510 (Aminocyclitol… ││     │   ├── CHEMONTID:0001661 (Secondary alcohols): 0… │
│     │   ├── CHEMONTID:0001661 (Secondary alcohols): … ││     │   │   └── CHEMONTID:0002647 (Cyclohexanols): 0.… │
│     │   │   └── CHEMONTID:0002647 (Cyclohexanols): 1… ││     │   ├── CHEMONTID:0001670 (Tertiary alcohols): 0.… │
│     │   └── CHEMONTID:0002286 (Polyols): 1.000        ││     │   └── CHEMONTID:0002286 (Polyols): 0.721         │
│     └── CHEMONTID:0000254 (Ethers): 1.000             ││     └── CHEMONTID:0000254 (Ethers): 0.634              │
│         └── CHEMONTID:0001656 (Acetals): 1.000        ││         └── CHEMONTID:0001656 (Acetals): 0.634         │
│ CHEMONTID:0004707 (Organic nitrogen compounds): 1.000 ││ CHEMONTID:0004707 (Organic nitrogen compounds): 0.992  │
│ └── CHEMONTID:0000278 (Organonitrogen compounds): 1.… ││ └── CHEMONTID:0000278 (Organonitrogen compounds): 0.9… │
│     ├── CHEMONTID:0002449 (Amines): 1.000             ││     ├── CHEMONTID:0002449 (Amines): 0.971              │
│     │   ├── CHEMONTID:0002450 (Primary amines): 1.000 ││     │   ├── CHEMONTID:0002450 (Primary amines): 0.971  │
│     │   │   └── CHEMONTID:0000469 (Monoalkylamines):… ││     │   │   └── CHEMONTID:0000469 (Monoalkylamines): … │
│     │   └── CHEMONTID:0002460 (Alkanolamines): 1.000  ││     │   └── CHEMONTID:0002460 (Alkanolamines): 0.745   │
│     │       └── CHEMONTID:0001897 (1,2-aminoalcohols… ││     │       └── CHEMONTID:0001897 (1,2-aminoalcohols)… │
│     └── CHEMONTID:0002674 (Cyclohexylamines): 1.000   ││     └── CHEMONTID:0002674 (Cyclohexylamines): 0.876    │
╰───────────────────────────────────────────────────────╯╰────────────────────────────────────────────────────────╯
```

```
[7]:
```

```
0
```

## Searching a catalog[#](#Searching-a-catalog "Link to this heading")

Warning

This feature is experimental and has not been properly evaluated. Use with caution.

The predictions can be used to search a catalog of compounds encoded as a `classes.hdf5` file, similar to what CHAMOIS uses for training. For instance, we can search which compound of MIBiG 3.1 is most similar to our prediction; hopefully we should get BGC0000703 among the top hits:

```
[8]:
```

```
# $ chamois search -i data/BGC0000703.4.hdf5 --catalog ../../data/datasets/mibig3.1/classes.hdf5 --render
chamois.cli.run(["search", "-i", "data/BGC0000703.4.hdf5", "--catalog", "../../data/datasets/mibig3.1/classes.hdf5", "--render"])
```

```
     Loading embedded model
```

```
     Loading probability predictions from 'data/BGC0000703.4.hdf5'
```

```
     Loading compound catalog from '../../data/datasets/mibig3.1/classes.hdf5'
```

```
   Computing pairwise distances and ranks
```

```
┏━━━━━━━━━━━━┳━━━━━━━━━━━━┳━━━━━━━━━━━┳━━━━━━━━━━┓
┃ BGC        ┃ Index      ┃ Compound  ┃ Distance ┃
┡━━━━━━━━━━━━╇━━━━━━━━━━━━╇━━━━━━━━━━━╇━━━━━━━━━━┩
│ BGC0000703 │ BGC0000703 │ kanamycin │ 0.40485  │
│            │ BGC0000702 │ kanamycin │ 0.40485  │
│            │ BGC0000704 │ kanamycin │ 0.40485  │
│            │ BGC0000706 │ kanamycin │ 0.40485  │
│            │ BGC0000705 │ kanamycin │ 0.40485  │
└────────────┴────────────┴───────────┴──────────┘
```

```
[8]:
```

```
0
```

## Interpreting a prediction[#](#Interpreting-a-prediction "Link to this heading")

The `chamois explain` command allows obtaini