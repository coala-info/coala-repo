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

## MACSE: Multiple Alignment of Coding SEquences Accounting for Frameshifts and Stop Codons

A wide range of molecular analyses relies on multiple sequence alignments (MSA). Until now the most efficient solution to align nucleotide (NT) sequences containing open reading frames was to use indirect procedures that align amino acid (AA) translation before reporting the inferred gap positions at the codon level. There are two important pitfalls with this approach. Firstly, any premature stop codon impedes using such a strategy. Secondly, each sequence is translated with the same reading frame from beginning to end, so that the presence of a single additional nucleotide leads to both aberrant translation and alignment.

MACSE aligns coding NT sequences with respect to their AA translation while allowing NT sequences to contain multiple frameshifts and/or stop codons. MACSE is hence the first automatic solution to align protein-coding gene datasets containing non-functional sequences (pseudogenes) without disrupting the underlying codon structure. It has also proved useful in detecting undocumented frameshifts in public database sequences and in aligning next-generation sequencing reads/contigs against a reference coding sequence.

For further details about the underlying algorithm see the original publication:
[MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons.
Vincent Ranwez, Sébastien Harispe, Frédéric Delsuc, Emmanuel JP Douzery
PLoS One 2011, 6(9): e22594](http://www.plosone.org/article/info%3Adoi/10.1371/journal.pone.0022594).

© 2026 GE²pop • Construit avec [GeneratePress](https://generatepress.com)