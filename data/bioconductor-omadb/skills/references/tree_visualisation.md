# Exploring Taxonomic trees with OmaDB

#### Klara Kaleb

#### 2025-10-30

Using OmaDB, a user can easily obtain a taxonomic tree of interest using the getTaxonomy structure. The tree can be restricted to a certain root or by a list of members and the data is returned in the newick format. The newick can then be exported and used to create a tree object using ape which can then be visualised using ggtree.

This is done below using the getTaxonomy(root=‘Alveolata’) function, the output of which is below.

```
library(OmaDB)

load('../data/taxonomy.rda')

getObjectAttributes(taxonomy)
```

```
## [1] "root_taxon : NULL"
## [1] "newick : character"
```

The tree can be further analysed and annotated using the ggtree package also available in Bioconductor. This can easily be done using the getTree() function in OmaDB.