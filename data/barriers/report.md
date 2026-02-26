# barriers CWL Generation Report

## barriers

### Tool Description
Compute local minima and energy barriers of a landscape

### Metadata
- **Docker Image**: quay.io/biocontainers/barriers:1.8.1--pl5321h503566f_4
- **Homepage**: https://www.tbi.univie.ac.at/RNA/Barriers/
- **Package**: https://anaconda.org/channels/bioconda/packages/barriers/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/barriers/overview
- **Total Downloads**: 16.3K
- **Last updated**: 2025-10-14
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
barriers 1.8.1

Compute local minima and energy barriers of a landscape

Usage: barriers [OPTIONS]... [[FILE]]...

This program reads an energy sorted list of conformations of a landscape, and
computes local minima and energy barriers of the landscape. For RNA secondary
structures, suitable input is produced by RNAsubopt. For each local minimum
found it prints to stdout, the conformation of the minimum, its energy, the
number of the "parent"-minimum it merges with, and the height of the energy
barrier. Additional information on each minimum, such as saddle point
conformation and basin sizes can be included via options.

A PostScript drawing of the resulting tree is written to "tree.ps" in the
current directory.

  -h, --help                    Print help and exit
      --detailed-help           Print help, including all details and hidden
                                  options, and exit
      --full-help               Print help, including hidden options, and exit
  -V, --version                 Print version and exit

General Options:
  Command line options which alter the general behavior of this program.


  -v, --verbose                 Be verbose, i.e. print more information.
                                  (default=off)
  -q, --quiet                   Be quiet (also inhibit PS tree output).
                                  (default=off)

Graphs and Move Sets:
  The graph and move set options specify the types of states/conformations in
  the system as well as their neighborhood. Some graphs provide different
  neighborhood settings. The type of landscape may also be set by the input
  file using the fourth word on first line. E.g.:

   AUCGUGAGCUGUGUAGCUUAGCUAGCUAGC -610 100 :: RNA-noLP


   for a landscape of canonical RNA structures.


  -G, --graph=Graph             Define type of the graph, i.e. configuration
                                  space.  (default=`RNA')
  -M, --moves=STRING            Select the move-set for generating neighbors of
                                  a configuration (if Graph allows several
                                  different ones).

Barrier Tree Computation:
  -c, --connected               Restrict the output to the connected component.
                                  (default=off)
      --bsize                   Print the size of of each basin in output.
                                  (default=off)
      --ssize                   Print saddle component sizes.  (default=off)
      --max=INT                 Compute only the lowest <num> local minima.
                                  (default=`100')
      --minh=<delta>            Print only minima with energy barrier greater
                                  than delta.  (default=`0.000001')
      --saddle                  Print the saddle point conformations in output.
                                  (default=off)

Transition Rate Computation:
      --rates                   Compute rates between macro states (basins).
                                  (default=off)

Miscellaneous Options:
  -P, --path=<l1>=<l2>          Backtrack an optimal path between local minimum
                                  l2 and l1.
      --mapstruc=<filename>     Map conformations to minima in the tree.
```

