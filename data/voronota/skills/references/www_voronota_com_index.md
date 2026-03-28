# Voronota version 1.29

## Quick links

* [Voronota-JS](./expansion_js/index.html) (for advanced scripting using JavaScript)

* [Voronota-LT](./expansion_lt/index.html) (for faster and parallelizable computation of tessellation-derived contact areas)

* [Voronota-GL](./expansion_gl/index.html) (for advanced scripting and visualization)
* [Web Voronota-GL](./expansion_gl/web/index.html) (online version of Voronota-GL)

* [Stable releases on GitHub](https://github.com/kliment-olechnovic/voronota/releases) (to get the latest stable version of Voronota and all its expansions)

## Table of contents

* [About Voronota](#about-voronota)
* [Voronota on GitHub](#voronota-on-github)
* [Quick install guide](#quick-install-guide)
* [About Voronota expansions](#about-voronota-expansions)
  + [Voronota-JS](#voronota-js)
  + [Voronota-LT](#voronota-lt)
  + [Voronota-GL](#voronota-gl)
* [Getting the latest version](#getting-the-latest-version)
* [Building from source code](#building-from-source-code)
  + [Requirements](#requirements)
  + [Using CMake](#using-cmake)
  + [Using C++ compiler directly](#using-c-compiler-directly)
  + [Enabling OpenMP](#enabling-openmp)
  + [Enabling MPI](#enabling-mpi)
  + [TR1 usage switch](#tr1-usage-switch)
* [Basic usage example](#basic-usage-example)
  + [Computing Voronoi vertices](#computing-voronoi-vertices)
  + [Computing inter-atom contacts](#computing-inter-atom-contacts)
  + [Computing annotated inter-atom contacts](#computing-annotated-inter-atom-contacts)
  + [Querying annotated inter-atom contacts](#querying-annotated-inter-atom-contacts)
  + [Getting help in command line](#getting-help-in-command-line)
* [Command reference](#command-reference)
  + [List of all commands](#list-of-all-commands)
  + [Command ‘get-balls-from-atoms-file’](#command-get-balls-from-atoms-file)
  + [Command ‘calculate-vertices’](#command-calculate-vertices)
  + [Command ‘calculate-vertices-in-parallel’](#command-calculate-vertices-in-parallel)
  + [Command ‘calculate-contacts’](#command-calculate-contacts)
  + [Command ‘query-balls’](#command-query-balls)
  + [Command ‘query-contacts’](#command-query-contacts)
  + [Command ‘draw-contacts’](#command-draw-contacts)
  + [Command ‘score-contacts-energy’](#command-score-contacts-energy)
  + [Command ‘score-contacts-quality’](#command-score-contacts-quality)
  + [Command ‘score-contacts-potential’](#command-score-contacts-potential)
  + [Command ‘compare-contacts’](#command-compare-contacts)
  + [Command ‘write-balls-to-atoms-file’](#command-write-balls-to-atoms-file)
  + [Command ‘query-balls-clashes’](#command-query-balls-clashes)
  + [Command ‘run-script’](#command-run-script)
  + [Command ‘expand-descriptors’](#command-expand-descriptors)
* [Wrapper scripts](#wrapper-scripts)
  + [VoroMQA method script](#voromqa-method-script)
  + [CAD-score method script](#cad-score-method-script)
  + [Contacts calculation convenience script](#contacts-calculation-convenience-script)
  + [Volumes calculation convenience script](#volumes-calculation-convenience-script)
  + [Pocket analysis script](#pocket-analysis-script)
  + [Membrane fitting script](#membrane-fitting-script)

# About Voronota

The analysis of macromolecular structures often requires a comprehensive definition of atomic neighborhoods. Such a definition can be based on the Voronoi diagram of balls, where each ball represents an atom of some van der Waals radius. Voronota is a software tool for finding all the vertices of the Voronoi diagram of balls. Such vertices correspond to the centers of the empty tangent spheres defined by quadruples of balls. Voronota is especially suitable for processing three-dimensional structures of biological macromolecules such as proteins and RNA.

Since version 1.2 Voronota also uses the Voronoi vertices to construct inter-atom contact surfaces and solvent accessible surfaces. Voronota provides tools to query contacts, generate contacts graphics, compare contacts and evaluate quality of protein structural models using contacts.

Most of the new developments are happening in the expansions of Voronota: Voronota-JS, Voronota-LT and Voronota-GL.

Voronota and its expansions are developed by Kliment Olechnovic (<https://www.kliment.lt>).

# Voronota on GitHub

Voronota source code is hosted on GitHub, at <https://github.com/kliment-olechnovic/voronota>.

The recommended way to get the latest stable version of Voronota and its expansions is to download the latest archive from the “Releases” page: <https://github.com/kliment-olechnovic/voronota/releases>.

The release archive contains ready-to-use statically compiled ‘voronota’ program for 64 bit Linux systems. The release archive also contains the source code that can be compiled on any modern Linux, macOS or Windows operating systems.

# Quick install guide

Below are several commands that install the latest version of Voronota and its expansions for the command line use in Unix-like systems.

```
# download the latest package
wget https://github.com/kliment-olechnovic/voronota/releases/download/v1.29.4771/voronota_1.29.4771.tar.gz

# unpack the package
tar -xf ./voronota_1.29.4771.tar.gz

# change to the package directory
cd ./voronota_1.29.4771

# run CMake
cmake . -DEXPANSION_JS=ON -DEXPANSION_LT=ON

# compile everything
make

# install everything
sudo make install
```

The installed files are listed in the ‘install\_manifest.txt’ file. They can be uninstalled by running

```
sudo xargs rm < ./install_manifest.txt
```

# About Voronota expansions

Currently there are three expansions of Voronota: Voronota-JS, Voronota-LT and Voronota-GL.

The expansions need to be built separately in their subdirectories. Alternatively, they can be built by appending `-DEXPANSION_JS=ON` and/or `-DEXPANSION_LT=ON` and/or `-DEXPANSION_GL=ON` to the CMake command call.

The expansions have separate dedicated documentation pages.

## Voronota-JS

[Voronota-JS](./expansion_js/index.html) expansion is located in the ‘expansion\_js’ subdirectory of the Voronota package.

Voronota-JS provides a way to write JavaScript scripts for the comprehensive analysis of macromolecular structures, including the Voronoi tesselation-based analysis. Currently, the Voronota-JS package contains several executables:

* “voronota-js” - core engine that executes JavaScript scripts.
* “voronota-js-voromqa” - wrapper to a voronota-js program for computing VoroMQA scores, both old and new (developed for CASP14).
* “voronota-js-only-global-voromqa” - wrapper to a voronota-js program for computing only global VoroMQA scores with fast caching.
* “voronota-js-membrane-voromqa” - wrapper to a voronota-js program for the VoroMQA-based analysis and assessment of membrane protein structural models.
* “voronota-js-ifeatures-voromqa” - wrapper to a voronota-js program for the computation of multiple VoroMQA-based features of protein-protein complexes.
* “voronota-js-fast-iface-voromqa” - wrapper to a voronota-js program for the very fast computation of the inter-chain interface VoroMQA energy.
* “voronota-js-fast-iface-cadscore” - wrapper to a voronota-js program for the very fast computation of the inter-chain interface CAD-score.
* “voronota-js-fast-iface-cadscore-matrix” - wrapper to a voronota-js program for the very fast computation of the inter-chain interface CAD-score matrix.
* “voronota-js-fast-iface-data-graph” - wrapper to a voronota-js program for the computation of interface graphs used by the VoroIF-GNN method.
* “voronota-js-voroif-gnn” - wrapper to a voronota-js program and GNN inference scripts that run the VoroIF-GNN method for scoring models of protein-protein complexes (developed for CASP15).
* “voronota-js-ligand-cadscore” - wrapper to a voronota-js program for the computation of protein-ligand variation of CAD-score (developed to analyze protein-ligand models from CASP15).

## Voronota-LT

[Voronota-LT](./expansion_lt/index.html) expansion is located in the ‘expansion\_lt’ subdirectory of the Voronota package.

Voronota-LT (pronounced ‘voronota lite’) is an alternative version of Voronota for constructing tessellation-derived atomic contact areas and volumes. Voronota-LT was written from scratch and does not use any external code, even from the core Voronota. The primary motivation for creating Voronota-LT was drastically increasing the speed of computing tessellation-based atom-atom contact areas and atom solvent-accessible surface areas. Like Voronota, Voronota-LT can compute contact areas derived from the additively weighted Voronoi tessellation, but the main increase in speed comes when utilizing a simpler, radical tessellation variant, also known as Laguerre-Laguerre tessellation or power diagram.

## Voronota-GL

[Voronota-GL](./expansion_gl/index.html) expansion is located in the ‘expansion\_gl’ subdirectory of the Voronota package

Voronota-GL is a visual tool for the comprehensive interactive analysis of macromolecular structures, including the Voronoi tesselation-based analysis.

# Getting the latest version

Download the latest archive from the official downloads page: <https://github.com/kliment-olechnovic/voronota/releases>.

The archive contains ready-to-use statically compiled ‘voronota’ program for 64 bit Linux systems. This executable can be rebuilt from the provided source code to work on any modern Linux, macOS or Windows operating systems.

On Ubuntu 18.04 and newer it is possible to install Voronota using ‘apt’ command:

```
sudo apt install voronota
```

On Windows 10 operating system the easiest way to run Voronota is to use Windows Subsystem for Linux (WSL).

# Building from source code

## Requirements

Voronota has no required external dependencies, only a standard-compliant C++ compiler is needed to build it.

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
cp ./voronota ../voronota
```

## Using C++ compiler directly

For example, “voronota” executable can be built from the sources in “src” directory using GNU C++ compiler:

```
g++ -O3 -std=c++11 -o voronota $(find ./src/ -name '*.cpp')
```

## Enabling OpenMP

To allow the usage of OpenMP when calling the “calculate-vertices-in-parallel” command, the “-fopenmp” flag needs to be set when building.

When building using C++ compiler directly, just add “-fopenmp”:

```
g++ -O3 -std=c++11 -fopenmp -o voronota $(find ./src/ -name '*.cpp')
```

When using CMake, set the CMAKE\_CXX\_FLAGS variable:

```
cmake -DCMAKE_CXX_FLAGS="-fopenmp" ./
make
```

## Enabling MPI

To allow the usage of MPI when calling the “calculate-vertices-in-parallel” command, you can use mpic++ compiler wrapper and define “ENABLE\_MPI” macro when buiding:

```
mpic++ -O3 -std=c++11 -DENABLE_MPI -o voronota ./$(find ./src/ -name '*.cpp')
```

## TR1 usage switch

Voronota can be built with either modern C++ compilers or pre-C++11 compilers that support C++ Technical Report 1 (TR1) features. The voronota code has preprocessor-based checks to find out if C++ TR1 namespace is available and needs to be used. If compilation fails, it may mean that these checks failed. To troubleshoot this, try setting the value of the “USE\_TR1” macro to 0 (to not use TR1 and to rely on C++11 standard) or 1 (to use TR1) when compiling, for example:

```
g++ -O3 -DUSE_TR1=1 -o voronota $(find ./src/ -name '*.cpp')
```

or

```
g++ -O3 -std=c++11 -DUSE_TR1=0 -o voronota $(find ./src/ -name '*.cpp')
```

# Basic usage example

## Computing Voronoi vertices

Here is a basic example of computing Voronoi vertices for a structure in a PDB file:

```
./voronota get-balls-from-atoms-file < input.pdb > balls.txt
./voronota calculate-vertices < balls.txt > vertices.txt
```

The first command reads a PDB file “input.pdb” and outputs a file “balls.txt” that contains balls corresponding to the atoms in “input.pdb” (by default, Voronota ignores all heteroatoms and all hydrogen atoms when reading PDB files: this behavior can be altered using command-line options). The second command reads “balls.txt” and outputs a file “vertices.txt” that contains a quadruples and empty tangent spheres that correspond to the vertices of the Voronoi diagram of the input balls. The formats of “balls.txt” and “vertices.txt” are described below.

In “balls.txt” the line format is “x y z r # comments”. The first four values (x, y, z, r) are atomic ball coordinates and radius. Comments are not needed for further calculations, they are to assist human readers. For example, below is a part of some possible “balls.txt”:

```
28.888 9.409 52.301 1.7 # 1 A 2 SER N
27.638 10.125 52.516 1.9 # 2 A 2 SER CA
26.499 9.639 51.644 1.75 # 3 A 2 SER C
26.606 8.656 50.915 1.49 # 4 A 2 SER O
27.783 11.635 52.378 1.91 # 5 A 2 SER CB
27.69 12.033 51.012 1.54 # 6 A 2 SER OG
```

In “vertices.txt” the line format is “q1 q2 q3 q4 x y z r”. The first four numbers (q1, q2, q3, q4) are numbers of atomic records in “balls.txt”, starting from 0. The remaining four values (x, y, z, r) are the coordinates and the radius of an empty tangent sphere of the quadruple of atoms. For example, below is a part of some possible “vertices.txt”:

```
0 1 2 3 27.761 8.691 51.553 -0.169
0 1 2 23 28.275 9.804 50.131 0.588
0 1 3 1438 24.793 -3.225 60.761 14.047
0 1 4 5 28.785 10.604 50.721 0.283
0 1 4 1453 30.018 10.901 55.386 1.908
0 1 5 23 28.544 10.254 50.194 0.595
```

## Computing inter-atom contacts

Taking the “balls.txt” file described in the previous section, here is a basic example of computing inter-atom contacts:

```
./voronota calculate-contacts < balls.txt > contacts.txt
```

In “contacts.txt” file the line format is “b1 b2 area”. The first two numbers (b1 and b2) are numbers of atomic records in “balls.txt”, starting from 0. If b1 does not equal b2, then the ‘area’ value is the area of contact between atoms b1 and b2. If b1 equals b2, then the ‘area’ value is the solvent-accessible area of atom b1. For example, below is a part of some possible “contacts.txt”:

```
0 0 35.440
0 1 15.908
0 2 0.167
0 3 7.025
0 4 7.021
0 5 0.624
0 23 2.849
0 25 0.008
0 26 11.323
0 1454 0.021
1 1 16.448
1 2 11.608
1 3 0.327
1 4 14.170
1 5 0.820
1 6 3.902
1 23 0.081
2 2 3.591
2 3 11.714
2 4 0.305
2 5 2.019
```

## Computing annotated inter-atom contacts

Here is a basic example of computing annotated inter-atom contacts:

```
./voronota get-balls-from-atoms-file --annotated < input.pdb > annotated_balls.txt
./voronota calculate-contacts --annotated < annotated_balls.txt > annotated_contacts.txt
```

In “annotated\_contacts.txt” the line format is “annotation1 annotation2 area distance tags adjuncts [graphics]”. The strings ‘annotation1’ and ‘annotation2’ describe contacting atoms, the ‘area’ value is the area of contact between the two atoms, the ‘distance’ value i