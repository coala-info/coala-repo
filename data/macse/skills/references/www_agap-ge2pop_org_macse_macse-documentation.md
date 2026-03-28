[Aller au contenu](#content "Aller au contenu")

[GE²pop](https://www.agap-ge2pop.org/)

Génomique évolutive et gestion des populations

[Home](https://www.agap-ge2pop.org/)

[Tools](https://www.agap-ge2pop.org/tools)

[Datasets](https://www.agap-ge2pop.org/datasets)

![](https://www.agap-ge2pop.org/wp-content/uploads/2023/06/logo_MACSE-1024x567.jpg)

[Tools](https://www.agap-ge2pop.org/tools/)

## **MACSE**

* [Overview](https://www.agap-ge2pop.org/macse/)
* Documentation
  + [Quickstart](https://www.agap-ge2pop.org/macse/macse-quickstart/)
  + [Documentation](https://www.agap-ge2pop.org/macse/macse-documentation/)
  + [Pipeline quickstart](https://www.agap-ge2pop.org/macse/pipeline-quickstart/)
  + [Pipeline documentation](https://www.agap-ge2pop.org/macse/pipeline-documentation/)
  + [Download tutorial files](https://www.agap-ge2pop.org/macse/download-tutorial-files/)
  + [Citing](https://www.agap-ge2pop.org/macse/citing/)
  + [Citations](https://scholar.google.com/scholar?hl=en&lr=&cites=https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0022594)
* Download
  + [MACSE & pipelines](https://www.agap-ge2pop.org/macsee-pipelines/)
  + [Barcoding alignments](https://www.agap-ge2pop.org/barcoding-alignments/)
  + [Tutorial files](https://www.agap-ge2pop.org/macse/download-tutorial-files/)
* [Members](https://www.agap-ge2pop.org/macse/members/)

# This is the documentation for MACSE v2.00

## 1. Overview

MACSE (Multiple Alignment of Coding SEquences Accounting for Frameshifts and Stop Codons) provides a complete toolkit dedicated to the multiple alignment of coding sequences that can be leveraged via both the command line and a Graphical User Interface (GUI).

Multiple sequence alignment (MSA) is a crucial step in many evolutionary analyses. Nonetheless, most existing alignment tools ignore the underlying codon structure of protein-coding nucleotide sequences. Accounting for this structure is not only useful to improve the proposed alignment, but it is also a prerequisite for some downstream analyses such as detection of selection footprints based on the ratio of non-synonymous to synonymous substitutions (dN/dS).

MACSE aligns protein-coding nucleotide (NT) sequences with respect to their amino acid (AA) translation while allowing NT sequences to contain multiple frameshifts and/or stop codons. MACSE was hence the first automatic solution to align protein-coding gene datasets containing non-functional sequences (pseudogenes) without disrupting the underlying codon structure. It has also proved useful in detecting undocumented frameshifts in public database sequences and in aligning next-generation sequencing reads/contigs against a reference coding sequence.

In the output alignment produced by MACSE, frameshifts are indicated using ‘!’. You can specify to MACSE a subset of your sequences that are more likely to contain frameshifts or stop codons, the **less reliable sequences** in the MACSE terminology. This allows to use a lower cost when introducing a stop codon or a frameshift in those sequences as compared to introducing such events in other **reliable sequences**. More details and examples concerning this feature are provided in the [alignSequences section](https://www.agap-ge2pop.org/alignsequences/).

[Seaview](http://pbil.univ-lyon1.fr/software/seaview3) is very convenient to visualize sequence alignments produced by MACSE. Indeed, Seaview accepts the ‘!’ character in both nucleotide and amino acid sequences and also allows to visually emphasize the codon structure of the aligned nucleotide sequences.

![](https://www.agap-ge2pop.org/wp-content/uploads/2023/05/Pg3MedicagoCDS-1024x242.jpg)

An example of the output alignments produced by MACSE. The nucleotide alignment is displayed on the left using the codon based coloration of SEAVIEW, the amino acid alignment is displayed on the right. Two sequences contain frameshifts.

## 2. Getting started with MACSE

If you are new to MACSE, you should probably start here:

* [installing and running MACSE](https://www.agap-ge2pop.org/macse/macse-quickstart/).

## 3. Programs

* [alignSequences](https://www.agap-ge2pop.org/alignsequences/): aligns nucleotide (NT) coding sequences using their amino acid (AA) translations.
* [alignTwoProfiles](https://www.agap-ge2pop.org/aligntwoprofiles/): aligns two previously computed alignments (also called profiles).
* [enrichAlignment](https://www.agap-ge2pop.org/enrichalignment/): adds sequences to a previously computed alignment.
* [exportAlignment](https://www.agap-ge2pop.org/exportalignment/): exports alignments (different formats) and other output files.
* [multiPrograms](https://www.agap-ge2pop.org/multiprograms/): sequentially executes multiple MACSE commands contained in a text file (one per line).
* [refineAlignment](https://www.agap-ge2pop.org/refinealignment/): improves a previously computed alignment.
* [reportGapsAA2NT](https://www.agap-ge2pop.org/reportgapsaa2nt/): reports gaps from aligned AA sequences to the corresponding (unaligned) NT sequences.
* [reportMaskAA2NT](https://www.agap-ge2pop.org/reportmaskaa2nt/): uses a NT alignment and a filtered (masked) version of its AA translation to derive the NT alignment.
* [splitAlignment](https://www.agap-ge2pop.org/splitalignment/): splits an alignment to extract a subset of selected sequences and/or sites.
* [translateNT2AA](https://www.agap-ge2pop.org/translatent2aa/): translates protein-coding nucleotide sequences into amino acid sequences.
* [trimAlignment](https://www.agap-ge2pop.org/trimalignment/): trims the input alignment by removing gappy sites at the beginning/end of the alignment.
* [trimNonHomologousFragments](https://www.agap-ge2pop.org/trimnonhomologousfragments/): identifies sequence fragments that do not share homology with other sequences and remove those fragments.

## 4. Common options

* [genetic codes](https://www.agap-ge2pop.org/genetic-codes/)
* [alignment costs](https://www.agap-ge2pop.org/alignment-costs/)
* [compressed AA alphabet](https://www.agap-ge2pop.org/compressed-aa-alphabet/)
* [allowed nucleotides](https://www.agap-ge2pop.org/allowed-nucleotides/)

© 2026 GE²pop • Construit avec [GeneratePress](https://generatepress.com)