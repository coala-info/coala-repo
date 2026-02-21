# Model inference

Luca De Sano, Daniele Ramazzotti, Giulio Caravagna, Alex Graudenxi and Marco Antoniotti

#### October 30, 2025

#### Package

TRONCO 2.42.0

We make use of the most of the functions described above to show how to perform inference with various algorithms; the reader should read first those sections of the vignette to have an explanation of how those functions work. The aCML dataset is used as a test-case for all algorithms, regardless it should be precessed by algorithms to infer ensemble-level progression models.

To replicate the plots of the original paper were the aCML dataset was first analyzed with CAPRI, we can change the colors assigned to each type of event with the function `change.color`.

```
dataset = change.color(aCML, 'Ins/Del', 'dodgerblue4')
dataset = change.color(dataset, 'Missense point', '#7FC97F')
as.colors(dataset)
```

```
##          Ins/Del   Missense point Nonsense Ins/Del   Nonsense point
##    "dodgerblue4"        "#7FC97F"        "#FDC086"        "#fab3d8"
```

#### 0.0.0.1 Data consolidation.

All TRONCO algorithms require an input dataset were events have non-zero/non-one probability, and are all distinguishable. The tool provides a function to return lists of events which do not satisfy these constraint.

```
consolidate.data(dataset)
```

```
## $indistinguishable
## list()
##
## $zeroes
## list()
##
## $ones
## list()
```

The aCML data has none of the above issues (the call returns empty lists); if this were not the case data manipulation functions can be used to edit a TRONCO object.

## 0.1 CAPRI

In what follows, we show CAPRI’s functioning by replicating the aCML case study presented in CAPRI’s original paper. Regardless from which types of mutations we include, we select only the genes mutated at least in the 5% of the patients – thus we first use `as.alterations` to have gene-level frequencies, and then we apply there a frequency filter (R’s output is omitted).

```
alterations = events.selection(as.alterations(aCML), filter.freq = .05)
```

```
## *** Aggregating events of type(s) { Ins/Del, Missense point, Nonsense Ins/Del, Nonsense point }
## in a unique event with label " Alteration ".
## Dropping event types Ins/Del, Missense point, Nonsense Ins/Del, Nonsense point for 23 genes.
## .......................
## *** Binding events for 2 datasets.
## *** Events selection: #events =  23 , #types =  1 Filters freq|in|out = { TRUE ,  FALSE ,  FALSE }
## Minimum event frequency:  0.05  ( 3  alterations out of  64  samples).
## .......................
## Selected  7  events.
##
## Selected  7  events, returning.
```

To proceed further with the example we create the *dataset* to be used for the inference of the model. From the original dataset we select all the genes whose mutations are occurring at least the 5% of the times, and we get that by the alterations profiles; also we force inclusion of all the events for the genes involved in an hypothesis (those included in variable `gene.hypotheses`, this list is based on the support found in the literature of potential aCML patterns).

```
gene.hypotheses = c('KRAS', 'NRAS', 'IDH1', 'IDH2', 'TET2', 'SF3B1', 'ASXL1')
aCML.clean = events.selection(aCML,
    filter.in.names=c(as.genes(alterations), gene.hypotheses))
```

```
## *** Events selection: #events =  31 , #types =  4 Filters freq|in|out = { FALSE ,  TRUE ,  FALSE }
## [filter.in] Genes hold:  TET2, EZH2, CBL, ASXL1, SETBP1  ...  [ 10 / 14  found].
## Selected  17  events, returning.
```

```
aCML.clean = annotate.description(aCML.clean,
    'CAPRI - Bionformatics aCML data (selected events)')
```

We show a new oncoprint of this latest dataset where we annotate the genes in `gene.hypotheses` in order to identify them. The sample names are also shown.

```
oncoprint(aCML.clean, gene.annot = list(priors = gene.hypotheses), sample.id = TRUE)
```

