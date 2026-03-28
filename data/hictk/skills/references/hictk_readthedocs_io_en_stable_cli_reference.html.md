Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

Hide navigation sidebar

Hide table of contents sidebar

[Skip to content](#furo-main-content)

Toggle site navigation sidebar

[hictk documentation](index.html)

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

[hictk documentation](index.html)

Installation

* [Installation](installation.html)
* [Installation (source)](installation_src.html)

FAQ

* [Frequently Asked Questions (FAQ)](faq.html)

Getting Started

* [Quickstart (CLI)](quickstart_cli.html)
* [Quickstart (API)](quickstart_api.html)
* [Downloading test datasets](downloading_test_datasets.html)
* [File validation](file_validation.html)
* [File metadata](file_metadata.html)
* [Format conversion](format_conversion.html)
* [Reading interactions](reading_interactions.html)
* [Creating .cool and .hic files](creating_cool_and_hic_files.html)
* [Creating multi-resolution files (.hic and .mcool)](creating_multires_files.html)
* [Balancing Hi-C matrices](balancing_matrices.html)

How-Tos

* [Reorder chromosomes](tutorials/reordering_chromosomes.html)
* [Dump interactions to .cool or .hic file](tutorials/dump_interactions_to_cool_hic_file.html)

CLI and API Reference

* CLI Reference
* [C++ API Reference](cpp_api/index.html)[ ]
* [Python API](https://hictkpy.readthedocs.io/en/stable/index.html)
* [R API](https://paulsengroup.github.io/hictkR/reference/index.html)

Telemetry

* [Telemetry](telemetry.html)

Back to top

[View this page](_sources/cli_reference.rst.txt "View this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# CLI Reference[¶](#cli-reference "Link to this heading")

For an up-to-date list of subcommands and CLI options refer to `hictk --help`.

## Subcommands[¶](#subcommands "Link to this heading")

```
Blazing fast tools to work with .hic and .cool files.
hictk [OPTIONS] [SUBCOMMANDS]
OPTIONS:
  -h,     --help              Print this help message and exit
  -V,     --version           Display program version information and exit
[Option Group: help]
  [At most 1 of the following options are allowed]
OPTIONS:
          --help-cite         Print hictk's citation in Bibtex format and exit.
          --help-build-meta   Print information regarding hictk's build options and third-party
                              dependencies, and exit.
          --help-docs         Print the URL to hictk's documentation and exit.
          --help-license      Print the hictk license and exit.
          --help-telemetry    Print information regarding telemetry collection and exit.
SUBCOMMANDS:
  balance                     Balance Hi-C files using ICE, SCALE, or VC.
  convert                     Convert Hi-C files between different formats.
  dump                        Read interactions and other kinds of data from .hic and Cooler
                              files and write them to stdout.
  fix-mcool                   Fix corrupted .mcool files.
  load                        Build .cool and .hic files from interactions in various text
                              formats.
  merge                       Merge multiple Cooler or .hic files into a single file.
  metadata                    Print file metadata to stdout.
  rename-chromosomes, rename-chromsRename chromosomes found in Cooler files.
  validate                    Validate .hic and Cooler files.
  zoomify                     Convert single-resolution Cooler and .hic files to
                              multi-resolution by coarsening.
```

## hictk balance[¶](#hictk-balance "Link to this heading")

```
Balance Hi-C files using ICE, SCALE, or VC.
hictk balance [OPTIONS] SUBCOMMAND
OPTIONS:
  -h,     --help              Print this help message and exit
SUBCOMMANDS:
  ice                         Balance Hi-C files using ICE.
  scale                       Balance Hi-C files using SCALE.
  vc                          Balance Hi-C matrices using VC.
```

## hictk balance ice[¶](#hictk-balance-ice "Link to this heading")

```
Balance Hi-C files using ICE.
hictk balance ice [OPTIONS] input
POSITIONALS:
  input TEXT:((.[ms]cool) OR (.hic)) AND (NOT .scool) REQUIRED
                              Path to the .hic, .cool or .mcool file to be balanced.
OPTIONS:
  -h,     --help              Print this help message and exit
          --mode TEXT:{gw,trans,cis} [gw]
                              Balance matrix using:
                              - genome-wide interactions (gw)
                              - trans-only interactions (trans)
                              - cis-only interactions (cis)
          --tmpdir TEXT:DIR   Path to a folder where to store temporary data.
          --ignore-diags UINT [2]
                              Number of diagonals (including the main diagonal) to mask before
                              balancing.
          --mad-max FLOAT:NONNEGATIVE [5]
                              Mask bins using the MAD-max filter.
                              Bins whose log marginal sum is less than --mad-max median
                              absolute deviations below the median log marginal sum of all the
                              bins in the same chromosome.
          --min-nnz UINT [10]
                              Mask rows with fewer than --min-nnz non-zero entries.
          --min-count UINT [0]
                              Mask rows with fewer than --min-count interactions.
          --tolerance FLOAT:NONNEGATIVE [1e-05]
                              Threshold of the variance of marginals used to determine whether
                              the algorithm has converged.
          --max-iters UINT:POSITIVE [500]
                              Maximum number of iterations.
          --rescale-weights, --no-rescale-weights{false}
                              Rescale weights such that rows sum approximately to 2.
          --name TEXT         Name to use when writing weights to file.
                              Defaults to ICE, INTER_ICE and GW_ICE when --mode is cis, trans
                              and gw, respectively.
          --create-weight-link, --no-create-weight-link{false}
                              Create a symbolic link to the balancing weights at
                              clr::/bins/weight.
                              Ignored when balancing .hic files
          --in-memory         Store all interactions in memory (greatly improves performance).
          --stdout            Write balancing weights to stdout instead of writing them to the
                              input file.
          --chunk-size UINT:POSITIVE [10000000]
                              Number of interactions to process at once. Ignored when using
                              --in-memory.
  -v,     --verbosity INT:INT in [1 - 4] [3]
                              Set verbosity of output to the console.
  -t,     --threads UINT:UINT in [1 - 32] [1]
                              Maximum number of parallel threads to spawn.
  -l,     --compression-lvl INT:INT in [0 - 19] [3]
                              Compression level used to compress temporary files using ZSTD.
  -f,     --force             Overwrite existing files and datasets (if any).
```

## hictk balance scale[¶](#hictk-balance-scale "Link to this heading")

```
Balance Hi-C files using SCALE.
hictk balance scale [OPTIONS] input
POSITIONALS:
  input TEXT:((.[ms]cool) OR (.hic)) AND (NOT .scool) REQUIRED
                              Path to the .hic, .cool or .mcool file to be balanced.
OPTIONS:
  -h,     --help              Print this help message and exit
          --mode TEXT:{gw,trans,cis} [gw]
                              Balance matrix using:
                              - genome-wide interactions (gw)
                              - trans-only interactions (trans)
                              - cis-only interactions (cis)
          --tmpdir TEXT       Path to a folder where to store temporary data.
          --max-percentile FLOAT [10]
                              Percentile used to compute the maximum number of nnz values that
                              cause a row to be masked.
          --max-row-sum-err FLOAT:NONNEGATIVE [0.05]
                              Row sum threshold used to determine whether convergence has been
                              achieved.
          --tolerance FLOAT:NONNEGATIVE [0.0001]
                              Threshold of the variance of marginals used to determine whether
                              the algorithm has converged.
          --max-iters UINT:POSITIVE [500]
                              Maximum number of iterations.
          --rescale-weights, --no-rescale-weights{false}
                              Rescale weights such that the sum of the balanced matrix is
                              similar to that of the input matrix.
          --name TEXT         Name to use when writing weights to file.
                              Defaults to SCALE, INTER_SCALE and GW_SCALE when --mode is cis,
                              trans and gw, respectively.
          --create-weight-link, --no-create-weight-link{false}
                              Create a symbolic link to the balancing weights at
                              clr::/bins/weight.
                              Ignored when balancing .hic files
          --in-memory         Store all interactions in memory (greatly improves performance).
          --stdout            Write balancing weights to stdout instead of writing them to the
                              input file.
          --chunk-size UINT:POSITIVE [10000000]
                              Number of interactions to process at once. Ignored when using
                              --in-memory.
  -v,     --verbosity INT:INT in [1 - 4] [3]
                              Set verbosity of output to the console.
  -t,     --threads UINT:UINT in [1 - 32] [1]
                              Maximum number of parallel threads to spawn.
  -l,     --compression-lvl INT:INT in [0 - 19] [3]
                              Compression level used to compress temporary files using ZSTD.
  -f,     --force             Overwrite existing files and datasets (if any).
```

## hictk balance vc[¶](#hictk-balance-vc "Link to this heading")

```
Balance Hi-C matrices using VC.
hictk balance vc [OPTIONS] input
POSITIONALS:
  input TEXT:((.[ms]cool) OR (.hic)) AND (NOT .scool) REQUIRED
                              Path to the .hic, .cool or .mcool file to be balanced.
OPTIONS:
  -h,     --help              Print this help message and exit
          --mode TEXT:{gw,trans,cis} [gw]
                              Balance matrix using:
                              - genome-wide interactions (gw)
                              - trans-only interactions (trans)
                              - cis-only interactions (cis)
          --rescale-weights, --no-rescale-weights{false}
                              Rescale weights such that the sum of the balanced matrix is
                              similar to that of the input matrix.
          --name TEXT         Name to use when writing weights to file.
                              Defaults to VC, INTER_VC and GW_VC when --mode is cis, trans and
                              gw, respectively.
          --create-weight-link, --no-create-weight-link{false}
                              Create a symbolic link to the balancing weights at
                              clr::/bins/weight.
                              Ignored when balancing .hic files
          --stdout            Write balancing weights to stdout instead of writing them to the
                              input file.
  -v,     --verbosity INT:INT in [1 - 4] [3]
                              Set verbosity of output to the console.
  -f,     --force             Overwrite existing files and datasets (if any).
```

## hictk convert[¶](#hictk-convert "Link to this heading")

```
Convert Hi-C files between different formats.
hictk convert [OPTIONS] input output
POSITIONALS:
  input TEXT:((.[ms]cool) OR (.hic)) AND (NOT .scool) REQUIRED
                              Path to the .hic, .cool or .mcool file to be converted.
  output TEXT REQUIRED        Output path. File extension is used to infer output format.
OPTIONS:
  -h,     --help              Print this help message and exit
          --output-fmt TEXT:{cool,mcool,hic} [auto]
                              Output format (by default this is inferred from the output file
                              extension).
                              Should be one of:
                              - cool
                              - mcool
                              - hic
  -r,     --resolutions UINT:POSITIVE ...
                              One or more resolutions to be converted. By default all
                              resolutions are converted.
          --normalization-methods TEXT [ALL]  ...
                              Name of one or more normalization methods to be copied.
                              By default, vectors for all known normalization methods are
                              copied.
                              Pass NONE to avoid copying the normalization vectors.
          --fail-if-norm-not-found
                              Fail if any of the requested normalization vectors are missing.
  -g,     --genome TEXT       Genome assembly name. By default this is copied from the .hic
                              file metadata.
          --tmpdir TEXT:DIR   Path where to store temporary files.
          --chunk-size UINT:POSITIVE [10000000]
                              Batch size to use when converting .[m]cool to .hic.
  -v,     --verbosity INT:INT in [1 - 4] [3]
                              Set verbosity of output to the console.
  -t,     --threads UINT:UINT in [2 - 32] [2]
                              Maximum number of parallel threads to spawn.
                              When converting from hic to cool, only two threads will be used.
  -l,     --compression-lvl UINT:INT in [1 - 12] [6]
                              Compression level used to compress interactions.
                              Defaults to 6 and 10 for .cool and .hic files, respectively.
          --skip-all-vs-all, --no-skip-all-vs-all{false}
                              Do not generate All vs All matrix.
                              Has no effect when creating .[m]cool files.
          --count-type TEXT:{auto,int,float} [auto]
                              Specify the strategy used to infer count types when converting
                              .hic files to .[m]cool format.
                              Can be one of: int, float, or auto.
  -f,     --force             Overwrite existing files (if any).
```

## hictk dump[¶](#hictk-dump "Link to this heading")

```
Read interactions and other kinds of data from .hic and Cooler files and write
them to stdout.