# Voronota-LT version 1.1

* [About Voronota-LT](#about-voronota-lt)
  + [Benchmarking data and results](#benchmarking-data-and-results)
* [Quickest install guide](#quickest-install-guide)
* [Quick install guide](#quick-install-guide)
* [Getting the latest version](#getting-the-latest-version)
* [Building the command-line tool from source code](#building-the-command-line-tool-from-source-code)
  + [Requirements](#requirements)
  + [Using CMake](#using-cmake)
  + [Using C++ compiler directly](#using-c-compiler-directly)
  + [Compiling on Windows](#compiling-on-windows)
* [Running the command-line tool](#running-the-command-line-tool)
  + [Example of a command to write main basic descriptors to files](#example-of-a-command-to-write-main-basic-descriptors-to-files)
* [Filtering (selection) system](#filtering-selection-system)
  + [General syntax](#general-syntax)
  + [Atom (or atom-based descriptor) selection](#atom-or-atom-based-descriptor-selection)
  + [Contact selection](#contact-selection)
* [Using Voronota-LT as a C++ library](#using-voronota-lt-as-a-c-library)
  + [Stateless C++ API](#stateless-c-api)
  + [Stateless C++ API additional features](#stateless-c-api-additional-features)
  + [Stateful C++ API for updatable tessellation](#stateful-c-api-for-updatable-tessellation)
* [Voronota-LT Python bindings](#voronota-lt-python-bindings)
  + [Installation](#installation)
  + [Basic usage examples](#basic-usage-examples)
  + [Biomolecules-focused usage examples](#biomolecules-focused-usage-examples)
* [Voronota-LT Rust bindings](#voronota-lt-rust-bindings)

# About Voronota-LT

Voronota-LT (pronounced ‘voronota lite’) is an alternative version of [Voronota](../index.html) for constructing tessellation-derived atomic contact areas and volumes. Voronota-LT was written from scratch and does not use any external code, even from the core Voronota. The primary motivation for creating Voronota-LT was drastically increasing the speed of computing tessellation-based atom-atom contact areas and atom solvent-accessible surface areas.

Like Voronota, Voronota-LT can compute contact areas derived from the additively weighted Voronoi tessellation, but the main increase in speed comes when utilizing a simpler, radical tessellation variant, also known as Laguerre-Laguerre tessellation or power diagram. This is the default tessellation variant in Voronota-LT. It considers radii of atoms together with the rolling probe radius to define radical planes as bisectors between atoms.

Voronota-LT is distributed as an expansion part of [the Voronota software package](../index.html), mainly to enable other Voronota expansions to easily use the Voronota-LT library.

The core functionality of Voronota-LT is also available via the [Voronota-LT web application](./web/index.html) built using Emscripten.

## Benchmarking data and results

Benchmarking data and results are available [here](./benchmark/index.html).

# Quickest install guide

Since Voronota-LT version 1.0.1, universal binary execuitables of Voronota-LT built with the [Cosmopolitan Libc toolkit](https://github.com/jart/cosmopolitan) are provided.

To download and prepare the latest released cosmopolitan executable, run the following commands in a shell environment (e.g. a Bash shell):

```
wget 'https://github.com/kliment-olechnovic/voronota/releases/download/v1.29.4771/cosmopolitan_voronota-lt_v1.1.492.exe'
mv cosmopolitan_voronota-lt_v1.1.492.exe voronota-lt
chmod +x voronota-lt
```

In case of a PowerShell environment in Windows 8, the setup can be done with a single command:

```
Invoke-WebRequest -Uri 'https://github.com/kliment-olechnovic/voronota/releases/download/v1.29.4771/cosmopolitan_voronota-lt_v1.1.492.exe' -OutFile voronota-lt.exe
```

# Quick install guide

Please refer to the [core Voronota quick install guide](../index.html#quick-install-guide).

# Getting the latest version

Download the latest archive from the official downloads page: <https://github.com/kliment-olechnovic/voronota/releases>.

The archive contains the Voronota-LT software in the ‘expansion\_lt’ subdirectory.

This executable can be built from the provided source code to work on any modern Linux, macOS or Windows operating systems.

# Building the command-line tool from source code

## Requirements

Voronota-LT has no required external dependencies, only a C++14-compliant compiler is needed to build it.

## Using CMake

You can build using CMake for makefile generation.

Change to the ‘expansion\_lt’ directory:

```
cd expansion_lt
```

Then run the sequence of commands:

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
cp ./voronota-lt ../voronota-lt
```

## Using C++ compiler directly

For example, “voronota-lt” executable can be built using GNU C++ compiler.

Change to the ‘expansion\_lt’ directory:

```
cd expansion_lt
```

Then run the compiler:

```
g++ -std=c++14 -O3 -fopenmp -o ./voronota-lt ./src/voronota_lt.cpp
```

Performance-boosting compiler flags can be included:

```
g++ -std=c++14 -Ofast -march=native -fopenmp -o ./voronota-lt ./src/voronota_lt.cpp
```

## Compiling on Windows

### Using Windows Subsystem for Linux

When using Windows Subsystem for Linux, Voronota-LT can be compiled using the same instructions as described above, that is, using CMake or g++ directly.

### Using Microsoft Visual C++ command-line compiler

If you have installed Visual Studio 2017 or later on Windows 10 or later, open ‘Developer Command Prompt for VS’ from start menu, navigate to the ‘expansion\_lt’ folder, and run the following command that produces ‘voronota-lt.exe’ program:

```
cl /Ox /openmp:llvm .\src\voronota_lt.cpp
```

# Running the command-line tool

The overview of command-line options, as well as input and output, is printed when running the “voronota-lt” executable with “–help” or “-h” flags:

```
voronota-lt --help

voronota-lt -h
```

The overview text is the following:

```
Voronota-LT version 1.1

'voronota-lt' executable constructs a radical Voronoi tessellation (also known as a Laguerre-Voronoi diagram or a power diagram)
of atomic balls of van der Waals radii constrained inside a solvent-accessible surface defined by a rolling probe.
The software computes inter-atom contact areas, per-cell solvent accessible surface areas, per-cell constrained volumes.
'voronota-lt' is very fast when used on molecular data with a not large rolling probe radius (less than 2.0 angstroms, 1.4 is recommended)
and can be made even faster by running it using multiple processors.

Options:
    --probe                                          number     rolling probe radius, default is 1.4
    --processors                                     number     maximum number of OpenMP threads to use, default is 2 if OpenMP is enabled, 1 if disabled
    --compute-only-inter-residue-contacts                       flag to only compute inter-residue contacts, turns off per-cell summaries
    --compute-only-inter-chain-contacts                         flag to only compute inter-chain contacts, turns off per-cell summaries
    --run-in-aw-diagram-regime                                  flag to run construct a simplified additively weighted Voronoi diagram, turns off per-cell summaries
    --input | -i                                     string     input file path to use instead of standard input, or '_stdin' to still use standard input
    --periodic-box-directions                        numbers    coordinates of three vectors (x1 y1 z1 x2 y2 z2 x3 y3 z3) to define and use a periodic box
    --periodic-box-corners                           numbers    coordinates of two corners (x1 y1 z1 x2 y2 z2) to define and use a periodic box
    --pdb-or-mmcif-exclude-heteroatoms                          flag to exclude heteroatoms when reading input in PDB or mmCIF format
    --pdb-or-mmcif-include-hydrogens                            flag to include hydrogen atoms when reading input in PDB or mmCIF format
    --pdb-or-mmcif-join-models                                  flag to join multiple models into an assembly when reading input in PDB or mmCIF format
    --pdb-or-mmcif-radii-config-file                 string     input file path for reading atom radii assignment rules
    --grouping-directives                            string     string with grouping directives separated by ';'
    --grouping-directives-file                       string     input file path for grouping directives
    --restrict-input-atoms                           string     selection expression to restrict input balls
    --restrict-contacts                              string     selection expression to restrict contacts before construction
    --restrict-contacts-for-output                   string     selection expression to restrict contacts for output
    --restrict-atom-descriptors-for-output           string     selection expression to restrict single-index data (balls, cells, sites) for output
    --print-contacts                                            flag to print table of contacts to stdout
    --print-contacts-residue-level                              flag to print table of residue-level grouped contacts to stdout
    --print-contacts-chain-level                                flag to print table of chain-level grouped contacts to stdout
    --print-cells                                               flag to print table of per-cell summaries to stdout
    --print-cells-residue-level                                 flag to print table of residue-level grouped per-cell summaries to stdout
    --print-cells-chain-level                                   flag to print table of chain-level grouped per-cell summaries to stdout
    --print-sites                                               flag to print table of binding site summaries to stdout
    --print-sites-residue-level                                 flag to print table of residue-level grouped binding site summaries to stdout
    --print-sites-chain-level                                   flag to print table of chain-level grouped binding site summaries to stdout
    --print-everything                                          flag to print everything to stdout, terminate if printing everything is not possible
    --write-input-balls-to-file                                 output file path to write input balls to file
    --write-contacts-to-file                         string     output file path to write table of contacts
    --write-contacts-residue-level-to-file           string     output file path to write table of residue-level grouped contacts
    --write-contacts-chain-level-to-file             string     output file path to write table of chain-level grouped contacts
    --write-cells-to-file                            string     output file path to write table of per-cell summaries
    --write-cells-residue-level-to-file              string     output file path to write table of residue-level grouped per-cell summaries
    --write-cells-chain-level-to-file                string     output file path to write table of chain-level grouped per-cell summaries
    --write-sites-to-file                            string     output file path to write table of binding site summaries
    --write-sites-residue-level-to-file              string     output file path to write table of residue-level grouped binding site summaries
    --write-sites-chain-level-to-file                string     output file path to write table of chain-level grouped binding site summaries
    --write-tessellation-edges-to-file               string     output file path to write generating IDs and lengths of SAS-constrained tessellation edges
    --write-tessellation-vertices-to-file            string     output file path to write generating IDs and positions of SAS-constrained tessellation vertices
    --write-raw-collisions-to-file                   string     output file path to write a table of both true (contact) and false (no contact) collisions
    --plot-contacts-to-file                          string     output file path to write SVG plot of contacts
    --plot-contacts-residue-level-to-file            string     output file path to write SVG plot of residue-level grouped contacts
    --plot-contacts-chain-level-to-file              string     output file path to write SVG plot of chain-level grouped contacts
    --plot-config-flags                              strings    space-separated list of plotting flags, e.g. ylabeled xlabeled gradient dark compact
    --graphics-output-file-for-pymol                 string     output file path to write contacts drawing script for PyMol
    --graphics-output-file-for-chimera               string     output file path to write contacts drawing script for Chimera or ChimeraX
    --graphics-title                                 string     title to use for the graphics objects generated by the contacts drawing script
    --graphics-restrict-representations              strings    space-separated list of representations to output, e.g.: balls faces wireframe sas sasmesh lattice
    --graphics-coloring-config                       string     string with graphics coloring rules separated by ';'
    --graphics-coloring-config-file                  string     input file path for reading graphics coloring rules
    --sites-view-script-for-pymol                    string     output file path to write sites view script for PyMol
    --sites-view-script-for-chimera                  string     output file path to write sites view script for ChimeraX
    --mesh-output-obj-file                           string     output file path to write contacts surfaces mesh .obj file
    --mesh-print-topology-summary                               flag to print mesh topology summary
    --measure-running-time                                      flag to measure and output running times
    --write-log-to-file                              string     output file path to write global log, does not turn off printing log to stderr
    --force-icode-column                                        flag to always add insertion code column to output tables even if there are no insertion codes
    --extra-columns                                             flag to add extra columns with empty identifier parts to output tables
    --quiet | -q                                                flag to suppress printing non-error log messages to stderr
    --help | -h                                                 flag to print help info to stderr and exit

Standard input stream:
    Several input formats are supported:
      a) Space-separated or tab-separated header-less table of balls, one of the following line formats possible:
             x y z radius
             chainID x y z radius
             chainID residueID x y z radius
             chainID residueID atomName x y z radius
             ch