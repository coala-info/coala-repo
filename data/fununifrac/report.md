# fununifrac CWL Generation Report

## fununifrac_compute_edges.py

### Tool Description
This will take the matrix made by graph_to_path_matrix.py and the all pairwise
distance matrix and solve the least squares problem of inferring the edge
lengths of the graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/fununifrac:0.0.1--pyh7cba7a3_0
- **Homepage**: https://github.com/KoslickiLab/FunUniFrac
- **Package**: https://anaconda.org/channels/bioconda/packages/fununifrac/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fununifrac/overview
- **Total Downloads**: 1.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/KoslickiLab/FunUniFrac
- **Stars**: N/A
### Original Help Text
```text
usage: compute_edges.py [-h] -e EDGE_FILE -d DISTANCE_FILE -o OUT_DIR
                        [-i OUT_ID] -b BRITE_ID [-n NUM_ITER] [-f FACTOR]
                        [-r REG_FACTOR] [--distance]

This will take the matrix made by graph_to_path_matrix.py and the all pairwise
distance matrix and solve the least squares problem of inferring the edge
lengths of the graph.

optional arguments:
  -h, --help            show this help message and exit
  -e EDGE_FILE, --edge_file EDGE_FILE
                        Input edge list file of the KEGG hierarchy
  -d DISTANCE_FILE, --distance_file DISTANCE_FILE
                        File containing all pairwise distances between KOs.
                        Use sourmash compare
  -o OUT_DIR, --out_dir OUT_DIR
                        Output directory: the location to place the output
                        file with edge list with lengths in the last column
  -i OUT_ID, --out_id OUT_ID
                        Test purpose: give an identifier to the output file so
                        that tester can recognize it
  -b BRITE_ID, --brite_id BRITE_ID
                        Brite ID of the KEGG hierarchy you want to focus on.
                        Eg. ko00001
  -n NUM_ITER, --num_iter NUM_ITER
                        Number of random selections on which to perform the
                        NNLS
  -f FACTOR, --factor FACTOR
                        Selects <--factor>*(A.shape[1]) rows for which to do
                        the NNLS
  -r REG_FACTOR, --reg_factor REG_FACTOR
                        Regularization factor for the NNLS
  --distance            Flag indicating that the input matrix is a distance
                        (0=identical). If not, it is assumed to be a
                        similarity (1=identical).
```


## fununifrac_compute_fununifrac.py

### Tool Description
This script will take a directory of sourmash gather results and a weighted edge list representing the KEGG hierarchy and compute all pairwise functional unifrac distances.

### Metadata
- **Docker Image**: quay.io/biocontainers/fununifrac:0.0.1--pyh7cba7a3_0
- **Homepage**: https://github.com/KoslickiLab/FunUniFrac
- **Package**: https://anaconda.org/channels/bioconda/packages/fununifrac/overview
- **Validation**: PASS

### Original Help Text
```text
usage: compute_fununifrac.py [-h] -e EDGE_LIST -fd FILE_DIR [-fp FILE_PATTERN]
                             -o OUT_DIR [-i OUT_ID] [-f] [-a ABUNDANCE_KEY]
                             [-t THREADS] [-b BRITE] [--diffab] [-v]
                             [--unweighted] [--L2] [--Ppushed]

This script will take a directory of sourmash gather results and a weighted
edge list representing the KEGG hierarchy and compute all pairwise functional
unifrac distances.

optional arguments:
  -h, --help            show this help message and exit
  -e EDGE_LIST, --edge_list EDGE_LIST
                        Input edge list file of the KEGG hierarchy. Must have
                        lengths in the third column.
  -fd FILE_DIR, --file_dir FILE_DIR
                        Directory of sourmash files.
  -fp FILE_PATTERN, --file_pattern FILE_PATTERN
                        Pattern to match files in the directory. Default is
                        '*_gather.csv'
  -o OUT_DIR, --out_dir OUT_DIR
                        Output directory name.
  -i OUT_ID, --out_id OUT_ID
                        Test purpose: give an identifier to the output file so
                        that tester can recognize it
  -f, --force           Overwrite the output file if it exists
  -a ABUNDANCE_KEY, --abundance_key ABUNDANCE_KEY
                        Key in the gather results to use for abundance.
                        Default is `f_unique_weighted`
  -t THREADS, --threads THREADS
                        Number of threads to use. Default is half the cores
                        available.
  -b BRITE, --brite BRITE
                        Use the subtree of the KEGG hierarchy rooted at the
                        given BRITE ID. eg. brite:ko00001
  --diffab              Also return the difference abundance vectors.
  -v                    Be verbose
  --unweighted          Compute unweighted unifrac instead of the default
                        weighted version
  --L2                  Use L2 UniFrac instead of L1
  --Ppushed             Flag indicating you want the pushed vectors to be
                        saved.
```

