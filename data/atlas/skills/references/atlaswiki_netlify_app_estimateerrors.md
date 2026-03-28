* [Atlas Documentation](./)
* [ATLAS and the ATLAS-pipeline](/)
* [**1** Getting started](/getting_started)
  + [**1.1** Installation using Conda](/installation-using-conda)
  + [**1.2** Installation from source](/installation-from-source)
  + [**1.3** Running ATLAS](/running-atlas)
  + [**1.4** Quickstart](/quickstart)
* [**2** Workflows](/workflows)
  + [**2.1** Low-depth sequencing](/low-depth-sequencing)
  + [**2.2** Ancient DNA](/ancient-dna)
* [**3** Tutorial](/tutorial)
  + [**3.1** Data from a Single Individual](/data-from-a-single-individual)
  + [**3.2** Data from One Population](/data-from-one-population)
  + [**3.3** Data from many Populations](/data-from-many-populations)
* [**4** Read tasks](/read-tasks)
  + [**4.1** assessSoftClipping](/assesssoftclipping)
  + [**4.2** BAMDiagnostics](/bamdiagnostics)
  + [**4.3** downsample](/downsample)
  + [**4.4** filterBAM](/filterbam)
  + [**4.5** mergeOverlappingReads](/mergeoverlappingreads)
  + [**4.6** mergeRG](/mergerg)
  + [**4.7** PMDS](/pmds)
  + [**4.8** qualityTransformation](/qualitytransformation)
* [**5** Site tasks](/site-tasks)
  + [**5.1** allelicDepth](/allelicdepth)
  + [**5.2** call](/call)
  + [**5.3** createMask](/createmask)
  + [**5.4** estimateErrors](/estimateerrors)
  + [**5.5** GLF](/glf)
  + [**5.6** summaryStats](/summarystats)
  + [**5.7** mutationLoad](/mutationload)
  + [**5.8** pileup](/pileup)
  + [**5.9** pileupToBed](/pileuptobed)
  + [**5.10** PSMC](/psmc)
  + [**5.11** thetaRatio](/thetaratio)
* [**6** Population tasks](/population-tasks)
  + [**6.1** alleleCounts](/allelecounts)
  + [**6.2** alleleFreq](/allelefreq)
  + [**6.3** ancestralAlleles](/ancestralalleles)
  + [**6.4** calculateF2](/calculatef2)
  + [**6.5** geneticDist](/geneticdist)
  + [**6.6** inbreeding](/inbreeding)
  + [**6.7** majorMinor](/majorminor)
  + [**6.8** printGLF](/printglf)
  + [**6.9** saf](/saf)
* [**7** VCF Tasks](/vcf-tasks)
  + [**7.1** convertVCF](/convertvcf)
  + [**7.2** testHardyWeinberg](/stesthardyweinberg)
  + [**7.3** VCFCompare](/vcfcompare)
  + [**7.4** VCFDiagnostics](/vcfdiagnostics)
* [**8** Simulation Tasks](/simulation-tasks)
  + [**8.1** simulate](/simulate)
* [**9** File Formats](/fileformats)
  + [**9.1** Beagle](/beagle)
  + [**9.2** geno](/geno)
  + [**9.3** LFMM](/lfmm)
  + [**9.4** posfile](/posfile)
  + [**9.5** genfile](/genfile)
* [**10** Filter parameters](/filter)
  + [**10.1** Filter parameters for Reads](/filter-parameters-for-reads)
  + [**10.2** Filter parameters for bases](/filter-parameters-for-bases)
  + [**10.3** Filter parameters for Parsing window settings](/filter-parameters-for-parsing-window-settings)
* [**11** Engine parameters](/engine)
* [**12** ATLAS-Pipeline](/atlas-pipeline)
  + [**12.1** Getting started](/getting-started)
  + [**12.2** Gaia](/gaia)
  + [**12.3** Rhea](/rhea)
  + [**12.4** Perses](/perses)
  + [**12.5** Pallas](/pallas)
  + [**12.6** Troubleshooting](/troubleshooting)
