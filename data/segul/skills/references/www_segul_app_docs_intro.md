[Skip to main content](#__docusaurus_skipToContent_fallback)

[![SEGUL Logo](/img/logo.svg)![SEGUL Logo](/img/logo.svg)

**SEGUL**](/)[Docs](/docs/intro)[News](/blog)

[GitHub](https://github.com/hhandika/segul)

* [Introduction](/docs/intro)
* [Quick Start](/docs/quick_start)
* [CLI vs GUI](/docs/cli_gui)
* [Features](/docs/features)
* [Installation](/docs/category/installation)
* [GUI Usages](/docs/category/gui-usages)
* [CLI Usages](/docs/category/cli-usages)
* [API Usages](/docs/category/api-usages)
* [Advanced Guides](/docs/category/advanced-guides)
* [Tutorials](/docs/category/tutorials)
* [Terms and Conditions](/docs/terms)
* [Privacy Policy](/docs/privacy)
* [Support](/docs/support)

* Introduction

On this page

# Introduction

**Thank you for using SEGUL!** 🙏🏻

We develop **SEGUL (SEquence and Genomic UtiLities)** to address the need for a high-performance and accessible phylogenomic tool. It is particularly well-suited for large-scale phylogenomic projects, especially those involving thousands of loci and hundreds of samples. Additionally, SEGUL is capable of handling small Sanger sequences effectively. SEGUL is a practical solution to typical phylogenomic data analyses and a proof of concept for genomic software that scales from smartphones, tablets, and personal computers to high-performance computing clusters. Check out [Chan 2024 perspective](https://onlinelibrary.wiley.com/doi/full/10.1111/1755-0998.13993) for an independent review of SEGUL.

info

SEGUL CLI is available on [Bioconda](https://anaconda.org/bioconda/segul). It is available for Linux and MacOS users using [ARM](https://en.wikipedia.org/wiki/ARM_architecture_family) or [x86\_64](https://en.wikipedia.org/wiki/X86-64) CPUs. To install SEGUL, use the following command:

```
conda install bioconda::segul
```

Or if you use mamba:

```
mamba install segul
```

Learn more about the installation using Bioconda [here](/docs/installation/install_conda).

## Citation[​](#citation "Direct link to Citation")

> Handika, H., and J. A. Esselstyn. 2024. SEGUL: Ultrafast, memory-efficient and mobile-friendly software for manipulating and summarizing phylogenomic datasets. *Molecular Ecology Resources*, 24(7). <https://doi.org/10.1111/1755-0998.13964>.

If you are interested in reading the journal article but cannot access it, you can request a copy from the authors on [ResearchGate](https://www.researchgate.net/publication/380125709_SEGUL_Ultrafast_memory-efficient_and_mobile-friendly_software_for_manipulating_and_summarizing_phylogenomic_datasets).

## Platform Support[​](#platform-support "Direct link to Platform Support")

### Desktop[​](#desktop "Direct link to Desktop")

| Platform | GUI | CLI |
| --- | --- | --- |
| Linux | ✅ | ✅ |
| MacOS | ✅ | ✅ |
| Windows | ✅ | ✅ |
| Windows Subsystem for Linux (WSL) | ❌ | ✅ |

### Mobile[​](#mobile "Direct link to Mobile")

| Platform | GUI | CLI |
| --- | --- | --- |
| iOS | ✅ | ❌ |
| iPadOS | ✅ | ❌ |
| Android | ✅ | ❌ |

## Navigating the Documentation[​](#navigating-the-documentation "Direct link to Navigating the Documentation")

We provide a [quick start](/docs/quick_start) with an overview of using SEGUL. Detailed instructions on installing SEGUL are available in the [installation guidelines](/docs/installation/intro). Feature usage guidelines are structured by interfaces (i.e., GUI, CLI, or API) organized as sections: [GUI Usage](/docs/category/gui-usages), [CLI Usage](/docs/category/cli-usages), and [API Usage](/docs/category/api-usages). Within a section, we provide a detailed instruction page for each feature. The instructions are independent of each other, and should contain enough information to use a feature for its respective interface. However, we recommend checking the introduction page for each section. The page provides a general overview, input and output formats, datatype, and other general information on using the interface. We also provide a [feature page](/docs/features) (work in progress) that provides a more detailed explanation, including the inner-working of all supported features. If you have questions, issues, or feedback about the app and its documentation, please refer to the [support](/docs/support) section. We also welcome collaboration and contribution.

tip

A dropdown menu at the top of each page allows you to navigate to different documentation sections for mobile reading. The sidebar on the right side of the page provides the same functionality for larger screen reading.

## Additional Resources[​](#additional-resources "Direct link to Additional Resources")

* [API Documentation](https://docs.rs/segul/0.18.1/segul/)
* [GUI Source Code](https://github.com/hhandika/segui)
* [CLI & Rust API Source Code](https://github.com/hhandika/segul)
* [Python API Source Code](https://github.com/hhandika/pysegul)

[Edit this page](https://github.com/hhandika/segui/tree/main/website/docs/intro.mdx)

[Next

Quick Start](/docs/quick_start)

* [Citation](#citation)
* [Platform Support](#platform-support)
  + [Desktop](#desktop)
  + [Mobile](#mobile)
* [Navigating the Documentation](#navigating-the-documentation)
* [Additional Resources](#additional-resources)

Copyright © 2026 H. Handika & J. A. Esselstyn.