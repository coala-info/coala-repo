▲❛♥❞s❝❛♣❡ ●❡♥❡t✐❝s ■♥tr♦
■♥tr♦❞✉❝t✐♦♥ t♦ ❧❛♥❞❣❡♥r❡♣♦rt

Bernd Gruber & Aaron Adamack

October 16, 2014

1

❈♦♥t❡♥ts

✶ Pr❡❢❛❝❡

✸

✷ ❆ s✐♠♣❧❡ ❧❡❛st✲❝♦st ♣❛t❤ ♠♦❞❡❧❧✐♥❣ ❛♥❛❧②s✐s ✭▲❈P▼❆✮

2.1.1 Add spatial information to a genind object

2.1 Genetic data set - create a genind object [with coordinates]

✸
. . . . . . . . . . . . .
4
. . . . . . . . . . . . . . . . . .
7
2.2 Creating a cost matrix layer . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
9
Selecting a relatedness index . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
2.3
2.4 Run the created example . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11

✸ ❚❤❡ r❡s✉❧ts ♦❢ ❛ ❧❡❛st✲❝♦st ♣❛t❤ ♠♦❞❡❧❧✐♥❣ ❛♥❛❧②s✐s

✶✶
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
3.1 A map of the least-cost paths
3.2 Checking the results of partial mantel tests and MMRR . . . . . . . . . . . . . . . 14
3.3 Output of the ﬁrst example . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
3.4 Use the read.genetable function to create a genind object with coordinates in one

go . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17

✹ ❍♦✇ t♦ ♣r♦❥❡❝t ❧❛t❧♦♥❣ ❞❛t❛ ✐♥t♦ ▼❡r❝❛t♦r

✺ ❆ ❝✉st♦♠✐s❡❞ st❡♣ ❜② st❡♣ ❛♥❛❧②s✐s

✻ ❈♦♥t❛❝ts ❛♥❞ ❈✐t❛t✐♦♥

✼ ❘❡❢❡r❡♥❝❡s

✽ ❆♣♣❡♥❞✐①

✶✾

✷✸

✸✺

✸✻

✸✻

2

✶ Pr❡❢❛❝❡

This tutorial provides an overview how to use landgenreport to perform a least-cost path
modeling analysis as a part of a landscape genetic analysis. The tutorial assumes that you
already have a basic understanding of how to use R. For example you should know how
to run a function and load a package.
If you don’t have this level of understanding of R,
there are a number of excellent tutorials and introductions to R available online. You can ﬁnd
them by using your favourite search engine to search for “R introduction” or “R tutorial”.
To start using this tutorial, you will need to install the package PopGenReport and (option-
ally) have a LaTeX environment installed on your computer in order to make full use of the
package. For information on how to install PopGenReport and LaTeX please visit our web-
site: ❤tt♣✿✴✴✇✇✇✳♣♦♣❣❡♥r❡♣♦rt✳♦r❣ and/or look at the other PopGenReport package tutorial
(PopGenReportIntroduction) [via ❜r♦✇s❡❱✐❣♥❡tt❡s✭✧P♦♣●❡♥❘❡♣♦rt✧✮]. If you are using the
Windows operating system, you can alternatively download a mobile version of the package
(including a running LaTeX environment): PopGenPack. This allows you to either run the
package from a USB device or copy it to a speciﬁed folder on your system, without the need
to setup all of the software packages. Finally, you should read a publication on least-cost path
modelling [e.g. Gruber & Adamack (in prep.)] to understand the principles behind the least-
cost path modelling approach.

✷ ❆ s✐♠♣❧❡ ❧❡❛st✲❝♦st ♣❛t❤ ♠♦❞❡❧❧✐♥❣ ❛♥❛❧②s✐s ✭▲❈P▼❆✮

