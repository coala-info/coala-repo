[Skip to content](#content)

Menu

[Microbiology.se](https://microbiology.se)

* [Home](https://microbiology.se)
* [Who we are](https://microbiology.se/people/)
  + [The team](https://microbiology.se/people/)
  + [Johan Bengtsson-Palme](https://microbiology.se/people/about/)
  + [Open positions](https://microbiology.se/people/open-positions/)
  + [Lab alumni](https://microbiology.se/people/lab-alumni/)
* [What we do](https://microbiology.se/research-interests/)
  + [Antibiotic resistance](https://microbiology.se/research-interests/antibiotic-resistance/)
  + [Community interactions](https://microbiology.se/research-interests/interactions/)
  + [Bacterial pathogenicity](https://microbiology.se/research-interests/pathogenicity/)
  + [Methods development](https://microbiology.se/research-interests/metagenomics/)
  + [Molecular taxonomy](https://microbiology.se/research-interests/molecular-taxonomy/)
  + [Grants](https://microbiology.se/research-interests/grants/)
  + [Teaching](https://microbiology.se/research-interests/teaching/)
* [Publications](https://microbiology.se/publications/)
* [Software](https://microbiology.se/software/)
  + [ITSx](https://microbiology.se/software/itsx/)
  + [Metaxa2](https://microbiology.se/software/metaxa2/)
    - [Metaxa2 FAQ](https://microbiology.se/software/metaxa2/metaxa2-faq/)
  + [MetaxaQR](https://microbiology.se/software/metaxaqr/)
    - [MetaxaQR FAQ](https://microbiology.se/software/metaxaqr/metaxaqr-faq/)
  + [Consension](https://microbiology.se/software/consension/)
  + [Mumame](https://microbiology.se/software/mumame/)
  + [CAFE](https://microbiology.se/software/cafe/)
  + [FARAO](https://microbiology.se/software/farao/)
    - [FARAO Parsers](https://microbiology.se/software/farao/parsers/)
  + [COAT](https://microbiology.se/software/coat/)
  + [Megraft](https://microbiology.se/software/megraft/)
  + [PETKit](https://microbiology.se/software/petkit/)
  + [TriMetAss](https://microbiology.se/software/trimetass/)
  + [Depreciated](https://microbiology.se/software)
    - [Metaxa](https://microbiology.se/software/metaxa/)
      * [Metaxa FAQ](https://microbiology.se/software/metaxa/metaxa-faq/)
  + [Scripts](https://microbiology.se/software/scripts/)

[The Bengtsson-Palme Lab

at Chalmers University of Technology
and the University of Gothenburg
**Microbiology, Metagenomics, Microbial Ecology and Bioinformatics**](https://microbiology.se)

# Metaxa2

**Metaxa2: Improved Identification and Taxonomic Classification of Small and Large Subunit rRNA in Metagenomic Data**

[Download the Metaxa2 package](https://microbiology.se/sw/Metaxa2_2.2.3.tar.gz) (version 2.2.3)

[Read the Metaxa2 manual](https://microbiology.se/publ/metaxa2_users_guide_2.2.pdf)

[Read the FAQ](https://microbiology.se/software/metaxa2/metaxa2-faq/)

Looking for the previous version of Metaxa? It is still available, [here](https://microbiology.se/software/metaxa/).

Please e-mail me if you encounter bugs or have questions, but first check out the FAQ! If you do not find your answer there, then feel free to e-mail me. My e-mail address is firstname.lastname[a]microbiology.se (and my name is Johan Bengtsson-Palme).

Version history

* 21st January 2013 – 2.0 beta – first public release.
* 4th March 2013 – 2.0 beta 2 – support for blast+ and paired-end reads in FASTA format.
* 9th April 2013 – 2.0 beta 3 – LSU support, rewritten classifier with improved taxonomic prediction.
* 22nd July 2013 – 2.0 beta 4 – cleaner database with less bad sequences, HMMER 3.1 compatibility, 12S
  support reintroduced.
* 10th November 2013 – 2.0 beta 5 – taxonomic classifier much improved, minor bug fixes.
* 26th November 2013 – 2.0 release candidate – software taken out of beta.
* 28th January 2014 – 2.0 release candidate 3 – cosmetic fixes.
* 5th November 2014 – 2.0.1 – stable release with slightly improved classifier.
* 7th April 2015 – 2.0.2 – slight improvements to the classifier, minor bug fixes.
* 2nd October 2015 – 2.1 – introduced Metaxa2 Diversity Tools, added the genome and reference modes, minor bug fixes.
* 9th October 2015 – 2.1.1 – fixed a bug in metaxa2\_uc.
* 15th January 2016 – 2.1.2 – enhanced memory efficiency.
* 7th April 2016 – 2.1.3 – features added to the metaxa2\_uc and metaxa2\_rf tools.
* 14th December 2017 – 2.2 beta 8 – added support for custom databases and improved the classifier (public beta).
* 1st January 2018 – 2.2 beta 9 – added support for custom databases and improved the classifier (public beta).
* 28th January 2018 – 2.2 beta 10 – added support for VSEARCH (public beta).
* 15th June 2018 – 2.2 – stable version including the Metaxa2 Database Builder
* 15th June 2020 – 2.2.1 – updated compatibility with HMMER 3.3
* 14th August 2020 – 2.2.2 – bug fixes related to the database repository
* 13th February 2021 – 2.2.3 – fixed a genome mode file reading bug

If you for any reason would be interested in an older version of Metaxa or Metaxa2, please e-mail me at the address below.

If you use Metaxa2 in your research, please cite it as:

Bengtsson-Palme J, Hartmann M, Eriksson KM, Pal C, Thorell K, Larsson DGJ, Nilsson RH: **Metaxa2: Improved Identification and Taxonomic Classification of Small and Large Subunit rRNA in Metagenomic Data**. Molecular Ecology Resources (2015). *[doi: 10.1111/1755-0998.12399](http://dx.doi.org/10.1111/1755-0998.12399)*

If you use the Metaxa2 database builder, please cite it as:

Bengtsson-Palme J, Richardson RT, Meola M, Wurzbacher C, Tremblay ED, Thorell K, Kanger K, Eriksson KM, Bilodeau GJ, Johnson RM, Hartmann M, Nilsson RH: **Metaxa2 Database Builder: Enabling taxonomic identification from metagenomic and metabarcoding data using any genetic marker**. Bioinformatics (2018). *[doi: 10.1093/bioinformatics/bty482](http://dx.doi.org/10.1093/bioinformatics/bty482)*

Contact information

Johan Bengtsson-Palme (firstname.lastname [at] microbiology.se)
University of Gothenburg
Department of Infectious Diseases
Guldhedsgatan 10
413 46 Göteborg

6 Comments

1. ![](https://secure.gravatar.com/avatar/1f35a1cf656c90f5081c3df5028a2540?s=70&d=blank&r=g)

   [Mikkel Winther Pedersen](http://geogenetics.ku.dk/staff/?pure=en/persons/289258)

   Hi Johan,

   Very interesting pipeline Metaxa 2.0, I have been testing it out on a metagenomic dataset of mine. I have a question related to the database imbedded in the programme. Would it be possible to use a database containing other taxonomically distinct genes? By referring to an external database, and what about the HMMs’s could these be substituted too?

   All the best,
   Mikkel

   February 11, 2015
2. ![](https://secure.gravatar.com/avatar/f26149d613f778d2fc8b528997ba4c00?s=70&d=blank&r=g)

   [Johan](https://www.microbiology.se)

   Dear Mikkel,

   I am not 100% sure what exactly you mean by “other taxonomically distinct genes”. Do you refer to, e.g., the *rpoB* genes or some other genetic barcode? Indeed this is somewhat like what we have done with [ITSx](https://microbiology.se/software/itsx/), but it turned out to be a much larger task than we envisioned. That said, Metaxa2 is in principle designed to deal with other genes as well, but that would require some changes to the code. Better ease-of-use for custom databases could be a suggestion for upcoming updates to the program, given that it is something that users need. Please send me an e-mail if you want to discuss this option further!

   Best,
   Johan

   February 17, 2015

### Add a Comment[Cancel reply](/software/metaxa2/#respond)

You must be [logged in](https://microbiology.se/wp/wp-login.php?redirect_to=https%3A%2F%2Fmicrobiology.se%2Fsoftware%2Fmetaxa2%2F) to post a comment.

### Projects and Centers

* [BacMet](http://bacmet.biomedicine.gu.se "The antibacterial biocide and metal resistance genes database")
* [BIOCIDE](https://www.gu.se/en/biocide "BIOCIDE JPI-funded project website")
* [CARe](https://care.gu.se "CARe – Centre for Antibiotic Resistance Research at University of Gothenburg")
* [DDLS](https://www.scilifelab.se/data-driven/ "Wallenberg Data Drive Life Science Platform")
* [EMBARK](http://antimicrobialresistance.eu "Home page of the EMBARK project")
* [GOTBIN](https://www.gu.se/en/core-facilities/bioinformatics-bcf/gotbin "Gothenburg Bioinformatics Network")
* [NoMoReAMR](https://nomoreamr.org "The NoMoReAMR Consortium")
* [UNITE](http://unite.ut.ee "Unified system for the DNA based fungal species linked to the classification")

### Collaborators

* [Åsa Sjöling](https://ki.se/en/research/groups/asa-sjoling-group#tab-start "Åsa Sjöling, University of Gothenburg/Karolinska Institute, Sweden")
* [Elaine Pereira de Martinis](https://bv.fapesp.br/en/pesquisador/6565/elaine-cristina-pereira-de-martinis/ "Elaine Cristina Pereira de Martinis, Universidade de São Paulo – Ribeirão Preto, Brazil")
* [Emmanuel Nnadi](https://orcid.org/0000-0002-8424-4859 "Nnaemeka Emmanuel Nnadi, Plateau State University Bokkos, Nigeria")
* [Erik Kristiansson](https://research.chalmers.se/person/erikkr "Erik Kristiansson, Chalmers University of Technology, Sweden")
* [Etienne Ruppé](https://www.iame-research.center/eq2/members/?user=etienne.ruppe)
* [Henrik Nilsson](https://www.gu.se/om-universitetet/hitta-person/henriknilsson "Henrik Nilsson, University of Gothenburg, Sweden")
* [Jo Handelsman](https://handelsmanlab.discovery.wisc.edu "Jo Handelsman, Wisconsin Institute for Discovery")
* [Joakim Larsson](https://www.gu.se/biomedicin/om-oss/avdelningen-for-infektionssjukdomar/joakim-larsson-group "Joakim Larsson, University of Gothenburg, Sweden (my boss)")
* [Kaisa Thorell](https://www.gu.se/en/about/find-staff/kaisathorell "Kaisa Thorell, University of Gothenburg, Sweden")
* [Luis Pedro Coelho](http://luispedro.org/)
* [Luisa Hugerth](https://www.katalog.uu.se/profile/?id=N22-1985 "Luisa Warchavchik Hugerth, Uppsala University, Sweden")
* [Martin Hartmann](http://microbiome.ch/ "Martin Hartmann, Swiss Federal Research Institute, Switzerland")
* [Rabaab Zahra](https://www.qau.edu.pk/profile.php?id=805015)
* [Sara Lindén](https://www.gu.se/en/research/sara-linden "Sara Lindén, University of Gothenburg, Sweden")
* [Sofia Forslund](http://forslund-lab.net/)
* [Thomas Berendonk](https://tu-dresden.de/bu/umwelt/hydro/hydrobiologie/limnologie/die-professur/beschaeftig/thomas-berendonk?set_language=en)
* [Volga Iñiguez](https://pure.umsa.bo/en/persons/volga-i%C3%B1%C3%ADguez-rojas "Volga Iñíguez Rojas, Universidad Mayor de San Andrés, Bolivia")

### JBP Elsewhere

* [Chalmers](https://www.chalmers.se/en/departments/life/research/systems-and-synthetic-biology/bengtsson-palme-lab/ "Chalmers website")
* [Google Scholar](http://scholar.google.se/citations?hl=en&user=-htwiiIAAAAJ "My Google Scholar Profile (actually the citation source I find to be most up-to-date)")
* [LinkedIn](https://www.linkedin.com/in/johanbengtsson/ "My LinkedIn Profile (not very well updated)")
* [Lost Shadow](http://phonocratic.com "My music")
* [ORCID](http://orcid.org/0000-0002-6528-3158 "My ORCID: 0000-0002-6528-3158")
* [ResearchGate](http://www.researchgate.net/profile/Johan_Bengtsson-Palme/ "My ResearchGate Profile (best updated and most used)")
* [SciLifeLab](https://www.scilifelab.se/researchers/johan-bengtsson-palme/ "SciLifeLab Fellow Page")
* [SysBio](https://www.sysbio.se/labs/bengtsson-palme-lab/ "Chalmers SysBio")
* [Twitter](https://twitter.com/bengtssonpalme "Occasionally, I do tweet")
* [University of Gothenburg](http://www.gu.se/english/about_the_university/staff/?languageId=100001&userId=xbengg "My page at the GU website")

### Tags

[16S](https://microbiology.se/tag/16s/)
[18S](https://microbiology.se/tag/18s/)
[Antibiotic pollution](https://microbiology.se/tag/antibiotic-pollution/)
[Antibiotic resistance](https://microbiology.se/tag/antibiotic-resistance/)
[Antibiotics](https://microbiology.se/tag/antibiotics/)
[Barcoding](https://microbiology.se/tag/barcoding/)
[Biodiversity](https://microbiology.se/tag/biodiversity/)
[Bioinformatics](https://microbiology.se/tag/bioinformatics/)
[Bugs](https://microbiology.se/tag/bugs/)
[Conferences](https://microbiology.se/tag/conferences/)
[Databases](https://microbiology.se/tag/databases/)
[DDLS](https://microbiology.se/tag/ddls/)
[DNA sequencing](https://microbiology.se/tag/dna-sequencing/)
[Ecology](https://microbiology.se/tag/ecology/)
[Emil Burman](https://microbiology.se/tag/emil-burman/)
[Environment](https://microbiology.se/tag/environment/)
[Environmental monitoring](https://microbiology.se/tag/environmental-monitoring/)
[Erik Kristiansson](https://microbiology.se/tag/erik-kristiansson/)
[Genome sequencing](https://microbiology.se/tag/genome-sequencing/)
[HMMER](https://microbiology.se/tag/hmmer/)
[ITS](https://microbiology.se/tag/its/)
[ITSx](https://microbiology.se/tag/itsx/)
[Joakim Larsson](https://microbiology.se/tag/joakim-larsson/)
[Job](https://microbiology.se/tag/job/)
[Metagenomics](https://microbiology.se/tag/metagenomics/)
[Metaxa](https://microbiology.se/tag/metaxa/)
[Metaxa2](https://microbiology.se/tag/metaxa2/)
[Microbial ecology](https://microbiology.se/tag/microbial-ecology/)
[Open positions](https://microbiology.se/tag/open-positions/)
[Papers](https://microbiology.se/tag/papers/)
[PhD student](https://microbiology.se/tag/phd-student/)
[Pollutants](https://microbiology.se/tag/pollutants/)
[PostDoc](https://microbiology.se/tag/postdoc/)
[Public information](https://microbiology.se/tag/public-information/)
[Risk assessment](https://microbiology.se/tag/risk-assessment/)
[rRNA](https://microbiology.se/tag/rrna/)
[Site info](https://microbiology.se/tag/site-info/)
[Software updates](https://microbiology.se/tag/software-updates/)
[Species classification](https://microbiology.se/tag/species-classification/)
[SSU](https://microbiology.se/tag/ssu/)
[Taxonomy](https://microbiology.se/tag/taxonomy/)
[Utilities](https://microbiology.se/tag/utilities/)
[Wisconsin](https://microbiology.se/tag/wisconsin/)
[Wisconsin Institute of Discovery](https://microbiology.se/tag/wisconsin-institute-of-discovery/)
[Workshop](https://microbiology.se/tag/workshop/)

### Meta

* [Log in](https://microbiology.se/wp/wp-login.php)
* [Entries feed](https://microbiology.se/feed/)
* [Comments feed](https://microbiology.se/comments/feed/)
* [WordPress.org](https://wordpress.org/)

### Site Navigation

* [Home](https://microbiology.se)
* [Who we are](https://microbiology.se/people/)
  + [The team](https://microbiology.se/people/)
  + [Johan Bengtsson-Palme](https://microbiology.se/people/about/)
  + [Open positions](https://microbiology.se/people/open-positions/)
  + [Lab alumni](https://microbiology.se/people/lab-alumni/)
* [What we do](https://microbiology.se/research-interests/)
  + [Antibiotic resistance](https://microbiology.se/research-interests/antibiotic-resistance/)
  + [Community interactions](https://microbiology.se/research-interests/interactions/)
  + [Bacterial pathogenicity](https://microbiology.se/research-interests/pathogenicity/)
  + [Methods developme