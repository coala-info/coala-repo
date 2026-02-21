# Code example from 'simpIntLists' vignette. See references/ for full tutorial.

### R code from vignette source 'simpIntLists.Rnw'

###################################################
### code chunk number 1: ex1
###################################################
 library(simpIntLists)
 i<-findInteractionList("arabidopsis", "EntrezId")
 i[1:5]
 data(ArabidopsisBioGRIDInteractionUniqueId)
 ArabidopsisBioGRIDInteractionUniqueId[30:32]


###################################################
### code chunk number 2: ex2
###################################################
data(ArabidopsisBioGRIDInteractionEntrezId)
ArabidopsisBioGRIDInteractionEntrezId[1:5]


###################################################
### code chunk number 3: ex3
###################################################
data(ArabidopsisBioGRIDInteractionOfficial)
ArabidopsisBioGRIDInteractionOfficial[1:5]


###################################################
### code chunk number 4: ex4
###################################################
data(ArabidopsisBioGRIDInteractionUniqueId)
ArabidopsisBioGRIDInteractionUniqueId[1:5]


###################################################
### code chunk number 5: ex5
###################################################
data(C.ElegansBioGRIDInteractionEntrezId)
C.ElegansBioGRIDInteractionEntrezId[1:5]


###################################################
### code chunk number 6: ex6
###################################################
data(C.ElegansBioGRIDInteractionOfficial)
C.ElegansBioGRIDInteractionOfficial[1:5]


###################################################
### code chunk number 7: ex7
###################################################
data(C.ElegansBioGRIDInteractionUniqueId)
C.ElegansBioGRIDInteractionUniqueId[1:5]


###################################################
### code chunk number 8: ex8
###################################################
 l <- findInteractionList("arabidopsis", "EntrezId")
 l[1:5]


###################################################
### code chunk number 9: ex9
###################################################
data(FruitFlyBioGRIDInteractionEntrezId)
FruitFlyBioGRIDInteractionEntrezId[1:5]


###################################################
### code chunk number 10: ex10
###################################################
data(FruitFlyBioGRIDInteractionOfficial)
FruitFlyBioGRIDInteractionOfficial[1:5]


###################################################
### code chunk number 11: ex11
###################################################
data(FruitFlyBioGRIDInteractionUniqueId)
FruitFlyBioGRIDInteractionUniqueId[1:5]


###################################################
### code chunk number 12: ex12
###################################################
data(HumanBioGRIDInteractionEntrezId)
HumanBioGRIDInteractionEntrezId[1]


###################################################
### code chunk number 13: ex13
###################################################
data(HumanBioGRIDInteractionOfficial)
HumanBioGRIDInteractionOfficial[1]


###################################################
### code chunk number 14: ex14
###################################################
data(HumanBioGRIDInteractionUniqueId)
HumanBioGRIDInteractionUniqueId[1]


###################################################
### code chunk number 15: ex15
###################################################
data(MouseBioGRIDInteractionEntrezId)
MouseBioGRIDInteractionEntrezId[1:5]


###################################################
### code chunk number 16: ex16
###################################################
data(MouseBioGRIDInteractionOfficial)
MouseBioGRIDInteractionOfficial[1:5]


###################################################
### code chunk number 17: ex17
###################################################
data(MouseBioGRIDInteractionUniqueId)
MouseBioGRIDInteractionUniqueId[1:5]


###################################################
### code chunk number 18: ex18
###################################################
data(S.PombeBioGRIDInteractionEntrezId)
S.PombeBioGRIDInteractionEntrezId[1:5]


###################################################
### code chunk number 19: ex19
###################################################
data(S.PombeBioGRIDInteractionOfficial)
S.PombeBioGRIDInteractionOfficial[1:5]


###################################################
### code chunk number 20: ex20
###################################################
data(S.PombeBioGRIDInteractionUniqueId)
S.PombeBioGRIDInteractionUniqueId[1:5]


###################################################
### code chunk number 21: ex21
###################################################
data(YeastBioGRIDInteractionEntrezId)
YeastBioGRIDInteractionEntrezId[1:5]


###################################################
### code chunk number 22: ex22
###################################################
data(YeastBioGRIDInteractionOfficial)
YeastBioGRIDInteractionOfficial[1:5]


###################################################
### code chunk number 23: ex23
###################################################
data(YeastBioGRIDInteractionUniqueId)
YeastBioGRIDInteractionUniqueId[1:5]


