# hotspot3d CWL Generation Report

## hotspot3d_Preprocessing

### Tool Description
3D mutation proximity analysis program. Preprocessing steps include parsing drugport database, updating proximity files, and running ROI generation, statistical calculation, annotation, and prioritization.

### Metadata
- **Docker Image**: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
- **Homepage**: https://github.com/ding-lab/hotspot3d
- **Package**: https://anaconda.org/channels/bioconda/packages/hotspot3d/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hotspot3d/overview
- **Total Downloads**: 11.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ding-lab/hotspot3d
- **Stars**: N/A
### Original Help Text
```text
Please give valid sub command ! 
Program: hotspot3d - 3D mutation proximity analysis program.
Version: V1.8.2
 Author: Beifang Niu, Adam D Scott, Sohini Sengupta, John Wallis & Amila Weerasinghe

  Usage: hotspot3d <command> [options]

           Preprocessing
              drugport  --  0) Parse drugport database (OPTIONAL)
              uppro     --  1) Update proximity files
              prep      --  2) Run steps 2a-2f of preprocessing
                  calroi    --  2a) Generate region of interest (ROI) information
                  statis    --  2b) Calculate p_values for pairs of mutations
                  anno      --  2c) Add region of interest (ROI) annotation
                  trans     --  2d) Add transcript annotation 
                  cosmic    --  2e) Add COSMIC annotation to proximity file
                  prior     --  2f) Prioritization

           Analysis

              main      --  0) Run steps a-f of analysis (BETA)
                  search    --  a) 3D mutation proximity searching
                  cluster   --  b) Determine mutation-mutation and mutation-drug clusters
                  sigclus   --  c) Determine significance of clusters (BETA)
                  summary   --  d) Summarize clusters
                  visual    --  e) Visulization of 3D proximity

           help      --  this message

         SUPPORT
         For user support please email adamscott@wustl.edu
```


## hotspot3d_drugport

### Tool Description
Drugport parsing tool for HotSpot3D

### Metadata
- **Docker Image**: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
- **Homepage**: https://github.com/ding-lab/hotspot3d
- **Package**: https://anaconda.org/channels/bioconda/packages/hotspot3d/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: hotspot3d drugport [options]

                             REQUIRED
--pdb-file-dir               PDB file directory 

                             OPTIONAL
--output-file                Output file of drugport parsing, default: drugport_results

--help                       this message
```


## hotspot3d_uppro

### Tool Description
Generate proximity files for proteins using PDB data and distance measures.

### Metadata
- **Docker Image**: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
- **Homepage**: https://github.com/ding-lab/hotspot3d
- **Package**: https://anaconda.org/channels/bioconda/packages/hotspot3d/overview
- **Validation**: PASS

### Original Help Text
```text
Option h is ambiguous (help, hold)

Usage: hotspot3d uppro [options]

                             REQUIRED
--output-dir                 Output directory of proximity files
--pdb-file-dir               PDB file directory 
--measure                    Distance measure between residues (shortest or average)
--parallel                   Parallelization to use (bsub, local, or none)
                                 use bsub if you want to use an LSF server
                                 use local if you want to use your CPU (CAUTION: make sure you know your max CPU processes)
                                 use none if you want to run calpro for each protein serially

                             OPTIONAL
--max-processes              Set if using parallel type local (CAUTION: make sure you know your max CPU processes)
--gene-file                  File with HUGO gene names in the first column (like a .maf)
--3d-distance-cutoff         Maximum 3D distance (<= Angstroms), defaul: 100
--linear-distance-cutoff     Minimum linear distance (> peptides), default: 0
--cmd-list-submit-file       Batch jobs file to run calpro step in parallel, default: cmd_list_submit_file
--hold                       Do not submit batch jobs, just write cmd_list_submit_file, default: submits (takes no input)

--help                       this message
```


## hotspot3d_prep

### Tool Description
Preparation step for Hotspot3D to generate proximity files and perform various analysis steps.

### Metadata
- **Docker Image**: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
- **Homepage**: https://github.com/ding-lab/hotspot3d
- **Package**: https://anaconda.org/channels/bioconda/packages/hotspot3d/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: hotspot3d prep [options]

                                   REQUIRED
--output-dir                       Output directory of proximity files

                                   OPTIONAL
--start                            What step to start on ( calroi , statis , anno , trans , cosmic , prior ), default is calroi
--blat                             Installation of blat to use for trans (defaults to your system default)
--grch                             Genome build (37 or 38), defaults to 38 or according to --release input
--release                          Ensembl release verion (55-87), defaults to 87 or to the latest release according to --grch input
                                       Note that releases 55-75 correspond to GRCh37 & 76-87 correspond to GRCh38
--p-value-cutoff                   p_value cutoff(<=) for prior, default is 0.05
--3d-distance-cutoff               3D distance cutoff (<= Angstroms) for prior, default is 20
--linear-cutoff                    Linear distance cutoff (> peptides) for prior, default is 0


--help                       this message
```


