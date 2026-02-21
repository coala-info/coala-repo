# Code example from 'RBGL' vignette. See references/ for full tutorial.

## ----Setup, include = FALSE---------------------------------------------------
library(RBGL)
library(Rgraphviz)
library(XML)

## ----bfDemo-------------------------------------------------------------------
con <- file(system.file("XML/bfsex.gxl", package="RBGL"))
bf <- fromGXL(con)
close(con)

## ----figbf, echo = FALSE, eval = FALSE----------------------------------------
# plot(bf, main="a) Breath-First Search Example")

## ----dfDemo-------------------------------------------------------------------
con <- file(system.file("XML/dfsex.gxl", package="RBGL"))
df <- fromGXL(con)
close(con)

## ----figdf, echo = FALSE, eval = FALSE----------------------------------------
# plot(df, main="b) Depth-First Search Example")

## ----dijkstraDemo-------------------------------------------------------------
con <- file(system.file("XML/dijkex.gxl", package="RBGL"))
dijk <- fromGXL(con)
close(con)

## ----figdijk, echo = FALSE, eval = FALSE--------------------------------------
# plot(dijk, main="c) Dijkstra's Example")

## ----connDemo-----------------------------------------------------------------
con <- file(system.file("XML/conn.gxl", package="RBGL"))
coex <- fromGXL(con)
close(con)

## ----figcoex, echo = FALSE, eval = FALSE--------------------------------------
# plot(coex, main="d) Coex Example")

## ----conn2Demo----------------------------------------------------------------
con <- file(system.file("XML/conn2.gxl", package="RBGL"))
coex2 <- fromGXL(con)
close(con)

## ----figcoex2, echo = FALSE, eval = FALSE-------------------------------------
# plot(coex2, main="e) Coex2 Example")

## ----conn2iDemo---------------------------------------------------------------
con <- file(system.file("XML/conn2iso.gxl", package="RBGL"))
coex2i <- fromGXL(con)
close(con)

## ----figcoex2i, echo = FALSE, eval = FALSE------------------------------------
# plot(coex2i, main="f) Coex2 Isomorphism Example")

## ----kmstDemo-----------------------------------------------------------------
con <- file(system.file("XML/kmstEx.gxl", package="RBGL"))
km <- fromGXL(con)
close(con)

## ----figkmst, echo = FALSE, eval = FALSE--------------------------------------
# plot(km, main="g) Kruskal MST Example")

## ----bicoDemo-----------------------------------------------------------------
con <- file(system.file("XML/biconn.gxl", package="RBGL"))
bicoex <- fromGXL(con)
close(con)

## ----figbico, echo = FALSE, eval = FALSE--------------------------------------
# plot(bicoex, main="h) Biconnected Component Example")

## ----ospfDemo-----------------------------------------------------------------
con <- file(system.file("XML/ospf.gxl", package="RBGL"))
ospf <- fromGXL(con)
close(con)

## ----figospf, echo = FALSE, eval = FALSE--------------------------------------
# plot(ospf, main="i) Ospf Example")

## ----zzDemo-------------------------------------------------------------------
con <- file(system.file("dot/joh.gxl", package="RBGL"))
joh <- fromGXL(con)
close(con)

## ----figjoh, echo = FALSE, eval = FALSE---------------------------------------
# plot(joh, main="j) joh Example")

## ----hcsDemo------------------------------------------------------------------
con <- file(system.file("XML/hcs.gxl", package="RBGL"))
hcs <- fromGXL(con)
close(con)

## ----fighcs, echo = FALSE, eval = FALSE---------------------------------------
# plot(hcs, main="k) HCS Example")

## ----kclexDemo----------------------------------------------------------------
con <- file(system.file("XML/snacliqueex.gxl", package="RBGL"))
kclex <- fromGXL(con)
close(con)

## ----figkclex, echo = FALSE, eval = FALSE-------------------------------------
# plot(kclex, main="l) kCliques Example")

## ----kcoexDemo----------------------------------------------------------------
con <- file(system.file("XML/snacoreex.gxl", package="RBGL"))
kcoex <- fromGXL(con)
close(con)

## ----figkcoex, echo = FALSE, eval = FALSE-------------------------------------
# plot(kcoex, main="m) kCores Example")

## ----layout, echo = FALSE-----------------------------------------------------
layout_matrix_1 <- matrix(1:4, ncol = 2)

## ----fig.cap = "The example graphs (I).", fig.height = 8, echo = FALSE--------
layout(layout_matrix_1)
plot(bf, main="a) Breath-First Search Example")
plot(dijk, main="c) Dijkstra's Example")
plot(df, main="b) Depth-First Search Example") 
plot(coex, main="d) Coex Example")

