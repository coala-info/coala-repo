---
name: mapgl
description: The mapgl tool performs phylogenetic mapping to label genomic regions as orthologous, gained, or lost across species using a maximum-parsimony algorithm. Use when user asks to label genomic regions by evolutionary history, predict feature presence in a common ancestor, or track the gain and loss of regulatory elements across a phylogenetic tree.
homepage: https://github.com/adadiehl/mapGL
---


# mapgl

## Overview
The `mapgl` tool performs phylogenetic mapping to label genomic regions as orthologous, gained in a query species, or lost in a target species. By utilizing chained alignment files and a Newick-formatted tree, it applies a maximum-parsimony algorithm to predict the presence or absence of a feature in the Most Recent Common Ancestor (MRCA). This is essential for comparative genomics workflows where researchers need to track the evolutionary dynamics of regulatory elements or other short sequence features across multiple species.

## Installation
The recommended way to install `mapgl` is via Bioconda:
```bash
conda install -c bioconda mapgl
```

## Core CLI Usage
The basic execution requires an input BED file, a Newick tree, species names, and alignment files.

```bash
mapGL.py input.bed tree.nwk query_name target_name query.target.chain.gz [query.outgroup.chain.gz ...]
```

### Required Arguments
- `input`: Input regions in BED or narrowPeak format.
- `tree`: Phylogenetic tree in standard Newick format (branch lengths are ignored).
- `qname`: Name of the query species (must match the name in the tree).
- `tname`: Name of the target species (must match the name in the tree).
- `alignments`: One or more `.chain` or `.pkl` files. 

## Expert Tips and Best Practices

### 1. Alignment File Naming Convention
`mapgl` identifies which alignment file belongs to which species based on the filename. Files must follow the convention: `qname.tname[...].chain.gz`. 
*Example*: If your query species is `hg38` and your target is `mm10`, the alignment file must be named `hg38.mm10.chain.gz`.

### 2. Tuning Mapping Stringency
Use the `-t` (threshold) parameter to control the required overlap for an element to be considered "mapped":
- `-t 0.0` (Default): Accepts a single-base overlap.
- `-t 1.0`: Requires the full length of the element to map.
- **Tip**: For high-confidence orthologs, a threshold of `0.5` to `0.8` is often preferred.

### 3. Handling Ambiguous Parsimony
When the root state of the tree cannot be determined, the tool defaults to a "gain" priority.
- Use `-n` (`--no_prune`) to disable disambiguation and explicitly label these features as `ambiguous`.
- Use `-p {gain,loss}` to set the priority. Use `-p loss` if you want to prioritize sequence loss (assigning presence to the root) or `-p gain` to prioritize sequence gain (assigning absence to the root).

### 4. Managing Gaps and Insertions
Use the `-g` (`--gap`) option to ignore elements containing large insertions or deletions. By default (`-1`), gaps of any size are allowed. Setting this to a positive integer will filter out elements where a gap exceeds that size in the alignment.

### 5. Mapping Convention for Split Alignments
By default, `mapgl` follows the `liftOver` convention: it keeps elements spanning multiple chains and reports the longest aligned segment. 
- **Warning**: Do not use `-d` (`--drop_split`) unless you have a specific reason to follow the older `bnMapper` convention of dropping these elements, as it can lead to false "loss" predictions for orthologous regions split by rearrangements.

### 6. Full Tree Labeling
If you are interested in events across the entire phylogeny rather than just the query and target branches, use the `-f` (`--full_labels`) flag. This will output a comma-delimited list of all gain/loss events detected on all branches of the provided tree.

## Output Interpretation
The output is tab-delimited. The most critical column is `status`:
- `ortholog`: Element exists in both query and target.
- `gain_[qname]`: Element is present in query but was likely absent in the MRCA.
- `loss_[tname]`: Element is present in query and was likely present in the MRCA, but is absent in the target.
- `ambiguous`: Only appears if `-n` is used and the state cannot be resolved.

## Reference documentation
- [mapGL GitHub Repository](./references/github_com_adadiehl_mapGL.md)
- [Bioconda mapgl Overview](./references/anaconda_org_channels_bioconda_packages_mapgl_overview.md)