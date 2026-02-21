getListGIF module

Lei Huang*, Xishu Wang(cid:132), Jing Wen(cid:133), Gang Feng§

October 30, 2018

∗Center for Research Informatics, University of Chicago, Chicago, IL 60637,
USA
§Northwestern University Clinical and Translational Sciences Institute,
Chicago, IL 60611, USA

1 Introduction

getListGIF is a utility function to interact with ListGIF web server (http://
listgif.nubic.northwestern.edu). ListGIF provides a comprehensive anal-
ysis solution to identify the overrepresented biomedical concepts from a list of
query genes. It combines Tag cloud, Wordle-like graph to present the analysis
results to the end-user [1][2]. ListGIF assumes the co-occurring functional anno-
tation terms of many genes from a list can reveal some common features of the
genes [2]. The hypergeometric test is performed to identify the enriched Gene
Reference Into Function (GeneRIF) and Gene Ontology (GO) terms. To reduce
the bias that unbalanced GeneRIF distribution among genes might introduce
to the result, both gene level and GeneRIF level analysis are provided. Result
is rendered as a “word cloud”-like graph for easy viewing.

2 Description

The followings are requirement for input query gene list and arguments of
getListGIF:

glist: This should be a character vector consisting of gene symbols in query

output: Optional. User can specify the name and location of the output word
cloud png ﬁle; otherwise the ﬁle name from ListGIF web server is used
and the output ﬁle is saved in current working directory.

background : This argument speciﬁes the background of the output word cloud

png ﬁle. Only white and black are supported. Default is white.

*lhuang7@uchicago.edu
(cid:132)wangxishu@gmail.com
(cid:133)vivannawj@gmail.com
§g-feng@northwestern.edu

1

type: This argument speciﬁes which ListGIF analysis can be performed on the
query gene list. User can specify either genelevel, riflevel or goterm
enrichment analysis.

(cid:136) genelevel : Gene level enrichment analysis.
(cid:136) riﬂevel : GeneRIF level enrichment analysis. Warning: this option

may take long depending on the length of the query gene list.

(cid:136) goterm: GO term enrichment analysis.

3 Example

The following is an example to generate the ListGIF word cloud graph for gene
list: MRPS35, NBL1, PSMD14, PGK1, SMC4, SLC16A1 and CAV1.

> #glist <- c("MRPS35","NBL1","PSMD14","PGK1","SMC4","SLC16A1","CAV1")

To get the graph at gene level (Figure 1):

> #getListGIF(glist=glist, output="tmp.png", background="white", type="genelevel")

To get the graph at GeneRIF level (note this may take a considerable amount

of time on ListGIF web server):

> #getListGIF(glist=glist, output="tmp.png", background="white", type="riflevel")

To get the graph for enriched GO terms:

> #getListGIF(glist=glist, output="tmp.png", background="white", type="goterm")

4 References

1.Wen, J., Wang X., Kibbe, W., Lin S., Lu, H., “Visual Annotation of the Gene
Database”, Conf Proc IEEE Eng Med Biol Soc. 2009;2009:4175-7
2.Wen, J., “Visual Annotation of Gene List with Functional Enrichment”, MS
Thesis, University of Illinois at Chicago (2012) http://hdl.handle.net/10027/
9072

2

Figure 1: An example of ListGIF word-cloud graph. The query genes are
MRPS35, NBL1, PSMD14, PGK1, SMC4, SLC16A1 and CAV1.

3