## ----fig.cap = "The example graphs (II).", fig.height = 8, echo = FALSE-------
layout(layout_matrix_1)
plot(coex2, main="e) Coex2 Example")
plot(km, main="g) Kruskal MST Example")
plot(coex2i, main="f) Coex2 Isomorphism Example")
plot(bicoex, main="h) Biconnected Component Example")

## ----fig.cap = "The example graphs (III).", fig.height = 8, echo = FALSE------
layout(layout_matrix_1)
plot(hcs, main="k) HCS Example")
plot(kcoex, main="m) kCores Example")
plot(kclex, main="l) kCliques Example")

## ----fdpic, fig.cap = "File dependency digraph example from Boost library", fig.height = 7, results = "hide", echo = FALSE----
data(FileDep)
FileDep
plot(FileDep)

## ----showFileDep--------------------------------------------------------------
data(FileDep)
FileDep

## ----echo = FALSE-------------------------------------------------------------
layout_matrix_2 <- matrix(1:2, ncol = 2)

## ----figdfsex, fig.cap = "a) The graph for depth-first-search example b) The graph for depth-first-search example, showing search orders.", echo = FALSE, results = "hide"----
layout(layout_matrix_2)
print(dfs.res <- dfs(df, "y"))
plot(df, main="a) DFS Example")
dfsNattrs <- makeNodeAttrs(df) 
dfsNattrs$label[dfs.res$discovered] <- 1:numNodes(df) 
plot(df, nodeAttrs=dfsNattrs, main="b) DFS Example with search order")

## ----DFSdemo------------------------------------------------------------------
print(dfs.res <- dfs(df, "y"))

## ----figdfs1, echo = FALSE, eval = FALSE--------------------------------------
# plot(df, main="a) DFS Example")

## ----figdfs2, echo = FALSE, eval = FALSE--------------------------------------
# dfsNattrs <- makeNodeAttrs(df)
# dfsNattrs$label[dfs.res$discovered] <- 1:numNodes(df)
# plot(df, nodeAttrs=dfsNattrs, main="b) DFS Example with search order")

## ----figbfsex, fig.cap = "a) The graph for breadth-first-search example b) The graph for breadth-first-search example, showing search orders.", echo = FALSE, results = "hide"----
layout(layout_matrix_2)
print(bfs.res <- bfs(bf,"s"))
plot(bf, main="a) BFS Example")
bfsNattrs <- makeNodeAttrs(bf)
bfsNattrs$label[bfs.res] <- 1:numNodes(bf)
plot(bf, nodeAttrs=bfsNattrs, main="b) BFS Example with search order")

## ----BFSdemo------------------------------------------------------------------
print(bfs.res <- bfs(bf,"s"))

## ----figbfs1, echo = FALSE, eval = FALSE--------------------------------------
# plot(bf, main="a) BFS Example")

## ----figbfs2, echo = FALSE, eval = FALSE--------------------------------------
# bfsNattrs <- makeNodeAttrs(bf)
# bfsNattrs$label[bfs.res] <- 1:numNodes(bf)
# plot(bf, nodeAttrs=bfsNattrs, main="b) BFS Example with search order")

## ----dijkdemo1----------------------------------------------------------------
nodes(dijk)
edgeWeights(dijk)
dijkstra.sp(dijk)

## ----dijkdemo2----------------------------------------------------------------
nodes(ospf)[6]
dijkstra.sp(ospf,nodes(ospf)[6])
sp.between(ospf, "RT6", "RT1")

## ----figospfs, fig.width = 6, fig.cap = "Network example from BGL.", echo = FALSE----
plot(ospf)

## ----bellmanfordDemo----------------------------------------------------------
dd <- coex2
nodes(dd)
bellman.ford.sp(dd)
bellman.ford.sp(dd,nodes(dd)[2])

## ----DAGDemo------------------------------------------------------------------
dd <- coex2
dag.sp(dd)
dag.sp(dd,nodes(dd)[2])

## ----johnsonDemo--------------------------------------------------------------
zz <- joh
edgeWeights(zz)
johnson.all.pairs.sp(zz)

## ----floydwarshallDemo--------------------------------------------------------
floyd.warshall.all.pairs.sp(coex)

## ----figjohn, fig.cap = "Example: Johnson-all-pairs-shortest-paths example", fig.small = TRUE, echo = FALSE----
plot(zz)

## ----KMSTdemo-----------------------------------------------------------------
mstree.kruskal(km)

## ----primDemo-----------------------------------------------------------------
mstree.prim(coex2)

