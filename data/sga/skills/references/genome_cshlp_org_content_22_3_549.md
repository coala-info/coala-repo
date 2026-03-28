[![Publisher Logo](/local/img/society_logo.gif)](http://www.cshlpress.com)[![Genome Research](/local/img/journal_logo_standalone.gif "Genome Research")](/)

[Skip to main page content](#content-block)

* [HOME](/ "HOME")
* [ABOUT](/site/misc/about.xhtml "ABOUT")
* [ARCHIVE](/content/by/year "ARCHIVE")
* [SUBMIT](http://submit.genome.org/ "SUBMIT")
* [SUBSCRIBE](/site/subscriptions/ "SUBSCRIBE")
* [ADVERTISE](/site/misc/adinfo.xhtml "ADVERTISE")
* [AUTHOR INFO](/site/misc/ifora.xhtml "AUTHOR INFO")
* [CONTACT](/feedback "CONTACT")
* [HELP](/help/ "HELP")

Search for Keyword:
GO

[Advanced Search](/search)

* [![Epigenetic Conference](//genome.cshlp.org/adsystem/graphics/5995074026563434/genesdev/5thEpi_468x60_gif.gif?ad=58078&adview=true "Epigenetic Conference")](/cgi/adclick/?ad=58078&adclick=true&url=https%3A%2F%2Ffusion-conferences.com%2Fconference%2F206%3Futm_source%3DGenomeResearch%26utm_medium%3DGifBanner%26utm_campaign%3DEpi26%26utm_content%3DEBTalk)

# Efficient de novo assembly of large genomes using compressed data structures

1. [Jared T. Simpson](/search?author1=Jared+T.+Simpson&sortspec=date&submit=Submit) and
2. [Richard Durbin](/search?author1=Richard+Durbin&sortspec=date&submit=Submit)[1](#fn-1)

1. Wellcome Trust Sanger Institute, Wellcome Trust Genome Campus, Hinxton, Cambridge CB10 1SA, United Kingdom

## Abstract

De novo genome sequence assembly is important both to generate new sequence assemblies for previously uncharacterized genomes
and to identify the genome sequence of individuals in a reference-unbiased way. We present memory efficient data structures
and algorithms for assembly using the FM-index derived from the compressed Burrows-Wheeler transform, and a new assembler
based on these called SGA (String Graph Assembler). We describe algorithms to error-correct, assemble, and scaffold large sets of sequence data. SGA uses the overlap-based
string graph model of assembly, unlike most de novo assemblers that rely on de Bruijn graphs, and is simply parallelizable.
We demonstrate the error correction and assembly performance of SGA on 1.2 billion sequence reads from a human genome, which
we are able to assemble using 54 GB of memory. The resulting contigs are highly accurate and contiguous, while covering 95%
of the reference genome (excluding contigs <200 bp in length). Because of the low memory requirements and parallelization
without requiring inter-process communication, SGA provides the first practical assembler to our knowledge for a mammalian-sized
genome on a low-end computing cluster.

## Footnotes

* [↵](#xref-fn-1-1)1 Corresponding author.

  E-mail rd{at}sanger.ac.uk.
* [Supplemental material is available for this article.]
* Article published online before print. Article, supplemental material, and publication date are at <http://www.genome.org/cgi/doi/10.1101/gr.126953.111>.

* Received May 31, 2011.
* Accepted December 5, 2011.

* Copyright © 2012 by Cold Spring Harbor Laboratory Press

Freely available online through the *Genome Research* Open Access option.

* [![Add to CiteULike](/shared/img/common/social-bookmarking/citeulike.gif "CiteULike")](/external-ref?tag_url=http://genome.cshlp.org/cgi/content/long/22/3/549&title=Efficient%20de%20novo%20assembly%20of%20large%20genomes%20using%20compressed%20data%20structures+--+Simpson%20and%20Durbin%2022%20%283%29%3A%20549+--+GENOME&doi=10.1101/gr.126953.111&link_type=CITEULIKE)CiteULike
* [![Add to Delicious](/shared/img/common/social-bookmarking/delicious.gif "Delicious")](/external-ref?tag_url=http://genome.cshlp.org/cgi/content/long/22/3/549&title=Efficient%20de%20novo%20assembly%20of%20large%20genomes%20using%20compressed%20data%20structures+--+Simpson%20and%20Durbin%2022%20%283%29%3A%20549+--+GENOME&doi=10.1101/gr.126953.111&link_type=DEL_ICIO_US)Delicious
* [![Add to Digg](/shared/img/common/social-bookmarking/digg.gif "Digg")](/external-ref?tag_url=http://genome.cshlp.org/cgi/content/long/22/3/549&title=Efficient%20de%20novo%20assembly%20of%20large%20genomes%20using%20compressed%20data%20structures+--+Simpson%20and%20Durbin%2022%20%283%29%3A%20549+--+GENOME&doi=10.1101/gr.126953.111&link_type=DIGG)Digg
* [![Add to Facebook](/shared/img/common/social-bookmarking/facebook.gif "Facebook")](/external-ref?tag_url=http://genome.cshlp.org/cgi/content/short/22/3/549&title=Efficient%20de%20novo%20assembly%20of%20large%20genomes%20using%20compressed%20data%20structures+--+Simpson%20and%20Durbin%2022%20%283%29%3A%20549+--+GENOME&doi=10.1101/gr.126953.111&link_type=FACEBOOK)Facebook
* [![Add to Google+](/shared/img/common/social-bookmarking/googleplus.jpg "Google+")](/external-ref?tag_url=http://genome.cshlp.org/cgi/content/long/22/3/549&title=Efficient%20de%20novo%20assembly%20of%20large%20genomes%20using%20compressed%20data%20structures+--+Simpson%20and%20Durbin%2022%20%283%29%3A%20549+--+GENOME&doi=10.1101/gr.126953.111&link_type=GOOGLEPLUS&log_only=yes)Google+
* [![Add to Reddit](/shared/img/common/social-bookmarking/reddit.gif "Reddit")](/external-ref?tag_url=http://genome.cshlp.org/cgi/content/long/22/3/549&title=Efficient%20de%20novo%20assembly%20of%20large%20genomes%20using%20compressed%20data%20structures+--+Simpson%20and%20Durbin%2022%20%283%29%3A%20549+--+GENOME&doi=10.1101/gr.126953.111&link_type=REDDIT)Reddit
* [![Add to Twitter](/shared/img/common/social-bookmarking/twitter.gif "Twitter")](/external-ref?tag_url=http://genome.cshlp.org/cgi/content/long/22/3/549&title=Efficient%20de%20novo%20assembly%20of%20large%20genomes%20using%20compressed%20data%20structures+--+Simpson%20and%20Durbin%2022%20%283%29%3A%20549+--+GENOME&doi=10.1101/gr.126953.111&link_type=TWITTER)Twitter

[What's this?](/help/social_bookmarks.dtl)

## Related Articles

* Resource: GAGE: A critical evaluation of genome assemblies and assembly algorithms
  + Steven L. Salzberg,
  + Adam M. Phillippy,
  + Aleksey Zimin,
  + Daniela Puiu,
  + Tanja Magoc,
  + Sergey Koren,
  + Todd J. Treangen,
  + Michael C. Schatz,
  + Arthur L. Delcher,
  + Michael Roberts,
  + Guillaume Marçais,
  + Mihai Pop,
  + and James A. YorkeGenome Res. March 2012 22: 557-567; Published in Advance December 6, 2011,  doi:10.1101/gr.131383.111

  + [Abstract](/content/22/3/557.abstract)
  + [Full Text](/content/22/3/557.full)
  + [Full Text (PDF)](/content/22/3/557.full.pdf%2Bhtml)
  + [Supplemental Material](/content/22/3/557/suppl/DC1)
* Resource: Assemblathon 1: A competitive assessment of de novo short read assembly methods
  + Dent Earl,
  + Keith Bradnam,
  + John St. John,
  + Aaron Darling,
  + Dawei Lin,
  + Joseph Fass,
  + Hung On Ken Yu,
  + Vince Buffalo,
  + Daniel R. Zerbino,
  + Mark Diekhans,
  + Ngan Nguyen,
  + Pramila Nuwantha Ariyaratne,
  + Wing-Kin Sung,
  + Zemin Ning,
  + Matthias Haimel,
  + Jared T. Simpson,
  + Nuno A. Fonseca,
  + İnanç Birol,
  + T. Roderick Docking,
  + Isaac Y. Ho,
  + Daniel S. Rokhsar,
  + Rayan Chikhi,
  + Dominique Lavenier,
  + Guillaume Chapuis,
  + Delphine Naquin,
  + Nicolas Maillet,
  + Michael C. Schatz,
  + David R. Kelley,
  + Adam M. Phillippy,
  + Sergey Koren,
  + Shiaw-Pyng Yang,
  + Wei Wu,
  + Wen-Chi Chou,
  + Anuj Srivastava,
  + Timothy I. Shaw,
  + J. Graham Ruby,
  + Peter Skewes-Cox,
  + Miguel Betegon,
  + Michelle T. Dimon,
  + Victor Solovyev,
  + Igor Seledtsov,
  + Petr Kosarev,
  + Denis Vorobyev,
  + Ricardo Ramirez-Gonzalez,
  + Richard Leggett,
  + Dan MacLean,
  + Fangfang Xia,
  + Ruibang Luo,
  + Zhenyu Li,
  + Yinlong Xie,
  + Binghang Liu,
  + Sante Gnerre,
  + Iain MacCallum,
  + Dariusz Przybylski,
  + Filipe J. Ribeiro,
  + Shuangye Yin,
  + Ted Sharpe,
  + Giles Hall,
  + Paul J. Kersey,
  + Richard Durbin,
  + Shaun D. Jackman,
  + Jarrod A. Chapman,
  + Xiaoqiu Huang,
  + Joseph L. DeRisi,
  + Mario Caccamo,
  + Yingrui Li,
  + David B. Jaffe,
  + Richard E. Green,
  + David Haussler,
  + Ian Korf,
  + and Benedict PatenGenome Res. December 2011 21: 2224-2241; Published in Advance September 16, 2011,  doi:10.1101/gr.126599.111

  + [Abstract](/content/21/12/2224.abstract)
  + [Full Text](/content/21/12/2224.full)
  + [Full Text (PDF)](/content/21/12/2224.full.pdf%2Bhtml)
  + [Supplemental Material](/content/21/12/2224/suppl/DC1)OPEN ACCESS ARTICLE
* Perspective: Assembly of large genomes using second-generation sequencing
  + Michael C. Schatz,
  + Arthur L. Delcher,
  + and Steven L. SalzbergGenome Res. September 2010 20: 1165-1173; Published in Advance May 27, 2010,  doi:10.1101/gr.101360.109

  + [Abstract](/content/20/9/1165.abstract)
  + [Full Text](/content/20/9/1165.full)
  + [Full Text (PDF)](/content/20/9/1165.full.pdf%2Bhtml)
* Resource: De novo assembly of human genomes with massively parallel short read sequencing
  + Ruiqiang Li,
  + Hongmei Zhu,
  + Jue Ruan,
  + Wubin Qian,
  + Xiaodong Fang,
  + Zhongbin Shi,
  + Yingrui Li,
  + Shengting Li,
  + Gao Shan,
  + Karsten Kristiansen,
  + Songgang Li,
  + Huanming Yang,
  + Jian Wang,
  + and Jun WangGenome Res. February 2010 20: 265-272; Published in Advance December 17, 2009,  doi:10.1101/gr.097261.109

  + [Abstract](/content/20/2/265.abstract)
  + [Full Text](/content/20/2/265.full)
  + [Full Text (PDF)](/content/20/2/265.full.pdf%2Bhtml)
  + [Supplemental Material](/content/20/2/265/suppl/DC1)
* Resource: ABySS: A parallel assembler for short read sequence data
  + Jared T. Simpson,
  + Kim Wong,
  + Shaun D. Jackman,
  + Jacqueline E. Schein,
  + Steven J.M. Jones,
  + and İnanç BirolGenome Res. June 2009 19: 1117-1123; Published in Advance February 27, 2009,  doi:10.1101/gr.089532.108

  + [Abstract](/content/19/6/1117.abstract)
  + [Full Text](/content/19/6/1117.full)
  + [Full Text (PDF)](/content/19/6/1117.full.pdf%2Bhtml)
  + [Supplemental Material](/content/19/6/1117/suppl/DC1)OPEN ACCESS ARTICLE
* RESOURCE: Velvet: Algorithms for de novo short read assembly using de Bruijn graphs
  + Daniel R. Zerbino and
  + Ewan BirneyGenome Res. May 2008 18: 821-829; Published in Advance March 18, 2008,  doi:10.1101/gr.074492.107

  + [Abstract](/content/18/5/821.abstract)
  + [Full Text](/content/18/5/821.full)
  + [Full Text (PDF)](/content/18/5/821.full.pdf%2Bhtml)
  + [Supplemental Research Data](/content/18/5/821/suppl/DC1)
* RESOURCE: ALLPATHS: De novo assembly of whole-genome shotgun microreads
  + Jonathan Butler,
  + Iain MacCallum,
  + Michael Kleber,
  + Ilya A. Shlyakhter,
  + Matthew K. Belmonte,
  + Eric S. Lander,
  + Chad Nusbaum,
  + and David B. JaffeGenome Res. May 2008 18: 810-820; Published in Advance March 13, 2008,  doi:10.1101/gr.7337908

  + [Abstract](/content/18/5/810.abstract)
  + [Full Text](/content/18/5/810.full)
  + [Full Text (PDF)](/content/18/5/810.full.pdf%2Bhtml)
  + [Supplemental Research Data](/content/18/5/810/suppl/DC1)

[« Previous](/content/22/3/539.short "Previous article") | [Next Article »](/content/22/3/557.short "Next article")

[Table of Contents](/content/22/3.toc "Table of Contents")

OPEN ACCESS ARTICLE

### This Article

1. Published in Advance
   December 7, 2011,
   doi:
   10.1101/gr.126953.111

   Genome Res.
   2012.

   22:
   549-556
   [Copyright © 2012 by Cold Spring Harbor Laboratory Press](/site/misc/terms.xhtml)

1. » AbstractFree
2. [Full Text](/content/22/3/549.full)Free
3. [Full Text (PDF)](/content/22/3/549.full.pdf%2Bhtml)Free
4. [Supplemental Material](/content/22/3/549/suppl/DC1)
5. All Versions of this Article:
   1. [gr.126953.111v1](/content/early/2011/12/07/gr.126953.111)
   2. [gr.126953.111v2](/content/early/2012/01/22/gr.126953.111)
   3. 22/3/549 most recent

#### Article Category

1. * [Resource](/search?tocsectionid=Resource&sortspec=date&submit=Submit)

#### Services

1. [Alert me when this article is cited](/cgi/alerts/ctalert?alertType=citedby&addAlert=cited_by&cited_by_criteria_resid=genome%3B22%2F3%2F549&saveAlert=no&return-type=article&return_url=http://genome.cshlp.org/content/22/3/549)
2. [Alert me if a correction is posted](/cgi/alerts/ctalert?alertType=correction&addAlert=correction&correction_criteria_value=22/3/549&saveAlert=no&return-type=article&return_url=http://genome.cshlp.org/content/22/3/549)
3. [Similar articles in this journal](/search?qbe=genome%3Bgr.126953.111&citation=Simpson%20and%20Durbin%2022%20%283%29:%20549&submit=yes)
4. [Similar articles in Web of Science](/external-ref?access_num=genome%3B22%2F3%2F549&link_type=ISI_RELATEDRECORDS)
5. [Article Metrics](/articleusage?gca=genome;22/3/549)
6. [Similar articles in PubMed](/external-ref?access_num=22156294&link_type=MED_NBRS)
7. [Download to citation manager](/citmgr?gca=genome%3B22%2F3%2F549)
8. [Permissions](/site/misc/permissions_landing.xhtml)

#### Citing Articles

1. [Load citing article information](/content/22/3/549?cited-by=yes&legid=genome;22/3/549#cited-by)
2. [Citing articles via Web of Science](/external-ref?access_num=%2Fgenome%2F22%2F3%2F549&link_type=ISI_CITING&accnum_type=native)
3. [Citing articles via Google Scholar](/external-ref?access_num=http://genome.cshlp.org/content/22/3/549.abstract&link_type=GOOGLESCHOLAR)

#### Google Scholar

1. [Articles by Simpson, J. T.](http://scholar.google.com/scholar?q=%22author%3ASimpson%20author%3AJ.T.%22)
2. [Articles by Durbin, R.](http://scholar.google.com/scholar?q=%22author%3ADurbin%20author%3AR.%22)
3. [Search for related content](/external-ref?access_num=http://genome.cshlp.org/content/22/3/549.abstract&link_type=GOOGLESCHOLARRELATED)

#### PubMed/NCBI

1. [PubMed citation](/external-ref?access_num=22156294&link_type=PUBMED)
2. [Articles by Simpson, J. T.](/external-ref?access_num=Simpson%20JT&link_type=AUTHORSEARCH)
3. [Articles by Durbin, R.](/external-ref?access_num=Durbin%20R&link_type=AUTHORSEARCH)

#### Related Content

1. [Related Articles](#rel-related-article)

#### Share

2. * [![Add to CiteULike](/shared/img/common/social-bookmarking/citeulike.gif "CiteULike")](/external-ref?tag_url=http://genome.cshlp.org/cgi/content/long/22/3/549&title=Efficient%20de%20novo%20assembly%20of%20large%20genomes%20using%20compressed%20data%20structures+--+Simpson%20and%20Durbin%2022%20%283%29%3A%20549+--+GENOME&doi=10.1101/gr.126953.111&link_type=CITEULIKE)CiteULike
   * [![Add to Delicious](/shared/img/common/social-bookmarking/delicious.gif "Delicious")](/external-ref?tag_url=http://genome.cshlp.org/cgi/content/long/22/3/549&title=Efficient%20de%20novo%20assembly%20of%20large%20genomes%20using%20compressed%20data%20structures+--+Simpson%20and%20Durbin%2022%20%283%29%3A%20549+--+GENOME&doi=10.1101/gr.126953.111&link_type=DEL_ICIO_US)Delicious
   * [![Add to Digg](/shared/img/common/social-bookmarking/digg.gif "Digg")](/external-ref?tag_url=http://genome.cshlp.org/cgi/content/long/22/3/549&title=Efficient%20de%20novo%20assembly%20of%20large%20genomes%20using%20compressed%20data%20structures+--+Simpson%20and%20Durbin%2022%20%283%29%3A%20549+--+GENOME&doi=10.1101/gr.126953.111&link_type=DIGG)Digg
   * [![Add to Facebook](/shared/img/common/social-bookmarking/facebook.gif "Facebook")](/external-ref?tag_url=http://genome.c