[Skip to main content](#__docusaurus_skipToContent_fallback)

[![SEGUL Logo](/img/logo.svg)![SEGUL Logo](/img/logo.svg)

**SEGUL**](/)[Docs](/docs/intro)[News](/blog)

[GitHub](https://github.com/hhandika/segul)

![SEGUL homepage](/img/screenshots.png)

# SEGUL

An ultrafast and mobile-friendly phylogenomic tool

SEGUL runs on every major platform—iOS, Android, Windows, macOS, and Linux—supporting both ARM and x86 architectures. We believe reproducible genomic research means analyses should be accessible to everyone, regardless of their computing device.

[Learn SEGUL](/docs/intro/)

### Easy to Use

SEGUL offers an intuitive command line interface for efficient operation, along with a user-friendly, interactive graphical interface. We provide comprehensive documentation to help users with varying levels of technical expertise.

### Accessible and Reproducible

SEGUL supports a wide range of devices, from smartphones to high-performance computers, without requiring any runtime dependencies. It also negates the need for supplementary applications like Docker or Singularity, enhancing its user-friendliness and accessibility.

### Fast and Memory Efficient

SEGUL delivers high-speed performance while maintaining minimal memory usage. It’s engineered to leverage multi-core CPUs for rapid data processing, all without requiring manual intervention from the users.

## Features

SEGUL features operation on alignment, genomic-specific, and sequence datasets.

### Alignments

Concatenate, convert, filter, split, and summarize alignment datasets. Also convert between different partition formats. Support Sanger and next-generation sequencing data.

### Genomics

Summarize FASTQ read and contiguous sequence datasets. Work on multiple large datasets simultaneously.

### Sequences

Extract, map, rename, remove, and translate sequence datasets. Support Sanger and next-generation sequencing data.

## Install SEGUL GUI

[![Get it on Microsoft Store](https://get.microsoft.com/images/en-us%20dark.svg)](https://apps.microsoft.com/detail/SEGUI/9np1bq6fw9pw?mode=direct/)[![Download on the Mac App Store](https://tools.applemediaservices.com/api/badges/download-on-the-mac-app-store/black/en-us?size=250x83&releaseDate=1716076800)](https://apps.apple.com/us/app/segui/id6447999874?mt=12&itsct=apps_box_badge&itscg=30200)[![Get it from the Snap Store](https://snapcraft.io/static/images/badges/en/snap-store-black.svg)](https://snapcraft.io/segui)

[![Download on the App Store](https://tools.applemediaservices.com/api/badges/download-on-the-app-store/black/en-us?size=250x83&releaseDate=1716076800)](https://apps.apple.com/us/app/segui/id6447999874?itsct=apps_box_badge&itscg=30200)[![Get it on Google Play](https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png)](https://play.google.com/store/apps/details?id=com.hhandika.segui&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1)

[CLI & other install options](/docs/installation/intro)

## What's New in SEGUL v0.23.0

### New Features 🚀

* [Convert alignments to unaligned sequences](/docs/cli-usage/align-unalign)
* [Add sequence to an existing sequence files/alignments](/docs/cli-usage/sequence-add)
* [Trim alignments](/docs/cli-usage/align-trim)
* New options for filtering alignments ([see details](/docs/cli-usage/align-filter)):
  + Minimum or maximum sequence length
  + Minimum or maximum of parsimony informative sites
  + Minimum taxon counts
  + Based on user-defined list of sequence IDs

### Breaking Changes ⚠️

* Filtering argument changes for better consistency (see [docs](/docs/cli-usage/align-filter))
* Remove `--ntax` option from [alignment filtering](/docs/cli-usage/align-filter) because by default SEGUL automatically and fastly counts the number of unique taxa across all input alignments

### Bug Fixes 🐛

* Fix max-gap filtering issues
* Fix concatenation leading to missing data when sequence IDs in FASTA files contain trailing whitespace

### Other Changes 🛠

* Migrate to Rust 2024 edition
* Update dependencies

Copyright © 2026 H. Handika & J. A. Esselstyn.