## hotspot3d_calroi

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
- **Homepage**: https://github.com/ding-lab/hotspot3d
- **Package**: https://anaconda.org/channels/bioconda/packages/hotspot3d/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: hotspot3d calroi [options]

                             REQUIRED
--output-dir                 Output directory of proximity files

--help                       this message
```


## hotspot3d_statis

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
- **Homepage**: https://github.com/ding-lab/hotspot3d
- **Package**: https://anaconda.org/channels/bioconda/packages/hotspot3d/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: hotspot3d statis [options]

                             REQUIRED
--output-dir                 Output directory of proximity files

--help                       this message
```


## hotspot3d_anno

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
- **Homepage**: https://github.com/ding-lab/hotspot3d
- **Package**: https://anaconda.org/channels/bioconda/packages/hotspot3d/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: hotspot3d anno [options]

                             REQUIRED
--output-dir                 Output directory of proximity files

--help                       this message
```


## hotspot3d_trans

### Tool Description
Generate proximity files for 3D hotspots

### Metadata
- **Docker Image**: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
- **Homepage**: https://github.com/ding-lab/hotspot3d
- **Package**: https://anaconda.org/channels/bioconda/packages/hotspot3d/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: hotspot3d trans [options]

                             REQUIRED
--output-dir                 Output directory of proximity files

                             OPTIONAL
--blat                       Installation of blat to use (defaults to your system default)
--grch                       Genome build (37 or 38), defaults to 38 or according to --release input
--release                    Ensembl release verion (55-87), defaults to 87 or to the latest release according to --grch input
                                 Note that releases 55-75 correspond to GRCh37 & 76-87 correspond to GRCh38

--help                       this message
```


## hotspot3d_cosmic

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
- **Homepage**: https://github.com/ding-lab/hotspot3d
- **Package**: https://anaconda.org/channels/bioconda/packages/hotspot3d/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: hotspot3d cosmic [options]

                             REQUIRED
--output-dir                 Output directory of proximity files

--help                       this message
```


## hotspot3d_prior

### Tool Description
Calculate prior probabilities for Hotspot3D analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
- **Homepage**: https://github.com/ding-lab/hotspot3d
- **Package**: https://anaconda.org/channels/bioconda/packages/hotspot3d/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: hotspot3d prior [options]

                             REQUIRED
--output-dir                 Output directory

                             OPTIONAL
--p-value-cutoff             p_value cutoff(<=), default is 0.05
--3d-distance-cutoff         3D distance cutoff (<= Angstroms), default is 20
--linear-cutoff              Linear distance cutoff (> peptides), default is 0

--help                       this message
```


## hotspot3d_Analysis

### Tool Description
3D mutation proximity analysis program.

### Metadata
- **Docker Image**: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
- **Homepage**: https://github.com/ding-lab/hotspot3d
- **Package**: https://anaconda.org/channels/bioconda/packages/hotspot3d/overview
- **Validation**: PASS

### Original Help Text
```text
Please give valid sub command ! 
Program: hotspot3d - 3D mutation proximity analysis program.
Version: V1.8.2
 Author: Beifang Niu, Adam D Scott, Sohini Sengupta, John Wallis & Amila Weerasinghe

  Usage: hotspot3d <command> [options]

           Preprocessing
              drugport  --  0) Parse drugport database (OPTIONAL)
              uppro     --  1) Update proximity files
              prep      --  2) Run steps 2a-2f of preprocessing
                  calroi    --  2a) Generate region of interest (ROI) information
                  statis    --  2b) Calculate p_values for pairs of mutations
                  anno      --  2c) Add region of interest (ROI) annotation
                  trans     --  2d) Add transcript annotation 
                  cosmic    --  2e) Add COSMIC annotation to proximity file
                  prior     --  2f) Prioritization

           Analysis

              main      --  0) Run steps a-f of analysis (BETA)
                  search    --  a) 3D mutation proximity searching
                  cluster   --  b) Determine mutation-mutation and mutation-drug clusters
                  sigclus   --  c) Determine significance of clusters (BETA)
                  summary   --  d) Summarize clusters
                  visual    --  e) Visulization of 3D proximity

           help      --  this message

         SUPPORT
         For user support please email adamscott@wustl.edu
```