After starting R with your favourite R Editor (we suggest Rstudio [❤tt♣✿✴✴✇✇✇✳rst✉❞✐♦✳♦r❣]
you will need to load the latest version of the package PopGenReport into your workspace
and conﬁrm that you are running at least Version 2.0, by typing:

r❡q✉✐r❡✭P♦♣●❡♥❘❡♣♦rt✮
★❝❤❡❝❦ ✇❤✐❝❤ ✈❡rs✐♦♥ ②♦✉ ❤❛✈❡
♣❛❝❦❛❣❡❱❡rs✐♦♥✭✧P♦♣●❡♥❘❡♣♦rt✧✮

★★ ❬✶❪

✷✳✶

✬

✬

★■❢ ②♦✉ ❤❛✈❡ ❛ ✈❡rs✐♦♥ ❜❡❢♦r❡ ✷✳✵ t❤❡♥ ②♦✉ ♥❡❡❞ t♦ ✉♣❞❛t❡ t❤❡ ♣❛❝❦❛❣❡
★✉s✐♥❣ t❤❡ ❝♦♠♠❛♥❞ ✐♥st❛❧❧✳♣❛❝❦❛❣❡s ✭r❡♠♦✈❡ t❤❡ ❤❛s❤ s②♠❜♦❧ ✐♥ t❤❡ ♥❡①t ❧✐♥❡✮
★✐♥st❛❧❧✳♣❛❝❦❛❣❡s✭✧P♦♣●❡♥❘❡♣♦rt✧✮

Once you have conﬁrmed that you have the right version of PopGenReport, you can run a
simple LCPMA by typing the command shown in the example text below. Please note (this is
true for every command line using the function ❧❛♥❞❣❡♥r❡♣♦rt):
You need to change the argument mk.pdf=FALSE to mk.pdf=TRUE if you want a full report.
The argument is set to FALSE here, to make sure that the examples run even if you don´t
have a LaTeX environment installed, which is not recommended, but may be the case for
users who do not want to install LaTeX or do not have the necessary admin rights on their
computer.

★r❡♠❡♠❜❡r ❢♦r ❛ ❢✉❧❧ r❡♣♦rt s❡t✿ ♠❦✳♣❞❢❂❚❘❯❊
r❡s✉❧ts✶ ❁✲❧❛♥❞❣❡♥r❡♣♦rt✭❧❛♥❞❣❡♥✱ ❢r✐❝✳r❛st❡r✱ ✧❉✧✱ ◆◆❂✹✱ ♠❦✳♣❞❢❂❋❆▲❙❊✮

★★ ▲♦❝✐ ♥❛♠❡s ✇❡r❡ ♥♦t ✉♥✐q✉❡ ❛♥❞ t❤❡r❡❢♦r❡ ❛❞❥✉st❡❞✳
★★ ❈♦♠♣✐❧✐♥❣ r❡♣♦rt✳✳✳
★★ ✲ ▲❛♥❞s❝❛♣❡ ❣❡♥❡t✐❝ ❛♥❛❧②s✐s ✉s✐♥❣ r❡s✐st❛♥❝❡ ♠❛tr✐❝❡s✳✳✳

3

★★ ❆♥❛❧②s✐♥❣ ❞❛t❛ ✳✳✳
★★ ❆❧❧ ❢✐❧❡s ❛r❡ ❛✈❛✐❧❛❜❧❡ ✐♥ t❤❡ ❢♦❧❞❡r✿
★★ ❈✿❭❯s❡rs❭s✹✷✺✽✷✹❭❆♣♣❉❛t❛❭▲♦❝❛❧❭❚❡♠♣❭❘t♠♣❖❯✷♦❛❚✴r❡s✉❧ts

★❧❡t ✉s ❝❤❡❝❦ ✐❢ t❤❡r❡ ✐s ❛♥②t❤✐♥❣ r❡t✉r♥❡❞ t♦ ♦✉r r❡s✉❧ts✶ ♦❜❥❡❝t
♥❛♠❡s✭r❡s✉❧ts✶✮

★★ ❬✶❪ ✧❧❡❛st❝♦st✧

★t❤❡r❡ s❤♦✉❧❞ ❜❡ ❛ ❧✐st ❝❛❧❧❡❞✿ ❧❡❛st❝♦st ✐♥ ②♦✉r r❡s✉❧ts✶ ♦❜❥❡❝t

The complete output of our least-cost path modelling analysis (LCPMA) is stored in the
results folder at the indicated path (the exact location depends on the temporary folder on
your machine). In this folder you should ﬁnd a number of CSV, PDF, SVG and other ﬁles.
Please see if you can locate the ﬁles. If you set mk.pdf=TRUE you will ﬁnd a full report of your
analysis in a single PDF named LandGenReport.pdf (this PDF can be found at the end of this
tutorial in the section 8: Appendix).

Hint: You can set the output folder to a more convenient location by setting the output path

via the ♣❛t❤✳♣❣r argument. Please make sure the speciﬁed folder does exist, for example:

r❡s✉❧ts❁✲❧❛♥❞❣❡♥r❡♣♦rt✭❧❛♥❞❣❡♥✱❢r✐❝✳r❛st❡r✱✧❉✧✱◆◆❂✹✱♣❛t❤✳♣❣r❂✧❉✿✴t❡♠♣✧✮

There are three essential bits of information that needs to be provided to the ❧❛♥❞❣❡♥r❡♣♦rt
function:

1. landgen: a genetic data set that contains the genotypes and coordinates of several indi-

viduals (a genind object)

2. fric.raster: the cost layer of the landscape (a raster object)

3. “D”: a character which indicates the type of genetic distance index that will be used to

create the pairwise-genetic distance matrix, e.g Jost’s D in this case

For the example above, all three types of information have been provided in the correct
format. Now we will run a real world example, that details the steps necessary to create the
three objects for your own data set.

✷✳✶ ●❡♥❡t✐❝ ❞❛t❛ s❡t ✲ ❝r❡❛t❡ ❛ ❣❡♥✐♥❞ ♦❜❥❡❝t ❬✇✐t❤ ❝♦♦r❞✐♥❛t❡s❪

We start with the genetic data set. Quite often, you will already have your data formatted
for another genetic analysis program such as: STRUCTURE, GENETIX, GENEPOP or FSTAT.
These ﬁle formats can easily be converted into a ❣❡♥✐♥❞ object. Below, we provide some ex-
ample for converting your data into a genind object if your data is already in the format for
STRUCTURE.

First you need to tell R where your data set is located. Please be very exact when you pro-
vide the path to your ﬁle, otherwise R will not be able to ﬁnd it. For this example, we will
assume your data is stored in the folder ’D:/data’ and is named ’testdata.struc’. If your data is
in the STRUCTURE format, simply type:

❣❡♥❞❛t❛ ❁✲ r❡❛❞✳str✉❝t✉r❡✭✬❉✿✴❞❛t❛✴t❡st❞❛t❛✳str✉❝✬✮

For other data formats, the command is very similar:

4

❣❡♥❞❛t❛ ❁✲ r❡❛❞✳❣❡♥❡t✐❝✭✬❉✿✴❞❛t❛✴t❡st❞❛t❛✳❣t①✬✮ ★ ❢♦r ❣❡♥❡t✐① ❢✐❧❡s
❣❡♥❞❛t❛ ❁✲ r❡❛❞✳❣❡♥❡♣♦♣✭✬❉✿✴❞❛t❛✴t❡st❞❛t❛✳❣❡♥✬✮ ★ ❢♦r ❣❡♥❡♣♦♣ ❢✐❧❡s
❣❡♥❞❛t❛ ❁✲ r❡❛❞✳❢st❛t✭✬❉✿✴❞❛t❛✴t❡st❞❛t❛✳❞❛t✬✮ ★ ❢♦r ❢st❛t ❢✐❧❡s

For the next example I use a structure ﬁle that is provided by the package ❛❞❡❣❡♥❡t called nan-
cycats. After the ﬁle name you need to provide some details on how your STRUCTURE ﬁle is
formatted. For more details, just type the function name preceded by a “?”. For r❡❛❞✳str✉❝t✉r❡
you need to type ❄r❡❛❞✳str✉❝t✉r❡ to get to the R help pages for this function and ❄♥❛♥❝②❝❛ts
to get an overview on the data set.

❢♥❛♠❡ ❁✲ s②st❡♠✳❢✐❧❡✭✧❢✐❧❡s✴♥❛♥❝②❝❛ts✳str✧✱♣❛❝❦❛❣❡❂✧❛❞❡❣❡♥❡t✧✮
❢♥❛♠❡ ★❧♦❝❛t✐♦♥ ♦❢ t❤❡ str✉❝t✉r❡ ❢✐❧❡

★★ ❬✶❪ ✧❈✿✴Pr♦❣r❛♠ ❋✐❧❡s✴❘✴❧✐❜r❛r②✴❛❞❡❣❡♥❡t✴❢✐❧❡s✴♥❛♥❝②❝❛ts✳str✧

❣❡♥❞❛t❛ ❁✲r❡❛❞✳str✉❝t✉r❡✭❢♥❛♠❡✱♦♥❡r♦✇♣❡r✐♥❞❂❋❆▲❙❊✱ ♥✳✐♥❞❂✷✸✼✱
♥✳❧♦❝❂✾✱ ❝♦❧✳❧❛❜❂✶✱ ❝♦❧✳♣♦♣❂✷✱ ❛s❦❂❋❆▲❙❊✮

★★
★★ ❈♦♥✈❡rt✐♥❣ ❞❛t❛ ❢r♦♠ ❛ ❙❚❘❯❈❚❯❘❊ ✳str✉ ❢✐❧❡ t♦ ❛ ❣❡♥✐♥❞ ♦❜❥❡❝t✳✳✳

Using the read functions above your data will be converted into a genind object. You can

conﬁrm that your dataset is now a genind object by typing:

❝❧❛ss✭❣❡♥❞❛t❛✮

★★ ❬✶❪ ✧❣❡♥✐♥❞✧
★★ ❛ttr✭✱✧♣❛❝❦❛❣❡✧✮
★★ ❬✶❪ ✧❛❞❡❣❡♥❡t✧

We can explore the content of the genind object by typing its name “gendata” into the con-

sole.

❣❡♥❞❛t❛

❣❡♥✐♥❞

★★★★★★★★★★★★★★★★★★★★★
★★★ ●❡♥✐♥❞ ♦❜❥❡❝t ★★★
★★★★★★★★★★★★★★★★★★★★★

★★
★★
★★
★★
★★ ✲ ❣❡♥♦t②♣❡s ♦❢ ✐♥❞✐✈✐❞✉❛❧s ✲
★★
★★ ❙✹ ❝❧❛ss✿
★★ ❅❝❛❧❧✿ r❡❛❞✳str✉❝t✉r❡✭❢✐❧❡ ❂ ❢♥❛♠❡✱ ♥✳✐♥❞ ❂ ✷✸✼✱ ♥✳❧♦❝ ❂ ✾✱ ♦♥❡r♦✇♣❡r✐♥❞ ❂ ❋❆▲❙❊✱
★★
★★
★★ ❅t❛❜✿ ✷✸✼ ① ✶✵✽ ♠❛tr✐① ♦❢ ❣❡♥♦t②♣❡s
★★
★★ ❅✐♥❞✳♥❛♠❡s✿ ✈❡❝t♦r ♦❢ ✷✸✼ ✐♥❞✐✈✐❞✉❛❧ ♥❛♠❡s
★★ ❅❧♦❝✳♥❛♠❡s✿ ✈❡❝t♦r ♦❢ ✾ ❧♦❝✉s ♥❛♠❡s
★★ ❅❧♦❝✳♥❛❧❧✿ ♥✉♠❜❡r ♦❢ ❛❧❧❡❧❡s ♣❡r ❧♦❝✉s
★★ ❅❧♦❝✳❢❛❝✿ ❧♦❝✉s ❢❛❝t♦r ❢♦r t❤❡ ✶✵✽ ❝♦❧✉♠♥s ♦❢ ❅t❛❜
★★ ❅❛❧❧✳♥❛♠❡s✿ ❧✐st ♦❢ ✾ ❝♦♠♣♦♥❡♥ts ②✐❡❧❞✐♥❣ ❛❧❧❡❧❡ ♥❛♠❡s ❢♦r ❡❛❝❤ ❧♦❝✉s

❝♦❧✳❧❛❜ ❂ ✶✱ ❝♦❧✳♣♦♣ ❂ ✷✱ ❛s❦ ❂ ❋❆▲❙❊✮

5

✷

★★ ❅♣❧♦✐❞②✿
★★ ❅t②♣❡✿ ❝♦❞♦♠
★★
★★ ❖♣t✐♦♥❛❧ ❝♦♥t❡♥ts✿
★★ ❅♣♦♣✿ ❢❛❝t♦r ❣✐✈✐♥❣ t❤❡ ♣♦♣✉❧❛t✐♦♥ ♦❢ ❡❛❝❤ ✐♥❞✐✈✐❞✉❛❧
★★ ❅♣♦♣✳♥❛♠❡s✿
★★
★★ ❅♦t❤❡r✿ ✲ ❡♠♣t② ✲

❢❛❝t♦r ❣✐✈✐♥❣ t❤❡ ♣♦♣✉❧❛t✐♦♥ ♦❢ ❡❛❝❤ ✐♥❞✐✈✐❞✉❛❧

The slots of the genind object (indicated by the @ sign which are subcomponents of gendata)
can also be examined by typing their names into the console. For example, there are slots that
indicate the population that each individual belongs to (@pop), the loci names (@loc.names)
and the number of alleles per locus (@loc.nall). You should always check this information to
conﬁrm that your data has loaded correctly.

❣❡♥❞❛t❛❅♣♦♣

★★
❬✶❪ P✵✶ P✵✶ P✵✶ P✵✶ P✵✶ P✵✶ P✵✶ P✵✶ P✵✶ P✵✶ P✵✷ P✵✷ P✵✷
★★ ❬✶✹❪ P✵✷ P✵✷ P✵✷ P✵✷ P✵✷ P✵✷ P✵✷ P✵✷ P✵✷ P✵✷ P✵✷ P✵✷ P✵✷
★★ ❬✷✼❪ P✵✷ P✵✷ P✵✷ P✵✷ P✵✷ P✵✷ P✵✸ P✵✸ P✵✸ P✵✸ P✵✸ P✵✸ P✵✸
★★ ❬✹✵❪ P✵✸ P✵✸ P✵✸ P✵✸ P✵✸ P✵✹ P✵✹ P✵✹ P✵✹ P✵✹ P✵✹ P✵✹ P✵✹
★★ ❬✺✸❪ P✵✹ P✵✹ P✵✹ P✵✹ P✵✹ P✵✹ P✵✹ P✵✹ P✵✹ P✵✹ P✵✹ P✵✹ P✵✹
★★ ❬✻✻❪ P✵✹ P✵✹ P✵✺ P✵✺ P✵✺ P✵✺ P✵✺ P✵✺ P✵✺ P✵✺ P✵✺ P✵✺ P✵✺
★★ ❬✼✾❪ P✵✺ P✵✺ P✵✺ P✵✺ P✵✻ P✵✻ P✵✻ P✵✻ P✵✻ P✵✻ P✵✻ P✵✻ P✵✻
★★ ❬✾✷❪ P✵✻ P✵✻ P✵✼ P✵✼ P✵✼ P✵✼ P✵✼ P✵✼ P✵✼ P✵✼ P✵✼ P✵✼ P✵✼
★★ ❬✶✵✺❪ P✵✼ P✵✼ P✵✼ P✵✽ P✵✽ P✵✽ P✵✽ P✵✽ P✵✽ P✵✽ P✵✽ P✵✽ P✵✽
★★ ❬✶✶✽❪ P✵✾ P✵✾ P✵✾ P✵✾ P✵✾ P✵✾ P✵✾ P✵✾ P✵✾ P✶✵ P✶✵ P✶✵ P✶✵
★★ ❬✶✸✶❪ P✶✵ P✶✵ P✶✵ P✶✵ P✶✵ P✶✵ P✶✵ P✶✶ P✶✶ P✶✶ P✶✶ P✶✶ P✶✶
★★ ❬✶✹✹❪ P✶✶ P✶✶ P✶✶ P✶✶ P✶✶ P✶✶ P✶✶ P✶✶ P✶✶ P✶✶ P✶✶ P✶✶ P✶✶
★★ ❬✶✺✼❪ P✶✶ P✶✷ P✶✷ P✶✷ P✶✷ P✶✷ P✶✷ P✶✷ P✶✸ P✶✸ P✶✸ P✶✸ P✶✸
★★ ❬✶✼✵❪ P✶✸ P✶✸ P✶✸ P✶✸ P✶✸ P✶✸ P✶✸ P✶✸ P✶✹ P✶✹ P✶✹ P✶✹ P✶✹
★★ ❬✶✽✸❪ P✶✹ P✶✹ P✶✹ P✶✹ P✶✹ P✶✹ P✶✹ P✶✹ P✶✹ P✶✹ P✶✹ P✶✹ P✶✺
★★ ❬✶✾✻❪ P✶✺ P✶✺ P✶✺ P✶✺ P✶✺ P✶✺ P✶✺ P✶✺ P✶✺ P✶✺ P✶✻ P✶✻ P✶✻
★★ ❬✷✵✾❪ P✶✻ P✶✻ P✶✻ P✶✻ P✶✻ P✶✻ P✶✻ P✶✻ P✶✻ P✶✷ P✶✷ P✶✷ P✶✷
★★ ❬✷✷✷❪ P✶✷ P✶✷ P✶✷ P✶✼ P✶✼ P✶✼ P✶✼ P✶✼ P✶✼ P✶✼ P✶✼ P✶✼ P✶✼
★★ ❬✷✸✺❪ P✶✼ P✶✼ P✶✼
★★ ✶✼ ▲❡✈❡❧s✿ P✵✶ P✵✷ P✵✸ P✵✹ P✵✺ P✵✻ P✵✼ P✵✽ P✵✾ P✶✵ ✳✳✳ P✶✼

❣❡♥❞❛t❛❅❧♦❝✳♥❛♠❡s

▲✶

★★
▲✾
★★ ✧▲✶✧ ✧▲✷✧ ✧▲✸✧ ✧▲✹✧ ✧▲✺✧ ✧▲✻✧ ✧▲✼✧ ✧▲✽✧ ✧▲✾✧

▲✼

▲✷

▲✽

▲✻

▲✺

▲✹

▲✸

❣❡♥❞❛t❛❅❧♦❝✳♥❛❧❧

★★ ▲✶ ▲✷ ▲✸ ▲✹ ▲✺ ▲✻ ▲✼ ▲✽ ▲✾
✽ ✶✷ ✶✷ ✶✽
★★ ✶✻ ✶✶ ✶✵ ✾ ✶✷

★ ♦r ✇❡ ❝❛♥ ✉s❡ t❤❡ t❛❜❧❡ ❢✉♥❝t✐♦♥ t♦ ❣❡t t❤❡ ♥✉♠❜❡r ♦❢ ✐♥❞✐✈✐❞✉❛❧s
★ ♣❡r ♣♦♣✉❧❛t✐♦♥
t❛❜❧❡✭❣❡♥❞❛t❛❅♣♦♣✮

6

★★
★★ P✵✶ P✵✷ P✵✸ P✵✹ P✵✺ P✵✻ P✵✼ P✵✽ P✵✾ P✶✵ P✶✶ P✶✷ P✶✸ P✶✹ P✶✺
★★ ✶✵
✶✼ ✶✶
★★ P✶✻ P✶✼
✶✸
★★ ✶✷

✶✶ ✶✹ ✶✵

✾ ✶✶ ✷✵

✷✸ ✶✺

✷✷ ✶✷

✶✹ ✶✸

From the lines @tab and @ind.names, you can see that we have 237 individual genotypes
in this data set, information on nine loci for each individual (from the lines starting @loc.nall
or @loc.names), and there are ten individuals in population “P01” (from the command ta-
ble(gendata@pop)).

✷✳✶✳✶ ❆❞❞ s♣❛t✐❛❧ ✐♥❢♦r♠❛t✐♦♥ t♦ ❛ ❣❡♥✐♥❞ ♦❜❥❡❝t

The genind object is missing some information that is very important for our LCPMA. It is
missing the spatial coordinates for each individual genetic sample. STRUCTURE ﬁles can
include spatial coordinates, but other genetic ﬁle formats often cannot. Thus, we will show
you here how to add spatial coordinates to the genind object (gendata) from a separate ﬁle.
First the spatial coordinates need to be loaded into the R workspace and then added to the
correct slot in our genind object, namely in the slot @other$xy. There are two requirements for
your spatial data:

1. Your data is in the same coordinate system as your cost matrix layer

2. The coordinates need to be in a projected coordinate system and (not longitude and lati-

tude), so distances can be calculated directly from the coordinates

Quite often spatial coordinates are provided via latitude and longitude.
If this is the case
and distances are calculated without projection, this would result in imprecise estimates of
spatial distances as these distance calculations would based on angles as measurement units.
Therefore we demonstrate in the example below, how to project the latitude and longitude
coordinates into the Mercator system (a coordinate system used by Google maps, which can
be used worldwide, see Example: How to project latlong data into Mercator4)).

First we load the data from a CSV ﬁle (a comma separated text ﬁle, that for each individual

has a x and a y coordinate) into the workspace using the read.csv function.

❝♦♦r❞❢✐❧❡ ❁✲ s②st❡♠✳❢✐❧❡✭✧❡①t❞❛t❛✴♥❛♥❝②❝♦♦r❞s✳❝s✈✧✱♣❛❝❦❛❣❡❂✧P♦♣●❡♥❘❡♣♦rt✧✮
❝♦♦r❞s ❁✲ r❡❛❞✳❝s✈✭❝♦♦r❞❢✐❧❡✮
★✇❡ ❝❤❡❝❦ t❤❡ ❢✐rst ✻ ❡♥tr✐❡s
❤❡❛❞✭❝♦♦r❞s✮

①

★★
②
★★ ✶ ✷✷✳✼✶ ✸✶✳✽✹
★★ ✷ ✷✷✳✽✾ ✷✽✳✼✸
★★ ✸ ✷✹✳✷✹ ✸✶✳✻✷
★★ ✹ ✷✻✳✵✷ ✸✸✳✺✻
★★ ✺ ✷✹✳✵✻ ✸✵✳✵✼
★★ ✻ ✷✷✳✹✸ ✸✷✳✼✾

We can plot the individuals by their coordinates using the plot function:

