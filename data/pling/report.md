# pling CWL Generation Report

## pling_align

### Tool Description
pling is a tool for reconstructing plasmid relationships from genome assemblies.

### Metadata
- **Docker Image**: quay.io/biocontainers/pling:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/iqbal-lab-org/pling
- **Package**: https://anaconda.org/channels/bioconda/packages/pling/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pling/overview
- **Total Downloads**: 1.4K
- **Last updated**: 2025-05-28
- **GitHub**: https://github.com/iqbal-lab-org/pling
- **Stars**: N/A
### Original Help Text
```text
usage: pling [-h] [--version] [--unimog UNIMOG]
             [--containment_distance CONTAINMENT_DISTANCE] [--dcj DCJ]
             [--regions] [--topology TOPOLOGY] [--batch_size BATCH_SIZE]
             [--sourmash] [--sourmash_threshold SOURMASH_THRESHOLD]
             [--identity IDENTITY] [--min_indel_size MIN_INDEL_SIZE]
             [--bh_connectivity BH_CONNECTIVITY]
             [--bh_neighbours_edge_density BH_NEIGHBOURS_EDGE_DENSITY]
             [--small_subcommunity_size_threshold SMALL_SUBCOMMUNITY_SIZE_THRESHOLD]
             [--output_type {html,json,both}]
             [--plasmid_metadata PLASMID_METADATA]
             [--ilp_solver {GLPK,gurobi}] [--timelimit TIMELIMIT]
             [--resources RESOURCES] [--cores CORES] [--profile PROFILE]
             [--forceall]
             genomes_list output_dir {align,skip}

positional arguments:
  genomes_list          Path to list of fasta file paths.
  output_dir            Path to output directory.
  {align,skip}          Integerisation method: "align" for alignment, "skip"
                        to skip integerisation altogether. Make sure to input
                        a unimog file if skipping integerisation.

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --unimog UNIMOG       Path to unimog file. Required input if skipping
                        integerisation. (default: None)
  --containment_distance CONTAINMENT_DISTANCE
                        Threshold for initial containment network. (default:
                        0.5)
  --dcj DCJ             Threshold for final DCJ-Indel network. (default: 4)
  --regions             Cluster regions rather than complete genomes. Assumes
                        regions are taken from circular plasmids. (default:
                        False)
  --topology TOPOLOGY   File stating whether plasmids are circular or linear.
                        Must be a tsv with two columns, one with plasmid IDs
                        under "plasmid" and one with "linear" or "circular" as
                        entries under "topology". Without this file, pling
                        will asume all plasmids are circular. (default: None)
  --batch_size BATCH_SIZE
                        How many pairs of genomes to run together in one go
                        (for integerisation from alignment and DCJ calculation
                        steps). (default: 200)
  --sourmash            Run sourmash as first filter on which pairs to
                        calculate DCJ on. Recommended for large and very
                        diverse datasets. (default: False)
  --sourmash_threshold SOURMASH_THRESHOLD
                        Threshold for filtering with sourmash. (default: 0.85)
  --identity IDENTITY   Threshold for percentage of shared sequence between
                        blocks (for integerisation from alignment and for
                        containment calculation). (default: 80)
  --min_indel_size MIN_INDEL_SIZE
                        Minimum size for an indel to be treated as a block
                        (for integerisation from alignment). (default: 200)
  --bh_connectivity BH_CONNECTIVITY
                        Minimum number of connections a plasmid need to be
                        considered a hub plasmid. (default: 10)
  --bh_neighbours_edge_density BH_NEIGHBOURS_EDGE_DENSITY
                        Maximum number of edge density between hub plasmid
                        neighbours to label the plasmid as hub. (default: 0.2)
  --small_subcommunity_size_threshold SMALL_SUBCOMMUNITY_SIZE_THRESHOLD
                        Communities with size up to this parameter will be
                        joined to neighbouring larger subcommunities.
                        (default: 4)
  --output_type {html,json,both}
                        Whether to output networks as html visualisations,
                        cytoscape formatted json, or both. (default: html)
  --plasmid_metadata PLASMID_METADATA
                        Metadata to add beside plasmid ID on the visualisation
                        graph. Must be a tsv with a single column, with data
                        in the same order as in genomes_list. (default: None)
  --ilp_solver {GLPK,gurobi}
                        ILP solver to use. Default is GLPK, which is slower
                        but is bundled with pling and is free. If using
                        gurobi, make sure you have a valid license and
                        gurobi_cl is in your PATH. (default: GLPK)
  --timelimit TIMELIMIT
                        Time limit in seconds for ILP solver. (default: None)
  --resources RESOURCES
                        tsv stating number of threads and memory to use for
                        each rule. (default: None)
  --cores CORES         Total number of cores/threads. Put the maximum number
                        of threads you request in the resources tsv here.
                        (This argument is passed on to snakemake's --cores
                        argument.) (default: 1)
  --profile PROFILE     To run on a cluster with corresponding snakemake
                        profile. (default: None)
  --forceall            Force snakemake to rerun everything. (default: False)
```