## ----figkm, fig.cap = "Kruskal MST examples.", echo = FALSE, results = "hide"----
km1 <- km 
km1 <- graph::addNode(c("F","G","H"), km1) 
km1 <- addEdge("G", "H", km1, 1) 
km1 <- addEdge("H", "G", km1, 1) 
connectedComp(ugraph(km1))
layout(layout_matrix_2)
plot(km, main="g) Kruskal MST Example")
plot(km1, main="Modified Kruskal MST example")

## ----conndemo-----------------------------------------------------------------
km1 <- km 
km1 <- graph::addNode(c("F","G","H"), km1) 
km1 <- addEdge("G", "H", km1, 1) 
km1 <- addEdge("H", "G", km1, 1) 
connectedComp(ugraph(km1))

## ----figkm1, echo = FALSE, eval = FALSE---------------------------------------
# plot(km1, main="Modified Kruskal MST example")

## ----sconndemo----------------------------------------------------------------
km2 <- km
km2 <- graph::addNode(c("F","G","H"), km2)
km2 <- addEdge("G", "H", km2, 1)
km2 <- addEdge("H", "G", km2, 1)
strongComp(km2)

## ----biConnCompdemo-----------------------------------------------------------
biConnComp(bicoex) 
articulationPoints(bicoex)

## ----figbicoex, fig.width = 6, fig.cap = "Biconnected components example from Boost library.", echo = FALSE----
plot(bicoex)

## ----incrCompdemo-------------------------------------------------------------
jcoex <- join(coex, hcs)
x <- init.incremental.components(jcoex)
incremental.components(jcoex)
same.component(jcoex, "A", "F")
same.component(jcoex, "A", "A1")
jcoex <- addEdge("A", "A1", jcoex) 
x <- init.incremental.components(jcoex)
incremental.components(jcoex)
same.component(jcoex, "A", "A1")

## ----figjcoex, fig.width = 6, fig.cap = "Example on incremental components: a graph connecting coexand hcs.", echo = FALSE----
plot(jcoex)

## ----MaxFlowdemo--------------------------------------------------------------
edgeWeights(dijk) 
edmonds.karp.max.flow(dijk, "B", "D") 
push.relabel.max.flow(dijk, "C", "B")

## ----SparseMatrixOrderingdemo-------------------------------------------------
dijk1 <- ugraph(dijk)
cuthill.mckee.ordering(dijk1) 
minDegreeOrdering(dijk1)
sloan.ordering(dijk1)

## ----edgeConndemo-------------------------------------------------------------
edgeConnectivity(coex)

## ----tsortDemo1---------------------------------------------------------------
tsort(FileDep)

## ----tsortDemo2, warning = FALSE----------------------------------------------
FD2 <- FileDep 
# now introduce a cycle 
FD2 <- addEdge(from="bar_o", to="dax_h", FD2) 
tsort(FD2)

## ----Isomorphismdemo----------------------------------------------------------
isomorphism(dijk, coex2) 
isomorphism(coex2i, coex2) 

## ----fig.small = TRUE, fig.cap = "Example conn2i", echo = FALSE---------------
plot(coex2i)

## ----VertexColoringdemo-------------------------------------------------------
sequential.vertex.coloring(coex)

## ----wavefrontdemo------------------------------------------------------------
ss <- 1 
ith.wavefront(dijk, ss)
maxWavefront(dijk) 
aver.wavefront(dijk) 
rms.wavefront(dijk)

## ----Centralitydemo, echo = TRUE----------------------------------------------
brandes.betweenness.centrality(coex)
betweenness.centrality.clustering(coex, 0.1, TRUE)

## ----mincutdemo---------------------------------------------------------------
minCut(coex)

## ----highlyConnSGdemo---------------------------------------------------------
highlyConnSG(coex) 
highlyConnSG(hcs)

## ----MaxCliquedemo------------------------------------------------------------
maxClique(coex) 
maxClique(hcs)

## ----IsTriangulateddemo-------------------------------------------------------
is.triangulated(coex)
is.triangulated(hcs)

## ----Separatesdemo------------------------------------------------------------
separates("B", "A", "E", km)
separates("B", "A", "C", km)

## ----kCoresdemo1--------------------------------------------------------------
kCores(kcoex) 
kcoex2 <- coex2 
kCores(kcoex2)
kCores(kcoex2, "in") 
kCores(kcoex2, "out") 
g1 <- addEdge("C", "B", kcoex2) 
kCores(g1, "in") 
g2 <- addEdge("C", "A", kcoex2)
kCores(g2, "out")

## ----figkcores, fig.small = TRUE, fig.cap = "K-cores Example.", echo = FALSE----
plot(kcoex)

## ----kCliquesdemo-------------------------------------------------------------
kCliques(kclex)

## ----figkcliques, fig.small = TRUE, fig.cap = "K-cliques Example", echo = FALSE----
plot(kclex)