## hotspot3d_main

### Tool Description
Hotspot3D main pipeline for proximity search, clustering, and analysis of mutations.

### Metadata
- **Docker Image**: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
- **Homepage**: https://github.com/ding-lab/hotspot3d
- **Package**: https://anaconda.org/channels/bioconda/packages/hotspot3d/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: hotspot3d main [options]

                             REQUIRED
--output-dir                 Output directory of proximity files
--maf-file                   .maf file used in proximity search step (used if vertex-type = recurrence)

                             OPTIONAL
--start                      Step to start on (search, post, cluster, sigclus, summary, visual), default: search
--drugport-file              DrugPort database parsing results file
--output-prefix              Prefix of output files, default: 3D_Proximity
--skip-silent                skip silent mutations, default: no
--missense-only              missense mutation only, default: no
--p-value-cutoff             P_value cutoff (<), default: 0.05 (if 3d-distance-cutoff also not set)
--3d-distance-cutoff         3D distance cutoff (<), default: 100 (if p-value-cutoff also not set)
--linear-cutoff              Linear distance cutoff (> peptides), default: 0
--amino-acid-header          .maf file column header for amino acid changes, default: amino_acid_change
--transcript-id-header       .maf file column header for transcript id's, default: transcript_name
--weight-header              .maf file column header for mutation weight, default: weight (used if vertex-type = weight)
--max-radius                 Maximum cluster radius (max network geodesic from centroid, <= Angstroms), default: 10
--clustering                 Cluster using network or density-based methods (network or density), default: network
--vertex-type                Graph vertex type for network-based clustering (recurrence, unique, or weight), default: recurrence
--distance-measure           Pair distance to use (shortest or average), default: average
--simulations                Number of simulations, default = 1000000

--help                       this message
```


## hotspot3d_search

### Tool Description
Search for proximity results using HotSpot3D preprocessing results

### Metadata
- **Docker Image**: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
- **Homepage**: https://github.com/ding-lab/hotspot3d
- **Package**: https://anaconda.org/channels/bioconda/packages/hotspot3d/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: hotspot3d search [options]

                             REQUIRED
--prep-dir                   HotSpot3D preprocessing results directory

                             REQUIRE AT LEAST ONE
--maf-file                   Input MAF file used to search proximity results
--site-file                  Protein site file (gene transcript position description)

                             OPTIONAL
--drugport-file              DrugPort database parsing results file
--output-prefix              Prefix of output files, default: 3D_Proximity 
--skip-silent                skip silent mutations, default: no
--missense-only              missense mutation only, default: no
--p-value-cutoff             p_value cutoff(<=), default: 0.05
--3d-distance-cutoff         3D distance cutoff (<=), default: 10
--linear-cutoff              Linear distance cutoff (>= peptides), default: 0 
--transcript-id-header       MAF file column header for transcript id's, default: transcript_name
--amino-acid-header          MAF file column header for amino acid changes, default: amino_acid_change 

--help                       this message
```


## hotspot3d_cluster

### Tool Description
Cluster mutation-mutation, mutation-drug, or mutation-site pairs using network or density-based methods.

### Metadata
- **Docker Image**: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
- **Homepage**: https://github.com/ding-lab/hotspot3d
- **Package**: https://anaconda.org/channels/bioconda/packages/hotspot3d/overview
- **Validation**: PASS