```
## *** Oncoprint for "CAPRI - Bionformatics aCML data (selected events)"
## with attributes: stage = FALSE, hits = TRUE
## Sorting samples ordering to enhance exclusivity patterns.
## Annotating genes with RColorBrewer color palette Set1 .
## Setting automatic row font (exponential scaling): 10.7
## Setting automatic samples font half of row font: 5.3
```

![Data selected for aCML reconstruction annotated with the events which are part of a pattern that we will input to CAPRI.](data:image/png;base64...)

Figure 1: Data selected for aCML reconstruction annotated with the events which are part of a pattern that we will input to CAPRI

### 0.1.1 Testable hypotheses via logical formulas (i.e., patterns)

CAPRI is the only algorithm in TRONCO that supports hypotheses-testing of causal structures expressed as logical formulas with AND, OR and XOR operators. An example invented formula could be

(APC:*Mutation* **XOR** APC:*Deletion*) **OR** CTNNB1:*Mutation*

where APC mutations and deletions are in disjunctive relation with CTNNB1 mutations; this is done to test if those events could confer equivalent fitness in terms of ensemble-level progression – see the original CAPRI paper and the PiCnIc pipeline for detailed explanations.

Every formula is transformed into a CAPRI *pattern*. For every hypothesis it is possible to specify against which possible target event it should be tested, e.g., one might test the above formula against PIK3CA mutations, but not ATM ones. If this is not done, a pattern is tested against all other events in the dataset but those which constitute itself. A pattern tested against one other event is called an hypothesis.

#### 0.1.1.1 Adding custom hypotheses.

We add the hypotheses that are described in CAPRI’s manuscript; we start with hard exclusivity (XOR) for NRAS/KRAS mutation,

NRAS:*Missense point* **XOR** KRAS:*Missense point*

tested against all the events in the dataset (default `pattern.effect = *`)

```
aCML.hypo = hypothesis.add(aCML.clean, 'NRAS xor KRAS', XOR('NRAS', 'KRAS'))
```

When a pattern is included, a new column in the dataset is created – whose signature is given by the evaluation of the formula constituting the pattern. We call this operation *lifting of a pattern*, and this shall create not inconsistency in the data – i.e., it shall not duplicate any of the other columns. TRONCO check this; for instance when we try to include a soft exclusivity (OR) pattern for the above genes we get an error (not shown).

```
aCML.hypo = hypothesis.add(aCML.hypo, 'NRAS or KRAS',  OR('NRAS', 'KRAS'))
```

Notice that TRONCO functions can be used to look at their alterations and understand why the OR signature is equivalent to the XOR one – this happens as no samples harbour both mutations.

```
oncoprint(events.selection(aCML.hypo,
    filter.in.names = c('KRAS', 'NRAS')),
    font.row = 8,
    ann.hits = FALSE)
```

```
## *** Events selection: #events =  18 , #types =  4 Filters freq|in|out = { FALSE ,  TRUE ,  FALSE }
## [filter.in] Genes hold:  KRAS, NRAS  ...  [ 2 / 2  found].
## Selected  2  events, returning.
## *** Oncoprint for ""
## with attributes: stage = FALSE, hits = FALSE
## Sorting samples ordering to enhance exclusivity patterns.
```

![Oncoprint output to show the perfect (hard) exclusivity among NRAS/KRAS mutations in aCML](data:image/png;base64...)

Figure 2: Oncoprint output to show the perfect (hard) exclusivity among NRAS/KRAS mutations in aCML

We repeated the same analysis as before for other hypotheses and for the same reasons, we will include only the hard exclusivity pattern. In this case we add a two-levels pattern

SF3B1:*Missense point* **XOR** (ASXL1:*Ins/Del* **XOR** ASXL1:*Nonsense point*)

since ASXL1 is mutated in two different ways, and no samples harbour both mutation types.

```
aCML.hypo = hypothesis.add(aCML.hypo, 'SF3B1 xor ASXL1', XOR('SF3B1', XOR('ASXL1')),
    '*')
```

Finally, we now do the same for genes TET2 and IDH2. In this case 3 events for the gene TET2 are present, that is `Ins/Del`, `Missense point` and `Nonsense point`. For this reason, since we are not specifying any subset of such events to be considered, all TET2 alterations are used. Since the events present a perfect hard exclusivity, their patters will be included as a XOR.

