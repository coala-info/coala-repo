[ ]
[ ]

[Skip to content](#clustering)

SADIE

Clustering

Initializing search

[jwillis0720/sadie](https://github.com/jwillis0720/sadie "Go to repository")

SADIE

[jwillis0720/sadie](https://github.com/jwillis0720/sadie "Go to repository")

* [SADIE](..)
* [Reference Database](../reference/)
* [ ]

  AIRR Sequence Annotation

  AIRR Sequence Annotation
  + [Annotating](../annotation/)
  + [Advanced Annotation Methods](../advanced_annotation/)
  + [Visualization](../visualization/)
* [Sequence Numbering](../renumbering/)
* [BCR/TCR Objects](../models/)
* [ ]
  [Clustering](./)
* [Contributing to SADIE](../contribute/)

# Clustering[¶](#clustering "Permanent link")

Clustering is handled using an input of [AirrTables](../annotation/#single-sequence-annotation). Consider the following example.

```
import pandas as pd

from sadie.airr.airrtable import LinkedAirrTable
from sadie.cluster import Cluster

# read in the bNAb data
df = pd.read_feather("hiv_bnabs.feather")

# this will create a linked heavy and light airr
# table where the unique name is called the cellid
linked_airr_table = LinkedAirrTable(df, key_column="cellid")

# setup api
cluster_api = Cluster(
    linked_airr_table,
    linkage="single",
    groupby=None,
    lookup=["cdr1_aa_heavy", "cdr2_aa_heavy", "cdr3_aa_heavy", "cdr1_aa_light", "cdr2_aa_light", "cdr3_aa_light"],
    pad_somatic=True,
)

# run the clustering with distance cutoff of 5
clustered_table = cluster_api.cluster(5)
# a column named cluster has been added to the airr table

# print out clusters but first sort by biggest cluster
gb = pd.DataFrame(clustered_table.set_index("cellid")).groupby(["cluster"])
for cluster in gb.size().sort_values(ascending=False).index:
    members = clustered_table.query(f"cluster=={cluster}")["cellid"].to_list()
    print("cluster name:", cluster, "contains", members, end="\n\n")
```

will print out:

```
cluster name: 35 contains ['PCT64-18B', 'PCT64-18C', 'PCT64-18D', 'PCT64-18F', 'PCT64-24F', 'PCT64-24G', 'PCT64-24H', 'PCT64-35B', 'PCT64-35C', 'PCT64-35D', 'PCT64-35E', 'PCT64-35F', 'PCT64-35G', 'PCT64-35H', 'PCT64-35I', 'PCT64-35K', 'PCT64-35N', 'PCT64-35O', 'PCT64-35S']

cluster name: 15 contains ['VRC26.08', 'VRC26.09', 'VRC26.20', 'VRC26.21', 'VRC26.22', 'VRC26.26', 'VRC26.27', 'VRC26.28', 'VRC26.29', 'VRC26.30', 'VRC26.31']

cluster name: 0 contains ['DH270.1', 'DH270.2', 'DH270.3', 'DH270.4', 'DH270.5', 'DH270.6', 'DH270.IA1', 'DH270.IA2', 'DH270.IA3', 'DH270.IA4']

cluster name: 1 contains ['VRC38.02', 'VRC38.03', 'VRC38.04', 'VRC38.05', 'VRC38.08', 'VRC38.09', 'VRC38.10', 'VRC38.11']

cluster name: 34 contains ['10J4', '10M6', '13I10', '2N5', '35O22', '4O20', '7B9', '7K3']

cluster name: 2 contains ['PGT151', 'PGT152', 'PGT153', 'PGT154', 'PGT155', 'PGT156', 'PGT157', 'PGT158']

...
```

So what happened here?

* We read in a `LinkedAirrTable`, which has the heavy and light table paired together. This is also a Pandas DataFrame, so we can use any Pandas method.
* Instantiate a Cluster object that contains the following parameters.

| Parameter | Description |
| --- | --- |
| `linkage` | The hierarchical clustering linkage method. [single, average or complete linkage](https://en.wikipedia.org/wiki/Hierarchical_clustering) |
| `groupby` | Do we pre-group by any fields. e.g. v\_call\_heavy will only cluster things that are the same v\_call\_heavy. |
| `lookup` | What fields to take the Levenshtein distance to make a cluster distance? |
| `pad_somatic` | Any somatic mutations that are present in both sequences will be subtracted from the total distance. This is useful for somatic hypermutation analysis. |

* Run `cluseter_api.cluster(distace)` where `distance` is a distance cutoff in hierarchical clustering. This will return an airrtable with the a field called cluster.

# A complete example[¶](#a-complete-example "Permanent link")

You will probably run this in context of a larger analysis where you use [airrtables](../annotation/#single-sequence-annotation) to create an Airr Table.

```
from sadie.airr import Airr
from sadie.airr.methods import run_mutational_analysis
from sadie.cluster import Cluster

fasta_file = "catnap.fasta"
airr_api = Airr("human", adaptable=True)
airr_table = airr_api.run_fasta(fasta_file)
airr_table_mutational = run_mutational_analysis(airr_table, "kabat", run_multiproc=False)

cluster_api = Cluster(airr_table_mutational, lookup=["cdr1_aa", "cdr2_aa", "cdr3_aa"], pad_somatic=True)

airr_table_with_cluster = cluster_api.cluster(5)
airr_table_with_cluster.sort_values("cluster")
print(airr_table_with_cluster.sort_values("cluster")[["sequence_id", "cluster"]].head(5))
```

|  | sequence\_id | cluster |
| --- | --- | --- |
| 45 | PCT64-24E\_MF565875\_PCT64-24E-HC\_anti-HIV\_immunoglobulin\_heavy\_chain\_variable\_region | 0 |
| 43 | PCT64-24A\_MF565871\_PCT64-24A-HC\_anti-HIV\_immunoglobulin\_heavy\_chain\_variable\_region | 0 |
| 44 | PCT64-24B\_MF565872\_PCT64-24B-HC\_anti-HIV\_immunoglobulin\_heavy\_chain\_variable\_region | 0 |
| 58 | PCT64-35M\_MF565891\_PCT64-35M-HC\_anti-HIV\_immunoglobulin\_heavy\_chain\_variable\_region | 0 |
| 8 | CH27\_patent\_20160244510\_CH27\_heavy\_chain | 1 |

`...`

In the example above, we did the following:

1. Read in a fasta file.
2. Annotated a fasta file
3. Ran mutational analysis on the Airr Table
4. Clustered the Airr Table
5. Printed out the cluster name and sequence id

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)