★❞❡❢✐♥❡ s♦♠❡ ♥✐❝❡ ❝♦❧♦✉rs ❢♦r ❡❛❝❤ ♣♦♣✉❧❛t✐♦♥ ✭t❤❡r❡ ❛r❡ ✶✼ ♣♦♣✉❧❛t✐♦♥s✮
❝♦❧s ❁✲ r❛✐♥❜♦✇✭✶✼✮
♣❧♦t✭❝♦♦r❞s✱ ❝♦❧❂❝♦❧s❬❣❡♥❞❛t❛❅♣♦♣❪✱ ♣❝❤❂✶✻✮

7

0
8

0
6

0
4

y

0
2

0

0

20

40

60

80

100

x

Now we can add the coordinates (coords) to our genind object (gendata). The correct place

to add the coordinates is the slot @other$xy. This can be done by typing:

❣❡♥❞❛t❛❅♦t❤❡r✩①② ❁✲ ❝♦♦r❞s
★❝❤❡❝❦ ✐❢ t❤❡r❡ ✐s ♥♦✇ ❛ ♥❡✇ s❧♦t ❅♦t❤❡r✩①②
❣❡♥❞❛t❛

★★★★★★★★★★★★★★★★★★★★★
★★★ ●❡♥✐♥❞ ♦❜❥❡❝t ★★★
★★★★★★★★★★★★★★★★★★★★★

★★
★★
★★
★★
★★ ✲ ❣❡♥♦t②♣❡s ♦❢ ✐♥❞✐✈✐❞✉❛❧s ✲
★★
★★ ❙✹ ❝❧❛ss✿
★★ ❅❝❛❧❧✿ r❡❛❞✳str✉❝t✉r❡✭❢✐❧❡ ❂ ❢♥❛♠❡✱ ♥✳✐♥❞ ❂ ✷✸✼✱ ♥✳❧♦❝ ❂ ✾✱ ♦♥❡r♦✇♣❡r✐♥❞ ❂ ❋❆▲❙❊✱
★★
★★
★★ ❅t❛❜✿ ✷✸✼ ① ✶✵✽ ♠❛tr✐① ♦❢ ❣❡♥♦t②♣❡s

❝♦❧✳❧❛❜ ❂ ✶✱ ❝♦❧✳♣♦♣ ❂ ✷✱ ❛s❦ ❂ ❋❆▲❙❊✮

❣❡♥✐♥❞

8

●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
★★
★★ ❅✐♥❞✳♥❛♠❡s✿ ✈❡❝t♦r ♦❢ ✷✸✼ ✐♥❞✐✈✐❞✉❛❧ ♥❛♠❡s
★★ ❅❧♦❝✳♥❛♠❡s✿ ✈❡❝t♦r ♦❢ ✾ ❧♦❝✉s ♥❛♠❡s
★★ ❅❧♦❝✳♥❛❧❧✿ ♥✉♠❜❡r ♦❢ ❛❧❧❡❧❡s ♣❡r ❧♦❝✉s
★★ ❅❧♦❝✳❢❛❝✿ ❧♦❝✉s ❢❛❝t♦r ❢♦r t❤❡ ✶✵✽ ❝♦❧✉♠♥s ♦❢ ❅t❛❜
★★ ❅❛❧❧✳♥❛♠❡s✿ ❧✐st ♦❢ ✾ ❝♦♠♣♦♥❡♥ts ②✐❡❧❞✐♥❣ ❛❧❧❡❧❡ ♥❛♠❡s ❢♦r ❡❛❝❤ ❧♦❝✉s
★★ ❅♣❧♦✐❞②✿
★★ ❅t②♣❡✿ ❝♦❞♦♠
★★
★★ ❖♣t✐♦♥❛❧ ❝♦♥t❡♥ts✿
★★ ❅♣♦♣✿ ❢❛❝t♦r ❣✐✈✐♥❣ t❤❡ ♣♦♣✉❧❛t✐♦♥ ♦❢ ❡❛❝❤ ✐♥❞✐✈✐❞✉❛❧
★★ ❅♣♦♣✳♥❛♠❡s✿
★★
★★ ❅♦t❤❡r✿ ❛ ❧✐st ❝♦♥t❛✐♥✐♥❣✿ ①②

❢❛❝t♦r ❣✐✈✐♥❣ t❤❡ ♣♦♣✉❧❛t✐♦♥ ♦❢ ❡❛❝❤ ✐♥❞✐✈✐❞✉❛❧

✷

✷✳✷ ❈r❡❛t✐♥❣ ❛ ❝♦st ♠❛tr✐① ❧❛②❡r

This part of the exercise is admittedly a bit artiﬁcial as there are numerous ways to create cost
layers. The most common approach is to use a Geographic Information System (GIS) and cre-
ate a raster layer that incorporates the structures which are thought to inﬂuence connectivity.
For example, roads may be a barrier to dispersal and thus cells that code for roads would be
given high resistance value. Alternatively, you could create an image ﬁle based on Google
Earth layers (see example below), where certain landuse classes (e.g. forest) are outlined and
ﬁlled with a certain colour. The colour codes for the amount of resistance value of the forest.
The raster package in R is capable of loading almost every possible ﬁle formats including ESRI
raster layers, ascii formats, bitmap ﬁles, geotiffs and other image formats that can be used to
represent a map. All you need to provide to the raster function in R is the ﬁlepath and ﬁle-
name. For example if your cost matrix layer is stored using the ESRI raster ﬁle format with the
name “raster.asc” in the folder “D:/data” then you simply type:

costlayer <- raster(“D:/data/raster.asc”)
To demonstrate that any image format can be used, we use the image of the R-logo (the red-
component only) that is provided by R as our cost matrix layer. This is admittedly a useless
cost matrix layer and we don’t expect to ﬁnd a relationship between our genetic data set and
the cost matrix layer.

❧♦❣♦ ❁✲ r❛st❡r✭s②st❡♠✳❢✐❧❡✭✧❡①t❡r♥❛❧✴r❧♦❣♦✳❣r❞✧✱ ♣❛❝❦❛❣❡❂✧r❛st❡r✧✮✮

To test if this ﬁle has been loaded successfully, we plot it and also add the sampled individ-

uals from our genetic data set (gendata) to the map.

♣❧♦t✭❧♦❣♦✮
♣♦✐♥ts✭❝♦♦r❞s✱ ❝♦❧❂❝♦❧s❬❣❡♥❞❛t❛❅♣♦♣❪✱ ♣❝❤❂✶✻✮

9

0
8

0
6

0
4

0
2

0

250

200

150

100

50

0

0

20

40

60

80

100

✷✳✸ ❙❡❧❡❝t✐♥❣ ❛ r❡❧❛t❡❞♥❡ss ✐♥❞❡①

There are ﬁve indices of genetic differentation currently implemented in the ❧❛♥❞❣❡♥r❡♣♦rt
function (check: ?landgenreport for details). Three indices are based on a subpopulation differ-
entiation (“D”, “Gst.Hedrick”, “Gst.Nei”= an often used variant of Fst) and two on relatedness
between individuals (“Kosman” & Lennard, “Smouse” & Peakall). The difference between the
indices is that if an individual based index is used then least-cost paths are calculated between
all pairs of individuals (in the case of our example dataset there are 237*236/2 = 27966 pairs of
individual genetic distances), if an index based on subpopulations is used (such as Jost’s D),
then the least-cost paths are calculated on a subpopulation basis (only 17*16/2 = 136 pairs in
our example). This is important as the calculation of least-cost paths can be a lengthy process
(which mainly depends on the resolution of the cost matrix layer and the number of pairwise
paths that needs to be calculated) as it is a computationally expensive process. Note that the
analysis is not restricted to the currently implemented genetic differentiation indices. An ex-
ample how researcher can use their own favorite genetic distance index is provided below (see
Section 5: A customised step by step analysis).

10

●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
✷✳✹ ❘✉♥ t❤❡ ❝r❡❛t❡❞ ❡①❛♠♣❧❡

For demonstration purposes we limited the number of subpopulations used in this example
to the ﬁrst six subpopulations. We did this by simply subsetting our genetic data set using the
index function “[]”. If we add up the number individuals in the ﬁrst six subpopulations, we
ﬁnd that there are 93 individuals in the ﬁrst six subpopulations.

t❛❜❧❡✭❣❡♥❞❛t❛❅♣♦♣✮ ★✐♥❞✐✈✐❞✉❛❧s ♣❡r ♣♦♣✉❧❛t✐♦♥

★★
★★ P✵✶ P✵✷ P✵✸ P✵✹ P✵✺ P✵✻ P✵✼ P✵✽ P✵✾ P✶✵ P✶✶ P✶✷ P✶✸ P✶✹ P✶✺
★★ ✶✵
✶✼ ✶✶
★★ P✶✻ P✶✼
✶✸
★★ ✶✷

✶✶ ✶✹ ✶✵

✾ ✶✶ ✷✵

✷✸ ✶✺

✷✷ ✶✷

✶✹ ✶✸

★❝✉♠✉❧❛t✐✈❡ s✉♠ ♦❢ t❤❡ ✐♥❞✐✈✐❞✉❛❧s ✭t❤❡② ❛r❡ s♦rt❡❞ ❜② s✉❜♣♦♣✉❧❛t✐♦♥s✮
❝✉♠s✉♠✭t❛❜❧❡✭❣❡♥❞❛t❛❅♣♦♣✮✮

★★ P✵✶ P✵✷ P✵✸ P✵✹ P✵✺ P✵✻ P✵✼ P✵✽ P✵✾ P✶✵ P✶✶ P✶✷ P✶✸ P✶✹ P✶✺
✾✸ ✶✵✼ ✶✶✼ ✶✷✻ ✶✸✼ ✶✺✼ ✶✼✶ ✶✽✹ ✷✵✶ ✷✶✷
★★ ✶✵
★★ P✶✻ P✶✼
★★ ✷✷✹ ✷✸✼

✻✼ ✽✷

✸✷ ✹✹

★s♦ ✇❡ s❡❡ t❤❡r❡ ❛r❡ ✾✸ ✐♥❞✐✈✐❞✉❛❧s ✐♥ t❤❡ ❢✐rst ✹ s✉❜♣♦♣✉❧❛t✐♦♥s

Once you have loaded all your data sets and made sure they are in the right format, the ﬁnal

command to run the LCPMA is very simple, just type:

★r❡♠❡♠❜❡r ②♦✉ ♥❡❡❞ t♦ s❡t ♠❦✳♣❞❢❂❚❘❯❊ ❢♦r ❛ ❢✉❧❧ r❡♣♦rt
r❡s✉❧ts✷ ❁✲ ❧❛♥❞❣❡♥r❡♣♦rt✭❣❡♥❞❛t❛❬✶✿✾✸✱❪✱ ❧♦❣♦✱ ✧❉✧✱◆◆❂✹✱ ♠❦✳♣❞❢❂❋❆▲❙❊✮

★★ ❈♦♠♣✐❧✐♥❣ r❡♣♦rt✳✳✳
★★ ✲ ▲❛♥❞s❝❛♣❡ ❣❡♥❡t✐❝ ❛♥❛❧②s✐s ✉s✐♥❣ r❡s✐st❛♥❝❡ ♠❛tr✐❝❡s✳✳✳
★★ ❆♥❛❧②s✐♥❣ ❞❛t❛ ✳✳✳
★★ ❆❧❧ ❢✐❧❡s ❛r❡ ❛✈❛✐❧❛❜❧❡ ✐♥ t❤❡ ❢♦❧❞❡r✿
★★ ❈✿❭❯s❡rs❭s✹✷✺✽✷✹❭❆♣♣❉❛t❛❭▲♦❝❛❧❭❚❡♠♣❭❘t♠♣❖❯✷♦❛❚✴r❡s✉❧ts

✸ ❚❤❡ r❡s✉❧ts ♦❢ ❛ ❧❡❛st✲❝♦st ♣❛t❤ ♠♦❞❡❧❧✐♥❣ ❛♥❛❧②s✐s

This time we want to have a closer look at the r❡s✉❧ts✷ object to understand the output of our
analysis. First, we want to create a map using the ﬁrst six subpopulations and then add the
least-cost paths to our analysis. Second, we check if the cost matrix (the R logo) contributes to
the explanation of the genetic structure of our subpopulations (checking the results of partial
mantel tests and the results of a multiple regression on distance matrices).

To look into the results2 object we need to learn about its slots (components).

♥❛♠❡s✭r❡s✉❧ts✷✮

★★ ❬✶❪ ✧❧❡❛st❝♦st✧

This tells us there is a subcomponent leastcost. All of the results of the LCPMA are combined

in this subcomponent and they can be accessesed via:

11

♥❛♠❡s✭r❡s✉❧ts✷✩❧❡❛st❝♦st✮

★★ ❬✶❪ ✧❡✉❝❧✳♠❛t✧
★★ ❬✹❪ ✧♣❛t❤❧❡♥❣t❤✳♠❛ts✧ ✧♣❛t❤s✧
★★ ❬✼❪ ✧♠❛♥t❡❧✳t❛❜✧

✧♠♠rr✳t❛❜✧

✧❝♦st✳♠❛t♥❛♠❡s✧

✧❝♦st✳♠❛ts✧
✧❣❡♥✳♠❛t✧

The reason for the subcomponent “leastcost” is, that the landgenreport function is meant
to be extendable. For future implementations of additional analyses, it is more convenient to
have the output separated in a subcomponent. The names of the subcomponents are all fairly
self-explanatory. For example ❡✉❝❧✳♠❛t holds the full pairwise matrix of Euclidean distances.
You can access it by typing its full name into the console.