* [Published with bookdown](https://github.com/rstudio/bookdown)

# [Welcome to ATLAS, your guide to the world of low-depth and ancient DNA!](./)

## 5.4 estimateErrors

**Estimating PMD pattern and Sequencing Errors**

`estimateErrors` uses genotype likelihood model to estimate the likelihood of sequencing errors and PMD using Expectation Maximization (EM) algorithm. The sequencing errors are recalibrated based on quality score of reads, fragment length, mapping quality, position in the read and context.

See Additional information for detailed description of the model.

### 5.4.1 Input

**Required inputs :**

|  |  |
| --- | --- |
| `--bam Input_bam_file.bam` | Input bam file. |
| `--fasta Input_refrence_genome_file.fasta` | Reference genome. |

**Optional inputs :**

|  |  |
| --- | --- |
| `--recalModel recal_model` | Semicolon separated recalibration model indicating which covariates and which regression model (empiric or polynomial) to use, e.g.`"intercept;quality:polynomial3;position:polynomial3;fragmentLength:polynomial3;mappingQuality:polynomial3;context;"`. Default = all five covariates are used and empiric regression is used for all. |
| `--pmdModel pmd_model` | pmd model to be used, e.g.`"CT5:0.2*exp(-0.3*p)+0.01;GA3:0.5*exp(-0.2*p)+0.01"`. Default = `CT5;GA5;CT3;GA3`. |

**Specific Parameters :**

* See [Filter parameters](/filter#Filter) to apply specific filters for bases, reads and parsing window setting.

Engine parameters that are common to all tasks can be found [here](/engine#Engine).

### 5.4.2 Output

### 5.4.3 Usage Example

```
#! /bin/bash

# Set atlas path
atlas=$(dirname "$0")/../build/atlas

# exponential PMD pattern
pmd="CT5:0.2*exp(-0.3*p)+0.07;GA3:0.2*exp(-0.25*p)+0.06"
# recal pattern, linear quality transformation and position dependency
recal="quality:polynomial[0.9];position:polynomial[0.02]"

# Simulate a BAM File with PMD and recal
$atlas simulate --pmd $pmd --recal $recal --logFile simulate.out

# Estimate errors
$atlas estimateErrors --bam ATLAS_simulations.bam --fasta ATLAS_simulations.fasta --logFile estimateErrors.out
```

**Additional Information**

**Genotype likelihood model for PMD and sequencing error recalibration**

The model implemented in ATLAS estimates three parameters in parallel, namely genotype distribution, PMD and recalibration parameter which is described below.

![](images/dag.png)

The figure above shows the directed acyclic graph (DAG) of the model, where the hidden genotype at site \(i = 1, . . . , I\) are given by \(g\_{i}\), where \(g\_{i} = AA,AC, . . . , TT\) is one of the 10 possible diploid genotypes; the sequencing data of a single individual at site \(i\) consist of \(n\_{i}\) reads that cover this site and the base of read \(j\) covering site \(i\) is denoted by \(d\_{ij} = A,C, G, T, j = 1, . . . , n\_{i}\).

The data \(d\_{ij}\) observed at a site \(i\) with true genotype \(g\_{i}\) is a function of four processes:

* The distribution of genotypes \(g\_{i}\) within the genome, and let \(\theta\_{g}\) denote the parameters governing that distribution.
* The random sampling of alleles of from genotypes. We will denote by \(b\_{ij} = A,C, G, T\) the sampled allele in read \(j\) covering site \(i\). Given a genotype \(g\_{i} = k l\) with \(k, l = A,C, G, T\) at that site we have

\[P(\boldsymbol{b\_{ij}}|g\_{i} = k,l) = \frac{1}{2}[Ind(b\_{ij}=k) + Ind(b\_{ij}=l)] = \begin{cases}
1 & \text{if } b\_{ij}=k=l,\\
\frac{1}{2} & \text{if } k \neq l \text{ and } b\_{ij}=k \text{ or } b\_{ij }=l,\\
0 & \text{otherwise. }
\end{cases}\]

The subset of bases that make up genotype \(g\) are denoted by \(b ∈ g\).

* PMD that potentially modifies \(b\_{ij}\). We will denote the resulting base by \(\bar{b}\_{ij} = A,C, G, T\) and by \(\theta\_{D}\) the parameters governing PMD. In the case of no PMD, \(b=\bar{b}\).
* Sequencing errors may result in \(d\_{ij} \neq \bar{b}\_{ij}\). The parameters governing sequencing errors is denoted by \(\theta\_{\epsilon}\).

Assuming independence among sequencing reads when conditioned on \(g\_{i}\), we then have,

\[\mathcal{L}(\boldsymbol{\theta\_{g},\theta\_{D},\theta\_{\epsilon}}) = P({d}|\theta\_{g},\theta\_{D},\theta\_{\epsilon}) = \prod\_{i=1}^{I}\sum\_{g}P({g}|\theta\_{g})\prod\_{j=1}^{n\_{i}} [\sum\_{b \in g}P(b|g)\sum\_{\bar{b}|b}P(\bar{b}|b,\theta\_{D})P(d\_{ij}|\bar{b},\theta\_{\epsilon})], \]
where \(d = (d\_{1}, . . . , d\_{I})\) denotes the full data with \(d\_{i} = (d\_{i1}, . . . , d\_{ini})\).

This formulation is very general and allows for different models regarding the distribution of genotypes \(P(g|\theta\_{g})\), PMD \(P(\bar{b}|b,\theta\_{D})\) and sequencing errors \(P(d\_{ij}|\bar{b},\theta\_{\epsilon})\).

**Implemented models regarding sequencing errors**

During implementation of the model regarding sequencing errors i.e. the probability function \(P(d\_{ij}|\bar{b},\theta\_{\epsilon})\), ATLAS assumes that,

\[P(d\_{ij}|\bar{b},\theta\_{\epsilon}) =P(d\_{ij}|\bar{b},\rho,\boldsymbol{\beta}) = \begin{cases}
1 -\epsilon(q\_{ij},\boldsymbol{\beta}) & \text{if } d\_{ij}=\bar{b},\\
\epsilon(q\_{ij},\boldsymbol{\beta})\rho\_{\bar{b}d\_{ij}} & \text{if } d\_{ij} \neq \bar{b},
\end{cases}\]

where \(\epsilon(q\_{ij},\boldsymbol{\beta})\) is the relevant sequencing error rate and \(\rho\_{kl}\) reflects the relative rate for a sequencing error at a particular base \(k = A,C, G, T\) to result in any of the three alternative bases \(l \neq k\).

\[0 \leq \rho\_{kl} \leq 1, \sum\_{l\neq k} \rho\_{kl}= 1 \quad\quad k,l =A,C,G,T \]

The error rates \(\epsilon(q\_{ij},\boldsymbol{\beta})\) themselves are functions of a given external vector of information \(q\_{ij}\) with parameters \(\theta\_{\epsilon}\). ATLAS then, assumes the logistic model
\[ \epsilon\_{ij} = \epsilon(q\_{ij},\boldsymbol{\beta}) = \beta\_{0} + \sum\_{l=k}^{K} \psi\_{k}(q\_{ijk},\beta\_{k}) \]

with \(K\) covariates \(q\_{ij} = (q\_{ij1}, \ldots, q\_{ijK})\) of which each has a function \(\psi\_{k}(q\_{ijk},\beta\_{k})\) with parameters \(\beta\_k\). Thus the total parameter vector is
\(\theta\_{\epsilon} = (\rho,\boldsymbol{\beta})\) with \(\rho = (\rho\_{AC},\rho\_{AG}, \ldots, \rho\_{TG})\) and \(\boldsymbol{\beta} = \{\beta\_0, \ldots, \beta\_K\}\).

* The parameters \(\theta\_{\epsilon} = (\rho,\boldsymbol{\beta})\) is estimated using the general EM algorithm introduced above.

**ATLAS considers the following potential covariates:**

* The transformed machine-reported quality score \(\tilde{Q}\_{ij}\) . We transform the original quality score \({Q}\_{ij}\) as

\[\tilde{Q}\_{ij} =log(\frac{e\_{ij}}{1-e\_{ij}}); e\_{ij}=10^{-Q\_{ij}/10} \]
to ensure that using \(\eta\_{ik}(\beta) = \tilde{Q}\_{ij}\) results in no transformation.

* The position within the read \(p\_{ij}\), each with parameters \(\beta\_{p}\).
* The sequencing context \(c\_{ij}\) , i.e. the base that was reported just previously of the current base \(d\_{ij}\) in 5’–>3’ direction (i.e. \(c\_{ij} = d\_{ij-1}\) for forward mapping reads and(i.e. \(c\_{ij} = d\_{ij+1}\) for reverse
  mapping reads).

Importantly, we will also infer an independent error model (i.e. independent \(\boldsymbol{\beta}\)) for each read group.

**Implemented models regarding PMD**

A characteristic feature of ancient DNA is post-mortem damage (PMD). The most common form of PMD is C-deamination, which leads to a C → T transition on the affected strand and a G → A transition on the complimentary strand. These deaminations do not occur randomly along the whole read, but instead are observed much more frequently at the beginning of a read. This is due to fragment ends being more often single-stranded and thus subject to a much higher rate of deamination.

During implementation of the model regarding PMD i.e. the probability function \(P(\bar{b}|b,d\_{ij})\), In case of C → T
damage,

\[P(\bar{b}|b,d\_{ij}) = \begin{cases}
1 & \text{if } \bar{b} = b \text{ and } b \neq C\\
0 & \text{if } \bar{b} \neq b \text{ and } b \neq C\\
D\_{ij} & \text{if } \bar{b} = T \text{ and } b = C\\
1 - D\_{ij} & \text{if } \bar{b} = C \text{ and } b = C ,
\end{cases}\]

where \(D\_{ij}\) denotes the probability that the base \(j\) at site \(i\) was affected by PMD. Analogously, in case of G → A damage,

\[P(\bar{b}|b,d\_{ij}) = \begin{cases}
1 & \text{if } \bar{b} = b \text{ and } b \neq G\\
0 & \text{if } \bar{b} \neq b \text{ and } b \neq G\\
D\_{ij} & \text{if } \bar{b} = A \text{ and } b = G\\
1 - D\_{ij} & \text{if } \bar{b} = G \text{ and } b = G ,
\end{cases}\]

ATLAS assumes that the rate $D\_{ij} = D(q\_{ij} , \_{D}) as well as the type of PMD damage to occur to be a function of a given external vector of information \(q\_{ij}\). Specifically, it models \(D\_{ij}\) as a function of
the distance \(\delta\_{ij}\) in bases from the nearest end \(e\_{ij} ∈ {5′, 3′}\) of the fragment (in case of paired-end sequencing) or read (in case of single end sequencing).

Let \(\psi = (\psi\_{1}, . . . , \psi\_{M})\) be the vector of PMD
probabilities for distances \(m = 1, . . . ,M\) up to a maximum distance \(M\). We then have,

\[D\_{ij} = f(\delta\_{ij}) = \begin{cases}
\psi\_{M} & \text{if } \delta\_{ij} \geq M\\
\psi\_{\delta\_{ij}} & \text{otherwise },
\end{cases}\]

**ATLAS considers the following additional categorical information:**

* It fits independent patterns for each read group.
* It uses different PMD patterns depending on whether a single-strand or double strand sequencing library was prepared:

  + For single-strand libraries, ATLAS assumes that for forward mapping reads C → T damage occurs on both ends while for reverse mapping reads G → A damage occurs at both ends. It further assumes that damages occur at the same rates (i.e. at the same \(\psi\)) for both types of reads at both ends.
  + For double-strand libraries, ATLAS assumes that for forward mapping reads C → T damage occurs at 5’ ends and G → A damage at 3’ ends, and the inverse for reverse mapping reads. It further assumes that damages occur at the same rates at 5’ ends of both forward and reverse mapping reads, and, equivalently, at the same rates at 3’ ends of both types of reads.
* ATLAS distinguishes between single-end and paired-end sequencing:

  + For single-end sequencing, the 5’ end of the read always marks the 5’ end of the fragment, and the distance \(δ\_{ij}\) measured from it thus reflects the distance relevant for PMD. ATLAS will thus infer a common pattern for all single-end read lengths at the 5’ end. The sequencing read may not reach the 3’ end of the fragment, however. Among the reads with lengths matching the maximum number of sequencing cycles \(C\_{max}\), for which \(δ\_{ij}\) measured from the 3’ end underestimates the true distance to the 3’ end of the fragment. This leads to a reduced PMD rate compared to the 5’ end at
    the same distance \(δ\_{ij}\) . Due to errors during adapter removal, this issue may also affect reads a few bases shorter than \(C\_{max}\). ATLAS will thus infer a common pattern for all reads shorter than \(C\_{max} − S\) and a different pattern for all reads of each of the lengths $ C\_{max},C\_{max} − 1, . . . ,C\_{max} − S$, where \(S\) is a user-defined threshold (typically 5 bases).
  + For paired-end sequencing, both ends are known and the distances \(δ\_{ij}\) properly reflect the distance to those ends. ATLAS thus uses a single PMD pattern for all fragment lengths.