NEFFy

NEFF Calculator and MSA File Converter

[Edit on GitHub](https://github.com/Maryam-Haghani/Neffy)

Loading...

Searching...

No Matches

Help Page

## Table of Contents

* [Alphabet](#alphabet)
* [Non-standard Residues](#non_standard)
* [make Installation](#make_installation)

# Alphabet

Each biological sequence is encoded using a valid set of characters to represent its composition. In the case of `protein`, this set consists of 20 canonical amino acids, with each amino acid being represented by a specific letter. The list includes: `A`, `C`, `D`, `E`, `F`, `G`, `H`, `I`, `K`, `L`, `M`, `N`, `P`, `Q`, `R`, `S`, `T`, `V`, `W`, `Y`. Additionally, six non-standard amino acids, as detailed in [Non-standard Residues](#non_standard) section, also are included within the protein alphabet.
For `DNA` sequences, the alphabet comprises `A`, `U`, `C`, `G` along with non-standard nucleic acid, `N`. Similarly, in the case of `RNA` sequences, the alphabet consists of `A`, `U`, `C`, `G` along with non-standard nucleic acid, `N`.
Among the [available tools](other_tools.html) for NEFF computation, while [RaptorX](other_tools.html#raptorX) and [Conkit](other_tools.html#conkit) do not explicitly specify an alphabet, [DeepMSA](other_tools.html#deep_msa) and [rMSA](other_tools.html#rMSA) operate within the `protein` alphabet. In contrast, [Gremlin](other_tools.html#gremlin) provides support for both `protein` and `RNA` (implicitly including `DNA`). Similarly, `NEFFy` covers a broad spectrum of biological sequences, encompassing proteins and nucleic acids, much like [Gremlin](other_tools.html#gremlin).

---

# Non-standard Residues

Non-standard residues are those that fall outside the standard set of residues, which typically includes `N` for DNAs and RNAs and `X`, `B`, `J`, `O`, `U` and `Z` for proteins. When it comes to NEFF computation and comparing the positions of a pair of sequences for similarity, there are various strategies available for handling these non-standard residues. One approach is to treat them as if they were standard amino acids, akin to the behavior exhibited by [DeepMSA](other_tools.html#deep_msa)'s symmetric version. Alternatively, they can be designated as gaps only when determining the permissible number of mismatches for each sequence, resembling the approach taken by [DeepMSA](other_tools.html#deep_msa)'s asymmetric option. Another option, similar to the practices of [rMSA](other_tools.html#rMSA) and [Gremlin](other_tools.html#gremlin), involves categorizing them as gaps both in the calculation of number of allowable mismatches and in aligning corresponding positions for a pair of sequences. Among the tools, [RaptorX](other_tools.html#raptorX) and [Conkit](other_tools.html#conkit) do not handle these residues. NEFFy is the only tool capable of handling these residues based on user preference,and its default option is to treat them as standard residues.

---

# `make` Installation

To use the `make` command, follow the steps below according to your operating system:

## macOS

The `make` command is not available by default on macOS. However, it can be easily installed by installing the Xcode Command Line Tools. You can do this by running the following command in the Terminal:

xcode-select --install

## Linux

The `make` command is commonly available by default on many Linux distributions. If it's not installed, it can be easily added using the package manager of your distribution. For example:

* On Debian-based systems (e.g., Ubuntu):

  sudo apt-get install make
* On Red Hat-based systems (e.g., Fedora):

  sudo dnf install make
* On Arch-based systems:

  sudo pacman -S make

## Windows

The `make` command is not available by default on Windows. However, it can be installed through several methods:

1. **Using Cygwin**:
   * Install Cygwin from the [Cygwin website](https://www.cygwin.com/).
   * During the installation, select `make` from the package list.
2. **Using GnuWin**:
   * Go to the [GnuWin website](http://gnuwin32.sourceforge.net/packages/make.htm).
   * Download the `make` package setup executable (e.g., `make-3.81.exe`).
   * Run the installer and follow the instructions to install `make`.
3. **Using WSL (Windows Subsystem for Linux)**:
   * Install WSL and a Linux distribution from the Microsoft Store (e.g., Ubuntu).
   * Once the distribution is set up, you can use the package manager to install `make` as you would on a native Linux system.

**Set Up Environment Variables**:

* After installing, add the `make` binary to your system’s PATH.
* Open the Start Menu, search for "Environment Variables," and select "Edit the system environment variables."
* In the System Properties window, click on the "Environment Variables" button.
* In the Environment Variables window, find the "Path" variable in the "System variables" section, select it, and click "Edit."
* Click "New" and add the path to the directory where `make.exe` was installed (e.g., `C:\Program Files (x86)\GnuWin32\bin`).
* Click "OK" to close all the windows.

**Verify the Installation**:

* Open a new Command Prompt window.
* Type `make --version` and press Enter.
* You should see the version information for `make`, confirming that it has been installed correctly.

By following these steps, you can have the `make` command available on macOS, Linux, and Windows, ensuring a consistent development environment across different operating systems.

---

For further assistance or inquiries, please contact the developer or create an [issue](https://github.com/Maryam-Haghani/Neffy/issues) in the GitHub repository.

Footer

---

Generated by [![doxygen](doxygen.svg)](https://www.doxygen.org/index.html) 1.11.0

© Copyright 2024, Maryam Haghani