r❡s✉❧ts✷✩❧❡❛st❝♦st✩❡✉❝❧✳♠❛t

✷

✸

✺

✹

✶

★★
✻
★★ ✶ ✵✳✵✵ ✷✹✳✷✵ ✸✽✳✶✵ ✺✽✳✹✷ ✷✸✳✻✹ ✸✽✳✼✹
★★ ✷ ✷✹✳✷✵
✵✳✵✵ ✻✷✳✸✵ ✼✻✳✵✸ ✶✾✳✶✾ ✻✵✳✶✵
★★ ✸ ✸✽✳✶✵ ✻✷✳✸✵ ✵✳✵✵ ✹✺✳✵✺ ✺✻✳✾✻ ✷✸✳✼✽
✵✳✵✵ ✽✷✳✵✸ ✻✽✳✵✽
★★ ✹ ✺✽✳✹✷ ✼✻✳✵✸ ✹✺✳✵✺
★★ ✺ ✷✸✳✻✹ ✶✾✳✶✾ ✺✻✳✾✻ ✽✷✳✵✸ ✵✳✵✵ ✹✼✳✽✹
★★ ✻ ✸✽✳✼✹ ✻✵✳✶✵ ✷✸✳✼✽ ✻✽✳✵✽ ✹✼✳✽✹ ✵✳✵✵

As expected this is a matrix with dimensions 6 x 6 (we only used the ﬁrst 6 subpopulations),
which is symmetrical (the distance from subpopulation 1 to subpopulation 6 is the same as
from 6 to 1) and has zero entries along the diagonal (the distance from population 1 to popu-
lation 1 is zero).

In more detail the subsubcomponents are:

• eucl.mat : Euclidean distance matrix

• cost.matnames : names of your cost layers

• cost.mats : the cost matrices (based on your least-cost path algorithm)

• pathlength.mat : the lengths of your least-cost paths (should not be used for an LCPMA,

see Etherington & Holland 2013)

• paths : the actual paths as SpatialLines objects

• gen.mat : the genetic distance matrix

• mantel.tab : a table that shows the results of partial Mantel tests ([Wasserman et al., 2010])

• mmrr.tab : a table that shows the results of a multiple matrix regression with randomisa-

tion analysis

✸✳✶ ❆ ♠❛♣ ♦❢ t❤❡ ❧❡❛st✲❝♦st ♣❛t❤s

Please note that all of the following plots have already been created by the landgenreport
function that you ran earlier and can be found in the indicated results folder. However, to help
you better understand the output of the landgenreport function we recreate some of the plots
“by hand”. This allows you to change the standard output if you think the standard output
needs to be customised.

For a simple map of the least-cost path we need three types of information - the least cost
layer, the coordinates of the sample individuals for each sub-population and the least-cost

12

paths. All of this information is within our input data and/or the results2 object. The cost ma-
trix layer is our logo object and we need to ﬁnd our coordinates for the ﬁrst six subpopulations.
If you remember we put them into our gendata object in the slot @other$xy.

♣❧♦t✭❧♦❣♦✮
♣♦✐♥ts✭❣❡♥❞❛t❛❅♦t❤❡r✩①②❬✶✿✾✸✱❪✱ ❝♦❧❂❣❡♥❞❛t❛❅♣♦♣✱ ♣❝❤❂✶✻✮

0
8

0
6

0
4

0
2

0

250

200

150

100

50

0

0

20

40

60

80

100

Finally, we need to ﬁnd the least-cost paths. They are stored in the ♣❛t❤s subcomponent of
our r❡s✉❧ts✷ object. As only one cost matrix layer has been supplied we can access the least-
cost path by referencing the ﬁrst entry in the paths component. We can check how many paths
there are by typing:

♥✉♠♣❛t❤s ❁✲ ❧❡♥❣t❤✭✭r❡s✉❧ts✷✩❧❡❛st❝♦st✩♣❛t❤s❬❬✶❪❪✮✮
♥✉♠♣❛t❤s

★★ ❬✶❪ ✶✺

There are 15, which is exactly what we would expect if we’d calculated the number of pos-
sible pairs (6*5/2 = 15). To plot the paths we need to do a bit of clever programming. The idea

13

●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
is simple, we create a loop that prints the paths one at a time. In R this can be done using a for
loop or more elegantly using the lapply function (lapply simply applies a function to our path
list).

♣❧♦t✭❧♦❣♦✮
♣♦✐♥ts✭❣❡♥❞❛t❛❅♦t❤❡r✩①②❬✶✿✾✸✱❪✱ ❝♦❧❂❣❡♥❞❛t❛❅♣♦♣✱ ♣❝❤❂✶✻✮
❢♦r ✭✐ ✐♥ ✶✿♥✉♠♣❛t❤s✮
④

❧✐♥❡s✭r❡s✉❧ts✷✩❧❡❛st❝♦st✩♣❛t❤s❬❬✶❪❪❬❬✐❪❪✮

⑥

★♦r ♠♦r❡ ❡❧❡❣❛♥t ✭❞✉♠♠② ✐s ❥✉st ♥❡❡❞❡❞ t♦ s✉♣♣r❡ss t❤❡ ❝♦♥s♦❧❡ ♦✉t♣✉t✮
❞✉♠♠② ❁✲ ❧❛♣♣❧②✭r❡s✉❧ts✷✩❧❡❛st❝♦st✩♣❛t❤s❬❬✶❪❪✱ ❢✉♥❝t✐♦♥ ✭①✮ ❧✐♥❡s✭①✮ ✮

0
8

0
6

0
4

0
2

0

250

200

150

100

50

0

0

20

40

60

80

100

✸✳✷ ❈❤❡❝❦✐♥❣ t❤❡ r❡s✉❧ts ♦❢ ♣❛rt✐❛❧ ♠❛♥t❡❧ t❡sts ❛♥❞ ▼▼❘❘

To check the results of partial mantel tests and MMRR, we simply access the respective sub-
subcomponents by their names:

14

●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
r❡s✉❧ts✷✩❧❡❛st❝♦st✩♠❛♥t❡❧✳t❛❜

♣
r
★★
♠♦❞❡❧
✵✳✹✹✷✹ ✵✳✶✺✾
★★ ✶ ●❡♥ ⑦r❡❞ ⑤ ❊✉❝❧✐❞❡❛♥
★★ ✷ ●❡♥ ⑦❊✉❝❧✐❞❡❛♥ ⑤ r❡❞ ✲✵✳✸✷✼✶ ✵✳✽✶

r❡s✉❧ts✷✩❧❡❛st❝♦st✩♠♠rr✳t❛❜

❧❛②❡r ❝♦❡❢❢✐❝✐❡♥t tst❛t✐st✐❝ t♣✈❛❧✉❡ ❋st❛t ❋♣✈❛❧✉❡
✵✳✺✶✷
✶✳✼✵✾
◆❆
✲✶✳✶✾✾
◆❆
✷✳✻✸✾

✷✳✻✺✺❡✲✵✺
✲✷✳✶✻✺❡✲✵✸
✶✳✽✶✾❡✲✵✶

✵✳✸✶✽
✵✳✹✷✹
✵✳✼✶✾

✶✳✹✻
◆❆
◆❆

★★
★★ ✷
r❡❞
★★ ✸ ❊✉❝❧✐❞❡❛♥
★★ ✶ ■♥t❡r❝❡♣t
★★
r✷
★★ ✷ ✵✳✶✾✺✽
◆❆
★★ ✸
◆❆
★★ ✶

As expected both analyses indicated that our resistance layer (the R logo) does not explain
the population structure of the six subpopulations. Please note that the logo is called “red” in
this example, because it is only the red component of the R logo image. The ﬁrst partial Mantel
test tests whether the genetic distance matrix (gen) is correlated with the cost matrix layer (red)
controlling for Euclidean distances. This is not the case. Also there is no correlation between
the genetic distances (Gen) and the Euclidean distances, controlling for the cost matrix (line 2
of the mantel.tab output). To understand this approach, please refer to Wasserman et al. [2010]
and Cushman et al. 2013. The basic idea behind this series of tests is that the partial Mantel
test on the correlation between a genetic distance matrix and a cost matrix (controlled by Eu-
clidean distance) should be signiﬁcant, but the reverse (genetic distance matrix correlated with
Euclidean distance matrix controlled for the cost distance matrix) should not be signiﬁcant.

The MMRR approach tests whether a linear regression between competing distance matri-
ces (Euclidean and cost matrices) is signiﬁcant, using a randomisation approach to ﬁnd the test
statistics [Wang, 2012]. To access the results of this approach we simply access the subcompo-
nent ♠♠rr✳t❛❜.

The results are similar to the partial Mantel test. None of the distance matrices can explain
the genetic structure between the six subpopulations. The overall correlation (Fstat, Fpvalue
and r2 value) is not signiﬁcant and the distance layers separately do not correlate with the
genetic distance matrix (tpvalue for each layer).

Be aware that all of these results can be found in the indicated results folder and also in the
complete report if the argument mk.pdf=TRUE was set when running the function landgenre-
port (check the Appendix for an output of the ﬁrst example).

✸✳✸ ❖✉t♣✉t ♦❢ t❤❡ ✜rst ❡①❛♠♣❧❡

To see how the results would look if there was a signiﬁcant relationship between a cost matrix
layer and the pairwise genetic distances, we will now take a look at our ﬁrst example. The
output is stored in the results1 object. Remember we ran:

r❡s✉❧ts ❁✲❧❛♥❞❣❡♥r❡♣♦rt✭❧❛♥❞❣❡♥✱ ❢r✐❝✳r❛st❡r✱ ✧❉✧✱ ◆◆❂✹✱ ♠❦✳♣❞❢❂❚❘❯❊✮

We can rerun the same code as above by simply changing everywhere we typed results2
to results1. This also demonstrates one of the advantages of using a script when running an
analysis.

15

★❝♦st ♠❛tr✐① ❧❛②❡r ❢r♦♠ ❡①❛♠♣❧❡ ✶
♣❧♦t✭❢r✐❝✳r❛st❡r✮
★✇❤❛t ❛r❡ t❤❡ ❝♦♦r❞✐♥❛t❡s ♦❢ t❤❡ s❛♠♣❧❡s
♣♦✐♥ts✭❧❛♥❞❣❡♥❅♦t❤❡r✩①②✱ ❝♦❧❂❧❛♥❞❣❡♥❅♣♦♣✱ ♣❝❤❂✶✻✮
★♣❧♦t t❤❡ ❧❡❛st ❝♦st ♣❛t❤s
❞✉♠♠② ❁✲ ❧❛♣♣❧②✭r❡s✉❧ts✶✩❧❡❛st❝♦st✩♣❛t❤s❬❬✶❪❪✱ ❢✉♥❝t✐♦♥ ✭①✮ ❧✐♥❡s✭①✮ ✮

0
5

0
4

0
3

0
2

0
1

0

20

15

10

5

0

10

20

30

40

50

★t❤❡ ♣❛rt✐❛❧ ▼❛♥t❡❧ t❡st r❡s✉❧ts
r❡s✉❧ts✶✩❧❡❛st❝♦st✩♠❛♥t❡❧✳t❛❜

♣
★★
★★ ✶ ●❡♥ ⑦❧❛②❡r ⑤ ❊✉❝❧✐❞❡❛♥ ✵✳✽✻✷✸ ✵✳✵✵✷
★★ ✷ ●❡♥ ⑦❊✉❝❧✐❞❡❛♥ ⑤ ❧❛②❡r ✲✵✳✹✼✼✶ ✵✳✾✾✸

♠♦❞❡❧

r

★t❤❡ ▼▼❘❘ t❡st r❡s✉❧ts
r❡s✉❧ts✶✩❧❡❛st❝♦st✩♠♠rr✳t❛❜

16

●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
✵✳✵✶✷✺✽✻
✲✵✳✵✵✽✽✸✹
✵✳✶✸✾✽✵✶

❧❛②❡r ❝♦❡❢❢✐❝✐❡♥t tst❛t✐st✐❝ t♣✈❛❧✉❡ ❋st❛t ❋♣✈❛❧✉❡
★★
✵✳✵✵✶
✶✶✳✵✸✻
★★ ✷
❧❛②❡r
◆❆
✲✸✳✺✶✽
★★ ✸ ❊✉❝❧✐❞❡❛♥
◆❆
✹✳✺✵✺
★★ ✶ ■♥t❡r❝❡♣t
★★
r✷
★★ ✷ ✵✳✽✼✷✼
◆❆
★★ ✸
◆❆
★★ ✶

✵✳✵✵✶ ✶✹✸✳✾
◆❆
✵✳✵✶✶
◆❆
✵✳✽✽✵

✸✳✹ ❯s❡ t❤❡ r❡❛❞✳❣❡♥❡t❛❜❧❡ ❢✉♥❝t✐♦♥ t♦ ❝r❡❛t❡ ❛ ❣❡♥✐♥❞ ♦❜❥❡❝t ✇✐t❤ ❝♦♦r❞✐♥❛t❡s

✐♥ ♦♥❡ ❣♦

This part of the tutorial demonstrates a different approach to creating a genind object from
genetic data stored in a simple CSV table created by a spreadsheet program such as EXCEL or
CALC. (also see the examples provided in the PopGenReportIntroduction.pdf)

