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

* Frequently Asked Questions (FAQ)

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

* [CLI Reference](cli_reference.html)
* [C++ API Reference](cpp_api/index.html)[ ]
* [Python API](https://hictkpy.readthedocs.io/en/stable/index.html)
* [R API](https://paulsengroup.github.io/hictkR/reference/index.html)

Telemetry

* [Telemetry](telemetry.html)

Back to top

[View this page](_sources/faq.rst.txt "View this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Frequently Asked Questions (FAQ)[¶](#frequently-asked-questions-faq "Link to this heading")

## .hic files created with hictk appear empty when opened in JuiceBox[¶](#hic-files-created-with-hictk-appear-empty-when-opened-in-juicebox "Link to this heading")

The .hic files created by hictk are in the latest format revision (.hic v9).

Versions of Juicebox available on [github.com/aidenlab/Juicebox](https://github.com/aidenlab/Juicebox/wiki/Download) are not capable of reading .hic v9 files.
Instead, you should download the latest version of JuiceBox from the [github.com/aidenlab/JuiceboxGUI](https://github.com/aidenlab/JuiceboxGUI) repository (e.g., [JuiceboxGUI v3.1.4](https://github.com/aidenlab/JuiceboxGUI/releases/tag/v3.1.4)).

## I am trying to install hictk using conda and I am running into package incompatibilities. What can I do?[¶](#i-am-trying-to-install-hictk-using-conda-and-i-am-running-into-package-incompatibilities-what-can-i-do "Link to this heading")

This is a common issue when working with Conda environments (and is not unique to hictk).
Here are some options:

* Install all the dependencies at once, when creating the environment.

  Instead of:
  :   ```
      conda create -n myenv
      conda install -c conda-forge -c bioconda package1
      conda install -c conda-forge -c bioconda package2
      conda install -c conda-forge -c bioconda hictk
      ```

  do:
  :   ```
      conda create -n myenv -c conda-forge -c bioconda package1 package2 hictk
      ```
* Use containers:
  :   ```
      # Note that this may require using sudo
      docker run --rm paulsengroup/hictk --help
      ```
* Compile from source:

  Package incompatibilities encountered with Conda are due to the way applications are compiled and packaged by conda (i.e., using dynamic linking).

  In contrast, when building hictk from source, all of hictk’s dependencies are statically linked into the hictk executable.
  This means that external dependencies are embedded into the hictk executable itself and are thus only needed while compiling hictk.

  After compilation, you are free to remove all of hictk’s dependencies, make copies of the hictk binary, and even share the same binary across multiple machines (provided that system libraries such as libc and libstdc++ are ABI compatible).

  Detailed instructions on how to build hictk from source are available [here](installation_src.html).

## How do I turn off telemetry?[¶](#how-do-i-turn-off-telemetry "Link to this heading")

The simplest way is to ensure you are defining the environment variable `HICTK_NO_TELEMETRY` before running hictk:

```
HICTK_NO_TELEMETRY=1 hictk dump ...
```

You can double-check whether hictk will collect telemetry with:

```
user@dev:/tmp$ HICTK_NO_TELEMETRY=1 hictk --help-telemetry

hictk was compiled WITH support for telemetry.
Telemetry data won't be collected as the environment variable "HICTK_NO_TELEMETRY" is defined.
See https://hictk.readthedocs.io/en/latest/telemetry.html for more details.

user@dev:/tmp$ hictk --help-telemetry

hictk was compiled WITH support for telemetry.
Telemetry data will be collected as the environment variable "HICTK_NO_TELEMETRY" is not defined.
See https://hictk.readthedocs.io/en/latest/telemetry.html for more details.
```

For more details, refer to the [Telemetry](telemetry.html) page in the documentation.

## When fetching expected or observed/expected interactions from .hic files I don’t get interactions for every pixel. How come?[¶](#when-fetching-expected-or-observed-expected-interactions-from-hic-files-i-don-t-get-interactions-for-every-pixel-how-come "Link to this heading")

This is the intended behavior (and it is also how [straw](https://github.com/aidenlab/straw) deals with data from expected matrices).

Despite the relative simplicity of the idea behind a matrix of expected genomic interactions, there is no consensus on exactly how this matrix should be calculated.

Thus, almost every tool calculates this matrix in slightly different ways.

When developing `hictk` we refrained from introducing a new way of computing expected interactions, and instead opted to mimic the behavior of [straw](https://github.com/aidenlab/straw).

## I am getting an error like “(Virtual File Layer) Unable to lock file” when balancing Cooler files with hictk balance[¶](#i-am-getting-an-error-like-virtual-file-layer-unable-to-lock-file-when-balancing-cooler-files-with-hictk-balance "Link to this heading")

Example:

```
[2025-04-11 11:51:22.095] [info]: Writing weights to /tmp/4DNFIZ1ZVXC8.mcool::/resolutions/1000/bins/GW_ICE...
HDF5-DIAG: Error detected in HDF5 (1.14.5):
  #000: src/src/H5F.c line 827 in H5Fopen(): unable to synchronously open file
    major: File accessibility
    minor: Unable to open file
  #001: src/src/H5F.c line 788 in H5F__open_api_common(): unable to open file
    major: File accessibility
    minor: Unable to open file
  #002: src/src/H5VLcallback.c line 3680 in H5VL_file_open(): open failed
    major: Virtual Object Layer
    minor: Can't open object
  #003: src/src/H5VLcallback.c line 3514 in H5VL__file_open(): open failed
    major: Virtual Object Layer
    minor: Can't open object
  #004: src/src/H5VLnative_file.c line 128 in H5VL__native_file_open(): unable to open file
    major: File accessibility
    minor: Unable to open file
  #005: src/src/H5Fint.c line 1963 in H5F_open(): unable to lock the file
    major: File accessibility
    minor: Unable to lock file
  #006: src/src/H5FD.c line 2402 in H5FD_lock(): driver lock request failed
    major: Virtual File Layer
    minor: Unable to lock file
  #007: src/src/H5FDsec2.c line 956 in H5FD__sec2_lock(): unable to lock file, errno = 11, error message = 'Resource temporarily unavailable'
    major: Virtual File Layer
    minor: Unable to lock file
[2025-04-11 11:51:22.095] [critical]: FAILURE! hictk balance encountered the following error: Unable to open file /tmp/4DNFIZ1ZVXC8.mcool (Virtual File Layer) Unable to lock file
```

After computing the balancing weights, `hictk balance` needs to write the weight vectors to the given Cooler file.

This requires that:

* You have write permissions on that file
* The file is not opened in any other process (e.g., Higlass, cooler, hictk, a Jupyter notebook etc.)

If you can’t figure out which process is keeping the file open, you can make a copy of the file and run `hictk balance` that copy.

## How should I cite hictk?[¶](#how-should-i-cite-hictk "Link to this heading")

Thanks for taking the time to check how to properly cite hictk!

* DOI:
  [doi.org/10.1093/bioinformatics/btae408](https://doi.org/10.1093/bioinformatics/btae408)
* Plain text:

  ```
  Roberto Rossini, Jonas Paulsen, hictk: blazing fast toolkit to work with .hic and .cool files Bioinformatics,
  Volume 40, Issue 7, July 2024, btae408, https://doi.org/10.1093/bioinformatics/btae408
  ```
* Bibtex:

  ```
  @article{hictk,
      author = {Rossini, Roberto and Paulsen, Jonas},
      title = "{hictk: blazing fast toolkit to work with .hic and .cool files}",
      journal = {Bioinformatics},
      volume = {40},
      number = {7},
      pages = {btae408},
      year = {2024},
      month = {06},
      issn = {1367-4811},
      doi = {10.1093/bioinformatics/btae408},
      url = {https://doi.org/10.1093/bioinformatics/btae408},
      eprint = {https://academic.oup.com/bioinformatics/article-pdf/40/7/btae408/58385157/btae408.pdf},
  }
  ```

[Next

Quickstart (CLI)](quickstart_cli.html)
[Previous

Installation (source)](installation_src.html)

Copyright © 2023, Roberto Rossini

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Frequently Asked Questions (FAQ)
  + [.hic files created with hictk appear empty when opened in JuiceBox](#hic-files-created-with-hictk-appear-empty-when-opened-in-juicebox)
  + [I am trying to install hictk using conda and I am running into package incompatibilities. What can I do?](#i-am-trying-to-install-hictk-using-conda-and-i-am-running-into-package-incompatibilities-what-can-i-do)
  + [How do I turn off telemetry?](#how-do-i-turn-off-telemetry)
  + [When fetching expected or observed/expected interactions from .hic files I don’t get interactions for every pixel. How come?](#when-fetching-expected-or-observed-expected-interactions-from-hic-files-i-don-t-get-interactions-for-every-pixel-how-come)
  + [I am getting an error like “(Virtual File Layer) Unable to lock file” when balancing Cooler files with hictk balance](#i-am-getting-an-error-like-virtual-file-layer-unable-to-lock-file-when-balancing-cooler-files-with-hictk-balance)
  + [How should I cite hictk?](#how-should-i-cite-hictk)