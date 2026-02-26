# plasnet CWL Generation Report

## plasnet_add-sample-hits

### Tool Description
Add sample hits annotations on top of previously identified subcommunities or types

### Metadata
- **Docker Image**: quay.io/biocontainers/plasnet:0.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/leoisl/plasnet
- **Package**: https://anaconda.org/channels/bioconda/packages/plasnet/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/plasnet/overview
- **Total Downloads**: 1.4K
- **Last updated**: 2026-02-23
- **GitHub**: https://github.com/leoisl/plasnet
- **Stars**: N/A
### Original Help Text
```text
Usage: plasnet add-sample-hits [OPTIONS] SUBCOMMUNITIES_PICKLE SAMPLE_HITS
                               OUTPUT_DIR

  Add sample hits annotations on top of previously identified subcommunities
  or types

Options:
  --output-type TEXT  Whether to output networks as html visualisations,
                      cytoscape formatted json, or both.
  --help              Show this message and exit.

  Add sample hits annotations on top of previously identified subcommunities or types.

  The first file, describing the subcommunities, is a pickle file (.pkl) that can be found in <type_out_dir>/objects/subcommunities.pkl,
  where <type_out_dir> is the output dir of the type command.

  The sample-hits file is a tab-separated file with 2 columns: sample, plasmid.
  These columns are self-explanatory and identifies the plasmids present in each sample.
  Example of such file:
  sample              plasmid
  cpe001_trim_ill     NZ_CP006799.1
  cpe001_trim_ill     NZ_CP028929.1
  cpe002_trim_ill     NZ_CP079159.1
  cpe005_trim_ill     NZ_CP006799.1
  cpe005_trim_ill     NZ_CP079676.1
  cpe010_trim_ill     NZ_CP028929.1
  cpe020_trim_ill     NZ_CP006799.1
  cpe020_trim_ill     NZ_CP079676.1
  cpe021_trim_ill     NZ_CP006799.1
```


## plasnet_split

### Tool Description
Creates and split a plasmid graph into communities

### Metadata
- **Docker Image**: quay.io/biocontainers/plasnet:0.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/leoisl/plasnet
- **Package**: https://anaconda.org/channels/bioconda/packages/plasnet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: plasnet split [OPTIONS] PLASMIDS DISTANCES OUTPUT_DIR

  Creates and split a plasmid graph into communities

Options:
  -d, --distance-threshold FLOAT  Distance threshold
  -b, --bh-connectivity INTEGER   Minimum number of connections a plasmid need
                                  to be considered a hub plasmid
  -e, --bh-neighbours-edge-density FLOAT
                                  Maximum number of edge density between hub
                                  plasmid neighbours to label the plasmid as
                                  hub
  -p, --output-plasmid-graph      Also outputs the full, unsplit, plasmid
                                  graph
  --output-type TEXT              Whether to output networks as html
                                  visualisations, cytoscape formatted json, or
                                  both.
  --plasmids-metadata PATH        Plasmids metadata text file.
  --graph-pickle TEXT             Existing plasmid graph to append new
                                  plasmids to.
  --prev_typing TEXT              Previous community typing, if appending to
                                  an existing plasmid graph.
  --no-community-vis
  --help                          Show this message and exit.

  Creates and split a plasmid graph into communities.
  The plasmid graph is defined by plasmid and distance files.

  The plasmid file is a tab-separated file with one column describing all plasmids in the dataset.
  Example of such file:
  plasmid
  AP024796.1
  AP024825.1
  CP012142.1
  CP014494.1
  CP019149.1
  CP021465.1
  CP022675.1
  CP024687.1
  CP026642.1
  CP027485.1

  The distances file is a tab-separated file with 3 columns: plasmid_1, plasmid_2, distance.
  plasmid_1 and plasmid_2 are plasmid names, and distance is a float between 0 and 1.
  The distance threshold is the minimum distance value for two plasmids to be considered connected.
  Example of such file:
  plasmid_1       plasmid_2       distance
  AP024796.1      AP024825.1      0.8
  AP024796.1      CP012142.1      0.5
  AP024796.1      CP014494.1      0.3
  AP024796.1      CP019149.1      0.0
  AP024796.1      CP021465.1      0.0
  AP024796.1      CP022675.1      1.0
  AP024796.1      CP024687.1      0.0
  AP024796.1      CP026642.1      0.5
  AP024796.1      CP027485.1      0.8
```


## plasnet_type

### Tool Description
Type the communities of a previously split plasmid graph into subcommunities or types

### Metadata
- **Docker Image**: quay.io/biocontainers/plasnet:0.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/leoisl/plasnet
- **Package**: https://anaconda.org/channels/bioconda/packages/plasnet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: plasnet type [OPTIONS] COMMUNITIES_PICKLE DISTANCES OUTPUT_DIR

  Type the communities of a previously split plasmid graph into subcommunities
  or types

Options:
  -d, --distance-threshold FLOAT  Distance threshold
  --small-subcommunity-size-threshold INTEGER
                                  Subcommunities with size up to this
                                  parameter will be joined to neighbouring
                                  larger subcommunities
  --output-type TEXT              Whether to output networks as html
                                  visualisations, cytoscape formatted json, or
                                  both.
  --prev_typing TEXT              Previous subcommunity typing, if it exists.
  --reclustering_method [unbiased|biased|nearest_neighbour]
                                  unbiased: If including a previous
                                  subcommunity typing, all previous and new
                                  genomes will be reclustered from scratch,
                                  ignoring previous typing. biased: The
                                  asynchronous label propagation will start
                                  with the previous typing as initial labels.
                                  nearest_neighbour: Does not cluster the new
                                  genomes, rather, assigns type based on the
                                  closest neighbour of the previous typing.
  --no-vis
  --help                          Show this message and exit.

  Type the communities of a previously split plasmid graph into subcommunities or types.
  This typing is based on running an asynchronous label propagation algorithm on the previously identified communities.
  This algorithm is implemented in the networkx library, and relies on a given distance file.
  This distance file should be a more precise and careful distance function than the one used to split the graph into communities.
  For example, you could use gene jaccard distance to split the graph and the DCJ-indel distance to type the communities.
  See https://github.com/iqbal-lab-org/pling for a tool to compute gene jaccard and DCJ-indel distances.

  The first file, describing the communities, is a pickle file (.pkl) that can be found in <split_out_dir>/objects/communities.pkl,
  where <split_out_dir> is the output dir of the split command.

  The distances file is a tab-separated file with 3 columns: plasmid_1, plasmid_2, distance.
  plasmid_1 and plasmid_2 are plasmid names, and distance is a float number.
  The distance threshold is the minimum distance value for two plasmids to be considered connected.
  Example of such file:
  plasmid_1       plasmid_2       distance
  AP024796.1      AP024825.1      4
  AP024796.1      CP012142.1      10
  AP024796.1      CP014494.1      20
  AP024796.1      CP019149.1      1
  AP024796.1      CP021465.1      0
  AP024796.1      CP022675.1      50
  AP024796.1      CP024687.1      1000
  AP024796.1      CP026642.1      20
  AP024796.1      CP027485.1      1
```