We use the following data set:

♣❧❛t②❢✐❧❡ ❁✲ s②st❡♠✳❢✐❧❡✭✧❡①t❞❛t❛✴♣❧❛t②♣✉s✶❝✳❝s✈✧✱♣❛❝❦❛❣❡❂✧P♦♣●❡♥❘❡♣♦rt✧✮
♣❧❛t② ❁✲ r❡❛❞✳❝s✈✭♣❧❛t②❢✐❧❡✮
❤❡❛❞✭♣❧❛t②✮

♣♦♣

✐♥❞

▼❛❧❡

▼❛❧❡

❧♦❝✐✶

❧❛t ❧♦♥❣

❣r♦✉♣ ❛❣❡

❧♦❝✐✷
★★
★★ ✶ ❚✶✺✽ ❇❧❛❝❦ ✲✹✵✳✽✼ ✶✹✺✳✸ ❋❡♠❛❧❡ ❥✉✈ ✶✹✶✴✶✹✺ ✷✹✸✴✷✹✸
★★ ✷ ❚✸✵✻ ❇❧❛❝❦ ✲✹✵✳✽✻ ✶✹✺✳✸
❆❞ ✶✹✺✴✶✹✺ ✷✹✸✴✷✹✸
★★ ✸ ❚✸✵✺ ❇❧❛❝❦ ✲✹✵✳✽✽ ✶✹✺✳✸ ❋❡♠❛❧❡ ❆❞ ✶✹✸✴✶✹✺ ✷✹✸✴✷✹✸
❆❞ ✶✹✶✴✶✹✶ ✷✹✸✴✷✹✸
★★ ✹ ❚✶✹✽ ❇❧❛❝❦ ✲✹✵✳✾✾ ✶✹✺✳✹
★★ ✺ ❚✶✹✾ ❇❧❛❝❦ ✲✹✵✳✾✾ ✶✹✺✳✹ ❋❡♠❛❧❡ ❆❞ ✶✹✶✴✶✹✺ ✷✹✸✴✷✹✺
▼❛❧❡ ❆❞ ✶✹✺✴✶✹✼ ✷✹✸✴✷✹✺
★★ ✻ ❚✶✵✻
★★
❧♦❝✐✻
❧♦❝✐✹
★★ ✶ ✶✺✾✴✶✼✸ ✷✻✸✴✷✻✺ ✷✶✺✴✷✶✺ ✶✾✷✴✶✾✷
★★ ✷ ✶✺✾✴✶✺✾ ✷✻✺✴✷✻✼ ✷✶✾✴✷✶✾ ✶✾✷✴✶✾✹
★★ ✸ ✶✺✾✴✶✺✾ ✷✻✺✴✷✻✺ ✷✶✺✴✷✶✺ ✶✾✹✴✶✾✹
★★ ✹ ✶✺✾✴✶✺✾ ✷✻✺✴✷✻✺ ✷✶✺✴✷✶✾ ✶✾✷✴✶✾✹
★★ ✺ ✶✺✾✴✶✼✶ ✷✻✺✴✷✻✼ ✷✶✺✴✷✶✺ ✶✾✹✴✶✾✻
★★ ✻ ✶✺✾✴✶✼✶ ✷✻✼✴✷✻✼ ✷✶✺✴✷✶✺ ✶✾✷✴✶✾✷

❇r✐❞ ✲✹✶✳✷✸ ✶✹✼✳✺
❧♦❝✐✺

❧♦❝✐✸

The ﬁrst row of the ﬁle is a header row. Subsequent rows contain the data for single in-
dividuals/samples. The ﬁrst column contains a unique identiﬁer for the individual/sample.
The title for this column must be ”ind”. The second column (optional) is the population that
the individual/sample belongs to. The title for the population column (if it is used) must be
”pop”. Separate columns are used for the latitude and longitude coordinates (given in decimal
degrees) of each individual/sample (optional) and these columns (if used) should be titled ’lat’
and ’long’. As an optional alternative, Mercator coordinates (or grid points) can be used for
spatial coordinates. If this option is used, the column titles should be “x” and “y”. Additional
(optional) observations such as gender, age, phenotype, etc. can be placed in a contiguous
block of columns. You are free to choose the column titles for these columns, but avoid using
spaces and symbols in these titles as they have a tendency to create problems. The remaining
columns contain the genetic data. Here you can use a single column per locus (with each of
the alleles separated by a deﬁned separator <not commas>) or you can have a single column
for each allele. The column titles for the genetic data are up to you, but again we discourage
the use of spaces and punctuation marks in the column titles.

17

It is very, very important to follow these formatting instructions closely if you want to import
your own data. Keep the spelling and case of the column titles (’ind’, ’pop’, ’lat’, ’long’, ’x’, and
’y’) consistent with the formatting shown in the examples. Additionally, use the same column
order as was used in this example. The number of columns can vary (e.g. if you provide more
(or less) additional information about your samples or if you have more or less loci). There is
some error prooﬁng in the import function, but it is best to stick with the example format as
closely as possible. From personal experience, if your dataset isn’t being imported correctly,
it is most likely because you have made a mistake with the column titles, e.g. something like
typing ’latitude’, ’Lat’, or ’LAT’ instead of ’lat’. More detailed instruction and how to access
the sample ﬁles can be found by typing: ❄r❡❛❞✳❣❡♥❡t❛❜❧❡.

To load the data and to create a genind object from a CSV ﬁle that includes individual co-
ordinates, we use the r❡❛❞✳❣❡♥❡t❛❜❧❡ function from PopGenReport. Here we need to specify
which columns contain the required information. As can be seen above the ﬁrst column has
information on the individual identiﬁer, the second has the information on the subpopulation
and the third and fourth contain spatial coordinates in latitude and longitude. Columns 5 and
6 have additional information on gender and age and the rest of the columns are our genetic
markers (six loci, both alleles are coded in one column, separated by a “/” symbol). You can
also specify the character for missing values if it is not “NA” (default value for missing data in
R).

♣❧❛t②✳❣❡♥ ❁✲ r❡❛❞✳❣❡♥❡t❛❜❧❡✭♣❧❛t②❢✐❧❡✱ ✐♥❞❂✶✱ ♣♦♣❂✷✱ ❧❛t❂✸✱ ❧♦♥❣❂✹✱ ♦t❤❡r✳♠✐♥❂✺✱

♦t❤❡r✳♠❛①❂✻✱ ♦♥❡❈♦❧P❡r❆❧❧❂❋❆▲❙❊✱ s❡♣❂✧✴✧✱ ♣❧♦✐❞②❂✷✮

♣❧❛t②✳❣❡♥

❣❡♥✐♥❞

★★★★★★★★★★★★★★★★★★★★★
★★★ ●❡♥✐♥❞ ♦❜❥❡❝t ★★★
★★★★★★★★★★★★★★★★★★★★★

★★
★★
★★
★★
★★ ✲ ❣❡♥♦t②♣❡s ♦❢ ✐♥❞✐✈✐❞✉❛❧s ✲
★★
★★ ❙✹ ❝❧❛ss✿
★★ ❅❝❛❧❧✿ ❞❢✷❣❡♥✐♥❞✭❳ ❂ ❣❡♥❡s✱ s❡♣ ❂ s❡♣✱ ♥❝♦❞❡ ❂ ♥❝♦❞❡✱ ✐♥❞✳♥❛♠❡s ❂ ✐♥❞s✱
❧♦❝✳♥❛♠❡s ❂ ❝♦❧♥❛♠❡s✭❣❡♥❡s✮✱ ♣♦♣ ❂ ♣♦♣s✱ ♠✐ss✐♥❣ ❂ ♠✐ss✐♥❣✱
★★
♣❧♦✐❞② ❂ ♣❧♦✐❞②✮
★★
★★
★★ ❅t❛❜✿ ✶✸ ① ✷✵ ♠❛tr✐① ♦❢ ❣❡♥♦t②♣❡s
★★
★★ ❅✐♥❞✳♥❛♠❡s✿ ✈❡❝t♦r ♦❢ ✶✸ ✐♥❞✐✈✐❞✉❛❧ ♥❛♠❡s
★★ ❅❧♦❝✳♥❛♠❡s✿ ✈❡❝t♦r ♦❢ ✻ ❧♦❝✉s ♥❛♠❡s
★★ ❅❧♦❝✳♥❛❧❧✿ ♥✉♠❜❡r ♦❢ ❛❧❧❡❧❡s ♣❡r ❧♦❝✉s
★★ ❅❧♦❝✳❢❛❝✿ ❧♦❝✉s ❢❛❝t♦r ❢♦r t❤❡ ✷✵ ❝♦❧✉♠♥s ♦❢ ❅t❛❜
★★ ❅❛❧❧✳♥❛♠❡s✿ ❧✐st ♦❢ ✻ ❝♦♠♣♦♥❡♥ts ②✐❡❧❞✐♥❣ ❛❧❧❡❧❡ ♥❛♠❡s ❢♦r ❡❛❝❤ ❧♦❝✉s
★★ ❅♣❧♦✐❞②✿
★★ ❅t②♣❡✿ ❝♦❞♦♠
★★
★★ ❖♣t✐♦♥❛❧ ❝♦♥t❡♥ts✿
★★ ❅♣♦♣✿ ❢❛❝t♦r ❣✐✈✐♥❣ t❤❡ ♣♦♣✉❧❛t✐♦♥ ♦❢ ❡❛❝❤ ✐♥❞✐✈✐❞✉❛❧
★★ ❅♣♦♣✳♥❛♠❡s✿
★★
★★ ❅♦t❤❡r✿ ❛ ❧✐st ❝♦♥t❛✐♥✐♥❣✿ ❧❛t❧♦♥❣ ❞❛t❛

❢❛❝t♦r ❣✐✈✐♥❣ t❤❡ ♣♦♣✉❧❛t✐♦♥ ♦❢ ❡❛❝❤ ✐♥❞✐✈✐❞✉❛❧

✷

If you want you can explore the content of the data set by accessing its slots (e.g. @pop,

18

@ind.names). Using r❡❛❞✳❣❡♥❡t❛❜❧❡, we created a valid genind object with spatial coordi-
nates in one step. Unfortunately the coordinates are provided as latitude and longitude and
they are not useful if you want to calculate pairwise Euclidean distances. Therefore we need
to convert them (reproject them) into a coordinate system that is better suited to performing
simple Euclidean distance calculations.

✹ ❍♦✇ t♦ ♣r♦❥❡❝t ❧❛t❧♦♥❣ ❞❛t❛ ✐♥t♦ ▼❡r❝❛t♦r

Before we convert our spatial coordinates, we use the ♠❦✳♠❛♣ feature of PopGenReport which
creates a map of your samples using a map downloaded from Google maps and your sample
spatial coordinates provided as latitudes and longitudes.

★★★ r❡♠❡♠❜❡r s❡t ♠❦✳♣❞❢❂❚❘❯❊ ✐❢ ②♦✉ ✇❛♥t t♦ ❤❛✈❡ ❛ r❡♣♦rt ✦✦✦✦✦✦
♣♦♣❣❡♥r❡♣♦rt✭♣❧❛t②✳❣❡♥✱ ♠❦✳♠❛♣❂❚❘❯❊✱♠❦✳❝♦✉♥ts❂❋❆▲❙❊✱ ♠❛♣❞♦t❝♦❧♦r❂✧r❡❞✧✱

♠❛♣t②♣❡❂✧r♦❛❞♠❛♣✧✱ ♠❦✳♣❞❢❂❋❆▲❙❊✮

★★ ❈♦♠♣✐❧✐♥❣ r❡♣♦rt✳✳✳
★★ ✲ ▼❛♣ ♦❢ ✐♥❞✐✈✐❞✉❛❧s✳✳✳
★★ ❆♥❛❧②s✐♥❣ ❞❛t❛ ✳✳✳
★★ ❆❧❧ ❢✐❧❡s ❛r❡ ❛✈❛✐❧❛❜❧❡ ✐♥ t❤❡ ❢♦❧❞❡r✿
★★ ❈✿❭❯s❡rs❭s✹✷✺✽✷✹❭❆♣♣❉❛t❛❭▲♦❝❛❧❭❚❡♠♣❭❘t♠♣❖❯✷♦❛❚✴r❡s✉❧ts
★★ ❧✐st✭✮

To convert the coordinates we need to ﬁrst specify which coordinate system the coordinates
are currently in (for latitudes and longitudes, WGS1984 is the most commonly used format)
and which coordinate system they should be converted to (in this case a Mercator projection
(see ❄▼❡r❝❛t♦r using the dismo package)). For this exercise we need to load an additional
package the dismo package (it should already be loaded from when you loaded the PopGen-
Report package, but it is better to make sure that it is explicitly loaded into the workspace). We
then extract our latlong coordinates from the ❅♦t❤❡r✩❧❛t❧♦♥❣ slot (be aware the data needs
to be in the order longitude followed by latitude, thus for the current example we reverse the
index by setting the columns to 2:1).