```
as.events(aCML.hypo, genes = 'TET2')
```

```
##         type             event
## gene 4  "Ins/Del"        "TET2"
## gene 32 "Missense point" "TET2"
## gene 88 "Nonsense point" "TET2"
```

```
aCML.hypo = hypothesis.add(aCML.hypo,
    'TET2 xor IDH2',
    XOR('TET2', 'IDH2'),
    '*')
aCML.hypo = hypothesis.add(aCML.hypo,
    'TET2 or IDH2',
    OR('TET2', 'IDH2'),
    '*')
```

Which is the following pattern

(TET2:*Ins/Del*) **XOR** (TET2:*Missense point*) **XOR** (TET2:*Nonsense point*) **XOR** (IDH2:*Missense point*)

which we can visualize via an `oncoprint`.

```
oncoprint(events.selection(aCML.hypo,
    filter.in.names = c('TET2', 'IDH2')),
    font.row = 8,
    ann.hits = FALSE)
```

```
## *** Events selection: #events =  21 , #types =  4 Filters freq|in|out = { FALSE ,  TRUE ,  FALSE }
## [filter.in] Genes hold:  TET2, IDH2  ...  [ 2 / 2  found].
## Selected  4  events, returning.
## *** Oncoprint for ""
## with attributes: stage = FALSE, hits = FALSE
## Sorting samples ordering to enhance exclusivity patterns.
```

![{oncoprint} output to show the soft exclusivity among NRAS/KRAS mutations in aCML](data:image/png;base64...)

Figure 3: {oncoprint} output to show the soft exclusivity among NRAS/KRAS mutations in aCML

#### 0.1.1.2 Adding (automatically) hypotheses for homologous events.

We consider homologous events those having the same mnemonic name – as of function `as.genes` – but events of different type. For instance, mutations and deletions of the same gene would be considered such (e.g., in the aCML dataset ASXL1 Ins/Del and Nonsense point).
It could be a good idea to test such events, in terms of progression fitness, to test is they might be equivalent; we can do that by building a pattern of exclusivity among them. TRONCO has a function to make this automatically which, by default, adds a soft exclusivity OR pattern among them.

```
aCML.hypo = hypothesis.add.homologous(aCML.hypo)
```

```
## *** Adding hypotheses for Homologous Patterns
##  Genes: TET2, EZH2, CBL, ASXL1, CSF3R
##  Cause: *
##  Effect: *
## .....Hypothesis created for all possible gene patterns.
```

This function added one pattern for each of TET2, EZH2, CBL, ASXL1, CSF3R (unless they created duplicated columns in the dataset), with a connective OR/XOR which is appropriate for the events considered; for instance the TET2 homologous pattern

(TET2:*Ins/Del*) **XOR** (TET2:*Missense point*) **XOR** (TET2:*Nonsense point*)

was created with a XOR function, as TET2 appears in perfect exclusivity.

#### 0.1.1.3 Adding (automatically) hypotheses for a group of genes.

The idea behind the previous function is generalized by `hypothesis.add.group`, that add a set of hypotheses that can be combinatorially created out of a group of genes. As such, this function can create an exponential number of hypotheses and should be used with caution as too many hypotheses, with respect to sample size, should not be included.

This function takes, among its inputs, the top-level logical connective, AND/OR/XOR, a minimum/maximum pattern size – to restrict the combinatorial sampling of subgroups –, plus a parameter that can be used to constrain the minimum event frequency. If, among the events included some of them have homologous, these are put automatically nested with the same logic of the `hypothesis.add.group` function.

```
dataset = hypothesis.add.group(aCML.clean, OR, group = c('SETBP1', 'ASXL1', 'CBL'))
```

```
## *** Adding Group Hypotheses
##  Group: SETBP1, ASXL1, CBL
##  Function: OR
##  Cause: * ;  Effect: * .
## Genes with multiple events:  ASXL1, CBL
## Generating  4 patterns [size: min = 3  -  max = 3 ].
## Hypothesis created for all possible patterns.
```

