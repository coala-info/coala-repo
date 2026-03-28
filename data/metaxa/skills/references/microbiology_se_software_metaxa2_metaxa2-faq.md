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

# Metaxa2 FAQ

This FAQ intends to answer some of the questions we have gotten about the Metaxa2 software package and its predecessor – [Metaxa](https://microbiology.se/software/metaxa/). Please look through this document before contacting me with a question. If the FAQ does not answer your question, you are very welcome to send an e-mail with the question to metaxa [at] microbiology [dot] se

**How should I cite Metaxa2?**

Since there is now a number of Metaxa-related publications, the decision on which to cite when has grown more complicated. This is how **I** would prefer that Metaxa2 was cited in various contexts:

* Use of the **Metaxa2** software for extracting and/or classifying rRNA sequences: Bengtsson-Palme et al. [Mol Ecol Resour (2015)](http://onlinelibrary.wiley.com/doi/10.1111/1755-0998.12399/abstract)
* Use of the **Metaxa2 Database Builder** software for creating custom databases: Bengtsson-Palme et al. [Bioinformatics (2018)](http://dx.doi.org/10.1093/bioinformatics/bty482)
* Use of the **Metaxa2 Diversity Tools** (metaxa2\_dc, metaxa2\_si, metaxa2\_rf and/or metaxa2\_uc): Bengtsson-Palme et al. [Ecol Inform (2016)](http://www.sciencedirect.com/science/article/pii/S1574954116300309)
* Any use of the original **Metaxa software version 1.X**: Bengtsson et al. [Antonie Van Leeuwenhoek (2011)](http://www.springerlink.com/content/n56h854713187159/)
* Referencing the **performance** of different software for classification of rRNA: Bengtsson-Palme et al. [Mol Ecol Resour (2015)](http://onlinelibrary.wiley.com/doi/10.1111/1755-0998.12399/abstract)
* Referencing the algorithm for rRNA *extraction*: Bengtsson et al. [Antonie Van Leeuwenhoek (2011)](http://www.springerlink.com/content/n56h854713187159/) **or** Bengtsson-Palme et al. [Encyclopedia of Metagenomics (2013)](http://www.springerreference.com/docs/html/chapterdbid/304105.html)
* Referencing the algorithm for *classification* of rRNA: Bengtsson-Palme et al. [Mol Ecol Resour (2015)](http://onlinelibrary.wiley.com/doi/10.1111/1755-0998.12399/abstract)
* Referencing the rarefaction method developed for metaxa2\_rf: Bengtsson-Palme et al. [Ecol Inform (2016)](http://www.sciencedirect.com/science/article/pii/S1574954116300309)

**How complete is the rRNA database of Metaxa2?**

The Metaxa2 database is mainly based on SILVA release 111. We are aware of that this release is getting outdated and plan to update the classification database in a forthcoming update to Metaxa2.

**Where do the chloroplast rRNA sequences in the Metaxa2 database come from?**

The chloroplast sequences in the Metaxa2 database come from SILVA release 111.

**Where do the mitochondrial rRNA sequences in the Metaxa2 database come from?**

The mitochondrial sequences in the Metaxa2 database come from SILVA release 111 and the MitoZoa database (version 2).

**Can I use Metaxa2 on another barcoding region than the rRNA genes?**

Yes, as of Metaxa2 version 2.2 and later this is possible. Use the Metaxa2 Database Builder (included with the software package) to build a custom database, and then classify your sequences using this new database.

**I have paired-end sequence data, but in this case only provide Metaxa2 with the forward reads using the following command:**

Probably, your pair file (xxxxx\_2.fastq) is also present in the same directory as the xxxxxx\_1.fastq file. In that case, the Metaxa2 auto-detect format function will guess the name of the pair file and if that file exists Metaxa2 will switch into paired-end mode using both files. This behavior is intended to help users avoid typing a lot of stuff, but it may make things confusing in some situations. Adding `-f fastq` solves this issue since that explicitly tells Metaxa2 which format that is used.

**Can I concatenate my two paired-end reads files and into one file, and process it as if it all was from non-paired data?**

Yes, but bear in mind that this kind of concatenation introduces a bias towards the detected reads, so results on community composition will be complicated to interpret. Generally, I would advise against doing this. Furthermore, depending on how your reads were named there may be duplicate read IDs when files are concatenated way. Check this first (that is, if the read ID includes a designation for \_1 or \_2). Furthermore, use the “-f fastq” option to make sure that Metaxa2 doesn’t treat the data as paired-end.

**Does the different orientation of the paired reads matter?**

No, as Metaxa2 detects rRNA on the reverse complements as well (by default).

**Is there any script or tool to merge the output of different samples into a single table?**

Yes, as of version 2.1 and later, Metaxa2 includes metaxa2\_dc which does this neatly. metaxa2\_dc is part of the Metaxa2 Diversity Tools.

**When extracting the Metaxa2 archive I get a lot of error messages of this type:
`` tar: Ignoring unknown extended header keyword `LIBARCHIVE.creationtime'
tar: Ignoring unknown extended header keyword `SCHILY.dev'
tar: Ignoring unknown extended header keyword `SCHILY.ino'
tar: Ignoring unknown extended header keyword `SCHILY.nlink' ``
Is there a problem with the Metaxa2 archive?**

No, some versions of Metaxa2 have been prepared on MacOS X using a distribution of tar that creates these strange “extended headers”. You can just ignore these error messages if you see them.

**I analyze data from microbial communities that live on/in host organism X. Is there a way to remove all rRNA sequences from organism X and just keep all the other ones?**

Yes, you can use the `--reference` option to do this. Provide a FASTA file with the rRNA sequences of organism X to the `--reference` option and those will be sorted out separately.

**Which version of MAFFT should I use for Metaxa2?**

We recommend using any 7.X version of MAFFT.

**Does Metaxa2 work on Windows?**

Short answer is no. I do not know anyone who has gotten Metaxa2 to work under Cygwin, so that is *not* a good option. However, Metaxa2 works very fine under virtualization software such as Virtual Box running a virtual Linux environment. Another good option is to find a colleague with a Mac and kindly ask him or her to run your sequences for you.

**There are no people running either Mac or Linux on my department [or: I am afraid of the Linux people/Mac fanboys], what do I do?**

I would recommend downloading Virtual Box (<http://www.virtualbox.org/>) and Bio-Linux (<http://envgen.nox.ac.uk/tools/bio-linux>). When you have gotten Virtual Box to run with Bio-Linux it should be relatively straightforward to install HMMER3 and Metaxa2 on the virtual machine using the Metaxa2 manual.

**Metaxa2 runs with my specified input file but the output file says that no sequences are detected. What goes on?**

Probably you have specified a file that does not exist. Currently, Metaxa2 does not warn the user that the input file is non-existent (which of course it will in a later version). It may also be that you are executing Metaxa2 in another directory than you intend. Check that the input file you desire to use is located in the current directory by typing “ls” on the command line.

**Does Metaxa2 support BLAST+?**

Yes. Use the “`--plus T`” option to specify use of BLAST+ instead of the “old-school” BLAST.

**The Metaxa2 installer script (install\_metaxa2) does not work. What can I do?**

Under some operating system environments (primarily on some Linux distributions and on Mac OS X versions prior to 10.4) the installer script that comes with Metaxa2 might not work. Usually this happens because of lack of permissions, but it can also be caused by differing login file structures on various Linux distribution. The first thing that should be tested if Metaxa2 refuses to run after install, is to logout of the system completely, and then re-login again. Sometimes this solves the issue.

If this does not help, the installer script actually failed, and Metaxa2 must be installed manually. This can be done by moving into the Metaxa2 directory and copy all files starting with “metaxa2” into the preferred bin-directory, e.g. by typing “cp -r metaxa2\* ~/bin/”. After this has been done, you may need to edit your login script so Metaxa2 is added to your PATH. If your bin-directory is already present in your PATH, this should not be a problem, and you should be able to run Metaxa2 immediately after copying it into the bin-directory, e.g. by typing “metaxa2 -h”.

**I have a multicore CPU, why is Metaxa2 so slow?**

Most likely you have not specified Metaxa2 to use more than one CPU. Using the “`--cpu [number]`” option the speed of Metaxa2 improves dramatically.

**Metaxa2 spawns a lot of HMMER processes that use up more CPUs than I specified using the `--cpu` option. What goes on?**

Metaxa2’s multi-threading system only partially takes into account the number of CPUs you specified using the `--cpu` option. If it is critical for you that Metaxa2 does not eat more CPU power than specified you should use the “`--multi_thread F”` option, which forces Metaxa2 to run the HMMER searches sequentially within the CPU limit.

**I started Metaxa2 and it stopped early on in the progress with the following message: “Checking and handling input sequence data (should not take long)…” Why isn’t the software continuing?**

You have not specified any input file (using the -i option). Therefore Metaxa2 has stopped, waiting for standard input. If this was unintended press control-C, and try again adding the input file option.

**Can I use Metaxa2 to find SSU/LSU sequences in my newly sequenced and assembled genome?**

Yes, as of Metaxa2 version 2.1 and later this is possible. Make sure that you have set the “`--mode`” option to either “`auto`” or “`genome`“.

**Can I use Metaxa2 to determine the number of copies of SSU sequences in a certain species?**

Yes, as of Metaxa2 version 2.1 and later this is possible. Make sure that you have set the “`--mode`” option to either “`auto`” or “`genome`“. That said, multiple SSUs within a genome is tricky for e.g. assembly software and therefore copy number detection can still be uncertain.

### Add a Comment[Cancel reply](/software/metaxa2/metaxa2-faq/#respond)

You must be [logged in](https://microbiology.se/wp/wp-login.php?redirect_to=https%3A%2F%2Fmicrobiology.se%2Fsoftware%2Fmetaxa2%2Fmetaxa2-faq%2F) to post a comment.

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
* [Martin Hartmann](http://microbiome