r❡q✉✐r❡✭❞✐s♠♦✮ ★❧♦❛❞ ♣❛❝❦❛❣❡ r❣❞❛❧
★❡①tr❛❝t ❝♦♦r❞✐♥❛t❡s ✭❧♦♥❣✱ ❧❛t✮
❧♦♥❣❧❛t❁✲ ❛s✳♠❛tr✐①✭♣❧❛t②✳❣❡♥❅♦t❤❡r✩❧❛t❧♦♥❣❬✱✷✿✶❪✮
★♣r♦❥❡❝t✐♦♥ ❢r♦♠ ❧❛t❧♦♥❣ t♦ ▼❡r❝❛t♦r
①② ❁✲▼❡r❝❛t♦r✭❧♦♥❣❧❛t✮
★❛❞❞ ✐t t♦ ♣❧❛t②✳❣❡♥ ❛t ❅♦t❤❡r✩①②
♣❧❛t②✳❣❡♥❅♦t❤❡r✩①② ❁✲ ①② ★❛❣❛✐♥ ❝❤❛♥❣❡

❛♥❞ t❤❡♥ ❧♦♥❣

For a LCPMA we need to have a cost matrix for the area. For this example, we will simply
create one using Google maps (be aware that we are assuming that the colours of the map
correctly code for resistance values, which is probably not useful in most cases, but is good
enough for demonstration purposes.)

❡❁✲ ❡①t❡♥t✭r❛♥❣❡✭❧♦♥❣❧❛t❬✱✶❪✮✱ r❛♥❣❡✭❧♦♥❣❧❛t❬✱✷❪✮✮ ★❡①t❡♥t ♦❢ t❤❡ ♠❛♣
t❛s♠❛♣ ❁✲ ❣♠❛♣✭❡✱st②❧❡❂✧❢❡❛t✉r❡✿❛❧❧⑤❡❧❡♠❡♥t✿❧❛❜❡❧s⑤✈✐s✐❜✐❧✐t②✿♦❢❢✧✱

♠❛♣t②♣❡❂✧r♦❛❞♠❛♣✧✮

♥❛♠❡s✭t❛s♠❛♣✮ ❁✲ ✧❚❛s♠❛♥✐❛✧
♣❧♦t✭t❛s♠❛♣✮

19

Figure 1: Map on platypus samples in Tasmania

20

♣♦✐♥ts✭♣❧❛t②✳❣❡♥❅♦t❤❡r✩①②✱ ♣❝❤❂✶✻✮

Now we can do our LCPMA, this time we want to use Hedrick’s Gst as a genetic distance
index between subpopulations and the 8 nearest neighbouring cells when calculating the least-
cost path. Please refer to the help page of ❧❛♥❞❣❡♥r❡♣♦rt (❄❧❛♥❞❣❡♥r❡♣♦rt) for more options.

★r❡♠❡♠❜❡r t♦ s❡t ♠❦✳♣❞❢❂❚❘❯❊ ❢♦r ❛ ❢✉❧❧ r❡♣♦rt
r❡s✉❧ts✸ ❁✲❧❛♥❞❣❡♥r❡♣♦rt✭♣❧❛t②✳❣❡♥✱ t❛s♠❛♣✱ ✧●st✳❍❡❞r✐❝❦✧✱ ◆◆❂✽✱ ♠❦✳♣❞❢❂❋❆▲❙❊✮

★★ ❈♦♠♣✐❧✐♥❣ r❡♣♦rt✳✳✳
★★ ✲ ▲❛♥❞s❝❛♣❡ ❣❡♥❡t✐❝ ❛♥❛❧②s✐s ✉s✐♥❣ r❡s✐st❛♥❝❡ ♠❛tr✐❝❡s✳✳✳
★★ ❆♥❛❧②s✐♥❣ ❞❛t❛ ✳✳✳
★★ ❆❧❧ ❢✐❧❡s ❛r❡ ❛✈❛✐❧❛❜❧❡ ✐♥ t❤❡ ❢♦❧❞❡r✿
★★ ❈✿❭❯s❡rs❭s✹✷✺✽✷✹❭❆♣♣❉❛t❛❭▲♦❝❛❧❭❚❡♠♣❭❘t♠♣❖❯✷♦❛❚✴r❡s✉❧ts

r❡s✉❧ts✸✩❧❡❛st❝♦st✩♠♠rr✳t❛❜

★★

❧❛②❡r ❝♦❡❢❢✐❝✐❡♥t tst❛t✐st✐❝ t♣✈❛❧✉❡ ❋st❛t ❋♣✈❛❧✉❡ r✷

21

●
●
●
●
●
●
●
●
●
●
●
●
●
✸✳✶✾✺❡✲✵✶
★★ ✶ ■♥t❡r❝❡♣t
★★ ✷ ❚❛s♠❛♥✐❛ ✲✶✳✷✷✻❡✲✵✼
✶✳✾✼✶❡✲✵✺
★★ ✸ ❊✉❝❧✐❞❡❛♥

◆❛◆
◆❛◆
◆❛◆

◆❆
◆❆
◆❆

◆❛◆
◆❆
◆❆

◆❆ ✶
◆❆ ◆❆
◆❆ ◆❆

As was done in the prior example, we can plot our least-cost paths to check if they have

artefacts (e.g. terrestrial animals dispersing via the sea).

★❝♦st ♠❛tr✐① ❧❛②❡r t❛s♠❛♣
♣❧♦t✭t❛s♠❛♣✮

★❤❡r❡ ✐s ✇❤❡r❡ t❤❡ s❛♠♣❧❡s ❛r❡ ❢r♦♠
♣♦✐♥ts✭♣❧❛t②✳❣❡♥❅♦t❤❡r✩①②✱ ❝♦❧❂♣❧❛t②✳❣❡♥❅♣♦♣✱ ♣❝❤❂✶✻✮
★♣❧♦t t❤❡ ❧❡❛st ❝♦st ♣❛t❤s
❞✉♠♠② ❁✲ ❧❛♣♣❧②✭r❡s✉❧ts✸✩❧❡❛st❝♦st✩♣❛t❤s❬❬✶❪❪✱ ❢✉♥❝t✐♦♥ ✭①✮ ❧✐♥❡s✭①✮ ✮

22

✺ ❆ ❝✉st♦♠✐s❡❞ st❡♣ ❜② st❡♣ ❛♥❛❧②s✐s

This section explains how to do a customised LCPMA analysis. Instead of using the function
❧❛♥❞❣❡♥r❡♣♦rt, we use the low-level functions ❣❡♥❧❡❛st❝♦st (to calculate a least-cost paths)
and ❧❣r▼▼❘❘ (to run a separate multiple matrix regression with randomisation analysis). Ad-
ditionally, we aim to test a suit of cost matrix layers at the same time. This is often necessary as
we do not know the precise resistance values of our cost matrix layers. Thus, we would like to
try a number of values and test which resistance values best explain the population structure.
For this example, we use the data set that is provided by ❧❛♥❞❣❡♥r❡♣♦rt (previously used in
the ﬁrst example).

The ﬁrst step is to create a set of cost matrix layers that we would like to test. To do this we
ﬁrst use ❢r✐❝✳r❛st❡r and change the values of the linear structures only. So ﬁrst we need to
explore which values the linear structures initially have.

♣❧♦t✭❢r✐❝✳r❛st❡r✮

23

●
●
●
●
●
●
●
●
●
●
●
●
●
0
5

0
4

0
3

0
2

0
1

0

20

15

10

5

0

10

20

30

40

50

t❛❜❧❡✭✈❛❧✉❡s✭❢r✐❝✳r❛st❡r✮✮

★★
★★
✷✵
✶
★★ ✷✸✺✶ ✶✹✾

As can be seen from the plot and the matrix output, the matrix cost layer has a value of 1 and
the green structures have a value of 20. We will use this information to change the values of
the green linear structure to four different values (20 [the original value], 0.1, 5 and 50). Then
we stack all these different layers into a single object (called a raster stack) and then run this
through our ❧❛♥❞❣❡♥r❡♣♦rt function.

✈❛❧ ❁✲ ❝✭✷✵✱ ✵✳✶✱✺✱✺✵✮

r ❁✲ st❛❝❦✭❢r✐❝✳r❛st❡r✮ ★t❤❡ ❢✐rst ❡♥tr② ✐s t❤❡ ♦r✐❣✐♥❛❧ ♠❛tr✐①
❢♦r ✭✐ ✐♥ ✷✿✹✮
④

24

r❬❬✐❪❪ ❁✲ ❢r✐❝✳r❛st❡r ★❝r❡❛t❡ ❛ ❝♦♣② ♦❢ ❢r✐❝✳r❛st❡r
r❬❬✐❪❪❬✈❛❧✉❡s✭r❬❬✐❪❪❂❂✷✵✮❪ ❁✲ ✈❛❧❬✐❪ ★s❡t t♦ ♥❡✇ ✈❛❧✉❡
♥❛♠❡s✭r❬❬✐❪❪✮
⑥
♥❛♠❡s✭r✮ ❁✲ ♣❛st❡✭✧▲❛②❡r✧✱✈❛❧✱s❡♣❂✧✧✮ ★r❡♥❛♠❡ ❧❛②❡rs
♣❧♦t✭r✮ ★★★♣❧♦t ❛❧❧ ❧❛②❡rs ✭♣❧❡❛s❡ ❝❤❡❝❦ t❤❡ s❝❛❧❡✮

Layer20

Layer0.1

0
5

0
4

0
3

0
2

0
1

0

0
5

0
4

0
3

0
2

0
1

0

Layer5

20

15

10

5

5

4

3

2

1

Layer50

1.0

0.8

0.6

0.4

0.2

50

40

30

20

10

0

10

20

30

40

50

0

10

20

30

40

50

This created the four different layers and combined them into a single raster stack named
“r”. Please note that values for the green structures are all different as indicated by the scale
bar for each plot. Now we can run the LCPMA as before, but using the complete raster stack,
using the ❧❛♥❞❣❡♥r❡♣♦rt function.

r❡s✉❧ts✹❛ ❁✲ ❧❛♥❞❣❡♥r❡♣♦rt✭❧❛♥❞❣❡♥✱ r ✱ ✧●st✳◆❡✐✧✱ ✹✮

★★ ▲♦❝✐ ♥❛♠❡s ✇❡r❡ ♥♦t ✉♥✐q✉❡ ❛♥❞ t❤❡r❡❢♦r❡ ❛❞❥✉st❡❞✳
★★ ❈♦♠♣✐❧✐♥❣ r❡♣♦rt✳✳✳
★★ ✲ ▲❛♥❞s❝❛♣❡ ❣❡♥❡t✐❝ ❛♥❛❧②s✐s ✉s✐♥❣ r❡s✐st❛♥❝❡ ♠❛tr✐❝❡s✳✳✳
★★ ❆♥❛❧②s✐♥❣ ❞❛t❛ ✳✳✳

25

★★ ❈r❡❛t✐♥❣ ♣❞❢ ❢r♦♠✿ ▲❛♥❞●❡♥❘❡♣♦rt✳r♥✇ ✳✳✳

★★ ♣r♦❝❡ss✐♥❣ ❢✐❧❡✿ ▲❛♥❞●❡♥❘❡♣♦rt✳t❡①
★★ ♦✉t♣✉t ❢✐❧❡✿

▲❛♥❞●❡♥❘❡♣♦rt✳t❡①

★★ ❋✐♥✐s❤❡❞✳
★★ ❈❤❡❝❦ ▲❛♥❞●❡♥❘❡♣♦rt✳♣❞❢ ❢♦r r❡s✉❧ts✳
★★ ❆❧❧ ❢✐❧❡s ❛r❡ ❛✈❛✐❧❛❜❧❡ ✐♥ t❤❡ ❢♦❧❞❡r✿
★★ ❈✿❭❯s❡rs❭s✹✷✺✽✷✹❭❆♣♣❉❛t❛❭▲♦❝❛❧❭❚❡♠♣❭❘t♠♣❖❯✷♦❛❚✴r❡s✉❧ts

r❡s✉❧ts✹❛✩❧❡❛st❝♦st✩♠♠rr✳t❛❜

❧❛②❡r ❝♦❡❢❢✐❝✐❡♥t tst❛t✐st✐❝ t♣✈❛❧✉❡ ❋st❛t ❋♣✈❛❧✉❡
✵✳✵✵✷
✲✷✳✽✸✺✹
◆❆
✶✳✻✼✸✼
◆❆
✶✳✻✶✶✹
◆❆
✲✶✳✷✼✷✵
◆❆
✵✳✸✼✷✺
◆❆
✸✳✷✼✸✾

✵✳✵✶✺ ✸✾✳✹✼
◆❆
✵✳✶✶✽
◆❆
✵✳✶✽✹
◆❆
✵✳✷✽✽
◆❆
✵✳✼✹✼
◆❆
✵✳✾✸✾

★★
✲✵✳✵✵✶✼✻✼✷
★★ ✹
▲❛②❡r✺
✵✳✵✵✶✹✻✶✷
★★ ✻ ❊✉❝❧✐❞❡❛♥
✵✳✵✵✶✸✶✵✵
▲❛②❡r✺✵
★★ ✺
★★ ✸ ▲❛②❡r✵✳✶ ✲✵✳✵✵✵✺✻✽✷
✵✳✵✵✵✸✸✸✻
★★ ✷
▲❛②❡r✷✵
★★ ✶ ■♥t❡r❝❡♣t
✵✳✵✶✺✶✷✺✷
r✷
★★
★★ ✹ ✵✳✽✸✺
◆❆
★★ ✻
◆❆
★★ ✺
◆❆
★★ ✸
◆❆
★★ ✷
◆❆
★★ ✶