The final dataset that will be given as input to CAPRI is finally shown. Notice the signatures of all the lifted patterns.

```
oncoprint(aCML.hypo, gene.annot = list(priors = gene.hypotheses), sample.id = TRUE,
    font.row=10, font.column=5, cellheight=15, cellwidth=4)
```

```
## *** Oncoprint for "CAPRI - Bionformatics aCML data (selected events)"
## with attributes: stage = FALSE, hits = TRUE
## Sorting samples ordering to enhance exclusivity patterns.
## Annotating genes with RColorBrewer color palette Set1 .
```

![oncoprint} output of the a dataset that has patterns that could be given as input to CAPRI to retrieve a progression model.](data:image/png;base64...)

Figure 4: oncoprint} output of the a dataset that has patterns that could be given as input to CAPRI to retrieve a progression model

#### 0.1.1.4 Querying, visualizing and manipulating CAPRI’s patterns.

We also provide functions to get the number of hypotheses and patterns present in the data.

```
npatterns(dataset)
```

```
## [1] 4
```

```
nhypotheses(dataset)
```

```
## [1] 106
```

We can visualize any pattern or the elements involved in them with the following functions.

```
as.patterns(dataset)
```

```
## [1] "OR_SETBP1_ASXL1"     "OR_SETBP1_CBL"       "OR_ASXL1_CBL"
## [4] "OR_SETBP1_ASXL1_CBL"
```

```
as.events.in.patterns(dataset)
```

```
##         type             event
## gene 6  "Ins/Del"        "CBL"
## gene 7  "Ins/Del"        "ASXL1"
## gene 29 "Missense point" "SETBP1"
## gene 34 "Missense point" "CBL"
## gene 91 "Nonsense point" "ASXL1"
```

```
as.genes.in.patterns(dataset)
```

```
## [1] "CBL"    "ASXL1"  "SETBP1"
```

```
as.types.in.patterns(dataset)
```

```
## [1] "Ins/Del"        "Missense point" "Nonsense point"
```

Similarily, we can enumerate the hypotheses with the function `as.hypotheses`, and delete certain patterns and hypotheses. Deleting a pattern consists in deleting all of its hypotheses.

```
head(as.hypotheses(dataset))
```

```
##      cause type cause event       effect type      effect event
## [1,] "Pattern"  "OR_SETBP1_ASXL1" "Ins/Del"        "TET2"
## [2,] "Pattern"  "OR_SETBP1_ASXL1" "Ins/Del"        "EZH2"
## [3,] "Pattern"  "OR_SETBP1_ASXL1" "Ins/Del"        "CBL"
## [4,] "Pattern"  "OR_SETBP1_ASXL1" "Missense point" "NRAS"
## [5,] "Pattern"  "OR_SETBP1_ASXL1" "Missense point" "KRAS"
## [6,] "Pattern"  "OR_SETBP1_ASXL1" "Missense point" "TET2"
```

```
dataset = delete.hypothesis(dataset, event = 'TET2')
dataset = delete.pattern(dataset, pattern = 'OR_ASXL1_CBL')
```

#### 0.1.1.5 How to build a pattern.

It is sometimes of help to plot some information about a certain combination of events, and a target – especially to disentangle the proper logical connectives to use when building a pattern. Here, we test genes SETBP1 and ASXL1 versus Missense point mutations of CSF3R, and observe that the majority of observations are mutually exclusive, but almost half of the CSF3R mutated samples with Missense point mutations do not harbout any mutation in SETBP1 and ASXL1.

```
tronco.pattern.plot(aCML,
    group = as.events(aCML, genes=c('SETBP1', 'ASXL1')),
    to = c('CSF3R', 'Missense point'),
    legend.cex=0.8,
    label.cex=1.0)
```