### Original Help Text
```text
HotSpot3D::Cluster::setOptions warning: no clustering option given, setting to default network

Usage: hotspot3d cluster [options]

                             REQUIRE AT LEAST ONE
--sites-file                 A .sites file with site-site pairs
--pairwise-file              A .pairwise file with mutation-mutation pairs (provide maf-file)
--drug-clean-file            A .drugs.*target.clean file with mutation-drug pairs (provide maf-file)
--musites-file               A .musites file with mutation-site pairs (provide maf-file and site-file)

                             CONDITIONAL REQUIREMENT
--maf-file                   .maf file used in proximity search step
                                 necessary for pairwise, drug-clean, or musites pair data
--hup-file                   hugo.uniprot.pdb.csv file location (this file is generated inside the preprocess data directory)
                                 required if --vertex-type=site or --clustering=density

                             OPTIONAL (General)
--clustering                 Cluster using network or density-based methods (network or density), default: network
--vertex-type                Graph vertex type for network-based clustering (recurrence, unique, site or weight), default: site
                                 recurrence vertices are the genomic mutations for each sample from the given .maf
                                 unique vertices are the specific genomic changes
                                 site vertices are the affected protein positions
                                 weight vertices are the genomic mutations with a numerical weighting
--distance-measure           Pair distance to use (shortest or average), default: average
--structure-dependent        Clusters for each structure or across all structures, default (no flag): independent
--subunit-dependent          Clusters for each subunit or across all subunits, default (no flag): independent
--meric-type                 Clusters for each intra-molecular (both monomers and homomers), monomer, homomer, 
                                 inter-molecular (heteromers), heteromer, multimer (simultaneously homomer & heteromer), or any *mer 
                                 (intra, monomer, homomer, inter, heteromer, multimer, or unspecified), default: unspecified
--transcript-id-header       .maf file column header for transcript id's, default: transcript_name
--amino-acid-header          .maf file column header for amino acid changes, default: amino_acid_change 
--weight-header              .maf file column header for mutation weight, default: weight (used if vertex-type = weight)
--parallel                   Parallelization for structure and subunit dependent runs (none or local), default: none
--max-processes              Set if using parallel type local (CAUTION: make sure you know your max CPU processes)
--gene-list-file             Choose mutations from the genes given in this list
--structure-list-file        Choose mutations from the structures given in this list

                              OPTIONAL (Network)
--output-prefix              Output prefix, default: 3D_Proximity
--p-value-cutoff             P_value cutoff (<), default: 0.05 (if 3d-distance-cutoff also not set)
--3d-distance-cutoff         3D distance cutoff (<), default: 100 (if p-value-cutoff also not set)
--linear-cutoff              Linear distance cutoff (> peptides), default: 0
--max-radius                 Maximum cluster radius (max network geodesic from centroid, <= Angstroms), default: 10
--weight-scale               Weight scale used to control scoring of vertices, default: 20
--length-scale               Length scale used to control scoring of vertices, default: 10
--vertex-score               Vertex score system to use (centrality, exponentials), default: centrality

                              OPTIONAL (Density)
--use-JSON                   Use pre-encoded mutations and distance-matrix hashes in json format, default (no flag): do not use json
--mutations-hash-json-file   JSON encoded mutations hash file produced by a previous cluster run
--distance-matrix-json-file  JSON encoded distance-matrix hash file produced by a previous cluster run
--siteVertexMap-json-file    JSON encoded siteVertexMap hash file produced by a previous cluster run
--Epsilon                    Epsilon value, default: 10
--MinPts                     MinPts, default: 4
--number-of-runs             Number of density clustering runs to perform before the cluster membership probability being calculated, default: 10
--probability-cut-off        Clusters will be formed with variants having at least this probability, default: 100




--help                       this message
```


## hotspot3d_sigclus

### Tool Description
Calculate significance of clusters using simulations

### Metadata
- **Docker Image**: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
- **Homepage**: https://github.com/ding-lab/hotspot3d
- **Package**: https://anaconda.org/channels/bioconda/packages/hotspot3d/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: hotspot3d sigclus [options]

	--prep-dir			Preprocessing directory 
	--pairwise			Pairwise file (pancan19.pairwise)
	--clusters			Cluster file (pancan19.intra.20..05.10.clusters)
	--output			Output file prefix (pancan19.intra.20..05.10)

	--simulations	Number of simulations, default = 1000000

	--help				This message
```


## hotspot3d_summary

### Tool Description
Summarize Hotspot3D clusters

### Metadata
- **Docker Image**: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
- **Homepage**: https://github.com/ding-lab/hotspot3d
- **Package**: https://anaconda.org/channels/bioconda/packages/hotspot3d/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: hotspot3d summary [options]

                             REQUIRED
--clusters-file              Clusters file

                             OPTIONAL
--output-prefix              Output prefix

--help                       this message
```


## hotspot3d_visual

### Tool Description
Visualize clusters and mutations using PyMol scripts

### Metadata
- **Docker Image**: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
- **Homepage**: https://github.com/ding-lab/hotspot3d
- **Package**: https://anaconda.org/channels/bioconda/packages/hotspot3d/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: hotspot3d visual [options]

                             REQUIRED
