Intro to ALL data for Bioc monograph

VJ Carey

October 30, 2025

1

Introduction

This document is for authors of the Bioc monograph, it just goes over various aspects
of the ALL data. Example analyses can be added here for illustration.

2 Attachment and data list

> library(ALL)
> data(ALL)
> show(ALL)

ExpressionSet (storageMode: lockedEnvironment)
assayData: 12625 features, 128 samples

element names: exprs

protocolData: none
phenoData

sampleNames: 01005 01010 ... LAL4 (128 total)
varLabels: cod diagnosis ... date last seen (21 total)
varMetadata: labelDescription

featureData: none
experimentData: use 'experimentData(object)'

pubMedIds: 14684422 16243790

Annotation: hgu95av2

3 Tables and graphs for phenodata

> print(summary(pData(ALL)))

cod
Length:128

diagnosis
Length:128

sex

age

F

:42

Min.

: 5.00

B2

BT

:36

1

Class :character
:character
Mode

Class :character
Mode :character

M
:83
NA's: 3

remission
CR
:99
REF :15
NA's:14

CR

Length:128
Class :character
:character
Mode

date.cr
Length:128
Class :character
:character
Mode

:23
B3
:19
B1
:15
T2
:12
B4
T3
:10
(Other):13

1st Qu.:19.00
Median :29.00
:32.37
Mean
3rd Qu.:45.50
:58.00
Max.
:5
NA's

t(4;11)

Mode :logical
FALSE:86
TRUE :7
NA's :35

t(9;22)

Mode :logical
FALSE:67
TRUE :26
NA's :35

cyto.normal
Mode :logical
FALSE:69
TRUE :24
NA's :35

citog
Length:128
Class :character
:character
Mode

mol.biol

ALL1/AF4:10
BCR/ABL :37
E2A/PBX1: 5
:74
NEG
: 1
NUP-98
p15/p16 : 1

fusion protein

:17
p190
p190/p210: 8
: 8
p210
:95
NA's

mdr
NEG :101
POS : 24
3
NA's:

kinet

ccr

dyploid:94
hyperd.:27
: 7
NA's

Mode :logical
FALSE:74
TRUE :26
NA's :28

relapse

Mode :logical
FALSE:35
TRUE :65
NA's :28

transplant
Mode :logical
FALSE:91
TRUE :9
NA's :28

f.u
Length:128
Class :character
:character
Mode

date last seen
Length:128
Class :character
:character
Mode

> hist(cvv <- apply(exprs(ALL),1,function(x)sd(x)/mean(x)))

2

> ok <- cvv > .08 & cvv < .18
> fALL <- ALL[ok,]
> show(fALL)

ExpressionSet (storageMode: lockedEnvironment)
assayData: 3841 features, 128 samples

element names: exprs

protocolData: none
phenoData

sampleNames: 01005 01010 ... LAL4 (128 total)
varLabels: cod diagnosis ... date last seen (21 total)
varMetadata: labelDescription

featureData: none
experimentData: use 'experimentData(object)'

pubMedIds: 14684422 16243790

Annotation: hgu95av2

> allx2 <- data.frame(t(exprs(fALL)), class=ALL$BT)

3

Histogram of cvv <− apply(exprs(ALL), 1, function(x) sd(x)/mean(x))cvv <− apply(exprs(ALL), 1, function(x) sd(x)/mean(x))Frequency0.00.10.20.30.401000200030004000> library(rpart)
> rp1 <- rpart(class~.,data=allx2)
> plot(rp1)
> text(rp1)

4

|X35016_at>=9.81X1389_at< 8.395X35991_at< 4.192X37902_at< 4.546X35723_at< 8.535X37780_at< 4.447B1B2B4B3B4T2T3