```
## Group:
##         type             event
## gene 7  "Ins/Del"        "ASXL1"
## gene 29 "Missense point" "SETBP1"
## gene 91 "Nonsense point" "ASXL1"
## Group tested against: CSF3R Missense point
## Pattern conditioned to samples: patient 5, patient 13, patient 30, patient 34, patient 45
## Co-occurrence in #samples:  0
## Hard exclusivity in #samples: 1 2 0
## Other observations in #samples: 2
## Soft exclusivity in #samples: 0
##               CSF3R
##   ASXL1           1
## SETBP1            2
##     ASXL1         0
## soft              0
## co-occurrence     0
## other             2
##      CSF3R Missense point
## [1,]                    3
## [2,]                    0
## [3,]                    0
## [4,]                    2
```

It is also possible to create a circle plot where we can observe the contribution of genes SETBP1 and ASXL1 in every match with a Missense point mutations of CSF3R.

```
tronco.pattern.plot(aCML,
    group = as.events(aCML, genes=c('TET2', 'ASXL1')),
    to = c('CSF3R', 'Missense point'),
    legend = 1.0,
    label.cex = 0.8,
    mode='circos')
```

```
## Group:
##         type             event
## gene 4  "Ins/Del"        "TET2"
## gene 7  "Ins/Del"        "ASXL1"
## gene 32 "Missense point" "TET2"
## gene 88 "Nonsense point" "TET2"
## gene 91 "Nonsense point" "ASXL1"
## Group tested against: CSF3R Missense point
## Pattern conditioned to samples: patient 5, patient 13, patient 30, patient 34, patient 45
## Co-occurrence in #samples:  0
## Hard exclusivity in #samples: 0 1 1 1 0
## Other observations in #samples: 2
## Soft exclusivity in #samples: 0
## Circlize matrix.
##               CSF3R
##   TET2            0
##    ASXL1          1
##     TET2          1
##      TET2         1
##       ASXL1       0
## soft              0
## co-occurrence     0
## other             2
```

![Circos to show an hypothesis: here we test genes SETBP1 and ASXL1 versus Missense point mutations of  CSF3R. The combination of this and the previous  plots should allow to understand which pattern we shall write in an attempt to capture a potential causality relation between the pattern and the event.](data:image/png;base64...)

Figure 5: Circos to show an hypothesis: here we test genes SETBP1 and ASXL1 versus Missense point mutations of CSF3R
The combination of this and the previous plots should allow to understand which pattern we shall write in an attempt to capture a potential causality relation between the pattern and the event.

### 0.1.2 Model reconstruction

We run the inference of the model by CAPRI algorithm with its default parameter: we use both AIC and BIC as regularizators, Hill-climbing as heuristic search of the solutions and exhaustive bootstrap (`nboot` replicates or more for Wilcoxon testing, i.e., more iterations can be performed if samples are rejected), p-value are set at 0.05. We set the seed for the sake of reproducibility.

`{r results='hide', include=FALSE}= aCML.hypo = annotate.description(aCML.hypo, '') aCML.clean = annotate.description(aCML.clean, '')`

```
model.capri = tronco.capri(aCML.hypo, boot.seed = 12345, nboot = 5)
```

```
## *** Checking input events.
## *** Inferring a progression model with the following settings.
##  Dataset size: n = 64, m = 26.
##  Algorithm: CAPRI with "bic, aic" regularization and "hc" likelihood-fit strategy.
##  Random seed: 12345.
##  Bootstrap iterations (Wilcoxon): 5.
##      exhaustive bootstrap: TRUE.
##      p-value: 0.05.
##      minimum bootstrapped scores: 3.
## *** Bootstraping selective advantage scores (prima facie).
##  ........
##  Evaluating "temporal priority" (Wilcoxon, p-value 0.05)
##  Evaluating "probability raising" (Wilcoxon, p-value 0.05)
## *** Loop detection found loops to break.
##  Removed 30 edges out of 69 (43%)
## *** Performing likelihood-fit with regularization bic.
## *** Performing likelihood-fit with regularization aic.
## *** Evaluating BIC / AIC / LogLik informations.
## The reconstruction has been successfully completed in 00h:00m:01s
```

```
model.capri = annotate.description(model.capri, 'CAPRI - aCML')
```