## pling_skip

### Tool Description
Integerisation method: "align" for alignment, "skip" to skip integerisation altogether. Make sure to input a unimog file if skipping integerisation.

### Metadata
- **Docker Image**: quay.io/biocontainers/pling:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/iqbal-lab-org/pling
- **Package**: https://anaconda.org/channels/bioconda/packages/pling/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pling [-h] [--version] [--unimog UNIMOG]
             [--containment_distance CONTAINMENT_DISTANCE] [--dcj DCJ]
             [--regions] [--topology TOPOLOGY] [--batch_size BATCH_SIZE]
             [--sourmash] [--sourmash_threshold SOURMASH_THRESHOLD]
             [--identity IDENTITY] [--min_indel_size MIN_INDEL_SIZE]
             [--bh_connectivity BH_CONNECTIVITY]
             [--bh_neighbours_edge_density BH_NEIGHBOURS_EDGE_DENSITY]
             [--small_subcommunity_size_threshold SMALL_SUBCOMMUNITY_SIZE_THRESHOLD]
             [--output_type {html,json,both}]
             [--plasmid_metadata PLASMID_METADATA]
             [--ilp_solver {GLPK,gurobi}] [--timelimit TIMELIMIT]
             [--resources RESOURCES] [--cores CORES] [--profile PROFILE]
             [--forceall]
             genomes_list output_dir {align,skip}

positional arguments:
  genomes_list          Path to list of fasta file paths.
  output_dir            Path to output directory.
  {align,skip}          Integerisation method: "align" for alignment, "skip"
                        to skip integerisation altogether. Make sure to input
                        a unimog file if skipping integerisation.

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --unimog UNIMOG       Path to unimog file. Required input if skipping
                        integerisation. (default: None)
  --containment_distance CONTAINMENT_DISTANCE
                        Threshold for initial containment network. (default:
                        0.5)
  --dcj DCJ             Threshold for final DCJ-Indel network. (default: 4)
  --regions             Cluster regions rather than complete genomes. Assumes
                        regions are taken from circular plasmids. (default:
                        False)
  --topology TOPOLOGY   File stating whether plasmids are circular or linear.
                        Must be a tsv with two columns, one with plasmid IDs
                        under "plasmid" and one with "linear" or "circular" as
                        entries under "topology". Without this file, pling
                        will asume all plasmids are circular. (default: None)
  --batch_size BATCH_SIZE
                        How many pairs of genomes to run together in one go
                        (for integerisation from alignment and DCJ calculation
                        steps). (default: 200)
  --sourmash            Run sourmash as first filter on which pairs to
                        calculate DCJ on. Recommended for large and very
                        diverse datasets. (default: False)
  --sourmash_threshold SOURMASH_THRESHOLD
                        Threshold for filtering with sourmash. (default: 0.85)
  --identity IDENTITY   Threshold for percentage of shared sequence between
                        blocks (for integerisation from alignment and for
                        containment calculation). (default: 80)
  --min_indel_size MIN_INDEL_SIZE
                        Minimum size for an indel to be treated as a block
                        (for integerisation from alignment). (default: 200)
  --bh_connectivity BH_CONNECTIVITY
                        Minimum number of connections a plasmid need to be
                        considered a hub plasmid. (default: 10)
  --bh_neighbours_edge_density BH_NEIGHBOURS_EDGE_DENSITY
                        Maximum number of edge density between hub plasmid
                        neighbours to label the plasmid as hub. (default: 0.2)
  --small_subcommunity_size_threshold SMALL_SUBCOMMUNITY_SIZE_THRESHOLD
                        Communities with size up to this parameter will be
                        joined to neighbouring larger subcommunities.
                        (default: 4)
  --output_type {html,json,both}
                        Whether to output networks as html visualisations,
                        cytoscape formatted json, or both. (default: html)
  --plasmid_metadata PLASMID_METADATA
                        Metadata to add beside plasmid ID on the visualisation
                        graph. Must be a tsv with a single column, with data
                        in the same order as in genomes_list. (default: None)
  --ilp_solver {GLPK,gurobi}
                        ILP solver to use. Default is GLPK, which is slower
                        but is bundled with pling and is free. If using
                        gurobi, make sure you have a valid license and
                        gurobi_cl is in your PATH. (default: GLPK)
  --timelimit TIMELIMIT
                        Time limit in seconds for ILP solver. (default: None)
  --resources RESOURCES
                        tsv stating number of threads and memory to use for
                        each rule. (default: None)
  --cores CORES         Total number of cores/threads. Put the maximum number
                        of threads you request in the resources tsv here.
                        (This argument is passed on to snakemake's --cores
                        argument.) (default: 1)
  --profile PROFILE     To run on a cluster with corresponding snakemake
                        profile. (default: None)
  --forceall            Force snakemake to rerun everything. (default: False)
```


## Metadata
- **Skill**: generated
