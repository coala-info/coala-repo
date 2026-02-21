# Code example from 'BaseSpaceR' vignette. See references/ for full tutorial.

### R code from vignette source 'BaseSpaceR.Rnw'

###################################################
### code chunk number 1: BaseSpaceR.Rnw:41-42
###################################################
options(width = 95)


###################################################
### code chunk number 2: BaseSpaceR.Rnw:133-136 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install()


###################################################
### code chunk number 3: BaseSpaceR.Rnw:142-145 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("BaseSpaceR")


###################################################
### code chunk number 4: BaseSpaceR.Rnw:149-150
###################################################
library(BaseSpaceR)


###################################################
### code chunk number 5: BaseSpaceR.Rnw:271-273
###################################################
data(aAuth)
aAuth


###################################################
### code chunk number 6: BaseSpaceR.Rnw:291-293
###################################################
u <- Users(aAuth)
u


###################################################
### code chunk number 7: BaseSpaceR.Rnw:300-302
###################################################
Id(u)
Name(u)


###################################################
### code chunk number 8: BaseSpaceR.Rnw:310-313
###################################################
u$Id
u$Email
u$fakeElement


###################################################
### code chunk number 9: BaseSpaceR.Rnw:320-324
###################################################
u <- Users()
u
u$Id
u$UserOwnedBy


###################################################
### code chunk number 10: BaseSpaceR.Rnw:331-333
###################################################
Users(aAuth, id = 1463464)
Users(aAuth, id = "1463464")


###################################################
### code chunk number 11: BaseSpaceR.Rnw:349-351
###################################################
g <- listGenomes(aAuth, Limit = 100)
g$SpeciesName


###################################################
### code chunk number 12: BaseSpaceR.Rnw:364-366
###################################################
length(g)
TotalCount(g)


###################################################
### code chunk number 13: BaseSpaceR.Rnw:372-374
###################################################
g[[3]]
is(g[[3]], "Item")


###################################################
### code chunk number 14: BaseSpaceR.Rnw:380-382
###################################################
g[2:4]
g[1]


###################################################
### code chunk number 15: BaseSpaceR.Rnw:395-399
###################################################
listGenomes(aAuth, Limit = 2)
g <- listGenomes(aAuth, Offset = 5, Limit = 2, SortBy = "Build")
g
TotalCount(g) # Collection size remains constant


###################################################
### code chunk number 16: BaseSpaceR.Rnw:406-407
###################################################
Genomes(aAuth, id = 4)


###################################################
### code chunk number 17: BaseSpaceR.Rnw:414-415
###################################################
Genomes(aAuth, id = c(4, 1, 110))


###################################################
### code chunk number 18: BaseSpaceR.Rnw:422-423
###################################################
Genomes(aAuth, id = 4, simplify = TRUE)


###################################################
### code chunk number 19: BaseSpaceR.Rnw:430-431
###################################################
Genomes(g)


###################################################
### code chunk number 20: BaseSpaceR.Rnw:444-446
###################################################
r <- listRuns(aAuth)
r


###################################################
### code chunk number 21: BaseSpaceR.Rnw:452-453
###################################################
listRuns(aAuth, Statuses = "Failed") # no failed runs in our case


###################################################
### code chunk number 22: BaseSpaceR.Rnw:459-461
###################################################
myRun <- Runs(r[1], simplify = TRUE)
myRun


###################################################
### code chunk number 23: BaseSpaceR.Rnw:468-470
###################################################
f <- listFiles(myRun)
Name(f)


###################################################
### code chunk number 24: BaseSpaceR.Rnw:475-476
###################################################
listFiles(myRun, Limit = 2, Extensions = ".bcl")


###################################################
### code chunk number 25: BaseSpaceR.Rnw:490-491
###################################################
Projects(listProjects(aAuth, Limit = 1), simplify = TRUE)


###################################################
### code chunk number 26: BaseSpaceR.Rnw:497-499
###################################################
myNewProj <- createProject(aAuth, name = "My New Project")
myNewProj


###################################################
### code chunk number 27: BaseSpaceR.Rnw:528-530
###################################################
reseq <- listAppResults(aAuth, projectId = 21383369, Limit = 1)
AppResults(reseq)


###################################################
### code chunk number 28: BaseSpaceR.Rnw:539-540 (eval = FALSE)
###################################################
## system.file("doc", "BaseSpaceR-QscoreApp.pdf", package = "BaseSpaceR")


###################################################
### code chunk number 29: BaseSpaceR.Rnw:560-563
###################################################
f <- listFiles(AppResults(reseq))
TotalCount(f)
Name(f)


###################################################
### code chunk number 30: BaseSpaceR.Rnw:569-570
###################################################
identical(f, listFiles(aAuth, appResultId = Id(reseq)))


###################################################
### code chunk number 31: BaseSpaceR.Rnw:579-581
###################################################
f <- listFiles(aAuth, appResultId = Id(reseq), Extensions = ".bam")
Name(f)


###################################################
### code chunk number 32: BaseSpaceR.Rnw:588-589
###################################################
Files(f)


###################################################
### code chunk number 33: BaseSpaceR.Rnw:614-618
###################################################
bamFiles <- listFiles(AppResults(reseq), Extensions = ".bam")
Name(bamFiles)
Id(bamFiles)
bamFiles


###################################################
### code chunk number 34: BaseSpaceR.Rnw:624-625
###################################################
getCoverageStats(aAuth, id = Id(bamFiles), "phix")


###################################################
### code chunk number 35: BaseSpaceR.Rnw:641-645
###################################################
vcfs <- listFiles(AppResults(reseq), Extensions = ".vcf")
Name(vcfs)
Id(vcfs)
vcfs


###################################################
### code chunk number 36: BaseSpaceR.Rnw:651-652 (eval = FALSE)
###################################################
## getVariants(aAuth, Id(vcfs)[1], chrom = "chr", EndPos = 1000000L, Limit = 5)


###################################################
### code chunk number 37: BaseSpaceR.Rnw:696-702
###################################################
myAppClientId <- "aaaaa8acb37a441fa71af5072fd7432b"
myAppClientSecret <- "bbbbb8acb37a441fa71af5072fd7432b"

aAuth <- AppAuth(client_id = myAppClientId,
                 client_secret = myAppClientSecret,
                 scope = "create global")


###################################################
### code chunk number 38: BaseSpaceR.Rnw:736-741
###################################################
aAuth <- AppAuth(client_id = myAppClientId,
                 client_secret = myAppClientSecret,
                 scope = "read global", 
                 doOAuth = FALSE) 
aAuth


###################################################
### code chunk number 39: BaseSpaceR.Rnw:750-752
###################################################
res <- initializeAuth(aAuth, scope = character())
res


###################################################
### code chunk number 40: BaseSpaceR.Rnw:767-769 (eval = FALSE)
###################################################
## requestAccessToken(aAuth)
## hasAccess(aAuth)


###################################################
### code chunk number 41: BaseSpaceR.Rnw:797-799
###################################################
data(aAuth)
app_access_token <- aAuth$access_token


###################################################
### code chunk number 42: BaseSpaceR.Rnw:805-807
###################################################
newAuth <- AppAuth(access_token = app_access_token)
newAuth


###################################################
### code chunk number 43: BaseSpaceR.Rnw:820-824
###################################################
newAuth <- AppAuth(access_token = app_access_token, 
                   client_secret = myAppClientSecret,
                   client_id = myAppClientId)
newAuth


###################################################
### code chunk number 44: BaseSpaceR.Rnw:837-838
###################################################
toLatex(sessionInfo())