```
## Warning in annotate.description(model.capri, "CAPRI - aCML"): Old description
## substituted: CAPRI - Bionformatics aCML data (selected events) .
```

## 0.2 CAPRESE

The CAPRESE algorithm is one of a set of algorithms to reconstruct progression models from data of an individual patient. This algorithm uses a shrinkage-alike estimator combining correlation and probability raising among pair of events. This algorithm shall return a forest of trees, a special case of a Suppes-Bayes Causal Network.

Despite this is derived to infer progression models from individual level data, we use it here to process aCML data (without patterns and with its default parameters). This algorithm has no bootstrap and, as such, is the quickest available in TRONCO.

```
model.caprese = tronco.caprese(aCML.clean)
```

```
## *** Checking input events.
## *** Inferring a progression model with the following settings.
##  Dataset size: n = 64, m = 17.
##  Algorithm: CAPRESE with shrinkage coefficient: 0.5.
## *** Evaluating LogLik informations.
## The reconstruction has been successfully completed in 00h:00m:00s
```

```
model.caprese = annotate.description(model.caprese, 'CAPRESE - aCML')
```

```
## Warning in annotate.description(model.caprese, "CAPRESE - aCML"): Old
## description substituted: CAPRI - Bionformatics aCML data (selected events) .
```

## 0.3 Directed Minimum Spanning Tree with Mutual Information

This algorithm is meant to extract a forest of trees of progression from data of an individual patient. This algorithm is based on a formulation of the problem in terms of minimum spamming trees and exploits results from Edmonds. We test it to infer a model from aCML data as we did with CAPRESE.

```
model.edmonds = tronco.edmonds(aCML.clean, nboot = 5, boot.seed = 12345)
```

```
## *** Checking input events.
## *** Inferring a progression model with the following settings.
##  Dataset size: n = 64, m = 17.
##  Algorithm: Edmonds with "no_reg" regularization Random seed: 12345.
##  Bootstrap iterations (Wilcoxon): 5.
##      exhaustive bootstrap: TRUE.
##      p-value: 0.05.
##      minimum bootstrapped scores: 3.
## *** Bootstraping selective advantage scores (prima facie).
##  ........
##  Evaluating "temporal priority" (Wilcoxon, p-value 0.05)
##  Evaluating "probability raising" (Wilcoxon, p-value 0.05)
## *** Loop detection found loops to break.
##  Removed 2 edges out of 24 (8%)
## *** Performing likelihood-fit with regularization: no_reg and score: pmi .
## *** Evaluating BIC / AIC / LogLik informations.
## The reconstruction has been successfully completed in 00h:00m:01s
```

```
model.edmonds = annotate.description(model.edmonds, 'MST Edmonds - aCML')
```

```
## Warning in annotate.description(model.edmonds, "MST Edmonds - aCML"): Old
## description substituted: CAPRI - Bionformatics aCML data (selected events) .
```

## 0.4 Partially Directed Minimum Spanning Tree with Mutual Information

This algorithm extends the previous one in situations where it is not possible to fully assess a confident time ordering among the nodes, hence leading to a partially directed input. This algorithm adopts Gabow search strategy to evaluate the best directed minimum spanning tree among such undirected components. We test it to infer a model from aCML data as all the other algorithms.

```
model.gabow = tronco.gabow(aCML.clean, nboot = 5, boot.seed = 12345)
```

```
## *** Checking input events.
## *** Inferring a progression model with the following settings.
##  Dataset size: n = 64, m = 17.
##  Algorithm: Gabow with "no_reg" regularization   Random seed: 12345.
##  Bootstrap iterations (Wilcoxon): 5.
##      exhaustive bootstrap: TRUE.
##      p-value: 0.05.
##      minimum bootstrapped scores: 3.
## *** Bootstraping selective advantage scores (prima facie).
##  ........
##  Evaluating "temporal priority" (Wilcoxon, p-value 0.05)
##  Evaluating "probability raising" (Wilcoxon, p-value 0.05)
## *** Loop detection found loops to break.
##  Removed 2 edges out of 24 (8%)
## *** Performing likelihood-fit with regularization: no_reg .
## *** Evaluating BIC / AIC / LogLik informations.
## The reconstruction has been successfully completed in 00h:00m:01s
```

