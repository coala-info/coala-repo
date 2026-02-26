# super_distance CWL Generation Report

## super_distance

### Tool Description
Matrix Representation with Distances: calculates pairwise distances between gene leaves, and estimates species trees from summary distance matrices

### Metadata
- **Docker Image**: quay.io/biocontainers/super_distance:1.1.0--h577a1d6_6
- **Homepage**: https://github.com/quadram-institute-bioscience/super_distance
- **Package**: https://anaconda.org/channels/bioconda/packages/super_distance/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/super_distance/overview
- **Total Downloads**: 9.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/quadram-institute-bioscience/super_distance
- **Stars**: N/A
### Original Help Text
```text
super_distance 1.1.0 
Matrix Representation with Distances: calculates pairwise distances between gene leaves, and estimates species trees from summary distance matrices
The complete syntax is:

 super_distance  [-h|--help] [-v|--version] [-F|--fast] [-e|--epsilon=<double>] [-s|--species=<species names>] [-o|--output=<newick>] <file> [<file>]...

  -h, --help                       print a longer help and exit
  -v, --version                    print version and exit
  -F, --fast                       for too many leaves, estimates only two species trees
  -e, --epsilon=<double>           tolerance (small value below which a branch length is considered zero for nodal distances)
  -s, --species=<species names>    file with species names, one per line (comments in square braces allowed); if absent, orthology is assumed
  -o, --output=<newick>            output file with species supertrees, in newick format (default '-')
  <file>                           list of gene tree files, in newick format

Based on several rescaled patristic distances, the program takes the average matrix between genes and estimates 
 the species tree using bioNJ, UPGMA and single-linkage after scaling back to the original values (more below). The program 
 also uses a distance matrix to project branch lengths on species trees missing lengths; 

The branch length rescaling per gene can be the minimum, the average, the total sum, etc. and at the end these values
 averaged over trees are scaled back in the final distance matrix, such that lengths in the supertree (species tree) are interpretable.
 One exception is the nodal distance, which is based on the number of nodes between two leaves (e.g. NJst). In this case it may make
 more sense to use another distance matrix to infer the branch lengths. Option 'F' uses averages distances projected on nodal-estimated tree; 
 it uses fewer scalings/options, providing a fast estimation. We avoid using individual gene trees since they may have 
 missing information (missing species or species pairs). For missing comparisons (when two species are never seen in the same gene tree)
 we use the ultrametric condition (comparison to a common species) to estimate its value.

If a file with species names is given, the program allows for paralogs; otherwise it assumes orthology and that _at_least_ one tree has no missing data:
 * Paralogy: the species names will be mapped to individual gene tree leaves (e.g. `ECOLI_a` and `ECOLI_b` will both map to species `ECOLI`).
    Each gene tree can therefore have several copies of each species, and can also have missing species.
 * Orthology: if a file with species names is not given, however, it is assumed that each species is represented at most once per gene, and
   furthermore that the leaf names represent the species, and are thus identical across trees. This mode is the underlying assumption behind
   most tree comparison software, although here missing data for some trees (not all) is allowed. I.e. as long as one tree has full information
   (for all species), then others can have some absent species.
With paralogs or not, it is not recommended to have missing entries in the distance matrix (e.g. when a species pair does not appear in any tree),
 and matrix representation with distances methods work better with more 'complete' gene trees.
```

