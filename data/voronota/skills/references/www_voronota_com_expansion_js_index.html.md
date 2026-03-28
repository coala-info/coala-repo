# Voronota-JS version 1.29

* [About Voronota-JS expansion](#about-voronota-js-expansion)
  + [Usage of externally developed software](#usage-of-externally-developed-software)
* [Quick install guide](#quick-install-guide)
* [Getting the latest version](#getting-the-latest-version)
* [Building from source code](#building-from-source-code)
  + [Requirements](#requirements)
  + [Using CMake](#using-cmake)
  + [Using C++ compiler directly](#using-c-compiler-directly)
* [More about generating tessellation-based data graphs from structures](#more-about-generating-tessellation-based-data-graphs-from-structures)
  + [Generating graphs with an extended set of annotations](#generating-graphs-with-an-extended-set-of-annotations)
  + [Fast generation of basic graphs](#fast-generation-of-basic-graphs)
* [More about protein-ligand variation of CAD-score](#more-about-protein-ligand-variation-of-cad-score)
  + [Example of how it works for CASP15 models](#example-of-how-it-works-for-casp15-models)
  + [More info about the involved contacts](#more-info-about-the-involved-contacts)
* [Wrapper scripts](#wrapper-scripts)
  + [VoroMQA dark and light methods](#voromqa-dark-and-light-methods)
  + [VoroMQA for only global scores with fast caching](#voromqa-for-only-global-scores-with-fast-caching)
  + [VoroMQA-based membrane protein structure assessment](#voromqa-based-membrane-protein-structure-assessment)
  + [VoroMQA-based collection of protein-protein complex features](#voromqa-based-collection-of-protein-protein-complex-features)
  + [Fast inter-chain interface VoroMQA energy](#fast-inter-chain-interface-voromqa-energy)
  + [Fast inter-chain interface CAD-score](#fast-inter-chain-interface-cad-score)
  + [Fast inter-chain interface CAD-score matrix](#fast-inter-chain-interface-cad-score-matrix)
  + [Fast inter-chain interface contacts](#fast-inter-chain-interface-contacts)
  + [Computation of inter-chain interface graphs](#computation-of-inter-chain-interface-graphs)
  + [VoroIF-GNN method for scoring models of protein-protein complexes](#voroif-gnn-method-for-scoring-models-of-protein-protein-complexes)
  + [Protein-ligand interface variation of CAD-score](#protein-ligand-interface-variation-of-cad-score)
  + [Global CAD-score, with an option to use the Voronota-LT algorithm](#global-cad-score-with-an-option-to-use-the-voronota-lt-algorithm)
  + [Global CAD-score matrix, with an option to use the Voronota-LT algorithm](#global-cad-score-matrix-with-an-option-to-use-the-voronota-lt-algorithm)

# About Voronota-JS expansion

Voronota-JS is an expansion of [the core Voronota software](../index.html). Voronota-JS provides a way to write JavaScript scripts for the comprehensive analysis of macromolecular structures, including the Voronoi tesselation-based analysis.

Currently, the Voronota-JS package contains several executables:

* “voronota-js” - core engine that executes JavaScript scripts.
* “voronota-js-voromqa” - wrapper to run voronota-js program for computing VoroMQA scores, both old and new (developed for CASP14).
* “voronota-js-only-global-voromqa” - wrapper to run voronota-js program for computing only global VoroMQA scores with fast caching.
* “voronota-js-membrane-voromqa” - wrapper to run voronota-js program for the VoroMQA-based analysis and assessment of membrane protein structural models.
* “voronota-js-ifeatures-voromqa” - wrapper to run voronota-js program for the computation of multiple VoroMQA-based features of protein-protein complexes.
* “voronota-js-fast-iface-voromqa” - wrapper to run voronota-js program for the very fast computation of the inter-chain interface VoroMQA energy.
* “voronota-js-fast-iface-cadscore” - wrapper to run voronota-js program for the very fast computation of the inter-chain interface CAD-score.
* “voronota-js-fast-iface-cadscore-matrix” - wrapper to run voronota-js program for the very fast computation of the inter-chain interface CAD-score matrix.
* “voronota-js-fast-iface-contacts” - wrapper to run voronota-js program for the very fast computation of the inter-chain interface contact areas.
* “voronota-js-fast-iface-data-graph” - wrapper to run voronota-js program for the computation of interface graphs used by the VoroIF-GNN method.
* “voronota-js-voroif-gnn” - wrapper to run voronota-js program and GNN inference scripts that run the VoroIF-GNN method for scoring models of protein-protein complexes (developed for CASP15).
* “voronota-js-ligand-cadscore” - wrapper to run voronota-js program for the computation of protein-ligand variation of CAD-score (developed to analyze protein-ligand models from CASP15).
* “voronota-js-global-cadscore” - wrapper to run voronota-js program for computating the global CAD-score, with an option to utilize the Voronota-LT algorithm for high speed.
* “voronota-js-global-cadscore-matrix” - wrapper to run voronota-js program for computating the global CAD-score matrix, with an option to utilize the Voronota-LT algorithm for high speed.

## Usage of externally developed software

Voronota-JS relies on several externally developed software projects (big thanks to their authors):

* Duktape - <https://duktape.org/>
* PStreams - <https://github.com/jwakely/pstreams>
* TM-align - <https://zhanggroup.org/TM-align/>
* FASPR - <https://zhanggroup.org/FASPR/>
* QCP - <https://theobald.brandeis.edu/qcp/>
* linenoise - <https://github.com/antirez/linenoise>
* PicoSHA2 - <https://github.com/okdshin/PicoSHA2>
* frugally-deep - <https://github.com/Dobiasd/frugally-deep>
  + FunctionalPlus - <https://github.com/Dobiasd/FunctionalPlus>
  + Eigen - <http://eigen.tuxfamily.org/>
  + json - <https://github.com/nlohmann/json>
* tinf - <https://github.com/jibsen/tinf>
* LodePNG - <https://github.com/lvandeve/lodepng>

# Quick install guide

Please refer to the [core Voronota quick install guide](../index.html#quick-install-guide).

# Getting the latest version

Download the latest archive from the official downloads page: <https://github.com/kliment-olechnovic/voronota/releases>.

The archive contains the Voronota-JS software in the ‘expansion\_js’ subdirectory. There is a ready-to-use statically compiled ‘voronota-js’ program for 64 bit Linux systems. This executable can be rebuilt from the provided source code to work on any modern Linux, macOS or Windows operating systems.

# Building from source code

## Requirements

Voronota-JS has no required external dependencies, only a C++14-compliant compiler is needed to build it.

## Using CMake

You can build using CMake for makefile generation. Starting in the directory containing “CMakeLists.txt” file, run the sequence of commands:

```
cmake ./
make
```

Alternatively, to keep files more organized, CMake can be run in a separate “build” directory:

```
mkdir build
cd build
cmake ../
make
cp ./voronota-js ../voronota-js
```

## Using C++ compiler directly

For example, “voronota-js” executable can be built from the sources in “src” directory using GNU C++ compiler:

```
g++ -std=c++14 -I"./src/dependencies" -O3 -o "./voronota-js" $(find ./src/ -name '*.cpp')
```

# More about generating tessellation-based data graphs from structures

Two utility scripts for generating Voronoi tessellation-based data graphs are included in [the Voronota-JS expansion](./index.html) of Voronota:

* `voronota-js-receptor-data-graph` - for generating graphs with an extended set of annotations
* `voronota-js-lt-data-graph` - for generating basic graphs, but much faster, using the Voronota-LT algorithm

These scripts are available in the latest version of [the Voronota package](../index.html#voronota-on-github), in the `expanson_js` subdirectory.

## Generating graphs with an extended set of annotations

The command-line interface of the `voronota-js-receptor-data-graph` script is described below:

```
'voronota-js-receptor-data-graph' script describes a receptor protein structure as an annotated graph.

Options:
    --input                   string  *  path to input protein file
    --probe-min               number     scanning probe radius minimum, default is 2.0
    --probe-max               number     scanning probe radius maximum, default is 30.0
    --buriedness-core         number     buriedness minimum for pocket start, default is 0.7
    --buriedness-rim          number     buriedness maximum for pocket end, default is 0.4
    --subpockets              number     number of sorted subpockets to include, default is 999999
    --output-dir              string  *  output directory path
    --output-naming           string     output files naming mode, default is 'BASENAME/name', other possibilities are 'BASENAME_name' and 'BASENAME/BASENAME_name'
    --help | -h                          flag to display help message and exit

Standard output:
    Information messages in stdout, error messages in stderr

Examples:
    voronota-js-receptor-data-graph --input "./2zsk.pdb" --output-dir "./output"

    voronota-js-receptor-data-graph --input "./2zsk.pdb" --output-dir "./output" --probe-min 1 --probe-max 5 --buriedness-core 0.8 --buriedness-rim 0.7 --subpockets 1
```

### Example of execution and output

Running

```
voronota-js-receptor-data-graph --input "./2zsk.pdb" --output-dir "./output"
```

generates four .TSV files:

* `./output/2zsk/atom_graph_nodes.tsv` - atom-level graph nodes table file, one row per node, every node represents an atom
* `./output/2zsk/atom_graph_links.tsv` - atom-level graph links (edges) table file, one row per link, every link represents an atom-atom contact
* `./output/2zsk/residue_graph_nodes.tsv` - residue-level graph nodes table file, one row per node, every node represents a residue
* `./output/2zsk/residue_graph_links.tsv` - residue-level graph links (edges) table file, one row per link, every link represents a residue-residue contact

It also generates .PDB files with “buriedness” and “pocketness” values written as b-factors - in case a user wants to visualize those values in a 3D viewer.

### Data format of the atom graph nodes file

Example (first 10 lines) from the file `./output/2zsk/atom_graph_nodes.tsv`:

```
ID_chainID  ID_resSeq  ID_iCode  ID_serial  ID_altLoc  ID_resName  ID_name  atom_index  residue_index  atom_type  residue_type  center_x  center_y  center_z  radius  sas_area  solvdir_x   solvdir_y   solvdir_z   voromqa_sas_energy  voromqa_depth  voromqa_score_a  voromqa_score_r  volume   volume_vdw  ev14       ev28      ev56       ufsr_a1  ufsr_a2  ufsr_a3   ufsr_b1  ufsr_b2  ufsr_b3   ufsr_c1  ufsr_c2  ufsr_c3  buriedness  pocketness
A           1          .         .          .          MET         N        0           0              97         12            22.493    56.29     12.4      1.7     53.351    0.559085    0.82758     -0.0503525  57.9168             1              1.01688e-07      0.167578         66.5845  15.242      0.125304   0.124587  0.121036   30.0876  112.815  -196.313  41.8069  256.541  -1727.84  37.0975  249.607  439.762  0.132536    0
A           1          .         .          .          MET         CA       1           0              93         12            21.658    55.076    12.14     1.9     4.72457   0.135243    0.432065    -0.891644   6.17629             1              0.015941         0.167578         26.134   13.3463     0.0448295  0.039199  0.0265035  30.0876  112.815  -196.313  41.8069  256.541  -1727.84  37.0975  249.607  439.762  0.0847213   0
A           1          .         .          .          MET         C        2           0              92         12            20.271    55.177    12.793    1.75    2.62013   -0.250994   0.910664    -0.328166   5.18333             1              0.292879         0.167578         14.0446  8.87448     0.601112   0.563979  0.457316   30.0876  112.815  -196.313  41.8069  256.541  -1727.84  37.0975  249.607  439.762  0.13229     0
A           1          .         .          .          MET         O        3           0              98         12            20.135    55.689    13.912    1.49    11.2317   0.372405    0.737202    0.56378     8.18408             1              0.361824         0.167578         31.8395  9.38393     0.661347   0.635732  2          30.0876  112.815  -196.313  41.8069  256.541  -1727.84  37.0975  249.607  439.762  0.139913    0
A           1          .         .          .          MET         CB       4           0              94         12            22.393    53.825    12.646    1.91    27.6946   0.886864    -0.0929711  0.452581    17.787              1              0.167248         0.167578         74.006   23.068      0.63118    0.590042  0.584411   30.0876  112.815  -196.313  41.8069  256.541  -1727.84  37.0975  249.607  439.762  0.121678    0
A           2          .         .          .          LYS         N        5           1              89         11            19.254    54.687    12.079    1.7     2.52782   -0.0429483  0.809307    -0.585814   3.47919             1              0.052448         0.472209         17.3995  10.0202     0.55985    0.535622  0.457316   29.1886  119.733  -71.1108  41.8069  256.541  -1727.84  37.0975  249.607  439.762  0.0643745   0
A           2          .         .          .          LYS         CA       6           1              84         11            17.871    54.701    12.555    1.9     2.06927   0.0828678   0.93132     -0.354648   1.32819             1              0.342294         0.472209         18.5844  12.7854     0.62449    0.611648  0.645691   29.1886  119.733  -71.1108  41.8069  256.541  -1727.84  37.0975  249.607  439.762  0.0846022   0
A           2          .         .          .          LYS         C        7           1              83         11            17.712    53.714    13.699    1.75    0.033581  0.809845    -0.165563   0.562797    0.0571512           1              0.698036         0.472209         11.1993  8.68042     0.965086   2         2          29.1886  119.733  -71.1108  41.8069  256.541  -1727.84  37.0975  249.607  439.762  2           0
A           2          .         .          .          LYS         O        8           1              91         11            18.114    52.551    13.6      1.49    1.14708   0.796577    -0.0907621  0.597685    0.209446            1              0.571392         0.472209         21.023   9.3442      0.965086   2         2          29.1886  119.733  -71.1108  41.8069  256.541  -1727.84  37.0975  249.607  439.762  2           0
```

Description of the columns:

* **ID\_chainID** - chain name in PDB file, given just for reference
* **ID\_resSeq** - residue number in PDB file, given just for reference
* **ID\_iCode** - insertion code in PDB file, usually null and written as ‘.’, given just for reference
* **ID\_altLoc** - atom alternate location indicator in PDB file, usually null and written as ‘.’, given just for reference
* **ID\_serial** - atom serial number in PDB file, usually null and written as ‘.’, given just for reference
* **ID\_resName** - residue name
* **ID\_name** - atom name
* **a