Instead of running the ❧❛♥❞❣❡♥r❡♣♦rt function we could use the ❣❡♥❧❡❛st❝♦st function.
This function offers the same functionality as ❧❛♥❞❣❡♥r❡♣♦rt, but allows us to run the analysis
step by step and makes it possible to customise the analysis (see also ❄❣❡♥❧❡❛st❝♦st).

r❡s✉❧ts✹❜ ❁✲ ❣❡♥❧❡❛st❝♦st✭❧❛♥❞❣❡♥✱ r✱ ✧●st✳◆❡✐✧✱ ✹✮

26

Layer20:leastcost, NN=4

20

15

10

5

0
5

0
4

0
3

0
2

0
1

0

0

10

20

30

40

50

27

●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
Layer0.1:leastcost, NN=4

1.0

0.8

0.6

0.4

0.2

0
5

0
4

0
3

0
2

0
1

0

0

10

20

30

40

50

28

●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
Layer5:leastcost, NN=4

5

4

3

2

1

0
5

0
4

0
3

0
2

0
1

0

0

10

20

30

40

50

29

●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
Layer50:leastcost, NN=4

50

40

30

20

10

0
5

0
4

0
3

0
2

0
1

0

0

10

20

30

40

50

♥❛♠❡s✭r❡s✉❧ts✹❜✮

★★ ❬✶❪ ✧❣❡♥✳♠❛t✧
★★ ❬✹❪ ✧❝♦st✳♠❛ts✧

✧❡✉❝❧✳♠❛t✧
✧♣❛t❤❧❡♥❣t❤✳♠❛ts✧ ✧♣❛t❤s✧

✧❝♦st✳♠❛t♥❛♠❡s✧

A nice feature of genleastcost is that you can observe the progress of the function by looking
at the plots that are created as the analysis proceeds. As can be seen, results4b has the same
slots as the results produced by the ❧❛♥❞❣❡♥r❡♣♦rt function (actually without the leastcost
level), but the mmrr.tab slot and the mantel.tab slot are missing. Instead of using the ’raw’
Gst.Nei index (which is a variant of Fst), we could ﬁrst visually plot Gst.Nei (actually Gst.Nei
/ (1-Gst.Nei)) against the log of Euclidean distance, which is the standard transformation used
for an isolation by distance plot. For this, we need to extract the values from our results4b
object.

❡✉❝❧ ❁✲ ❧♦❣✭r❡s✉❧ts✹❜✩❡✉❝❧✳♠❛t✮
❣❡♥ ❁✲ r❡s✉❧ts✹❜✩❣❡♥✳♠❛t ✴ ✭✶✲r❡s✉❧ts✹❜✩❣❡♥✳♠❛t✮
♣❧♦t✭❡✉❝❧✱ ❣❡♥✱ ②❧❛❜❂✧❋st✴✶✲❋st✧✱ ①❧❛❜❂✧❧♦❣ ❞✐st❛♥❝❡✧✮

30

●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
t
s
F
−
1
/
t
s
F

0
1
.
0

8
0
.
0

6
0
.
0

4
0
.
0

2
0
.
0

0
0
.
0

2.0

2.5

3.0

3.5

log distance

There seems to be a bit of a relationship between both distance matrices. Thus, we use
a MMRR that also includes the Euclidean distance matrix. We can use the ❧❣r▼▼❘❘ function,
which is based on the MMRR function from Wang [2012]. It requires three arguments, a genetic
distance matrix, cost matrix(ces) and a Euclidean distance matrix (see ❄❧❣r▼▼❘❘ for details).

❧❣r▼▼❘❘✭ ❣❡♥✱ r❡s✉❧ts✹❜✩❝♦st✳♠❛ts✱ ❡✉❝❧✮

❧❛②❡r ❝♦❡❢❢✐❝✐❡♥t tst❛t✐st✐❝ t♣✈❛❧✉❡ ❋st❛t ❋♣✈❛❧✉❡
✵✳✵✵✺
✲✷✳✾✾✻✸
◆❆
✶✳✻✵✵✽
◆❆
✶✳✺✽✺✼
◆❆
✲✶✳✶✸✷✷
◆❆
✲✵✳✽✼✷✼
◆❆
✵✳✸✵✷✾

✵✳✵✷✽ ✸✽✳✷✽
◆❆
✵✳✶✺✷
◆❆
✵✳✶✾✾
◆❆
✵✳✸✺✽
◆❆
✵✳✻✸✵
◆❆
✵✳✼✼✺

★★ ✩♠♠rr✳t❛❜
★★
★★ ✹
▲❛②❡r✺
✲✵✳✵✵✶✹✸✺✶
★★ ✻ ❊✉❝❧✐❞❡❛♥
✵✳✵✶✽✹✶✺✸
✵✳✵✵✶✹✸✺✾
▲❛②❡r✺✵
★★ ✺
★★ ✸ ▲❛②❡r✵✳✶ ✲✵✳✵✵✵✺✸✸✹
✲✵✳✵✶✾✺✻✸✼
★★ ✶ ■♥t❡r❝❡♣t
★★ ✷
✵✳✵✵✵✸✵✹✹
▲❛②❡r✷✵
r✷
★★
★★ ✹ ✵✳✽✸✵✼
◆❆
★★ ✻

31

●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
★★ ✺
★★ ✸
★★ ✶
★★ ✷

◆❆
◆❆
◆❆
◆❆

If you compare this output to the output created by the ❧❛♥❞r❡♣♦rt function you can see that
they are fairly similar, so the transformation did not affect the result in this case. Layer5 (the
green structure has a resistance value of 5) seems to be the cost matrix layer that best describes
the data.

Be aware that all of the cost matrices might be highly correlated to the genetic distance
matrix. We can check this by looking at the actual least-cost paths for the four cost matrices.
For this we need to slightly extend our script so we can have all of the least-cost paths for each
of the cost matrices in one output object.

★❝♦st ♠❛tr✐① ❧❛②❡r ❢r♦♠ ❡①❛♠♣❧❡ ✶
♣❛r✭♠❢r♦✇❂❝✭✷✱✷✮✮ ★❢♦✉r ♣❧♦ts ✷ ❜② ✷
❢♦r ✭✐ ✐♥ ✶✿✹✮
④
♣❧♦t✭r❬❬✐❪❪✱ ♠❛✐♥❂♥❛♠❡s✭r✮❬✐❪✮
★❤❡r❡ ❛r❡ t❤❡ ❝♦♦r❞✐♥❛t❡s st♦r❡❞
♣♦✐♥ts✭♣❧❛t②✳❣❡♥❅♦t❤❡r✩①②✱ ❝♦❧❂♣❧❛t②✳❣❡♥❅♣♦♣✱ ♣❝❤❂✶✻✮
★♣❧♦t t❤❡ ❧❡❛st ❝♦st ♣❛t❤s
❞✉♠♠② ❁✲ ❧❛♣♣❧②✭r❡s✉❧ts✹❛✩❧❡❛st❝♦st✩♣❛t❤s❬❬✐❪❪✱ ❢✉♥❝t✐♦♥ ✭①✮ ❧✐♥❡s✭①✮ ✮
⑥

32

Layer20

Layer0.1

0
5

0
4

0
3

0
2

0
1

0

0
5

0
4

0
3

0
2

0
1

0

0

10

20

30

40

50

Layer5

20

15

10

5

5

4

3

2

1

0
5

0
4

0
3

0
2

0
1

0

0
5

0
4

0
3

0
2

0
1

0

0

10

20

30

40

50

Layer50

1.0

0.8

0.6

0.4

0.2

50
40
30
20
10

0

10

20

30

40

50

0

10

20

30

40

50

To calculate the correlation between the cost matrices we need to extract them and put them
into the ❝♦r function. Again this can be achieved elegantly using the lapply function, admit-
tedly a bit confusing because we need to reformat our data, so that it can be processed by the
different functions.

❧❛②❡rs ❁✲ ❞❛t❛✳❢r❛♠❡✭❧❛♣♣❧② ✭r❡s✉❧ts✹❜✩❝♦st✳♠❛ts✱

❢✉♥❝t✐♦♥✭①✮ ❛s✳♥✉♠❡r✐❝✭❛s✳❞✐st✭①✮✮✮✮

♣❛✐rs✭❧❛②❡rs✮ ★♣❧♦ts t❤❡ ♣❛✐r✇✐s❡ ❝♦rr❡❧❛t✐♦♥s

33

5

10 15 20 25 30

20

40

60

80

Layer20

Layer0.1

Layer5

Layer50

0
8

0
6

0
4

0
2

0
6

0
5

0
4

0
3

0
2

0
1

0
3

5
2

0
2

5
1

0
1

5

0
8

0
6

0
4

0
2

20

40

60

80

10 20 30 40 50 60

❝♦r✭❧❛②❡rs✮

★❝❛❧❝✉❧❛t❡ r ✈❛❧✉❡s ❢♦r ❡❛❝❤ ♣❛✐r

★★
★★ ▲❛②❡r✷✵
★★ ▲❛②❡r✵✳✶
★★ ▲❛②❡r✺
★★ ▲❛②❡r✺✵

▲❛②❡r✷✵ ▲❛②❡r✵✳✶ ▲❛②❡r✺ ▲❛②❡r✺✵
✵✳✾✾✻✵
✵✳✻✼✹✾ ✵✳✾✸✹✹
✶✳✵✵✵✵ ✵✳✼✽✹✽
✵✳✻✻✵✺
✵✳✼✽✹✽ ✶✳✵✵✵✵ ✵✳✾✷✺✼
✶✳✵✵✵✵
✵✳✻✻✵✺ ✵✳✾✷✺✼

✶✳✵✵✵✵
✵✳✻✼✹✾
✵✳✾✸✹✹
✵✳✾✾✻✵

Here we actually see that Layer5, Layer20 and Layer50 are highly correlated r > 0.9 and
therefore the three matrices should not be used at the same time in the MMRR. We can select
only Layer0.1 and Layer20 (the ﬁrst two from the raster stack) and rerun the ❧❣r▼▼❘❘ function.

❧❣r▼▼❘❘✭ ❣❡♥✱ r❡s✉❧ts✹❜✩❝♦st✳♠❛ts❬✶✿✷❪✱ ❡✉❝❧✮

★★ ✩♠♠rr✳t❛❜
★★
★★ ✷

❧❛②❡r ❝♦❡❢❢✐❝✐❡♥t tst❛t✐st✐❝ t♣✈❛❧✉❡ ❋st❛t ❋♣✈❛❧✉❡
✵✳✵✵✷
✼✳✸✷✹✽✶

✵✳✵✵✾ ✹✽✳✻✻

✵✳✵✵✶✸✵✹✽

▲❛②❡r✷✵

34

●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
●
✲✶✳✺✽✶✹✶
✵✳✼✼✺✽✵
✲✵✳✵✾✾✷✽

✵✳✷✵✵
✵✳✼✺✺
✵✳✾✷✻

◆❆
◆❆
◆❆

◆❆
◆❆
◆❆

★★ ✸ ▲❛②❡r✵✳✶ ✲✵✳✵✵✵✽✶✸✸
✵✳✵✶✻✼✸✶✺
★★ ✶ ■♥t❡r❝❡♣t
★★ ✹ ❊✉❝❧✐❞❡❛♥
✲✵✳✵✵✶✵✽✷✼
r✷
★★
★★ ✷ ✵✳✼✽✵✼
◆❆
★★ ✸
◆❆
★★ ✶
◆❆
★★ ✹

This time only Layer20 comes out as being signiﬁcant, which is reassuring as in the example

a resistance value of 20 was used in a simulation of our populations.

Finally for completeness, we can also run the Wasserman et al. [2010] approach that uses a
series of partial Mantel tests. Again we use only the ﬁrst two layers of the raster stack and the
function used is called ✇❛ss❡r♠❛♥♥.

✇❛ss❡r♠❛♥♥✭ ❣❡♥✱ r❡s✉❧ts✹❜✩❝♦st✳♠❛ts❬✶✿✷❪✱ ❡✉❝❧✮

♠♦❞❡❧
●❡♥ ⑦▲❛②❡r✷✵ ⑤ ▲❛②❡r✵✳✶

★★ ✩♠❛♥t❡❧✳t❛❜
♣
r
★★
★★ ✶
✵✳✽✹✾✻ ✵✳✵✵✷
★★ ✸ ●❡♥ ⑦▲❛②❡r✷✵ ⑤ ❊✉❝❧✐❞❡❛♥ ✵✳✼✺✽✽ ✵✳✵✵✽
★★ ✻ ●❡♥ ⑦❊✉❝❧✐❞❡❛♥ ⑤ ▲❛②❡r✵✳✶ ✵✳✺✾✽✹ ✵✳✵✵✶
✲✵✳✸✹✶ ✵✳✾✽✺
★★ ✷
★★ ✺ ●❡♥ ⑦▲❛②❡r✵✳✶ ⑤ ❊✉❝❧✐❞❡❛♥ ✲✵✳✷✼✼✺ ✵✳✾✹✽
★★ ✹ ●❡♥ ⑦❊✉❝❧✐❞❡❛♥ ⑤ ▲❛②❡r✷✵ ✲✵✳✷✺✵✶ ✵✳✾✹✷