--clusters-file              Clusters file
--pdb                        PDB ID on which to view clusters

                             AT LEAST ONE
--pairwise-file              A .pairwise file
--musites-file               A .musites file
--sites-file                 A .sites file
--drug-pairs-file            A .drug*clean file (either target or nontarget)

                             OPTIONAL
--output-file                Output filename for single PyMol script, default: hotspot3d.visual.pml
--pymol                      PyMoL program location, default: /usr/bin/pymol
--output-dir                 Output directory for multiple PyMol scripts, current working directory
--pdb-dir                    PDB file directory, default: current working directory
--bg-color                   background color, default: white
--mut-color                  mutation color, default: red
--mut-style                  mutation style, default: spheres
--site-color                 site color, default: blue
--site-style                 site style, default: sticks
--compound-color             compound color, default: util.cbag
--compound-style             compound style, default: sticks if compound-color, util.cbag otherwise
--script-only                If included (on), pymol is not run with new <output-file> when finished, default: off
--clusters-file-type         which clustering module created your clusters-file? network or density, default: network

--help                       this message

Tip: To run an already created .pml file, run pymol <your output-file>
```


## hotspot3d_SUPPORT

### Tool Description
3D mutation proximity analysis program.

### Metadata
- **Docker Image**: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
- **Homepage**: https://github.com/ding-lab/hotspot3d
- **Package**: https://anaconda.org/channels/bioconda/packages/hotspot3d/overview
- **Validation**: PASS

### Original Help Text
```text
Please give valid sub command ! 
Program: hotspot3d - 3D mutation proximity analysis program.
Version: V1.8.2
 Author: Beifang Niu, Adam D Scott, Sohini Sengupta, John Wallis & Amila Weerasinghe

  Usage: hotspot3d <command> [options]

           Preprocessing
              drugport  --  0) Parse drugport database (OPTIONAL)
              uppro     --  1) Update proximity files
              prep      --  2) Run steps 2a-2f of preprocessing
                  calroi    --  2a) Generate region of interest (ROI) information
                  statis    --  2b) Calculate p_values for pairs of mutations
                  anno      --  2c) Add region of interest (ROI) annotation
                  trans     --  2d) Add transcript annotation 
                  cosmic    --  2e) Add COSMIC annotation to proximity file
                  prior     --  2f) Prioritization

           Analysis

              main      --  0) Run steps a-f of analysis (BETA)
                  search    --  a) 3D mutation proximity searching
                  cluster   --  b) Determine mutation-mutation and mutation-drug clusters
                  sigclus   --  c) Determine significance of clusters (BETA)
                  summary   --  d) Summarize clusters
                  visual    --  e) Visulization of 3D proximity

           help      --  this message

         SUPPORT
         For user support please email adamscott@wustl.edu
```


## hotspot3d_For

### Tool Description
3D mutation proximity analysis program.

### Metadata
- **Docker Image**: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
- **Homepage**: https://github.com/ding-lab/hotspot3d
- **Package**: https://anaconda.org/channels/bioconda/packages/hotspot3d/overview
- **Validation**: PASS

### Original Help Text
```text
Please give valid sub command ! 
Program: hotspot3d - 3D mutation proximity analysis program.
Version: V1.8.2
 Author: Beifang Niu, Adam D Scott, Sohini Sengupta, John Wallis & Amila Weerasinghe

  Usage: hotspot3d <command> [options]

           Preprocessing
              drugport  --  0) Parse drugport database (OPTIONAL)
              uppro     --  1) Update proximity files
              prep      --  2) Run steps 2a-2f of preprocessing
                  calroi    --  2a) Generate region of interest (ROI) information
                  statis    --  2b) Calculate p_values for pairs of mutations
                  anno      --  2c) Add region of interest (ROI) annotation
                  trans     --  2d) Add transcript annotation 
                  cosmic    --  2e) Add COSMIC annotation to proximity file
                  prior     --  2f) Prioritization

           Analysis

              main      --  0) Run steps a-f of analysis (BETA)
                  search    --  a) 3D mutation proximity searching
                  cluster   --  b) Determine mutation-mutation and mutation-drug clusters
                  sigclus   --  c) Determine significance of clusters (BETA)
                  summary   --  d) Summarize clusters
                  visual    --  e) Visulization of 3D proximity

           help      --  this message

         SUPPORT
         For user support please email adamscott@wustl.edu
```

