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

[PopPUNK 2.7.0 documentation](index.html)

[![Logo](_static/poppunk_v2.png)

PopPUNK 2.7.0 documentation](index.html)

Contents:

* [PopPUNK documentation](index.html)
* [Installation](installation.html)
* [Overview](overview.html)
* [Sketching (`--create-db`)](sketching.html)
* [Data quality control (`--qc-db`)](qc.html)
* [Fitting new models (`--fit-model`)](model_fitting.html)
* [Distributing PopPUNK models](model_distribution.html)
* [Query assignment (`poppunk_assign`)](query_assignment.html)
* [Creating visualisations](visualisation.html)
* [Minimum spanning trees](mst.html)
* [Subclustering with PopPIPE](subclustering.html)
* [Using GPUs](gpu.html)
* [Troubleshooting](troubleshooting.html)
* Scripts
* [Iterative PopPUNK](poppunk_iterate.html)
* [Citing PopPUNK](citing.html)
* [Reference documentation](api.html)
* [Roadmap](roadmap.html)
* [Miscellaneous](miscellaneous.html)

Back to top

[View this page](_sources/scripts.rst.txt "View this page")

# Scripts[¶](#scripts "Link to this heading")

Brief documentation on the helper scripts included in the package in the `/scripts` directory.
To use these scripts you will need to have a clone of the git repository, or they should also be
installed with the prefix ‘poppunk’ (e.g to run `extract_distances.py`, run the command
`poppunk_extract_distances.py`).

## Easy run mode[¶](#easy-run-mode "Link to this heading")

Previous versions of the software had an `--easy-run` mode which would run a pipeline of:

* `--create-db` to sketch genomes
* `--fit-model --dbscan` to fit a flexible model
* `--refine-model` to improve this model

This is now available as `poppunk_easy_run.py` which will chain calls to `poppunk`
and `poppunk_visualise` to replicate this functionality.

## Iterative PopPUNK[¶](#iterative-poppunk "Link to this heading")

You can combine the output from multiple to produce further analysis. For an easy
way to create multiple clusters, try the `--multi-boundary` option ([Running with multiple boundary positions](model_fitting.html#multi-boundary)).

The script to analyse these is `poppunk_iterate.py`. Basic use is to provide the
output directory as `--db`, but run `--help` for other common options. This relies on
finding files named `<db>/<db>_boundary<n>_clusters.csv`, where `<n>` is the boundary
iteration number (continuous integers increasing from zero). Clusters must contain at least
two samples.

This script will do the following:

1. Starting from the most specific clusters (nearest the origin), it will iteratively
   add new clusters which are either:

   > 1. totally new clusters
   > 2. subsets of existing clusters
   > 3. existing clusters are subsets of the new cluster.
2. Remove duplicate clusters.
3. Calculate average core distance within this cluster set.
4. Create a tree by nesting smaller clusters within larger clusters they are subsets of.
5. Output the combined clusters, average core distances, and tree.
6. Cut this tree to pick a set of clusters under a similarity given by `--cutoff`.

## Adding weights to the network[¶](#adding-weights-to-the-network "Link to this heading")

Converts binary within-cluster edge weights to the Euclidean core-accessory distance.
This is equivalent to running with `--graph-weights`:

```
poppunk_add_weights <name>_graph.gt <name>.dists <output>
```

Default output is a graph-tool file. Add `--graphml` to save as .graphml instead.

## Writing the pairwise distances to an output file[¶](#writing-the-pairwise-distances-to-an-output-file "Link to this heading")

By default PopPUNK does not write the calculated \(\pi\_n\) and \(a\) distances out, as this
contains \(\frac{1}{2}n\*(n-1)\) rows, which gives a multi Gb file for large datasets.

However, if needed, there is a script available to extract these distances as a text file:

```
poppunk_extract_distances.py --distances strain_db.dists --output strain_db.dists.out
```

## Writing network components to an output file[¶](#writing-network-components-to-an-output-file "Link to this heading")

Visualisation of large networks with cytoscape may become challenging. It is possible to extract
individual components/clusters for visualisation as follows:

```
poppunk_extract_components.py strain_db_graph.gpickle strain_db
```

## Calculating Rand indices[¶](#calculating-rand-indices "Link to this heading")

This script allows the clusters formed by different runs/fits/modes of PopPUNK to be compared to each
other. 0 indicates the clusterings are totally discordant, and 1 indicates they are identical.

Run:

```
poppunk_calculate_rand_indices.py --input poppunk_gmm_clusters.csv,poppunk_dbscan_cluster.csv
```

The script will calculate the [Rand index](https://en.wikipedia.org/wiki/Rand_index#Rand_index)
and the [adjusted Rand index](https://en.wikipedia.org/wiki/Rand_index#Adjusted_Rand_index)
between all pairs of files provided (comma separated) to the `--input` argument.
These will be written to the file `rand.out`, which can be changed using `--output`.

The `--subset` argument can be used to restrict comparisons to include only specific samples
listed in the provided file.

## Calculating silhouette indices[¶](#calculating-silhouette-indices "Link to this heading")

This script can be used to find how well the clusters project into core-accessory space by
calculating the [silhoutte index](https://en.wikipedia.org/wiki/Silhouette_%28clustering%29),
which measures how close samples are to others in their own cluster compared to samples from other
clusters. The silhoutte index is calculated for every sample and takes a value between -1 (poorly matched)
to +1 (well matched). The script reports the average of these indices across all samples, using Euclidean
distances between the (normalised) core and accessory divergences calculated by PopPUNK.

To run:

```
poppunk_calculate_silhouette.py --distances strain_db.dists --cluster-csv strain_db_clusters.csv
```

The following additional options are available for use with external clusterings (e.g. from hierBAPS):

* `--cluster-col` the (1-indexed) column index containing the cluster assignment
* `--id-col` the (1-indexed) column index containing the sample names
* `--sub` a string to remove from sample names to match them to those in `--distances`

## Distributing PopPUNK models[¶](#distributing-poppunk-models "Link to this heading")

This script automatically generates compressed and uncompressed directories containing all files
required for distribution and reuse of PopPUNK model fits.

To run:

```
python poppunk_distribute_fit.py --dbdir database_directory --fitdir model_fit_directory --outpref output_prefix
```

The following additional arguments are available:

* `--lineage` specify only if lineage fit was used.
* `--no-compress` will not generate tar.bz2 archives

`--dbdir` and `--fitdir` can be the same directory, however both must still be specified.
The output of this script is a directory and a compressed tar.bz2 archive for each of the
full dataset and representative genomes dataset.

[Next

Iterative PopPUNK](poppunk_iterate.html)
[Previous

Troubleshooting](troubleshooting.html)

Copyright © 2018-2025, John Lees and Nicholas Croucher

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Scripts
  + [Easy run mode](#easy-run-mode)
  + [Iterative PopPUNK](#iterative-poppunk)
  + [Adding weights to the network](#adding-weights-to-the-network)
  + [Writing the pairwise distances to an output file](#writing-the-pairwise-distances-to-an-output-file)
  + [Writing network components to an output file](#writing-network-components-to-an-output-file)
  + [Calculating Rand indices](#calculating-rand-indices)
  + [Calculating silhouette indices](#calculating-silhouette-indices)
  + [Distributing PopPUNK models](#distributing-poppunk-models)