Ctc Package

Antoine Lucas

October 29, 2025

Contents

1 Overview

2 Aim

3 Usage

3.1 Building hierarchical clustering with another software
. . . . . .
3.2 Using other visualization softwares . . . . . . . . . . . . . . . . .

4 See Also

1 Overview

1

1

1
2
3

3

Ctc package provides several functions for conversion. Specially to export and
import data from Xcluster1 or Cluster2 software (very used for Gene’s expression
analysis), and to export clusters to TreeView or Freeview visualization software.

2 Aim

• To explore clusters made by Xcluster and Cluster .

• To cluster data with Xcluster (it requires very low memory usage) and
analyze the results with R. Warning: results are not exactly the same as
hclust results with R.

3 Usage

Standard way of building a hierarchical clustering with R is with this command:

> data(USArrests)
> h = hclust(dist(USArrests))
> plot(h)

Or for the “heatmap”:

1http://genome-www.stanford.edu/~sherlock/cluster.html
2http://rana.lbl.gov/EisenSoftware.htm

1

> heatmap(as.matrix(USArrests))

3.1 Building hierarchical clustering with another software

We made these tools

r2xcluster Write data table to Xcluster file format

> library(ctc)
> r2xcluster(USArrests,file='USArrests_xcluster.txt')

r2cluster Write data table to Cluster file format

> r2cluster(USArrests,file='USArrests_xcluster.txt')

xcluster Hierarchical clustering (need Xcluster tool by Gavin Sherlock)

> h.xcl=xcluster(USArrests)
> plot(h.xcl)

It is roughtly the same as

> r2xcluster(USArrests,file='USArrests_xcluster.txt')
> system('Xcluster -f USArrests_xcluster.txt -e 0 -p 0 -s 0 -l 0')
> h.xcl=xcluster2r('USArrests_xcluster.gtr',labels=TRUE)

xcluster2r Importing Xcluster/Cluster output

2

MurderRapeUrbanPopAssaultNorth CarolinaDelawareLouisianaMississippiMarylandArizonaIllinoisMichiganVermontWest VirginiaSouth DakotaMinnesotaNew HampshirePennsylvaniaOhioNebraskaKentuckyKansasMissouriTennesseeTexasRhode IslandMassachusettsWyomingOklahoma3.2 Using other visualization softwares

We now consider that we have an object of the type produced by ’hclust’ (or a
hierarchical cluster imported with previous functions) like:

> hr = hclust(dist(USArrests))
> hc = hclust(dist(t(USArrests)))

hc2Newick Export hclust objects to Newick format files

> write(hc2Newick(hr),file='hclust.newick')

r2gtr,r2atr,r2cdt Export hclust objects to Freeview or Treeview visualization

softwares

> r2atr(hc,file="cluster.atr")
> r2gtr(hr,file="cluster.gtr")
> r2cdt(hr,hc,USArrests ,file="cluster.cdt")

hclust2treeview Clustering and Export hclust objects to Freeview or Tree-

view visualization softwares

> hclust2treeview(USArrests,file="cluster.cdt")

[1] 1

4 See Also

Theses examples can be tested with command demo(ctc).

All functions has got man pages, try help.start().

Ctc aims to interact with other softwares, some of them:

xcluster made by Gavin Scherlock, http://genome-www.stanford.edu/˜sherlock/cluster.html

Cluster, Treeview made by Michael Eisen, http://rana.lbl.gov/EisenSoftware.htm

Freeview made by Marco Kavcic and Blaz Zupan, http://magix.fri.uni-lj.si/freeview

If you want to cite amap or ctc in a publication, use :

Antoine Lucas and Sylvain Jasson, Using amap and ctc Packages for Huge

Clustering, R News, 2006, vol 6, issue 5 pages 58-60.

3