```
model.gabow = annotate.description(model.gabow, 'MST Gabow - aCML')
```

```
## Warning in annotate.description(model.gabow, "MST Gabow - aCML"): Old
## description substituted: CAPRI - Bionformatics aCML data (selected events) .
```

## 0.5 Undirected Minimum Spanning Tree with Likelihood-Fit

This algorithm is meant to extract a progression from data of an individual patient, but it is not constrained to retrieve a tree/forest – i.e., it could retrieve a direct acyclic graph – according to the level of noise and heterogeneity of the input data. This algorithm is based on a
formulation of the problem in terms of minimum spamming trees and exploits results from Chow Liu and other variants for likelihood-fit. Thus, this algorithm is executed with potentially multiple regularizator as CAPRI – here we use BIC/AIC.

We test it to aCML data as all the other algorithms.

```
model.chowliu = tronco.chowliu(aCML.clean, nboot = 5, boot.seed = 12345)
```

```
## *** Checking input events.
## *** Inferring a progression model with the following settings.
##  Dataset size: n = 64, m = 17.
##  Algorithm: Chow Liu with "bic, aic" regularization  Random seed: 12345.
##  Bootstrap iterations (Wilcoxon): 5.
##      exhaustive bootstrap: TRUE.
##      p-value: 0.05.
##      minimum bootstrapped scores: 3.
## *** Bootstraping selective advantage scores (prima facie).
##  ........
##  Evaluating "temporal priority" (Wilcoxon, p-value 0.05)
##  Evaluating "probability raising" (Wilcoxon, p-value 0.05)
## *** Loop detection found loops to break.
##  Removed 2 edges out of 24 (8%)
## *** Performing likelihood-fit with regularization bic .
## *** Performing likelihood-fit with regularization aic .
## *** Evaluating BIC / AIC / LogLik informations.
## The reconstruction has been successfully completed in 00h:00m:01s
```

```
model.chowliu = annotate.description(model.chowliu, 'MST Chow Liu - aCML')
```

```
## Warning in annotate.description(model.chowliu, "MST Chow Liu - aCML"): Old
## description substituted: CAPRI - Bionformatics aCML data (selected events) .
```

## 0.6 Undirected Minimum Spanning Tree with Mutual Information

This algorithm is meant to extract a progression from data of an individual patient. As the Chow Liu algorithm, this could retrieve a direct acyclic graph according to the level of noise and heterogeneity of the input data. This algorithm formulatesf the problem in terms of undirected minimum spamming trees and exploits results from Prim, which are a generalization of Edomonds’ ones. We test it to aCML data as all the other algorithms.

```
model.prim = tronco.prim(aCML.clean, nboot = 5, boot.seed = 12345)
```

```
## *** Checking input events.
## *** Inferring a progression model with the following settings.
##  Dataset size: n = 64, m = 17.
##  Algorithm: Prim with "no_reg" regularization    Random seed: 12345.
##  Bootstrap iterations (Wilcoxon): 5.
##      exhaustive bootstrap: TRUE.
##      p-value: 0.05.
##      minimum bootstrapped scores: 3.
## *** Bootstraping selective advantage scores (prima facie).
##  ........
##  Evaluating "temporal priority" (Wilcoxon, p-value 0.05)
##  Evaluating "probability raising" (Wilcoxon, p-value 0.05)
## *** Loop detection found loops to break.
##  Removed 2 edges out of 24 (8%)
## *** Performing likelihood-fit with regularization: no_reg .
## *** Evaluating BIC / AIC / LogLik informations.
## The reconstruction has been successfully completed in 00h:00m:02s
```

```
model.prim = annotate.description(model.prim, 'MST Prim - aCML data')
```

```
## Warning in annotate.description(model.prim, "MST Prim - aCML data"): Old
## description substituted: CAPRI - Bionformatics aCML data (selected events) .
```