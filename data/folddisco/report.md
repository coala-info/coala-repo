# folddisco CWL Generation Report

## folddisco_index

### Tool Description
Index PDB files for folddisco

### Metadata
- **Docker Image**: quay.io/biocontainers/folddisco:1.7514114--ha6fb395_0
- **Homepage**: https://github.com/steineggerlab/folddisco
- **Package**: https://anaconda.org/channels/bioconda/packages/folddisco/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/folddisco/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2025-08-18
- **GitHub**: https://github.com/steineggerlab/folddisco
- **Stars**: N/A
### Original Help Text
```text
[91m░█▀▀░█▀█░█░░░█▀▄░[93m█▀▄░▀█▀░█▀▀░█▀▀░█▀█[0m
[91m░█▀▀░█░█░█░░░█░█░[93m█░█░░█░░▀▀█░█░░░█░█[0m
[91m░▀░░░▀▀▀░▀▀▀░▀▀░░[93m▀▀░░▀▀▀░▀▀▀░▀▀▀░▀▀▀[0m

usage: folddisco index -p <i:PDB_DIR>|<i:FOLDCOMP_DB> -i <o:INDEX_PATH> [OPTIONS]

input/output:
 -p, --pdbs <PATH>                Directory or Foldcomp DB containing PDB files
 -i, --index <PATH>               Path to save the index table
 -r, --recursive                  Index PDB files in subdirectories recursively

indexing parameters:
 -t, --threads <INT>              Number of threads to use [1]
 -n, --max-residue <INT>          Maximum number of residues in a PDB file [50000]
 --id <STR>                       ID type to use (pdb, uniprot, afdb, relpath, abspath) [relpath]
 -m, --mode <MODE>                Mode to index [id]
    id: suitable for smaller dataset (N < 65536) with hashmap offset;
    big: 8GB fixed-size offset table, suitable for large dataset

hashing parameters:
 -y, --type STR                   Hash type to use (default, pdb, trrosetta, ppf, 3di) [default]
 -d, --distance INT               Number of distance bins [default, 16]
 -a, --angle INT                  Number of angle bins [default, 4]
 --multiple-bins STR              Multiple bins for distance and angle (dist1-ang1,dist2-ang2 e.g. 16-4,8-3)
                                  While increasing sensitivity, this option increases the size of the index.

general options:
 -v, --verbose                    Print verbose messages
 -h, --help                       Print this help menu
 
examples:
# Default. h_sapiens directory or foldcomp database is indexed with default parameters
folddisco index -p h_sapiens -i index/h_sapiens -t 12

# Indexing big protein dataset
folddisco index -p swissprot -i index/swissprot -t 64 -m big -v

# Indexing with custom hash type and parameters
folddisco index -p h_sapiens -i index/h_sapiens -t 12 -y default -d 16 -a 4 # Default
folddisco index -p h_sapiens -i index/h_sapiens -t 12 -y pdb -d 8 -a 3 # PDB
```


## folddisco_query

### Tool Description
Search for patterns in PDB files using an index.

### Metadata
- **Docker Image**: quay.io/biocontainers/folddisco:1.7514114--ha6fb395_0
- **Homepage**: https://github.com/steineggerlab/folddisco
- **Package**: https://anaconda.org/channels/bioconda/packages/folddisco/overview
- **Validation**: PASS