●❡♥ ⑦▲❛②❡r✵✳✶ ⑤ ▲❛②❡r✷✵

Here Layer20 shows the a signiﬁcant correlation when corrected for Euclidean distance or
Layer0.1, which is not true for the inverse. All other comparison are not following the require-
ments of Wasserman et al. [2010] (a signiﬁcant correlation corrected by the competing layer and
a non-signiﬁcant correlation corrected by the original layer), so both methods lead to the same
conclusion that Layer20 is the cost matrix that explains best the connectivity in the landscape.

✻ ❈♦♥t❛❝ts ❛♥❞ ❈✐t❛t✐♦♥

Please do not hesitate to contact the authors of P♦♣●❡♥❘❡♣♦rt if you have any comments or
questions regarding the package. First of all we are certain there will still be ”bugs” in the
code as it is impossible to test it under all conditions. Additionally, we would like to expand
the capabilities of PopGenReport in the future and comments on features that you would like
to have included for your analysis are most welcome. For further updates please check our
website: ✇✇✇✳♣♦♣❣❡♥r❡♣♦rt✳♦r❣.
For citation please use

❝✐t❛t✐♦♥✭✧P♦♣●❡♥❘❡♣♦rt✧✮

★★
★★ ❆❞❛♠❛❝❦ ❆❚ ❛♥❞ ●r✉❜❡r ❇ ✭✷✵✶✹✮✳ ✧P♦♣●❡♥❘❡♣♦rt✿
★★ s✐♠♣❧✐❢②✐♥❣ ❜❛s✐❝ ♣♦♣✉❧❛t✐♦♥ ❣❡♥❡t✐❝ ❛♥❛❧②s❡s ✐♥ ❘✳✧
★★ ❴▼❡t❤♦❞s ✐♥ ❊❝♦❧♦❣② ❛♥❞ ❊✈♦❧✉t✐♦♥❴✱ ✯✺✯✭✹✮✱ ♣♣✳
★★ ✸✽✹✲✸✽✼✳
★★
★★ ❆ ❇✐❜❚❡❳ ❡♥tr② ❢♦r ▲❛❚❡❳ ✉s❡rs ✐s

35

★★
★★
★★
★★
★★
★★
★★
★★
★★
★★
★★

❅❆rt✐❝❧❡④✱

t✐t❧❡ ❂ ④P♦♣●❡♥❘❡♣♦rt✿ s✐♠♣❧✐❢②✐♥❣ ❜❛s✐❝ ♣♦♣✉❧❛t✐♦♥ ❣❡♥❡t✐❝ ❛♥❛❧②s❡s ✐♥ ❘⑥✱
❛✉t❤♦r ❂ ④❆❛r♦♥ ❚✳ ❆❞❛♠❛❝❦ ❛♥❞ ❇❡r♥❞ ●r✉❜❡r⑥✱
②❡❛r ❂ ④✷✵✶✹⑥✱
❥♦✉r♥❛❧ ❂ ④▼❡t❤♦❞s ✐♥ ❊❝♦❧♦❣② ❛♥❞ ❊✈♦❧✉t✐♦♥⑥✱
✈♦❧✉♠❡ ❂ ④✺⑥✱
♥✉♠❜❡r ❂ ④✹⑥✱
♣❛❣❡s ❂ ④✸✽✹✲✸✽✼⑥✱
②❡❛r ❂ ④✷✵✶✹⑥✱

⑥

Have fun running P♦♣●❡♥❘❡♣♦rt and may there be exciting results :-)

Bernd & Aaron
bernd.gruber@canberra.edu.au
aaron.adamack@canberra.edu.au

✼ ❘❡❢❡r❡♥❝❡s

❘❡❢❡r❡♥❝❡s

Ian J Wang. Environmental and topographic variables shape genetic structure and effec-
tive population sizes in the endangered Yosemite toad. Diversity and Distributions, 18
doi: 10.1111/j.1472-4642.2012.00897.x. URL ❁●♦t♦■❙■❃✿✴✴❲❖❙✿
(10):1033–1041, 2012.
✵✵✵✸✵✽✹✻✻✾✵✵✵✵✽.

Tzeidle N Wasserman, Samuel A Cushman, Michael K Schwartz, and David O Wallin. Spa-
tial scaling and multi-model inference in landscape genetics: Martes americana in northern
Idaho. Landscape Ecology, 25(10):1601–1612, 2010. doi: 10.1007/s10980-010-9525-7. URL
❁●♦t♦■❙■❃✿✴✴❲❖❙✿✵✵✵✷✽✸✸✼✶✵✵✵✵✶✶.

✽ ❆♣♣❡♥❞✐①

Output of a full report running: r❡s✉❧ts ❁✲❧❛♥❞❣❡♥r❡♣♦rt✭❧❛♥❞❣❡♥✱ ❢r✐❝✳r❛st❡r✱ ✧❉✧✱
♠❦✳♣❞❢❂❚❘❯❊✮.

36

A Population Genetic Report
using PopGenReport Ver. 2.0

Adamack & Gruber (2014)

July 10, 2014

Contents

1 Landscape Genetic Analysis

2
2
1.1 Maps of resistance matrices . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3
1.2 Pairwise Euclidean distances
. . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5
1.3 Pairwise cost distances . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
7
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
1.4 Pairwise path lengths
1.5 Pairwise genetic distances (D) . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
9
1.6 Partial Mantel tests following the approach of Wassermann et al. 2010 . . . . . . 11
. . . . . . . . . . . . . 12
1.7 Multiple Matrix Regression with Randomization analysis

1

1 Landscape Genetic Analysis

Here some initial words on the method....

1.1 Maps of resistance matrices

The following pages show simple maps of the resistance matrices. In case of the pathtype is
”leastcost” also the least-cost paths are shown.

2

1.2 Pairwise Euclidean distances

3

0
1

9
3

8
3

6
2

6

3
3

2
2

3
4

4
1

9

0

9

7
3

1
3

5
2

1
1

5
2

6
2

9
3

0
1

0

9

8

7
2

5
2

4
1

0
1

0
2

8
1

0
3

0

0
1

4
1

7

1
1

5
1

8
1

9
3

0
2

1
3

0

0
3

9
3

3
4

6

2
2

4
3

4
1

7
1

3
3

0

1
3

8
1

6
2

2
2

5

5
2

6

0
2

0
3

0

3
3

0
2

0
2

5
2

3
3

4

4
3

5
3

1
2

0

0
3

7
1

9
3

0
1

1
1

6

3

3
1

1
2

0

1
2

0
2

4
1

8
1

4
1

5
2

6
2

2

0

2
2

1
2

5
3

6

4
3

5
1

5
2

1
3

8
3

1

0

2
2

3
1

4
3

5
2

2
2

1
1

7
2

7
3

9
3

1

2

3

4

5

6

7

8

9

0
1

s
e
c
n
a
t
s
i

d

n
a
e
d

i
l
c
u
e

e
s
i
w
r
i
a
P

:
1

e
l

b
a
T

4

1.3 Pairwise cost distances

5

0
1

5
5

4
7

7
3

8

3
6

9
2

3
8

7
1

3
1

0

9

2
5

1
6

4
3

5
1

0
5

6
2

5
7

4
1

0

3
1

8

8
3

5
6

0
2

3
1

4
5

2
2

6
6

0

4
1

7
1

7

4
3

6
1

6
4

9
7

5
2

4
5

0

6
6

5
7

3
8

6

6
2

8
6

8
1

5
2

2
6

0

4
5

2
2

6
2

9
2

5

6
4

1
1

4
5

5
6

0

2
6

5
2

4
5

0
5

3
6

4

1
5

6
7

3
3

0

5
6

5
2

9
7

3
1

5
1

8

3

8
1

0
6

0

3
3

4
5

8
1

6
4

0
2

4
3

7
3

2

0

8
4

0
6

6
7

1
1

8
6

6
1

5
6

1
6

4
7

1

0

8
4

8
1

1
5

6
4

6
2

4
3

8
3

2
5

5
5

1

2

3

4

5

6

7

8

9

0
1

4
=
N
N

,
’
t
s
o
c
t
s
a
e
l
’

=
e
p
y
t
h
t
a
p

,
r
e
y
a
l

-

s
e
c
n
a
t
s
i

d

t
s
o
c

e
s
i
w
r
i
a
P

:
2

e
l

b
a
T

6

1.4 Pairwise path lengths

Path lengths are only calculated if path type is ”leastcost”.

7

0
1

5
5

4
7

7
3

8

3
6

9
2

4
6

7
1

3
1

0

9

2
5

1
6

4
3

5
1

0
5

6
2

5
7

4
1

0

3
1

8

8
3

5
6

0
2

3
1

4
5

2
2

7
4

0

4
1

7
1

7

5
1

6
1

7
2

0
6

5
2

5
3

0

7
4

5
7

4
6

6

6
2

9
4

8
1

5
2

2
6

0

5
3

2
2

6
2

9
2

5

6
4

1
1

4
5

5
6

0

2
6

5
2

4
5

0
5

3
6

4

1
5

6
7

3
3

0

5
6

5
2

0
6

3
1

5
1

8

3

8
1

1
4

0

3
3

4
5

8
1

7
2

0
2

4
3

7
3

2

0

9
2

1
4

6
7

1
1

9
4

6
1

5
6

1
6

4
7

1

0

9
2

8
1

1
5

6
4

6
2

5
1

8
3

2
5

5
5

1

2

3

4

5

6

7

8

9

0
1

4
=
N
N

,
’
t
s
o
c
t
s
a
e
l
’

=
e
p
y
t
h
t
a
p

,
r
e
y
a
l

-

)
s
h
t
a
p

t
s
o
c

t
s
a
e
l

n
o

d
e
s
a
b
(

s
h
t
g
n
e
l

h
t
a
p

e
s
i
w
r
i
a
P

:
3

e
l

b
a
T

8

1.5 Pairwise genetic distances (D)

9

0
1

8
3
4
.
0

1
9
6
.
0

5
9
2
.
0

4
2
1
.
0

8
0
7
.
0

3
3
3
.
0

8
0
7
.
0

0
8
1
.
0

2
4
1
.
0

0
0
0
.
0

9

5
7
4
.
0

8
7
6
.
0

1
3
3
.
0

0
8
1
.
0

1
7
6
.
0

8
0
3
.
0

7
7
6
.
0

2
4
1
.
0

0
0
0
.
0

2
4
1
.
0

8

5
3
4
.
0

7
5
6
.
0

3
7
2
.
0

0
7
1
.
0

7
6
6
.
0

6
9
2
.
0

6
9
6
.
0

0
0
0
.
0

2
4
1
.
0

0
8
1
.
0

7

1
0
7
.
0

1
0
2
.
0

4
5
6
.
0

5
0
7
.
0

4
1
2
.
0

3
1
7
.
0

0
0
0
.
0

6
9
6
.
0

7
7
6
.
0

8
0
7
.
0

6

6
5
3
.
0

3
5
6
.
0

8
4
2
.
0

0
3
3
.
0

0
9
6
.
0

0
0
0
.
0

3
1
7
.
0

6
9
2
.
0

8
0
3
.
0

3
3
3
.
0

5

5
4
6
.
0

3
3
1
.
0

2
1
6
.
0

9
1
7
.
0

0
0
0
.
0

0
9
6
.
0

4
1
2
.
0

7
6
6
.
0

1
7
6
.
0

8
0
7
.
0

4

8
5
4
.
0

1
1
7
.
0

7
0
3
.
0

0
0
0
.
0

9
1
7
.
0

0
3
3
.
0

5
0
7
.
0

0
7
1
.
0

0
8
1
.
0

4
2
1
.
0

3

2
3
2
.
0

2
0
6
.
0

0
0
0
.
0

7
0
3
.
0

2
1
6
.
0

8
4
2
.
0

4
5
6
.
0

3
7
2
.
0

1
3
3
.
0

5
9
2
.
0

2

0
4
6
.
0

0
0
0
.
0

2
0
6
.
0

1
1
7
.
0

3
3
1
.
0

3
5
6
.
0

1
0
2
.
0

7
5
6
.
0

8
7
6
.
0

1
9
6
.
0

1

0
0
0
.
0

0
4
6
.
0

2
3
2
.
0

8
5
4
.
0

5
4
6
.
0

6
5
3
.
0

1
0
7
.
0

5
3
4
.
0

5
7
4
.
0

8
3
4
.
0

1

2

3

4

5

6

7

8

9

0
1

)
D
(

e
c
n
a
t
s
i

d

c
i
t
e
n
e
g

e
s
i
w
r
i
a
P

:
4

e
l

b
a
T

10

1.6 Partial Mantel tests following the approach of Wassermann et al. 2010

11

model

r

1 Gen ˜layer | Euclidean 0.8623
-0.4771
2 Gen ˜Euclidean | layer

p
0.003
0.994

Table 5: Mantel tests following methodology of Wassermann et al. 2011

1.7 Multiple Matrix Regression with Randomization analysis

The approach follows the approach of Wang 2013 and Legendre et al. 1994.

layer
layer
2
3 Euclidean
Intercept
1

coeﬃcient
0.013
-0.009
0.140

tstatistic
11.036
-3.518
4.505

tpvalue
0.001
0.021
0.877

Fstat Fpvalue
0.001

143.917

r2
0.873

Table 6: Multiple Matrix Regression wiht Randomization

12

