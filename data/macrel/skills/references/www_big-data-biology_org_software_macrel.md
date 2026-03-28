[Home](/index)

[Team](/people/)

[Papers](/papers/)

[Software](/software/)

[Blog](/blog/)

#### Most recent BDB-Lab papers

[Long-read metagenomic sequencing reveals novel lineages and functional diversity in urban soil microbiome](https://doi.org/10.64898/2026.03.20.713087) by [Yiqian Duan,](/person/Yiqian_Duan) *et al*. at *BioRxiv (preprint)*

[Capturing global pet dog gut microbial diversity and hundreds of near-finished bacterial genomes by using long-read metagenomics in a Shanghai cohort](https://doi.org/10.1101/2025.09.17.676595) by [Anna Cuscó,](/person/anna_cusco) *et al*. at *BioRxiv (preprint)*

[AEMB: a computationally efficient abundance estimation method for metagenomic binning](https://doi.org/10.1101/2025.07.30.667338) by [Shaojun Pan,](/person/Shaojun_Pan) *et al*. at *BioRxiv (preprint)*

[argNorm: Normalization of Antibiotic Resistance Gene Annotations to the Antibiotic Resistance Ontology (ARO)](https://doi.org/10.1093/bioinformatics/btaf173) by [Svetlana Ugarcina Perovic,](/person/svetlana_ugarcina_perovic) [Vedanth Ramji,](/person/vedanth_ramji) *et al*. at *Bioinformatics*

[A catalogue of small proteins from the global microbiome](https://doi.org/10.1038/s41467-024-51894-6) by [Yiqian Duan,](/person/Yiqian_Duan) *et al*. at *Nature Communications*

[All papers (including collaboration papers)](/papers/)

#### BDB-Lab Links

[Quarterly newsletter](https://bigdatabiology.substack.com/)
([January 2026 edition](https://bigdatabiology.substack.com/p/bdb-lab-january-2026-updates))

[Big Data Biology Lab's Blog](/blog/)

[@BigDataBiology on Twitter](https://twitter.com/BigDataBiology)

[@BigDataBiology on YouTube](https://youtube.com/%40BigDataBiology)

[Mailing lists](/mailing-lists)

#### Major Projects

[GMGC](/project/gmgc)

[EMBARK](/project/embark)

[Small proteins/smORFs](/project/small_orfs)

[SEARCHER](/project/searcher)

#### Other Links

[FAQ](/faq/)

[Open Positions](/positions/)

[Software Commitments](/software/commitments)

#### Lab Members

[Luis Pedro Coelho](/person/luis_pedro_coelho)

[Anil Pokhrel](/person/Anil_Pokhrel)

[Alexandre Areias Castro](/person/Alexandre_Areias_Castro)

[M Nithya Kruthi](/person/M_Nithya_Kruthi)

[Juan S. Inda-Díaz](/person/Juan_Inda)

[Faith Adegoke](/person/Faith_Adegoke)

[Catarina Loureiro](/person/Catarina_Loureiro)

#### Twitter feed

[Tweets by BigDataBiology](https://twitter.com/BigDataBiology?ref_src=twsrc%5Etfw)

# Macrel webservice

This webserver allows you to use Macrel for short jobs. For larger jobs, you can download and use the [command line version of the tool.](https://macrel.rtfd.io/)

If you use macrel in your published work, please cite:

> *Santos-Júnior CD, Pan S, Zhao X, Coelho LP. 2020. Macrel: antimicrobial peptide screening in genomes and metagenomes.
> PeerJ 8:e10555. doi: [10.7717/peerj.10555](https://doi.org/10.7717/peerj.10555)*

---

## Online AMP prediction

**Step 1.** Select mode:

Predict from contigs (DNA sequences)

Predict from peptides (amino acid sequences)

(The command line tool also supports prediction from short-reads, but this is not available on the webserver).

---

Note that when finding matches in the AMPSphere database, only exact matches are reported. If you want to find similar sequences, you can use the [AMPSphere webserver](https://ampsphere.big-data-biology.org/) or download the database and use the command line version of the tool.

Macrel uses machine learning to select peptides
with high probability of being an AMP. Macrel is optimized for higher
specificity (low rate of false positives).

Macrel will also classify AMPs into hemolytic and
non-hemolytic peptides.

---

Copyright (c) 2018–2026. Luis Pedro Coelho and other group members. All rights reserved.