### Original Help Text
```text
[91m░█▀▀░█▀█░█░░░█▀▄░[93m█▀▄░▀█▀░█▀▀░█▀▀░█▀█[0m
[91m░█▀▀░█░█░█░░░█░█░[93m█░█░░█░░▀▀█░█░░░█░█[0m
[91m░▀░░░▀▀▀░▀▀▀░▀▀░░[93m▀▀░░▀▀▀░▀▀▀░▀▀▀░▀▀▀[0m

usage: folddisco query -p <i:PDB> -q <QUERY> -i <i:INDEX> [OPTIONS] 

input/output:
 -p, --pdb <PATH>                 Path of PDB file to query
 -q, --query <STR>                Query string that specifies residues or a text file containing query
 -i, --index <PATH>               Path of index table to load [REQUIRED]
 -o, --output <PATH>              Output file path [stdout]
 
search parameters:
 -t, --threads <INT>              Number of threads [1]
 -d, --distance <FLOAT>           Distance threshold in Angstroms. Multiple values can be separated by comma [0.5]
 -a, --angle <FLOAT>              Angle threshold. Multiple values can be separated by comma [5.0]
 --ca-distance <FLOAT>            C-alpha distance threshold in matching residues [1.0]
 --sampling-count <INT>           Number of sampled hashes to search [all]
 --sampling-ratio <FLOAT>         Sampling ratio for hashes used in searching. For long queries, smaller ratio is recommended [1.0]
 --freq-filter <FLOAT>            Skip queries with hash frequency higher than given ratio [0.0]
 --length-penalty <FLOAT>         Length penalty for searching. Zero means no penalty and higher value gives more penalty to longer structures [0.5]
 --skip-match                     Skip matching residues
 --serial-index                   Handle residue indices serially

filtering options:
 --total-match <INT>              Filter out structures with less than total match count [0]
 --covered-node <INT>             Filter out structures not covered by given number of nodes with hashes [0]
 --covered-node-ratio <FLOAT>     Filter out structures not covered by given ratio of nodes with hashes [0.0]
 --max-node <INT>                 Filter out structures of maximum matching node size smaller than given value [0]
 --max-node-ratio <FLOAT>         Filter out structures of maximum matching node size smaller than given ratio [0.0]
 --score <FLOAT>                  IDF score cutoff [0.0]
 --connected-node <INT>           Filter out structures/matches with connected node count smaller than given value [0]
 --connected-node-ratio <FLOAT>   Filter out structures/matches with connected node count smaller than given ratio [0.0]
 --num-residue <INT>              Number of residues cutoff [50000]
 --plddt <FLOAT>                  pLDDT cutoff [0.0]
 --top <INT>                      Limit output to top N structures [all]

display options:
 --header                         Print header in output
 --web                            Print output for web
 --per-structure                  Print output per structure
 --per-match                      Print output per match. Not working with --skip-match
 --sort-by-score                  Sort output by score
 --sort-by-rmsd                   Sort output by RMSD. Not working with --skip-match
 --skip-ca-match                  Print matching residues before C-alpha distance check
 --partial-fit                    Superposition will find the best aligning substructure using LMS (Least Median of Squares)
 --superpose                      Print U, T, CA of matching residues

general options:
 -v, --verbose                    Print verbose messages
 -h, --help                       Print this help menu

examples:
# Search with default settings. This will print out matching motifs with sorting by RMSD.
folddisco query -p query/4CHA.pdb -q B57,B102,C195 -i index/h_sapiens_folddisco -t 6

# Print top 100 structures with sorting by score
folddisco query -p query/4CHA.pdb -q B57,B102,C195 -i index/h_sapiens_folddisco -t 6 --top 100 --per-structure --sort-by-score

# Query file given as separate text file
folddisco query -q query/zinc_finger.txt -i index/h_sapiens_folddisco -t 6 -d 0.5 -a 5

# Query with amino-acid substitutions and range. 
# Alternative amino acids can be given after colon. Range can be given with dash.
# This will query first 10 residues and 11th residue with subsitution to any amino acid.
folddisco query -p query/4CHA.pdb -q 1-10,11:X -i index/h_sapiens_folddisco -t 6 --serial-index

# Filtering
## Based on connected node and rmsd
folddisco query -q query/zinc_finger.txt -i index/h_sapiens_folddisco -t 6 --connected-node 0.75 --rmsd 1.0

## Coverage based filtering & top N filtering without residue matching
folddisco query -q query/zinc_finger.txt -i index/h_sapiens_folddisco -t 6 --covered-node 3 --top 1000 --per-structure --skip-match
```


## folddisco_benchmark

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/folddisco:1.7514114--ha6fb395_0
- **Homepage**: https://github.com/steineggerlab/folddisco
- **Package**: https://anaconda.org/channels/bioconda/packages/folddisco/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
[1;31m[FAIL][0m Result, answer, and index files must be provided
```


## Metadata
- **Skill**: generated
