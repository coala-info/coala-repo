[ ]
[ ]

![HyPhy Logo](../../images/header-logo.svg)
HyPhy
Hypothesis Testing using Phylogenies

![HyPhy Logo](../../images/header-logo.svg)
HyPhy

[![](../../images/logo.svg)](../..)

* [Home](../.. "Home")
* [News and Releases](../../news/ "News and Releases")
* [About](../../about/ "About")
* [Installation](../../installation/ "Installation")
* [Getting Started](../../getting-started/ "Getting Started")
* [Methods](../../methods/general/ "Methods")
* [Selection](../../methods/selection-methods/ "Selection")
* Tutorials

  + [CLI Tutorial](../CLI-tutorial/ "CLI Tutorial")
  + [CL Prompt Tutorial](./ "CL Prompt Tutorial")

    - [Before you begin](#before-you-begin "Before you begin")
    - [Preparing labeled phylogenies](#preparing-labeled-phylogenies "Preparing labeled phylogenies")
    - [Preparing input data for HyPhy](#preparing-input-data-for-hyphy "Preparing input data for HyPhy")
    - [General Information](#general-information "General Information")
    - [Use BUSTED to test for alignment-wide episodic diversifying selection.](#use-busted-to-test-for-alignment-wide-episodic-diversifying-selection "Use BUSTED to test for alignment-wide episodic diversifying selection.")
    - [Use aBSREL to find lineages which have experienced episodic diversifying selection.](#use-absrel-to-find-lineages-which-have-experienced-episodic-diversifying-selection "Use aBSREL to find lineages which have experienced episodic diversifying selection.")
    - [Use FEL to find sites that have experienced pervasive diversifying selection.](#use-fel-to-find-sites-that-have-experienced-pervasive-diversifying-selection "Use FEL to find sites that have experienced pervasive diversifying selection.")
    - [Use MEME to find sites that have experienced pervasive diversifying selection.](#use-meme-to-find-sites-that-have-experienced-pervasive-diversifying-selection "Use MEME to find sites that have experienced pervasive diversifying selection.")
    - [Use SLAC to find sites that have experienced pervasive diversifying selection.](#use-slac-to-find-sites-that-have-experienced-pervasive-diversifying-selection "Use SLAC to find sites that have experienced pervasive diversifying selection.")
    - [Use FUBAR to find sites that have experienced pervasive diversifying selection.](#use-fubar-to-find-sites-that-have-experienced-pervasive-diversifying-selection "Use FUBAR to find sites that have experienced pervasive diversifying selection.")
    - [Use RELAX to compare selective pressures on different parts of the tree](#use-relax-to-compare-selective-pressures-on-different-parts-of-the-tree "Use RELAX to compare selective pressures on different parts of the tree")
    - [Use FADE to test for directional selection at individual sites in a protein alignment](#use-fade-to-test-for-directional-selection-at-individual-sites-in-a-protein-alignment "Use FADE to test for directional selection at individual sites in a protein alignment")
* Batch Language

  + [Reference](../../hbl-reference/ "Reference")
  + [Library](../../hbl-reference/libv3/ "Library")
* [Resources](../../resources/ "Resources")

# Using HyPhy interactive command line prompt to detect selection.[#](#using-hyphy-interactive-command-line-prompt-to-detect-selection "Permanent link")

These tutorials outline how to prepare data and execute analyses in HyPhy's suite of methods for detecting natural selection in protein-coding alignments.

All analyses described here produce a final output JSON-formatted file which can be uploaded to [HyPhy Vision](http://vision.hyphy.org) for exploration. You can obtain a description of JSON contents for all analyses [here](../../resources/json-fields.pdf). In addition, each analysis will provide live [Markdown-formatted](https://en.wikipedia.org/wiki/Markdown) status indicators to the console while running.

### Before you begin[#](#before-you-begin "Permanent link")

1. Install the current release of HyPhy on your computer, as needed, using [these instructions](../../installation/).
2. This tutorial employs example datasets, available for download as a [zip file](https://github.com/veg/hyphy-site/blob/master/docs/tutorials/files/tutorial_data.zip?raw=true). Unpack this zip file on your machine for use and **remember the absolute path to this directory**. All datasets and output JSON files for this tutorial are in this zip file.
3. This tutorial assumes you are specifically using the HyPhy executable `hyphy`\*. If you have installed a different executable (e.g. `HYPHYMPI`), you may need to alter some commands.

*\*Note: As of version 2.4.0, the old single-core executable, `hyphy`, has been removed; now the multi-core executable is referred to as `hyphy` (a `HYPHYMP` executable is still created for backward compatibility but it is just a sim-link to the `hyphy` executable). This was done for simplicity and because running hyphy with a single-core is rarely the desired choice*

### Preparing labeled phylogenies[#](#preparing-labeled-phylogenies "Permanent link")

Several analyses are accept labeled phylogenies to define branch sets for selection testing. Moreover, the method **RELAX** *requires* a labeled phylogeny to compare selection pressures. To assist in tree labeling, we recommend using our [Phylotree Widget](http://phylotree.hyphy.org). Instructions for using this widget are available [here](../phylotree/).

### Preparing input data for HyPhy[#](#preparing-input-data-for-hyphy "Permanent link")

All analyses require an alignment and corresponding phylogeny for analysis. There are options for preparing your data:

* Prepare your data in two separate files with the alignment and phylogeny each. Most standard alignment formats are accepted (FASTA, phylip, etc.), and the phylogeny should be Newick-formatted.
* Prepare your data in a single file containing a FASTA-formatted alignment, beneath which should be a Newick-formatted phylogeny.
* Prepare your data as a NEXUS file with both a data matrix and a tree block. Note that this file type will be necessary for performing a partitioned analysis, where different sites evolve according to different phylogenies (i.e. a recombination-corrected dataset from [**GARD**](../methods/selection-methods/#gard).

Each of these choices will trigger a slightly different data-input prompt, as described in the **General Information** section below.

### General Information[#](#general-information "Permanent link")

All available selection analyses in HyPhy can be accessed by launching HyPhy from the command line by typing `hyphy -i` *(or launching `HYPHYMPI -i` in an appropriate MPI environment) and entering* *`1`* *to reach the* *`Selection Analyses`*\* menu:
![HyPhy Selection Analyses Menu](../files/images/selection-analyses-menu.png)

In this menu, launch your desired analysis by issuing its associated number (i.e. launch FEL by entering **`2`** upon reaching this menu).

Within each analysis, you will see a series of prompts for providing information. All analyses begin with the following prompts:

* **`Choose Genetic Code`**. Generally, the universal genetic code (**`1`**) should be provided here, unless the dataset of interest uses a different NCBI-defined genetic code. For each option, the corresponding NCBI translation table is indicated.
* **`Select a coding sequence alignment file`**. This option prompts for the dataset to analyze. Provide the **full path** to the dataset of interest.

  + If you provide a file containing only an alignment, HyPhy will issue a subsequent prompt: **`Please select a tree file for the data`**. Supply the full path to your Newick-formatted phylogeny here.
  + If you provide a file containing both an alignment and tree, HyPhy will prompt you to confirm that the tree provided should be used: **`A tree was found in the data file:...Would you like to use it (y/n)?`**. Enter **`y`** to use this tree, or enter **`n`** if a different tree is desired. HyPhy will then prompt for this path.
  + If you provide a NEXUS file, Hyphy will accept the tree(s) as given and will not issue a subsequent prompt.

### Use BUSTED to test for alignment-wide episodic diversifying selection.[#](#use-busted-to-test-for-alignment-wide-episodic-diversifying-selection "Permanent link")

> See [here](../methods/selection-methods/#busted) for a description of the BUSTED method.

We will demonstrate BUSTED use with an alignment of primate sequences for the KSR2 gene, a kinase suppressor of RAS-2, from [Enard et al, 2016](https://elifesciences.org/articles/12469). This dataset is in the file `ksr2.fna`.

Launch HyPhy from the command line by typing `hyphy -i`. Navigate through the prompt to reach the BUSTED analysis: Enter **1** for "Selection Analyses", and then **5** for "BUSTED". Respond to the following prompts:

* **`Choose Genetic Code`**: Enter `1` to select the Universal genetic code.
* **`Select a coding sequence alignment file`**: Enter the full path to the example dataset, `/path/to/tutorial_data/ksr2.fna`
* **`A tree was found in the data file:...Would you like to use it (y/n)?`**: Enter `y` to use the provided tree.
* **`Choose the set of branches to test for selection`**: To execute a BUSTED analysis that tests the entire tree for selection, enter option `1` for **All**. Alternatively, if you wish to test a subset of branches, enter a different option (2,3,4, or other). Note that any labels present in the provided phylogeny will be listed as options in this menu.

BUSTED will now run to completion and print markdown-formatted status indicators to screen, indicating the progression of model fits and concluding with the final BUSTED test results:
![BUSTED markdown output](../files/images/busted-markdown.png)

We, therefore, find that there is evidence for positive, diversifying selection in this dataset, at P=0.0015.

### Use aBSREL to find lineages which have experienced episodic diversifying selection.[#](#use-absrel-to-find-lineages-which-have-experienced-episodic-diversifying-selection "Permanent link")

> See [here](../methods/selection-methods/#absrel) for a description of the aBSREL method.

We will demonstrate aBSREL use with an alignment of HIV-1 envelope protein-coding sequences collected from epidemiologically-linked donor-recipient transmission pairs, from [Frost et al, 2005](http://jvi.asm.org/content/79/10/6523). This dataset is in the file `hiv1_transmission.fna`.

Launch HyPhy from the command line by typing `hyphy -i`. Navigate through the prompt to reach the aBSREL analysis: Enter **1** for "Selection Analyses", and then **6** for "aBSREL". Respond to the following prompts:

* **`Choose Genetic Code`**: Enter `1` to select the Universal genetic code.
* **`Select a coding sequence alignment file`**: Enter the full path to the example dataset, `/path/to/tutorial_data/hiv1_transmission.fna`
* **`A tree was found in the data file:...Would you like to use it (y/n)?`**: Enter `y` to use the provided tree.
* **`Choose the set of branches to test for selection`**: To test for selection on each branch of your tree (an "exploratory" analysis that may suffer from low power), enter option `1` for **All**. Alternatively, if you wish to test for selection only on a subset of branches, enter a different option (2,3,4, or other). Note that any labels present in the provided phylogeny will be listed as options in this menu.

aBSREL will now run to completion and print markdown-formatted status indicators to screen, indicating the progression of model fits and concluding with the final aBSREL test results (abbreviated output shown here with the final result only):
![aBSREL markdown output](../files/images/absrel-markdown.png)

We, therefore, find that there is evidence for episodic diversifying selection in this dataset along three branches, after applying the Bonferroni-Holm procedure to control family-wise error rates.

### Use FEL to find sites that have experienced pervasive diversifying selection.[#](#use-fel-to-find-sites-that-have-experienced-pervasive-diversifying-selection "Permanent link")

> See [here](../methods/selection-methods/#fel) for a description of the FEL method.

We will demonstrate FEL use with an alignment of abalone sperm lysin sequences. This dataset is in the file `lysin.fna`.

Launch HyPhy from the command line by typing `hyphy -i`. Navigate through the prompt to reach the FEL analysis: Enter **1** for "Selection Analyses", and then **2** for "FEL". Respond to the following prompts:

* **`Choose Genetic Code`**: Enter `1` to select the Universal genetic code.
* **`Select a coding sequence alignment file`**: Enter the full path to the example dataset, `/path/to/tutorial_data/lysin.fna`
* **`A tree was found in the data file:...Would you like to use it (y/n)?`**: Enter `y` to use the provided tree.
* **`Choose the set of branches to test for selection`**: To perform tests for diversifying selection that consider all branches, enter option `1` for **All**. Alternatively, if you wish to test for site-level selection considering only a subset of branches, enter a different option (2,3,4, or other). Note that any labels present in the provided phylogeny will be listed as options in this menu.
* **`Use synonymous rate variation? Strongly recommended YES for selection inference.`**: Enter `1` to employ synonymous rate variation. If you would like to constrain dS=1 at all sites, for example, to calculate evolutionary rate point estimates, enter `2`.
* **`Select the p-value threshold to use when testing for selection`**: Provide the desired P-value threshold for calling sites as positively selected. We recommend `0.1` for FEL.

FEL will now run to completion and print markdown-formatted status indicators to screen, indicating the progression of model fits and concluding with the final FEL test results:
![FEL markdown output](../files/images/fel-markdown.png)

Note that FEL will formally test for both positive and negative selection at each site. This analysis found 22 sites under pervasive negative selection and 17 sites under pervasive positive selection at our specified threshold of P<0.1.

### Use MEME to find sites that have experienced pervasive diversifying selection.[#](#use-meme-to-find-sites-that-have-experienced-pervasive-diversifying-selection "Permanent link")

> See [here](../methods/selection-methods/#meme) for a description of the MEME method.

We will demonstrate MEME use with an alignment of abalone sperm lysin sequences. This dataset is in the file `lysin.fna`.

Launch HyPhy from the command line by typing `hyphy -i`. Navigate through the prompt to reach the MEME analysis: Enter **1** for "Selection Analyses", and then **1** for "MEME". Respond to the following prompts:

* **`Choose Genetic Code`**: Enter `1` to select the Universal genetic code.
* **`Select a coding sequence alignment file`**: Enter the full path to the example dataset, `/path/to/tutorial_data/h3_trunk.fna`
* **`A tree was found in the data file:...Would you like to use it (y/n)?`**: Enter `y` to use 