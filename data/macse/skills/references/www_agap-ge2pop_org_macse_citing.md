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

# Citing MACSE

If you find MACSE useful, please cite:

* [MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons.
  Vincent Ranwez, Sébastien Harispe, Frédéric Delsuc, Emmanuel JP Douzery
  PLoS One 2011, 6(9): e22594](http://www.plosone.org/article/info%3Adoi/10.1371/journal.pone.0022594).
* [MACSE v2: Toolkit for the Alignment of Coding Sequences Accounting for Frameshifts and Stop Codons.
  V Ranwez, E.J.P Douzery, N. Chantret, F. Delsuc. Molecular Biology and Evolution (2018) 35 (10): 2582-2584.](http://www.plosone.org/article/info%3Adoi/10.1371/journal.pone.0022594)

If you find OMM\_MACSE\_V10 pipeline useful, please cite:

* The OMM\_MACSE pipeline description:
  [Celine Scornavacca, Khalid Belkhir, Jimmy Lopez, R&emy Dernat, Fr&ed&eric Delsuc, Emmanuel J P Douzery, Vincent Ranwez, OrthoMaM v10: Scaling-Up Orthologous Coding Sequence and Exon Alignments with More than One Hundred Mammalian Genomes, Molecular Biology and Evolution, Volume 36, Issue 4, April 2019, Pages 861â€“862, https://doi.org/10.1093/molbev/msz015](https://doi.org/10.1093/molbev/msy159)
* MACSE V2.03:
  [MACSE v2: Toolkit for the Alignment of Coding Sequences Accounting for Frameshifts and Stop Codons.
  Vincent Ranwez, Emmanuel J P Douzery, C&edric Cambon, Nathalie Chantret, Fr&ed&eric Delsuc. Molecular Biology and Evolution (2018) 35 (10): 2582-2584.](http://www.plosone.org/article/info%3Adoi/10.1371/journal.pone.0022594)
* MAFFT v7.271 (default) or MUSCLE v3.8.31 (depending on selected options)
  [Katoh K., Standley D.M. (2013). MAFFT multiple sequence alignment software version 7: improvements in performance and usability. Molecular biology and evolution, 30(4), 772-780.](https://academic.oup.com/mbe/article/30/4/772/1073398)
  [Edgar R.C. (2004). MUSCLE: multiple sequence alignment with high accuracy and high throughput. Nucleic acids research, 32(5), 1792-1797.](https://academic.oup.com/nar/article/32/5/1792/2380623)
* HMMCleaner V1\_8\_VR2 (default)
  [Di Franco, Arnaud, et al. Evaluating the usefulness of alignment filtering methods to reduce the impact of errors on evolutionary inferences. BMC Evolutionary Biology, vol. 19, no. 1, 2019. Gale Academic Onefile, Accessed 13 Oct. 2019.](https://bmcevolbiol.biomedcentral.com/articles/10.1186/s12862-019-1350-2)
  Note that the OMM\_MACSE pipeline uses a modified version (V1\_8\_VR2) of HMMCleaner V1\_8 developped by Raphael Poujol
  Vincent Ranwez modified the original perl script so that
  + sequences and sequence names are unchanged even when they contain unusual characters
  + all output files are saved in the current directory (rather that being spread in the directory containing the input fasta file and HMMCleaner perl script)HMMCleaner has since been re-written by Arnaud Di Franco and a more [recent release of HMMCleanere](https://metacpan.org/pod/HmmCleaner.pl) is available.

© 2026 GE²pop • Construit avec [GeneratePress](https://generatepress.com)