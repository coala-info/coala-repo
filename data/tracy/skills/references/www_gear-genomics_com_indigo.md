# Indigo

SNV and InDel Discovery in Chromatogram traces obtained from Sanger
sequencing of PCR products.

[Get help](https://www.gear-genomics.com/contact)
·
[Citation](https://www.gear-genomics.com/citation)
·
[Source](https://github.com/gear-genomics/indigo)

* [Input](#input-tab)
* [Results](#result-tab)
* [Help](#help-tab)

Chromatogram file (`.scf`, `.abi`,
`.ab1`, `.ab!` or `.ab`)

Left Chromatogram Trim Size

Right Chromatogram Trim Size

Peak percentage to call bases ()

Align to

[Genome](#target-genome)
[FASTA file (single sequence)](#target-fasta)
[Chromatogram file (wildtype)](#target-chromatogram)

Genomes not loaded!

 Launch
Analysis

 Show Example

Analysis is running, please
be patient.

View
PDF

Variants BCF

-- Please select --
Trace & basecall viewer
Alignments
Variants
Decomposition

#### Trace & basecall viewer

Plot help:
[Zoom/pan/hover](https://help.plot.ly/zoom-pan-hover-controls/)
[Toolbar](https://help.plot.ly/getting-to-know-the-plotly-modebar/)

#### Alt1 Alignment

#### Alt2 Alignment

#### Alt1 vs Alt2 Alignment

#### Variants

#### Decomposition plot

Plot help:
[Zoom/pan/hover](https://help.plot.ly/zoom-pan-hover-controls/)
[Toolbar](https://help.plot.ly/getting-to-know-the-plotly-modebar/)

#### Application Description

Indigo is a rapid SNV and InDel discovery method for Chromatogram
traces obtained from Sanger sequencing of PCR products. The tool can
separate a mutated and wildtype allele with the help of a provided
reference. Indigo aligns both alleles against the reference genome,
calls variants and annotates these variants with rs identifiers.
Indigo also estimates the allelic fractions based on the mixed
traces.

#### Accepted Input

The trace files can be provided in abi or scf trace format (\*.scf,
\*.abi, \*.ab1, \*.ab! and \*.ab). The reference can be a genome
selected from the dropdown menu, an uploaded fasta file (\*.fa) or
another trace file (\*.scf, \*.abi, \*.ab1, \*.ab! and \*.ab).

#### Sample Data

The "Show Example" button loads an example trace file
[(click to download file)](static/bin/sample.abi) that is
then separated into two alleles. Both alleles are aligned to the
reference, variants are called and annotated and results can be
downloaded in PDF and VCF format.

[GEAR ~](https://www.gear-genomics.com)
·
·
[Terms of Use](https://www.gear-genomics.com/terms)
·
[Contact Us](https://www.gear-genomics.com/contact)

Supported by
[![EMBL logo](embl.a312a356.svg)](https://www.embl.de/)