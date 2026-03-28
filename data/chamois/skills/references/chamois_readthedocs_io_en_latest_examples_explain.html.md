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

* [Basic functionalities](basic.html)
* Explain a prediction

* [Examples](index.html)
* Explain a prediction

# Explain a prediction[#](#Explain-a-prediction "Link to this heading")

This model demonstrates the use of the CHAMOIS API to establish links between the genes of a query cluster and the ChemOnt classes of the putative metabolite as predicted by CHAMOIS.

```
[1]:
```

```
import chamois
chamois.__version__
```

```
[1]:
```

```
'0.2.2'
```

## Loading data[#](#Loading-data "Link to this heading")

Use `gb-io` to load the GenBank record for a cluster into a dedicated `ClusterSequence` object. Let’s use [AB746937.1](https://www.ncbi.nlm.nih.gov/nuccore/AB746937.1), the biosynthetic gene cluster for [muraminomicin](https://pubchem.ncbi.nlm.nih.gov/compound/145720725) found in *Streptosporangium amethystogenes*.

```
[2]:
```

```
import gb_io
import chamois.model
records = gb_io.load("data/AB746937.1.gbk")
clusters = [chamois.model.ClusterSequence(records[0])]
```

## Calling genes[#](#Calling-genes "Link to this heading")

You can use the `chamois.orf` module to call the genes inside one or more `ClusterSequence` objects. Since the source GenBank record has already gene called (in `CDS` features, with the gene name added in the `/protein_id` qualifier), we can skip gene calling and simply extract the already-present genes. For this, we use a `CDSFinder`:

```
[3]:
```

```
from chamois.orf import CDSFinder
orf_finder = CDSFinder(locus_tag="protein_id")
proteins = list(orf_finder.find_genes(clusters))
```

## Extracting features[#](#Extracting-features "Link to this heading")

Once we have a list of proteins, we need to annotate them with protein domains. CHAMOIS is distributed with the Pfam HMMs required by the CHAMOIS predictor, so we can simply use these and run the default annotation with a `PfamAnnotator` object:

```
[4]:
```

```
from chamois.domains import PfamAnnotator
annotator = PfamAnnotator()
domains = list(annotator.annotate_domains(proteins))
```

## Building compositional matrices[#](#Building-compositional-matrices "Link to this heading")

We now have a list of domains, but we want to turn these domains into a matrix of presence/absence of each Pfam domain in each gene cluster. To do so, let’s first load the trained CHAMOIS predictor, so we know which features we need to extract:

```
[5]:
```

```
from chamois.predictor import ChemicalOntologyPredictor
predictor = ChemicalOntologyPredictor.trained()
```

Then simply build the observations table (from the source clusters), and the actual compositional data matrix, returned as an `AnnData` object to preserve observation and feature metadata:

```
[6]:
```

```
import chamois.compositions
obs = chamois.compositions.build_observations(clusters)
data = chamois.compositions.build_compositions(domains, obs, predictor.features_)
data
```

```
[6]:
```

```
AnnData object with n_obs × n_vars = 1 × 896
    obs: 'length'
    var: 'name', 'description', 'kind'
```

```
[7]:
```

```
data.var_vector(clusters[0].id)
```

```
[7]:
```

```
array([0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0,
       0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0,
       1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1,
       1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0,
       1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0,
       0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0,
       1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
       0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0,
       1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0,
       1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
       0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
```

## Infer chemical classes[#](#Infer-chemical-classes "Link to this heading")

With the compositional matrix ready, we can simply call the `predict_probas` method on the predictor to get the class probabilities predicted by CHAMOIS:

```
[8]:
```

```
probas = predictor.predict_probas(data)
```

`probas` is a NumPy array containing probabilities for each of the classes of the model. We can turn these predictions into a table retaining the metadata from the original predictor:

```
[9]:
```

```
classes = predictor.classes_.copy()
classes['probability'] = probas[0]
classes[classes['probability'] > 0.5]
```

```
[9]:
```

|  | name | description | n\_positives | information\_accretion | probability |
| --- | --- | --- | --- | --- | --- |
| CHEMONTID:0000002 | Organoheterocyclic compounds | Compounds containing a ring with least one car... | 1325 | 0.000000 | 0.999824 |
| CHEMONTID:0000011 | Carbohydrates and carbohydrate conjugates | Monosaccharides, disaccharides, oligosaccharid... | 341 | 2.203840 | 0.996191 |
| CHEMONTID:0000012 | Lipids and lipid-like molecules | Fatty acids and their derivatives, and substan... | 679 | 0.000000 | 0.991993 |
| CHEMONTID:0000013 | Amino acids, peptides, and analogues | Organic compounds containing an amino acid or ... | 851 | 0.575324 | 0.652714 |
| CHEMONTID:0000050 | Lactones | Cyclic esters of hydroxy carboxylic acids, con... | 410 | 1.692297 | 0.906615 |
| CHEMONTID:0000075 | Pyrimidines and pyrimidine derivatives | Compounds containing a pyrimidne ring, which i... | 79 | 0.340075 | 0.664085 |
| CHEMONTID:0000129 | Alcohols and polyols | Organic compounds in which at least one hydrox... | 1075 | 0.547347 | 0.996302 |
| CHEMONTID:0000160 | Lactams | Compounds containing a lactam ring, which is a... | 479 | 1.467895 | 0.953170 |
| CHEMONTID:0000254 | Ethers | Compounds bearing an ether group with the form... | 603 | 1.381453 | 0.998986 |
| CHEMONTID:0000261 | Phenylpropanoids and polyketides | Organic compounds that are synthesized either ... | 517 | 0.000000 | 0.762557 |
| CHEMONTID:0000264 | Organic acids and derivatives | Compounds an organic acid or a derivative ther... | 1429 | 0.000000 | 0.999968 |
| CHEMONTID:0000265 | Carboxylic acids and derivatives | Compounds containing a carboxylic acid group w... | 1268 | 0.172451 | 0.999968 |
| CHEMONTID:0000278 | Organonitrogen compounds | Organic compounds containing a nitrogen atom. | 1284 | -0.000000 | 0.999836 |
| CHEMONTID:0000291 | Pyrimidones | Compounds that contain a pyrimidine ring, whic... | 28 | 1.496426 | 0.549593 |
| CHEMONTID:0000323 | Organooxygen compounds | Organic compounds containing a bond between a ... | 1571 | 0.002752 | 0.999788 |
| CHEMONTID:0000324 | Fatty acid esters | Carboxylic ester derivatives of a fatty acid. | 116 | 2.341691 | 0.896289 |
| CHEMONTID:0000331 | Fatty amides | Carboxylic acid amide derivatives of fatty aci... | 398 | 0.563048 | 0.978401 |
| CHEMONTID:0000346 | Dicarboxylic acids and derivatives | Organic compounds containing exactly two carbo... | 205 | 2.628859 | 0.537920 |
| CHEMONTID:0000348 | Peptides | Compounds containing an amide derived from two... | 328 | 1.375463 | 0.652714 |
| CHEMONTID:0000364 | Organic carbonic acids and derivatives | Compounds comprising the organic carbonic acid... | 69 | 4.372266 | 0.885487 |
| CHEMONTID:0000469 | Monoalkylamines | Organic compounds containing an primary alipha... | 297 | 0.147625 | 0.953351 |
| CHEMONTID:0000475 | Carboxylic acid amides | Carboxylic acid derivatives containing a carbo... | 781 | 0.472970 | 0.995798 |
| CHEMONTID:0000517 | Ureas | Compounds containing two amine groups joined b... | 33 | 1.064130 | 0.871849 |
| CHEMONTID:0001093 | Carboxylic acid derivatives | Derivatives of carboxylic acid. | 1084 | 0.226190 | 0.999872 |
| CHEMONTID:0001096 | N-acyl amines | Compounds containing a fatty acid moiety linke... | 366 | 0.120925 | 0.731227 |
| CHEMONTID:0001167 | Dialkyl ethers | Organic compounds containing the dialkyl ether... | 333 | 0.856636 | 0.998986 |
| CHEMONTID:0001238 | Carboxylic acid esters | Carboxylic acid derivatives in which the carbo... | 547 | 0.986752 | 0.998772 |
| CHEMONTID:0001346 | Diazines | Organic compounds containing a five-member het... | 100 | 3.727920 | 0.664085 |
| CHEMONTID:0001542 | Disaccharides | Compounds containing two carbohydrate moieties... | 58 | 2.555647 | 0.591085 |
| CHEMONTID:0001656 | Acetals | Compounds having the structure R2C(OR')2 ( R' ... | 274 | 1.137982 | 0.989885 |
| CHEMONTID:0001661 | Secondary alcohols | Compounds containing a secondary alcohol funct... | 816 | 0.397696 | 0.996302 |
| CHEMONTID:0001664 | Tertiary carboxylic acid amides | Compounds containing an amide derivative of ca... | 301 | 1.375559 | 0.854960 |
| CHEMONTID:0001831 | Carbonyl compounds | Organic compounds containing a carbonyl group,... | 1255 | 0.323996 | 0.927188 |
| CHEMONTID:0002012 | Oxanes | Compounds containing an oxane (tetrahydropyran... | 365 | 1.860024 | 0.987434 |
| CHEMONTID:0002105 | Glycosyl compounds | Carbohydrate derivatives in which a sugar grou... | 239 | 0.512761 | 0.899443 |
| CHEMONTID:0002202 | Hydropyrimidines | Compounds containing a hydrogenated pyrimidine... | 35 | 1.174498 | 0.664085 |
| CHEMONTID:0002207 | O-glycosyl compounds | Glycoside in which a sugar group is bonded thr... | 186 | 0.361708 | 0.855456 |
| CHEMONTID:0002449 | Amines | Compounds formally derived from ammonia by rep... | 560 | 1.197146 | 0.953351 |
| CHEMONTID:0002450 | Primary amines | Amines having the nitrogen atom linked to exac... | 329 | 0.767339 | 0.953351 |
| CHEMONTID:0003890 | Vinylogous amides | Organic compounds containing an amine group, w... | 106 | 3.752870 | 0.938973 |
| CHEMONTID:0003909 | Fatty Acyls | Organic molecules synthesized by chain elongat... | 588 | 0.207595 | 0.991993 |
| CHEMONTID:0003940 | Organic oxides | Organic compounds containing an oxide group. | 1447 | 0.121371 | 0.997032 |
| CHEMONTID:0004139 | Azacyclic compounds | Organic compounds containing an heterocycle wi... | 916 | 0.532573 | 0.972626 |
| CHEMONTID:0004140 | Oxacyclic compounds | Organic compounds containing an heterocycle wi... | 860 | 0.623584 | 0.999824 |
| CHEMONTID:0004144 | Heteroaromatic compounds | Compounds containing an aromatic ring where a ... | 484 | 1.452913 | 0.929851 |
| CHEMONTID:0004150 | Hydrocarbon derivatives | Derivatives of hydrocarbons obtained by substi... | 1584 | 0.000000 | 0.998957 |
| CHEMONTID:0004557 | Organopnictogen compounds | Compounds containing a bond between carbon a p... | 1103 | 0.000000 | 0.989550 |
| CHEMONTID:0004603 | Organic oxygen compounds | Organic compounds that contain one or more oxy... | 1574 | 0.000000 | 0.999788 |
| CHEMONTID:0004707 | Organic nitrogen compounds | Organic compounds containing a nitrogen atom. | 1284 | 0.000000 | 0.999836 |

## Build gene contribution table[#](#Build-gene-contribution-table "Link to this heading")

Now that we have the predictions, we can inspect the model to explain which genes of the cluster contributed to the prediction of each class. This can be done in the command line with the `chamois explain cluster` subcommand, or programmatically:

```
[10]:
```

```
from chamois.cli.explain import build_genetable
genetable = build_genetable(proteins, domains, predictor, probas).set_index("class")
genetable
```

```
[10]:
```

|  | name | probability | BAM98946.1 | BAM98947.1 | BAM98948.1 | BAM98949.1 | BAM98950.1 | BAM98951.1 | BAM98952.1 | BAM98953.1 | ... | BAM98989.1 | BAM98990.1 | BAM98991.1 | BAM98992.1 | BAM98993.1 | BAM98994.1 | BAM98995.1 | BAM98996.1 | BAM98997.1 | BAM98998.1 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| class |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| CHEMONTID:0000002 | Organoheterocyclic compounds | 0.999824 | 0.229691 | -0.996043 | 0.000000 | 0.000000 | 0.000000 | 0.415219 | 0.0 | 0.000000 | ... | 0.0 | 0.366459 | 1.001705 | 0.797974 | 0.757944 | -0.06379