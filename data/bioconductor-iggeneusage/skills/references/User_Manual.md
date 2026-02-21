# User Manual: IgGeneUsage

SK

#### Sep 12, 2023

# Contents

* [1 Introduction](#introduction)
* [2 Input](#input)
* [3 Model](#model)
* [4 Case Study A: analyzing IRRs](#case-study-a-analyzing-irrs)
  + [4.1 DGU analysis](#dgu-analysis)
  + [4.2 Output format](#output-format)
  + [4.3 Model checking](#model-checking)
    - [4.3.1 MCMC sampling](#mcmc-sampling)
  + [4.4 PPC: posterior predictive checks](#ppc-posterior-predictive-checks)
    - [4.4.1 PPCs: repertoire-specific](#ppcs-repertoire-specific)
    - [4.4.2 PPCs: overall](#ppcs-overall)
  + [4.5 Results](#results)
    - [4.5.1 DGU: differential gene usage](#dgu-differential-gene-usage)
    - [4.5.2 Promising hits](#promising-hits)
    - [4.5.3 Promising hits [count]](#promising-hits-count)
  + [4.6 GU: gene usage summary](#gu-gene-usage-summary)
* [5 Leave-one-out (LOO) analysis](#leave-one-out-loo-analysis)
  + [5.1 LOO-DGU: variability of effect size \(\gamma\)](#loo-dgu-variability-of-effect-size-gamma)
  + [5.2 LOO-DGU: variability of \(\pi\)](#loo-dgu-variability-of-pi)
  + [5.3 LOO-GU: variability of the gene usage](#loo-gu-variability-of-the-gene-usage)
* [6 Case Study B: analyzing IRRs containing biological replicates](#case-study-b-analyzing-irrs-containing-biological-replicates)
  + [6.1 Modeling](#modeling)
  + [6.2 Posterior predictive checks](#posterior-predictive-checks)
  + [6.3 Analysis of estimated effect sizes](#analysis-of-estimated-effect-sizes)
* [7 Session](#session)

```
require(IgGeneUsage)
require(rstan)
require(knitr)
require(ggplot2)
require(ggforce)
require(ggrepel)
require(reshape2)
require(patchwork)
```

# 1 Introduction

Decoding the properties of immune receptor repertoires (IRRs) is key to
understanding how our adaptive immune system responds to challenges, such
as viral infection or cancer. One important quantitative property of IRRs
is their immunoglobulin (Ig) gene usage, i.e. how often are the differnt
Igs that make up the immune receptors used in a given IRR. Furthermore, we
may ask: is there differential gene usage (DGU) between IRRs from different
biological conditions (e.g. healthy vs tumor).

Both of these questions can be answered quantitatively by are answered by
*[IgGeneUsage](https://bioconductor.org/packages/3.22/IgGeneUsage)*.

# 2 Input

The main input of *[IgGeneUsage](https://bioconductor.org/packages/3.22/IgGeneUsage)* is a data.frame that has the
following columns:

1. **individual\_id**: name of the repertoire (e.g. Patient-1)
2. **condition**: name of the condition to which each repertoire
   belongs (healthy, tumor\_A, tumor\_B, …)
3. **gene\_name**: gene name (e.g. IGHV1-10 or family TRVB1)
4. **gene\_usage\_count**: numeric (count) of usage related in individual x
   gene x condition specified in columns 1-3
5. [optional] **repertoire**: character/numeric identifier that tags the
   different biological replicates if they are available for a specific
   individual

# 3 Model

*[IgGeneUsage](https://bioconductor.org/packages/3.22/IgGeneUsage)* transforms the input data as follows.

First, given \(R\) repertoires with \(G\) genes each, *[IgGeneUsage](https://bioconductor.org/packages/3.22/IgGeneUsage)*
generates a gene usage matrix \(Y^{R \times G}\). Row sums in \(Y\) define the
total usage (\(N\)) in each repertoire.

Second, for the analysis of DGU between biological conditions, we use a
Bayesian model (\(M\)) for zero-inflated beta-binomial regression. Empirically,
we know that Ig gene usage data can be noisy also not exhaustive, i.e. some
Ig genes that are systematically rearranged at low probability might not be
sampled, and certain Ig genes are not encoded (or dysfunctional) in some
individuals. \(M\) can fit over-dispersed and zero-inflated Ig gene usage data.

In the output of *[IgGeneUsage](https://bioconductor.org/packages/3.22/IgGeneUsage)*, we report the mean effect
size (es or \(\gamma\)) and its 95% highest density interval (HDI). Genes with
\(\gamma \neq 0\) (e.g. if 95% HDI of \(\gamma\) excludes 0) are most likely
to experience differential usage. Additionally, we report the probability of
differential gene usage (\(\pi\)):
\[\begin{align}
\pi = 2 \cdot \max\left(\int\_{\gamma = -\infty}^{0} p(\gamma)\mathrm{d}\gamma,
\int\_{\gamma = 0}^{\infty} p(\gamma)\mathrm{d}\gamma\right) - 1
\end{align}\]
with \(\pi = 1\) for genes with strong differential usage, and \(\pi = 0\) for
genes with negligible differential gene usage. Both metrics are computed based
on the posterior distribution of \(\gamma\), and are thus related.

# 4 Case Study A: analyzing IRRs

*[IgGeneUsage](https://bioconductor.org/packages/3.22/IgGeneUsage)* has a couple of built-in Ig gene usage datasets.
Some were obtained from studies and others were simulated.

Lets look into the simulated dataset `d_zibb_3`. This dataset was generated
by a zero-inflated beta-binomial (ZIBB) model, and *[IgGeneUsage](https://bioconductor.org/packages/3.22/IgGeneUsage)*
was designed to fit ZIBB-distributed data.

```
data("d_zibb_3", package = "IgGeneUsage")
knitr::kable(head(d_zibb_3))
```

| individual\_id | gene\_name | gene\_usage\_count | condition |
| --- | --- | --- | --- |
| I\_1 | G\_1 | 29 | C\_1 |
| I\_1 | G\_2 | 135 | C\_1 |
| I\_1 | G\_3 | 6 | C\_1 |
| I\_1 | G\_4 | 52 | C\_1 |
| I\_1 | G\_5 | 68 | C\_1 |
| I\_1 | G\_6 | 41 | C\_1 |

We can also visualize `d_zibb_3` with *[ggplot](https://CRAN.R-project.org/package%3Dggplot)*:

```
ggplot(data = d_zibb_3)+
  geom_point(aes(x = gene_name, y = gene_usage_count, col = condition),
             position = position_dodge(width = .7), shape = 21)+
  theme_bw(base_size = 11)+
  ylab(label = "Gene usage [count]")+
  xlab(label = '')+
  theme(legend.position = "top")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.4))
```

![](data:image/png;base64...)

## 4.1 DGU analysis

As main input *[IgGeneUsage](https://bioconductor.org/packages/3.22/IgGeneUsage)* uses a data.frame formatted as e.g.
`d_zibb_3`. Other input parameters allow you to configure specific settings
of the *[rstan](https://CRAN.R-project.org/package%3Drstan)* sampler.

In this example, we analyze `d_zibb_3` with 3 MCMC chains, 1500 iterations
each including 500 warm-ups using a single CPU core (Hint: for parallel
chain execution set parameter `mcmc_cores` = 3). We report for each model
parameter its mean and 95% highest density interval (HDIs).

**Important remark:** you should run DGU analyses using default
*[IgGeneUsage](https://bioconductor.org/packages/3.22/IgGeneUsage)* parameters. If warnings or errors are reported
with regard to the MCMC sampling, please consult the Stan manual111 <https://mc-stan.org/misc/warnings.html> and
adjust the inputs accordingly. If the warnings persist, please submit an
issue with a reproducible script at the Bioconductor support site or on
Github222 <https://github.com/snaketron/IgGeneUsage/issues>.

```
M <- DGU(ud = d_zibb_3, # input data
         mcmc_warmup = 300, # how many MCMC warm-ups per chain (default: 500)
         mcmc_steps = 1500, # how many MCMC steps per chain (default: 1,500)
         mcmc_chains = 3, # how many MCMC chain to run (default: 4)
         mcmc_cores = 1, # how many PC cores to use? (e.g. parallel chains)
         hdi_lvl = 0.95, # highest density interval level (de fault: 0.95)
         adapt_delta = 0.8, # MCMC target acceptance rate (default: 0.95)
         max_treedepth = 10) # tree depth evaluated at each step (default: 12)
```

```
FALSE
FALSE SAMPLING FOR MODEL 'dgu' NOW (CHAIN 1).
FALSE Chain 1:
FALSE Chain 1: Gradient evaluation took 0.000175 seconds
FALSE Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 1.75 seconds.
FALSE Chain 1: Adjust your expectations accordingly!
FALSE Chain 1:
FALSE Chain 1:
FALSE Chain 1: Iteration:    1 / 1500 [  0%]  (Warmup)
FALSE Chain 1: Iteration:   50 / 1500 [  3%]  (Warmup)
FALSE Chain 1: Iteration:  100 / 1500 [  6%]  (Warmup)
FALSE Chain 1: Iteration:  150 / 1500 [ 10%]  (Warmup)
FALSE Chain 1: Iteration:  200 / 1500 [ 13%]  (Warmup)
FALSE Chain 1: Iteration:  250 / 1500 [ 16%]  (Warmup)
FALSE Chain 1: Iteration:  300 / 1500 [ 20%]  (Warmup)
FALSE Chain 1: Iteration:  301 / 1500 [ 20%]  (Sampling)
FALSE Chain 1: Iteration:  350 / 1500 [ 23%]  (Sampling)
FALSE Chain 1: Iteration:  400 / 1500 [ 26%]  (Sampling)
FALSE Chain 1: Iteration:  450 / 1500 [ 30%]  (Sampling)
FALSE Chain 1: Iteration:  500 / 1500 [ 33%]  (Sampling)
FALSE Chain 1: Iteration:  550 / 1500 [ 36%]  (Sampling)
FALSE Chain 1: Iteration:  600 / 1500 [ 40%]  (Sampling)
FALSE Chain 1: Iteration:  650 / 1500 [ 43%]  (Sampling)
FALSE Chain 1: Iteration:  700 / 1500 [ 46%]  (Sampling)
FALSE Chain 1: Iteration:  750 / 1500 [ 50%]  (Sampling)
FALSE Chain 1: Iteration:  800 / 1500 [ 53%]  (Sampling)
FALSE Chain 1: Iteration:  850 / 1500 [ 56%]  (Sampling)
FALSE Chain 1: Iteration:  900 / 1500 [ 60%]  (Sampling)
FALSE Chain 1: Iteration:  950 / 1500 [ 63%]  (Sampling)
FALSE Chain 1: Iteration: 1000 / 1500 [ 66%]  (Sampling)
FALSE Chain 1: Iteration: 1050 / 1500 [ 70%]  (Sampling)
FALSE Chain 1: Iteration: 1100 / 1500 [ 73%]  (Sampling)
FALSE Chain 1: Iteration: 1150 / 1500 [ 76%]  (Sampling)
FALSE Chain 1: Iteration: 1200 / 1500 [ 80%]  (Sampling)
FALSE Chain 1: Iteration: 1250 / 1500 [ 83%]  (Sampling)
FALSE Chain 1: Iteration: 1300 / 1500 [ 86%]  (Sampling)
FALSE Chain 1: Iteration: 1350 / 1500 [ 90%]  (Sampling)
FALSE Chain 1: Iteration: 1400 / 1500 [ 93%]  (Sampling)
FALSE Chain 1: Iteration: 1450 / 1500 [ 96%]  (Sampling)
FALSE Chain 1: Iteration: 1500 / 1500 [100%]  (Sampling)
FALSE Chain 1:
FALSE Chain 1:  Elapsed Time: 1.746 seconds (Warm-up)
FALSE Chain 1:                4.449 seconds (Sampling)
FALSE Chain 1:                6.195 seconds (Total)
FALSE Chain 1:
FALSE
FALSE SAMPLING FOR MODEL 'dgu' NOW (CHAIN 2).
FALSE Chain 2:
FALSE Chain 2: Gradient evaluation took 0.000116 seconds
FALSE Chain 2: 1000 transitions using 10 leapfrog steps per transition would take 1.16 seconds.
FALSE Chain 2: Adjust your expectations accordingly!
FALSE Chain 2:
FALSE Chain 2:
FALSE Chain 2: Iteration:    1 / 1500 [  0%]  (Warmup)
FALSE Chain 2: Iteration:   50 / 1500 [  3%]  (Warmup)
FALSE Chain 2: Iteration:  100 / 1500 [  6%]  (Warmup)
FALSE Chain 2: Iteration:  150 / 1500 [ 10%]  (Warmup)
FALSE Chain 2: Iteration:  200 / 1500 [ 13%]  (Warmup)
FALSE Chain 2: Iteration:  250 / 1500 [ 16%]  (Warmup)
FALSE Chain 2: Iteration:  300 / 1500 [ 20%]  (Warmup)
FALSE Chain 2: Iteration:  301 / 1500 [ 20%]  (Sampling)
FALSE Chain 2: Iteration:  350 / 1500 [ 23%]  (Sampling)
FALSE Chain 2: Iteration:  400 / 1500 [ 26%]  (Sampling)
FALSE Chain 2: Iteration:  450 / 1500 [ 30%]  (Sampling)
FALSE Chain 2: Iteration:  500 / 1500 [ 33%]  (Sampling)
FALSE Chain 2: Iteration:  550 / 1500 [ 36%]  (Sampling)
FALSE Chain 2: Iteration:  600 / 1500 [ 40%]  (Sampling)
FALSE Chain 2: Iteration:  650 / 1500 [ 43%]  (Sampling)
FALSE Chain 2: Iteration:  700 / 1500 [ 46%]  (Sampling)
FALSE Chain 2: Iteration:  750 / 1500 [ 50%]  (Sampling)
FALSE Chain 2: Iteration:  800 / 1500 [ 53%]  (Sampling)
FALSE Chain 2: Iteration:  850 / 1500 [ 56%]  (Sampling)
FALSE Chain 2: Iteration:  900 / 1500 [ 60%]  (Sampling)
FALSE Chain 2: Iteration:  950 / 1500 [ 63%]  (Sampling)
FALSE Chain 2: Iteration: 1000 / 1500 [ 66%]  (Sampling)
FALSE Chain 2: Iteration: 1050 / 1500 [ 70%]  (Sampling)
FALSE Chain 2: Iteration: 1100 / 1500 [ 73%]  (Sampling)
FALSE Chain 2: Iteration: 1150 / 1500 [ 76%]  (Sampling)
FALSE Chain 2: Iteration: 1200 / 1500 [ 80%]  (Sampling)
FALSE Chain 2: Iteration: 1250 / 1500 [ 83%]  (Sampling)
FALSE Chain 2: Iteration: 1300 / 1500 [ 86%]  (Sampling)
FALSE Chain 2: Iteration: 1350 / 1500 [ 90%]  (Sampling)
FALSE Chain 2: Iteration: 1400 / 1500 [ 93%]  (Sampling)
FALSE Chain 2: Iteration: 1450 / 1500 [ 96%]  (Sampling)
FALSE Chain 2: Iteration: 1500 / 1500 [100%]  (Sampling)
FALSE Chain 2:
FALSE Chain 2:  Elapsed Time: 1.67 seconds (Warm-up)
FALSE Chain 2:                4.316 seconds (Sampling)
FALSE Chain 2:                5.986 seconds (Total)
FALSE Chain 2:
FALSE
FALSE SAMPLING FOR MODEL 'dgu' NOW (CHAIN 3).
FALSE Chain 3:
FALSE Chain 3: Gradient evaluation took 0.000128 seconds
FALSE Chain 3: 1000 transitions using 10 leapfrog steps per transition would take 1.28 seconds.
FALSE Chain 3: Adjust your expectations accordingly!
FALSE Chain 3:
FALSE Chain 3:
FALSE Chain 3: Iteration:    1 / 1500 [  0%]  (Warmup)
FALSE Chain 3: Iteration:   50 / 1500 [  3%]  (Warmup)
FALSE Chain 3: Iteration:  100 / 1500 [  6%]  (Warmup)
FALSE Chain 3: Iteration:  150 / 1500 [ 10%]  (Warmup)
FALSE Chain 3: Iteration:  200 / 1500 [ 13%]  (Warmup)
FALSE Chain 3: Iteration:  250 / 1500 [ 16%]  (Warmup)
FALSE Chain 3: Iteration:  300 / 1500 [ 20%]  (Warmup)
FALSE Chain 3: Iteration:  301 / 1500 [ 20%]  (Sampling)
FALSE Chain 3: Iteration:  350 / 1500 [ 23%]  (Sampling)
FALSE Chain 3: Iteration:  400 / 1500 [ 26%]  (Sampling)
FALSE Chain 3: Iteration:  450 / 1500 [ 30%]  (Sampling)
FALSE Chain 3: Iteration:  500 / 1500 [ 33%]  (Sampling)
FALSE Chain 3: Iteration:  550 / 1500 [ 36%]  (Sampling)
FALSE Chain 3: Iteration:  600 / 1500 [ 40%]  (Sampling)
FALSE Chain 3: Iteration:  650 / 1500 [ 43%]  (Sampling)
FALSE Chain 3: Iteration:  700 / 1500 [ 46%]  (Sampling)
FALSE Chain 3: Iteration:  750 / 1500 [ 50%]  (Sampling)
FALSE Chain 3: Iteration:  800 / 1500 [ 53%]  (Sampling)
FALSE Chain 3: Iteration:  850 / 1500 [ 56%]  (Sampling)
FALSE Chain 3: Iteration:  900 / 1500 [ 60%]  (Sampling)
FALSE Chain 3: Iteration:  950 / 1500 [ 63%]  (Sampling)
FALSE Chain 3: Iteration: 1000 / 1500 [ 66%]  (Sampling)
FALSE Chain 3: Iteration: 1050 / 1500 [ 70%]  (Sampling)
FALSE Chain 3: Iteration: 1100 / 1500 [ 73%]  (Sampling)
FALSE Chain 3: Iteration: 1150 / 1500 [ 76%]  (Sampling)
FALSE Chain 3: Iteration: 1200 / 1500 [ 80%]  (Sampling)
FALSE Chain 3: Iteration: 1250 / 1500 [ 83%]  (Sampling)
FALSE Chain 3: Iteration: 1300 / 1500 [ 86%]  (Sampling)
FALSE Chain 3: Iteration: 1350 / 1500 [ 90%]  (Sampling)
FALSE Chain 3: Iteration: 1400 / 1500 [ 93%]  (Sampling)
FALSE Chain 3: Iteration: 1450 / 1500 [ 96%]  (Sampling)
FALSE Chain 3: Iteration: 1500 / 1500 [100%]  (Sampling)
FALSE Chain 3:
FALSE Chain 3:  Elapsed Time: 1.763 seconds (Warm-up)
FALSE Chain 3:                4.344 seconds (Sampling)
FALSE Chain 3:                6.107 seconds (Total)
FALSE Chain 3:
```

## 4.2 Output format

In the output of DGU, we provide the following objects:

* `dgu` and `dgu_prob` (main results of *[IgGeneUsage](https://bioconductor.org/packages/3.22/IgGeneUsage)*):
  quantitative DGU summary on a log- and probability-scale, respectively.
* `gu`: condition-specific relative gene usage (GU) of each gene
* `theta`: probabilities of gene usage in each sample
* `ppc`: posterior predictive checks data (see section ‘Model checking’)
* `ud`: processed Ig gene usage data
* `fit`: rstan (‘stanfit’) object of the fitted model \(\rightarrow\) used
  for model checks (see section ‘Model checking’)

```
summary(M)
```

```
FALSE          Length Class      Mode
FALSE dgu       9     data.frame list
FALSE dgu_prob  9     data.frame list
FALSE gu        8     data.frame list
FALSE theta    12     data.frame list
FALSE ppc       2     -none-     list
FALSE ud       24     -none-     list
FALSE fit       1     stanfit    S4
```

## 4.3 Model checking

* **Check your model fit**. For this, you can use the object glm.

  + Minimal checklist of successful MCMC sampling333 <https://mc-stan.org/misc/warnings.html>:
    - no divergences
    - no excessive warnings from rstan
    - Rhat < 1.05
    - high Neff
  + Minimal checklist for valid model:
    - posterior predictive checks (PPCs): is model consistent with reality,
      i.e. is there overlap between simulated and observed data?
    - leave-one-out analysis

### 4.3.1 MCMC sampling

* divergences, tree-depth, energy
* none found

```
rstan::check_hmc_diagnostics(M$fit)
```

```
FALSE
FALSE Divergences:
```

```
FALSE
FALSE Tree depth:
```

```
FALSE
FALSE Energy:
```

* rhat < 1.05 and n\_eff > 0

```
rstan::stan_rhat(object = M$fit)|rstan::stan_ess(object = M$fit)
```

![](data:image/png;base64...)

## 4.4 PPC: posterior predictive checks

### 4.4.1 PPCs: repertoire-specific

The model used by *[IgGeneUsage](https://bioconductor.org/packages/3.22/IgGeneUsage)* is generative, i.e. with the
model we can generate usage of each Ig gene in a given repertoire (y-axis).
Error bars show 95% HDI of mean posterior prediction. The predictions can be
compared with the observed data (x-axis). For points near the diagonal
\(\rightarrow\) accurate prediction.

```
ggplot(data = M$ppc$ppc_rep)+
  facet_wrap(facets = ~individual_id, ncol = 5)+
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", col = "darkgray")+
  geom_errorbar(aes(x = observed_count, y = ppc_mean_count,
                    ymin = ppc_L_count, ymax = ppc_H_count), col = "darkgray")+
  geom_point(aes(x = observed_count, y = ppc_mean_count), size = 1)+
  theme_bw(base_size = 11)+
  theme(legend.position = "top")+
  xlab(label = "Observed usage [counts]")+
  ylab(label = "PPC usage [counts]")
```

![](data:image/png;base64...)

### 4.4.2 PPCs: overall

Prediction of generalized gene usage within a biological condition is also
possible. We show the predictions (y-axis) of the model, and compare them
against the observed mean usage (x-axis). If the points are near the diagonal
\(\rightarrow\) accurate prediction. Errors are 95% HDIs of the mean.

```
ggplot(data = M$ppc$ppc_condition)+
  geom_errorbar(aes(x = gene_name, ymin = ppc_L_prop*100,
                    ymax = ppc_H_prop*100, col = condition),
                position = position_dodge(width = 0.65), width = 0.1)+
  geom_point(aes(x = gene_name, y = ppc_mean_prop*100,col = condition),
                position = position_dodge(width = 0.65))+
  theme_bw(base_size = 11)+
  theme(legend.position = "top")+
  xlab(label = "Observed usage [%]")+
  ylab(label = "PPC usage [%]")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.4))
```

![](data:image/png;base64...)

## 4.5 Results

Each row of `glm` summarizes the degree of DGU observed for specific
Igs. Two metrics are reported:

* `es` (also referred to as \(\gamma\)): effect size on DGU, where `contrast`
  gives the direction of the effect (e.g. tumor - healthy or healthy - tumor)
* `pmax` (also referred to as \(\pi\)): probability of DGU (parameter \(\pi\)
  from model \(M\))

For `es` we also have the mean, median standard error (se), standard
deviation (sd), L (low bound of 95% HDI), H (high bound of 95% HDI)

```
kable(x = head(M$dgu), row.names = FALSE, digits = 2)
```

| es\_mean | es\_mean\_se | es\_sd | es\_median | es\_L | es\_H | contrast | gene\_name | pmax |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 0.18 | 0.01 | 0.30 | 0.10 | -0.25 | 0.94 | C\_1-vs-C\_2 | G\_1 | 0.46 |
| -0.01 | 0.00 | 0.20 | 0.00 | -0.45 | 0.40 | C\_1-vs-C\_2 | G\_4 | 0.02 |
| -0.08 | 0.00 | 0.23 | -0.05 | -0.62 | 0.35 | C\_1-vs-C\_2 | G\_3 | 0.27 |
| -0.06 | 0.00 | 0.17 | -0.04 | -0.43 | 0.25 | C\_1-vs-C\_2 | G\_2 | 0.26 |
| 0.06 | 0.00 | 0.17 | 0.04 | -0.27 | 0.44 | C\_1-vs-C\_2 | G\_5 | 0.24 |
| -0.03 | 0.00 | 0.19 | -0.02 | -0.45 | 0.36 | C\_1-vs-C\_2 | G\_8 | 0.11 |

### 4.5.1 DGU: differential gene usage

We know that the values of `\gamma` and `\pi` are related to each other.
Lets visualize them for all genes (shown as a point). Names are shown for
genes associated with \(\pi \geq 0.95\). Dashed horizontal line represents
null-effect (\(\gamma = 0\)).

Notice that the gene with \(\pi \approx 1\) also has an effect size whose
95% HDI (error bar) does not overlap the null-effect. The genes with high
degree of differential usage are easy to detect with this figure.

```
# format data
stats <- M$dgu
stats <- stats[order(abs(stats$es_mean), decreasing = FALSE), ]
stats$gene_fac <- factor(x = stats$gene_name, levels = unique(stats$gene_name))

ggplot(data = stats)+
  geom_hline(yintercept = 0, linetype = "dashed", col = "gray")+
  geom_errorbar(aes(x = pmax, y = es_mean, ymin = es_L, ymax = es_H),
                col = "darkgray")+
  geom_point(aes(x = pmax, y = es_mean, col = contrast))+
  geom_text_repel(data = stats[stats$pmax >= 0.95, ],
                  aes(x = pmax, y = es_mean, label = gene_fac),
                  min.segment.length = 0, size = 2.75)+
  theme_bw(base_size = 11)+
  theme(legend.position = "top")+
  xlab(label = expression(pi))+
  xlim(c(0, 1))+
  ylab(expression(gamma))
```

![](data:image/png;base64...)

### 4.5.2 Promising hits

Lets visualize the observed data of the genes with high probability of
differential gene usage (\(\pi \geq 0.95\)). Here we show the gene usage in %.

```
promising_genes <- stats$gene_name[stats$pmax >= 0.95]

ppc_gene <- M$ppc$ppc_condition
ppc_gene <- ppc_gene[ppc_gene$gene_name %in% promising_genes, ]

ppc_rep <- M$ppc$ppc_rep
ppc_rep <- ppc_rep[ppc_rep$gene_name %in% promising_genes, ]

ggplot()+
  geom_point(data = ppc_rep,
             aes(x = gene_name, y = observed_prop*100, col = condition),
             size = 1, fill = "black",
             position = position_jitterdodge(jitter.width = 0.1,
                                             jitter.height = 0,
                                             dodge.width = 0.35))+
  geom_errorbar(data = ppc_gene,
                aes(x = gene_name, ymin = ppc_L_prop*100,
                    ymax = ppc_H_prop*100, group = condition),
                position = position_dodge(width = 0.35), width = 0.15)+
  theme_bw(base_size = 11)+
  theme(legend.position = "top")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.4))+
  ylab(label = "PPC usage [%]")+
  xlab(label = '')
```

![](data:image/png;base64...)

### 4.5.3 Promising hits [count]

Lets also visualize the predicted gene usage counts in each repertoire.

```
ggplot()+
  geom_point(data = ppc_rep,
             aes(x = gene_name, y = observed_count, col = condition),
             size = 1, fill = "black",
             position = position_jitterdodge(jitter.width = 0.1,
                                             jitter.height = 0,
                                             dodge.width = 0.5))+
  theme_bw(base_size = 11)+
  theme(legend.position = "top")+
  ylab(label = "PPC usage [count]")+
  xlab(label = '')+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.4))
```

![](data:image/png;base64...)

## 4.6 GU: gene usage summary

*[IgGeneUsage](https://bioconductor.org/packages/3.22/IgGeneUsage)* also reports the inferred gene usage (GU)
probability of individual genes in each condition. For a given gene we
report its mean GU (`prob_mean`) and the 95% (for instance) HDI (`prob_L`
and `prob_H`).

```
ggplot(data = M$gu)+
  geom_errorbar(aes(x = gene_name, y = prob_mean, ymin = prob_L,
                    ymax = prob_H, col = condition),
                width = 0.1, position = position_dodge(width = 0.4))+
  geom_point(aes(x = gene_name, y = prob_mean, col = condition), size = 1,
             position = position_dodge(width = 0.4))+
  theme_bw(base_size = 11)+
  theme(legend.position = "top")+
  ylab(label = "GU [probability]")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.4))
```

![](data:image/png;base64...)

# 5 Leave-one-out (LOO) analysis

To assert the robustness of the probability of DGU (\(\pi\)) and the effect
size (\(\gamma\)), *[IgGeneUsage](https://bioconductor.org/packages/3.22/IgGeneUsage)* has a built-in procedure for
fully Bayesian leave-one-out (LOO) analysis.

During each step of LOO, we discard the data of one of the R repertoires,
and use the remaining data to analyze for DGU. In each step we record
\(\pi\) and \(\gamma\) for all genes, including the mean and 95% HDI of
\(\gamma\). We assert quantitatively the robustness of \(\pi\) and \(\gamma\)
by evaluating their variability for a specific gene.

This analysis can be computationally demanding.

```
L <- LOO(ud = d_zibb_3, # input data
         mcmc_warmup = 500, # how many MCMC warm-ups per chain (default: 500)
         mcmc_steps = 1000, # how many MCMC steps per chain (default: 1,500)
         mcmc_chains = 1, # how many MCMC chain to run (default: 4)
         mcmc_cores = 1, # how many PC cores to use? (e.g. parallel chains)
         hdi_lvl = 0.95, # highest density interval level (de fault: 0.95)
         adapt_delta = 0.8, # MCMC target acceptance rate (default: 0.95)
         max_treedepth = 10) # tree depth evaluated at each step (default: 12)
```

```
FALSE
FALSE SAMPLING FOR MODEL 'dgu' NOW (CHAIN 1).
FALSE Chain 1:
FALSE Chain 1: Gradient evaluation took 0.000144 seconds
FALSE Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 1.44 seconds.
FALSE Chain 1: Adjust your expectations accordingly!
FALSE Chain 1:
FALSE Chain 1:
FALSE Chain 1: Iteration:   1 / 1000 [  0%]  (Warmup)
FALSE Chain 1: Iteration:  50 / 1000 [  5%]  (Warmup)
FALSE Chain 1: Iteration: 100 / 1000 [ 10%]  (Warmup)
FALSE Chain 1: Iteration: 150 / 1000 [ 15%]  (Warmup)
FALSE Chain 1: Iteration: 200 / 1000 [ 20%]  (Warmup)
FALSE Chain 1: Iteration: 250 / 1000 [ 25%]  (Warmup)
FALSE Chain 1: Iteration: 300 / 1000 [ 30%]  (Warmup)
FALSE Chain 1: Iteration: 350 / 1000 [ 35%]  (Warmup)
FALSE Chain 1: Iteration: 400 / 1000 [ 40%]  (Warmup)
FALSE Chain 1: Iteration: 450 / 1000 [ 45%]  (Warmup)
FALSE Chain 1: Iteration: 500 / 1000 [ 50%]  (Warmup)
FALSE Chain 1: Iteration: 501 / 1000 [ 50%]  (Sampling)
FALSE Chain 1: Iteration: 550 / 1000 [ 55%]  (Sampling)
FALSE Chain 1: Iteration: 600 / 1000 [ 60%]  (Sampling)
FALSE Chain 1: Iteration: 650 / 1000 [ 65%]  (Sampling)
FALSE Chain 1: Iteration: 700 / 1000 [ 70%]  (Sampling)
FALSE Chain 1: Iteration: 750 / 1000 [ 75%]  (Sampling)
FALSE Chain 1: Iteration: 800 / 1000 [ 80%]  (Sampling)
FALSE Chain 1: Iteration: 850 / 1000 [ 85%]  (Sampling)
FALSE Chain 1: Iteration: 900 / 1000 [ 90%]  (Sampling)
FALSE Chain 1: Iteration: 950 / 1000 [ 95%]  (Sampling)
FALSE Chain 1: Iteration: 1000 / 1000 [100%]  (Sampling)
FALSE Chain 1:
FALSE Chain 1:  Elapsed Time: 2.28 seconds (Warm-up)
FALSE Chain 1:                1.728 seconds (Sampling)
FALSE Chain 1:                4.008 seconds (Total)
FALSE Chain 1:
```

```
FALSE
FALSE SAMPLING FOR MODEL 'dgu' NOW (CHAIN 1).
FALSE Chain 1:
FALSE Chain 1: Gradient evaluation took 0.000127 seconds
FALSE Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 1.27 seconds.
FALSE Chain 1: Adjust your expectations accordingly!
FALSE Chain 1:
FALSE Chain 1:
FALSE Chain 1: Iteration:   1 / 1000 [  0%]  (Warmup)
FALSE Chain 1: Iteration:  50 / 1000 [  5%]  (Warmup)
FALSE Chain 1: Iteration: 100 / 1000 [ 10%]  (Warmup)
FALSE Chain 1: Iteration: 150 / 1000 [ 15%]  (Warmup)
FALSE Chain 1: Iteration: 200 / 1000 [ 20%]  (Warmup)
FALSE Chain 1: Iteration: 250 / 1000 [ 25%]  (Warmup)
FALSE Chain 1: Iteration: 300 / 1000 [ 30%]  (Warmup)
FALSE Chain 1: Iteration: 350 / 1000 [ 35%]  (Warmup)
FALSE Chain 1: Iteration: 400 / 1000 [ 40%]  (Warmup)
FALSE Chain 1: Iteration: 450 / 1000 [ 45%]  (Warmup)
FALSE Chain 1: Iteration: 500 / 1000 [ 50%]  (Warmup)
FALSE Chain 1: Iteration: 501 / 1000 [ 50%]  (Sampling)
FALSE Chain 1: Iteration: 550 / 1000 [ 55%]  (Sampling)
FALSE Chain 1: Iteration: 600 / 1000 [ 60%]  (Sampling)
FALSE Chain 1: Iteration: 650 / 1000 [ 65%]  (Sampling)
FALSE Chain 1: Iteration: 700 / 1000 [ 70%]  (Sampling)
FALSE Chain 1: Iteration: 750 / 1000 [ 75%]  (Sampling)
FALSE Chain 1: Iteration: 800 / 1000 [ 80%]  (Sampling)
FALSE Chain 1: Iteration: 850 / 1000 [ 85%]  (Sampling)
FALSE Chain 1: Iteration: 900 / 1000 [ 90%]  (Sampling)
FALSE Chain 1: Iteration: 950 / 1000 [ 95%]  (Sampling)
FALSE Chain 1: Iteration: 1000 / 1000 [100%]  (Sampling)
FALSE Chain 1:
FALSE Chain 1:  Elapsed Time: 2.382 seconds (Warm-up)
FALSE Chain 1:                1.729 seconds (Sampling)
FALSE Chain 1:                4.111 seconds (Total)
FALSE Chain 1:
```

```
FALSE
FALSE SAMPLING FOR MODEL 'dgu' NOW (CHAIN 1).
FALSE Chain 1:
FALSE Chain 1: Gradient evaluation took 0.000126 seconds
FALSE Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 1.26 seconds.
FALSE Chain 1: Adjust your expectations accordingly!
FALSE Chain 1:
FALSE Chain 1:
FALSE Chain 1: Iteration:   1 / 1000 [  0%]  (Warmup)
FALSE Chain 1: Iteration:  50 / 1000 [  5%]  (Warmup)
FALSE Chain 1: Iteration: 100 / 1000 [ 10%]  (Warmup)
FALSE Chain 1: Iteration: 150 / 1000 [ 15%]  (Warmup)
FALSE Chain 1: Iteration: 200 / 1000 [ 20%]  (Warmup)
FALSE Chain 1: Iteration: 250 / 1000 [ 25%]  (Warmup)
FALSE Chain 1: Iteration: 300 / 1000 [ 30%]  (Warmup)
FALSE Chain 1: Iteration: 350 / 1000 [ 35%]  (Warmup)
FALSE Chain 1: Iteration: 400 / 1000 [ 40%]  (Warmup)
FALSE Chain 1: Iteration: 450 / 1000 [ 45%]  (Warmup)
FALSE Chain 1: Iteration: 500 / 1000 [ 50%]  (Warmup)
FALSE Chain 1: Iteration: 501 / 1000 [ 50%]  (Sampling)
FALSE Chain 1: Iteration: 550 / 1000 [ 55%]  (Sampling)
FALSE Chain 1: Iteration: 600 / 1000 [ 60%]  (Sampling)
FALSE Chain 1: Iteration: 650 / 1000 [ 65%]  (Sampling)
FALSE Chain 1: Iteration: 700 / 1000 [ 70%]  (Sampling)
FALSE Chain 1: Iteration: 750 / 1000 [ 75%]  (Sampling)
FALSE Chain 1: Iteration: 800 / 1000 [ 80%]  (Sampling)
FALSE Chain 1: Iteration: 850 / 1000 [ 85%]  (Sampling)
FALSE Chain 1: Iteration: 900 / 1000 [ 90%]  (Sampling)
FALSE Chain 1: Iteration: 950 / 1000 [ 95%]  (Sampling)
FALSE Chain 1: Iteration: 1000 / 1000 [100%]  (Sampling)
FALSE Chain 1:
FALSE Chain 1:  Elapsed Time: 2.54 seconds (Warm-up)
FALSE Chain 1:                1.706 seconds (Sampling)
FALSE Chain 1:                4.246 seconds (Total)
FALSE Chain 1:
```

```
FALSE
FALSE SAMPLING FOR MODEL 'dgu' NOW (CHAIN 1).
FALSE Chain 1:
FALSE Chain 1: Gradient evaluation took 0.000133 seconds
FALSE Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 1.33 seconds.
FALSE Chain 1: Adjust your expectations accordingly!
FALSE Chain 1:
FALSE Chain 1:
FALSE Chain 1: Iteration:   1 / 1000 [  0%]  (Warmup)
FALSE Chain 1: Iteration:  50 / 1000 [  5%]  (Warmup)
FALSE Chain 1: Iteration: 100 / 1000 [ 10%]  (Warmup)
FALSE Chain 1: Iteration: 150 / 1000 [ 15%]  (Warmup)
FALSE Chain 1: Iteration: 200 / 1000 [ 20%]  (Warmup)
FALSE Chain 1: Iteration: 250 / 1000 [ 25%]  (Warmup)
FALSE Chain 1: Iteration: 300 / 1000 [ 30%]  (Warmup)
FALSE Chain 1: Iteration: 350 / 1000 [ 35%]  (Warmup)
FALSE Chain 1: Iteration: 400 / 1000 [ 40%]  (Warmup)
FALSE Chain 1: Iteration: 450 / 1000 [ 45%]  (Warmup)
FALSE Chain 1: Iteration: 500 / 1000 [ 50%]  (Warmup)
FALSE Chain 1: Iteration: 501 / 1000 [ 50%]  (Sampling)
FALSE Chain 1: Iteration: 550 / 1000 [ 55%]  (Sampling)
FALSE Chain 1: Iteration: 600 / 1000 [ 60%]  (Sampling)
FALSE Chain 1: Iteration: 650 / 1000 [ 65%]  (Sampling)
FALSE Chain 1: Iteration: 700 / 1000 [ 70%]  (Sampling)
FALSE Chain 1: Iteration: 750 / 1000 [ 75%]  (Sampling)
FALSE Chain 1: Iteration: 800 / 1000 [ 80%]  (Sampling)
FALSE Chain 1: Iteration: 850 / 1000 [ 85%]  (Sampling)
FALSE Chain 1: Iteration: 900 / 1000 [ 90%]  (Sampling)
FALSE Chain 1: Iteration: 950 / 1000 [ 95%]  (Sampling)
FALSE Chain 1: Iteration: 1000 / 1000 [100%]  (Sampling)
FALSE Chain 1:
FALSE Chain 1:  Elapsed Time: 2.212 seconds (Warm-up)
FALSE Chain 1:                1.678 seconds (Sampling)
FALSE Chain 1:                3.89 seconds (Total)
FALSE Chain 1:
```

```
FALSE
FALSE SAMPLING FOR MODEL 'dgu' NOW (CHAIN 1).
FALSE Chain 1:
FALSE Chain 1: Gradient evaluation took 0.00013 seconds
FALSE Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 1.3 seconds.
FALSE Chain 1: Adjust your expectations accordingly!
FALSE Chain 1:
FALSE Chain 1:
FALSE Chain 1: Iteration:   1 / 1000 [  0%]  (Warmup)
FALSE Chain 1: Iteration:  50 / 1000 [  5%]  (Warmup)
FALSE Chain 1: Iteration: 100 / 1000 [ 10%]  (Warmup)
FALSE Chain 1: Iteration: 150 / 1000 [ 15%]  (Warmup)
FALSE Chain 1: Iteration: 200 / 1000 [ 20%]  (Warmup)
FALSE Chain 1: Iteration: 250 / 1000 [ 25%]  (Warmup)
FALSE Chain 1: Iteration: 300 / 1000 [ 30%]  (Warmup)
FALSE Chain 1: Iteration: 350 / 1000 [ 35%]  (Warmup)
FALSE Chain 1: Iteration: 400 / 1000 [ 40%]  (Warmup)
FALSE Chain 1: Iteration: 450 / 1000 [ 45%]  (Warmup)
FALSE Chain 1: Iteration: 500 / 1000 [ 50%]  (Warmup)
FALSE Chain 1: Iteration: 501 / 1000 [ 50%]  (Sampling)
FALSE Chain 1: Iteration: 550 / 1000 [ 55%]  (Sampling)
FALSE Chain 1: Iteration: 600 / 1000 [ 60%]  (Sampling)
FALSE Chain 1: Iteration: 650 / 1000 [ 65%]  (Sampling)
FALSE Chain 1: Iteration: 700 / 1000 [ 70%]  (Sampling)
FALSE Chain 1: Iteration: 750 / 1000 [ 75%]  (Sampling)
FALSE Chain 1: Iteration: 800 / 1000 [ 80%]  (Sampling)
FALSE Chain 1: Iteration: 850 / 1000 [ 85%]  (Sampling)
FALSE Chain 1: Iteration: 900 / 1000 [ 90%]  (Sampling)
FALSE Chain 1: Iteration: 950 / 1000 [ 95%]  (Sampling)
FALSE Chain 1: Iteration: 1000 / 1000 [100%]  (Sampling)
FALSE Chain 1:
FALSE Chain 1:  Elapsed Time: 2.168 seconds (Warm-up)
FALSE Chain 1:                1.696 seconds (Sampling)
FALSE Chain 1:                3.864 seconds (Total)
FALSE Chain 1:
```

```
FALSE
FALSE SAMPLING FOR MODEL 'dgu' NOW (CHAIN 1).
FALSE Chain 1:
FALSE Chain 1: Gradient evaluation took 0.000132 seconds
FALSE Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 1.32 seconds.
FALSE Chain 1: Adjust your expectations accordingly!
FALSE Chain 1:
FALSE Chain 1:
FALSE Chain 1: Iteration:   1 / 1000 [  0%]  (Warmup)
FALSE Chain 1: Iteration:  50 / 1000 [  5%]  (Warmup)
FALSE Chain 1: Iteration: 100 / 1000 [ 10%]  (Warmup)
FALSE Chain 1: Iteration: 150 / 1000 [ 15%]  (Warmup)
FALSE Chain 1: Iteration: 200 / 1000 [ 20%]  (Warmup)
FALSE Chain 1: Iteration: 250 / 1000 [ 25%]  (Warmup)
FALSE Chain 1: Iteration: 300 / 1000 [ 30%]  (Warmup)
FALSE Chain 1: Iteration: 350 / 1000 [ 35%]  (Warmup)
FALSE Chain 1: Iteration: 400 / 1000 [ 40%]  (Warmup)
FALSE Chain 1: Iteration: 450 / 1000 [ 45%]  (Warmup)
FALSE Chain 1: Iteration: 500 / 1000 [ 50%]  (Warmup)
FALSE Chain 1: Iteration: 501 / 1000 [ 50%]  (Sampling)
FALSE Chain 1: Iteration: 550 / 1000 [ 55%]  (Sampling)
FALSE Chain 1: Iteration: 600 / 1000 [ 60%]  (Sampling)
FALSE Chain 1: Iteration: 650 / 1000 [ 65%]  (Sampling)
FALSE Chain 1: Iteration: 700 / 1000 [ 70%]  (Sampling)
FALSE Chain 1: Iteration: 750 / 1000 [ 75%]  (Sampling)
FALSE Chain 1: Iteration: 800 / 1000 [ 80%]  (Sampling)
FALSE Chain 1: Iteration: 850 / 1000 [ 85%]  (Sampling)
FALSE Chain 1: Iteration: 900 / 1000 [ 90%]  (Sampling)
FALSE Chain 1: Iteration: 950 / 1000 [ 95%]  (Sampling)
FALSE Chain 1: Iteration: 1000 / 1000 [100%]  (Sampling)
FALSE Chain 1:
FALSE Chain 1:  Elapsed Time: 2.636 seconds (Warm-up)
FALSE Chain 1:                1.678 seconds (Sampling)
FALSE Chain 1:                4.314 seconds (Total)
FALSE Chain 1:
```

```
FALSE
FALSE SAMPLING FOR MODEL 'dgu' NOW (CHAIN 1).
FALSE Chain 1:
FALSE Chain 1: Gradient evaluation took 0.000127 seconds
FALSE Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 1.27 seconds.
FALSE Chain 1: Adjust your expectations accordingly!
FALSE Chain 1:
FALSE Chain 1:
FALSE Chain 1: Iteration:   1 / 1000 [  0%]  (Warmup)
FALSE Chain 1: Iteration:  50 / 1000 [  5%]  (Warmup)
FALSE Chain 1: Iteration: 100 / 1000 [ 10%]  (Warmup)
FALSE Chain 1: Iteration: 150 / 1000 [ 15%]  (Warmup)
FALSE Chain 1: Iteration: 200 / 1000 [ 20%]  (Warmup)
FALSE Chain 1: Iteration: 250 / 1000 [ 25%]  (Warmup)
FALSE Chain 1: Iteration: 300 / 1000 [ 30%]  (Warmup)
FALSE Chain 1: Iteration: 350 / 1000 [ 35%]  (Warmup)
FALSE Chain 1: Iteration: 400 / 1000 [ 40%]  (Warmup)
FALSE Chain 1: Iteration: 450 / 1000 [ 45%]  (Warmup)
FALSE Chain 1: Iteration: 500 / 1000 [ 50%]  (Warmup)
FALSE Chain 1: Iteration: 501 / 1000 [ 50%]  (Sampling)
FALSE Chain 1: Iteration: 550 / 1000 [ 55%]  (Sampling)
FALSE Chain 1: Iteration: 600 / 1000 [ 60%]  (Sampling)
FALSE Chain 1: Iteration: 650 / 1000 [ 65%]  (Sampling)
FALSE Chain 1: Iteration: 700 / 1000 [ 70%]  (Sampling)
FALSE Chain 1: Iteration: 750 / 1000 [ 75%]  (Sampling)
FALSE Chain 1: Iteration: 800 / 1000 [ 80%]  (Sampling)
FALSE Chain 1: Iteration: 850 / 1000 [ 85%]  (Sampling)
FALSE Chain 1: Iteration: 900 / 1000 [ 90%]  (Sampling)
FALSE Chain 1: Iteration: 950 / 1000 [ 95%]  (Sampling)
FALSE Chain 1: Iteration: 1000 / 1000 [100%]  (Sampling)
FALSE Chain 1:
FALSE Chain 1:  Elapsed Time: 2.628 seconds (Warm-up)
FALSE Chain 1:                1.856 seconds (Sampling)
FALSE Chain 1:                4.484 seconds (Total)
FALSE Chain 1:
```

```
FALSE
FALSE SAMPLING FOR MODEL 'dgu' NOW (CHAIN 1).
FALSE Chain 1:
FALSE Chain 1: Gradient evaluation took 0.00013 seconds
FALSE Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 1.3 seconds.
FALSE Chain 1: Adjust your expectations accordingly!
FALSE Chain 1:
FALSE Chain 1:
FALSE Chain 1: Iteration:   1 / 1000 [  0%]  (Warmup)
FALSE Chain 1: Iteration:  50 / 1000 [  5%]  (Warmup)
FALSE Chain 1: Iteration: 100 / 1000 [ 10%]  (Warmup)
FALSE Chain 1: Iteration: 150 / 1000 [ 15%]  (Warmup)
FALSE Chain 1: Iteration: 200 / 1000 [ 20%]  (Warmup)
FALSE Chain 1: Iteration: 250 / 1000 [ 25%]  (Warmup)
FALSE Chain 1: Iteration: 300 / 1000 [ 30%]  (Warmup)
FALSE Chain 1: Iteration: 350 / 1000 [ 35%]  (Warmup)
FALSE Chain 1: Iteration: 400 / 1000 [ 40%]  (Warmup)
FALSE Chain 1: Iteration: 450 / 1000 [ 45%]  (Warmup)
FALSE Chain 1: Iteration: 500 / 1000 [ 50%]  (Warmup)
FALSE Chain 1: Iteration: 501 / 1000 [ 50%]  (Sampling)
FALSE Chain 1: Iteration: 550 / 1000 [ 55%]  (Sampling)
FALSE Chain 1: Iteration: 600 / 1000 [ 60%]  (Sampling)
FALSE Chain 1: Iteration: 650 / 1000 [ 65%]  (Sampling)
FALSE Chain 1: Iteration: 700 / 1000 [ 70%]  (Sampling)
FALSE Chain 1: Iteration: 750 / 1000 [ 75%]  (Sampling)
FALSE Chain 1: Iteration: 800 / 1000 [ 80%]  (Sampling)
FALSE Chain 1: Iteration: 850 / 1000 [ 85%]  (Sampling)
FALSE Chain 1: Iteration: 900 / 1000 [ 90%]  (Sampling)
FALSE Chain 1: Iteration: 950 / 1000 [ 95%]  (Sampling)
FALSE Chain 1: Iteration: 1000 / 1000 [100%]  (Sampling)
FALSE Chain 1:
FALSE Chain 1:  Elapsed Time: 2.346 seconds (Warm-up)
FALSE Chain 1:                1.674 seconds (Sampling)
FALSE Chain 1:                4.02 seconds (Total)
FALSE Chain 1:
```

```
FALSE
FALSE SAMPLING FOR MODEL 'dgu' NOW (CHAIN 1).
FALSE Chain 1:
FALSE Chain 1: Gradient evaluation took 0.000128 seconds
FALSE Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 1.28 seconds.
FALSE Chain 1: Adjust your expectations accordingly!
FALSE Chain 1:
FALSE Chain 1:
FALSE Chain 1: Iteration:   1 / 1000 [  0%]  (Warmup)
FALSE Chain 1: Iteration:  50 / 1000 [  5%]  (Warmup)
FALSE Chain 1: Iteration: 100 / 1000 [ 10%]  (Warmup)
FALSE Chain 1: Iteration: 150 / 1000 [ 15%]  (Warmup)
FALSE Chain 1: Iteration: 200 / 1000 [ 20%]  (Warmup)
FALSE Chain 1: Iteration: 250 / 1000 [ 25%]  (Warmup)
FALSE Chain 1: Iteration: 300 / 1000 [ 30%]  (Warmup)
FALSE Chain 1: Iteration: 350 / 1000 [ 35%]  (Warmup)
FALSE Chain 1: Iteration: 400 / 1000 [ 40%]  (Warmup)
FALSE Chain 1: Iteration: 450 / 1000 [ 45%]  (Warmup)
FALSE Chain 1: Iteration: 500 / 1000 [ 50%]  (Warmup)
FALSE Chain 1: Iteration: 501 / 1000 [ 50%]  (Sampling)
FALSE Chain 1: Iteration: 550 / 1000 [ 55%]  (Sampling)
FALSE Chain 1: Iteration: 600 / 1000 [ 60%]  (Sampling)
FALSE Chain 1: Iteration: 650 / 1000 [ 65%]  (Sampling)
FALSE Chain 1: Iteration: 700 / 1000 [ 70%]  (Sampling)
FALSE Chain 1: Iteration: 750 / 1000 [ 75%]  (Sampling)
FALSE Chain 1: Iteration: 800 / 1000 [ 80%]  (Sampling)
FALSE Chain 1: Iteration: 850 / 1000 [ 85%]  (Sampling)
FALSE Chain 1: Iteration: 900 / 1000 [ 90%]  (Sampling)
FALSE Chain 1: Iteration: 950 / 1000 [ 95%]  (Sampling)
FALSE Chain 1: Iteration: 1000 / 1000 [100%]  (Sampling)
FALSE Chain 1:
FALSE Chain 1:  Elapsed Time: 2.158 seconds (Warm-up)
FALSE Chain 1:                1.677 seconds (Sampling)
FALSE Chain 1:                3.835 seconds (Total)
FALSE Chain 1:
```

```
FALSE
FALSE SAMPLING FOR MODEL 'dgu' NOW (CHAIN 1).
FALSE Chain 1:
FALSE Chain 1: Gradient evaluation took 0.000132 seconds
FALSE Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 1.32 seconds.
FALSE Chain 1: Adjust your expectations accordingly!
FALSE Chain 1:
FALSE Chain 1:
FALSE Chain 1: Iteration:   1 / 1000 [  0%]  (Warmup)
FALSE Chain 1: Iteration:  50 / 1000 [  5%]  (Warmup)
FALSE Chain 1: Iteration: 100 / 1000 [ 10%]  (Warmup)
FALSE Chain 1: Iteration: 150 / 1000 [ 15%]  (Warmup)
FALSE Chain 1: Iteration: 200 / 1000 [ 20%]  (Warmup)
FALSE Chain 1: Iteration: 250 / 1000 [ 25%]  (Warmup)
FALSE Chain 1: Iteration: 300 / 1000 [ 30%]  (Warmup)
FALSE Chain 1: Iteration: 350 / 1000 [ 35%]  (Warmup)
FALSE Chain 1: Iteration: 400 / 1000 [ 40%]  (Warmup)
FALSE Chain 1: Iteration: 450 / 1000 [ 45%]  (Warmup)
FALSE Chain 1: Iteration: 500 / 1000 [ 50%]  (Warmup)
FALSE Chain 1: Iteration: 501 / 1000 [ 50%]  (Sampling)
FALSE Chain 1: Iteration: 550 / 1000 [ 55%]  (Sampling)
FALSE Chain 1: Iteration: 600 / 1000 [ 60%]  (Sampling)
FALSE Chain 1: Iteration: 650 / 1000 [ 65%]  (Sampling)
FALSE Chain 1: Iteration: 700 / 1000 [ 70%]  (Sampling)
FALSE Chain 1: Iteration: 750 / 1000 [ 75%]  (Sampling)
FALSE Chain 1: Iteration: 800 / 1000 [ 80%]  (Sampling)
FALSE Chain 1: Iteration: 850 / 1000 [ 85%]  (Sampling)
FALSE Chain 1: Iteration: 900 / 1000 [ 90%]  (Sampling)
FALSE Chain 1: Iteration: 950 / 1000 [ 95%]  (Sampling)
FALSE Chain 1: Iteration: 1000 / 1000 [100%]  (Sampling)
FALSE Chain 1:
FALSE Chain 1:  Elapsed Time: 2.63 seconds (Warm-up)
FALSE Chain 1:                1.675 seconds (Sampling)
FALSE Chain 1:                4.305 seconds (Total)
FALSE Chain 1:
```

```
FALSE
FALSE SAMPLING FOR MODEL 'dgu' NOW (CHAIN 1).
FALSE Chain 1:
FALSE Chain 1: Gradient evaluation took 0.000119 seconds
FALSE Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 1.19 seconds.
FALSE Chain 1: Adjust your expectations accordingly!
FALSE Chain 1:
FALSE Chain 1:
FALSE Chain 1: Iteration:   1 / 1000 [  0%]  (Warmup)
FALSE Chain 1: Iteration:  50 / 1000 [  5%]  (Warmup)
FALSE Chain 1: Iteration: 100 / 1000 [ 10%]  (Warmup)
FALSE Chain 1: Iteration: 150 / 1000 [ 15%]  (Warmup)
FALSE Chain 1: Iteration: 200 / 1000 [ 20%]  (Warmup)
FALSE Chain 1: Iteration: 250 / 1000 [ 25%]  (Warmup)
FALSE Chain 1: Iteration: 300 / 1000 [ 30%]  (Warmup)
FALSE Chain 1: Iteration: 350 / 1000 [ 35%]  (Warmup)
FALSE Chain 1: Iteration: 400 / 1000 [ 40%]  (Warmup)
FALSE Chain 1: Iteration: 450 / 1000 [ 45%]  (Warmup)
FALSE Chain 1: Iteration: 500 / 1000 [ 50%]  (Warmup)
FALSE Chain 1: Iteration: 501 / 1000 [ 50%]  (Sampling)
FALSE Chain 1: Iteration: 550 / 1000 [ 55%]  (Sampling)
FALSE Chain 1: Iteration: 600 / 1000 [ 60%]  (Sampling)
FALSE Chain 1: Iteration: 650 / 1000 [ 65%]  (Sampling)
FALSE Chain 1: Iteration: 700 / 1000 [ 70%]  (Sampling)
FALSE Chain 1: Iteration: 750 / 1000 [ 75%]  (Sampling)
FALSE Chain 1: Iteration: 800 / 1000 [ 80%]  (Sampling)
FALSE Chain 1: Iteration: 850 / 1000 [ 85%]  (Sampling)
FALSE Chain 1: Iteration: 900 / 1000 [ 90%]  (Sampling)
FALSE Chain 1: Iteration: 950 / 1000 [ 95%]  (Sampling)
FALSE Chain 1: Iteration: 1000 / 1000 [100%]  (Sampling)
FALSE Chain 1:
FALSE Chain 1:  Elapsed Time: 2.516 seconds (Warm-up)
FALSE Chain 1:                1.674 seconds (Sampling)
FALSE Chain 1:                4.19 seconds (Total)
FALSE Chain 1:
```

```
FALSE
FALSE SAMPLING FOR MODEL 'dgu' NOW (CHAIN 1).
FALSE Chain 1:
FALSE Chain 1: Gradient evaluation took 0.000121 seconds
FALSE Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 1.21 seconds.
FALSE Chain 1: Adjust your expectations accordingly!
FALSE Chain 1:
FALSE Chain 1:
FALSE Chain 1: Iteration:   1 / 1000 [  0%]  (Warmup)
FALSE Chain 1: Iteration:  50 / 1000 [  5%]  (Warmup)
FALSE Chain 1: Iteration: 100 / 1000 [ 10%]  (Warmup)
FALSE Chain 1: Iteration: 150 / 1000 [ 15%]  (Warmup)
FALSE Chain 1: Iteration: 200 / 1000 [ 20%]  (Warmup)
FALSE Chain 1: Iteration: 250 / 1000 [ 25%]  (Warmup)
FALSE Chain 1: Iteration: 300 / 1000 [ 30%]  (Warmup)
FALSE Chain 1: Iteration: 350 / 1000 [ 35%]  (Warmup)
FALSE Chain 1: Iteration: 400 / 1000 [ 40%]  (Warmup)
FALSE Chain 1: Iteration: 450 / 1000 [ 45%]  (Warmup)
FALSE Chain 1: Iteration: 500 / 1000 [ 50%]  (Warmup)
FALSE Chain 1: Iteration: 501 / 1000 [ 50%]  (Sampling)
FALSE Chain 1: Iteration: 550 / 1000 [ 55%]  (Sampling)
FALSE Chain 1: Iteration: 600 / 1000 [ 60%]  (Sampling)
FALSE Chain 1: Iteration: 650 / 1000 [ 65%]  (Sampling)
FALSE Chain 1: Iteration: 700 / 1000 [ 70%]  (Sampling)
FALSE Chain 1: Iteration: 750 / 1000 [ 75%]  (Sampling)
FALSE Chain 1: Iteration: 800 / 1000 [ 80%]  (Sampling)
FALSE Chain 1: Iteration: 850 / 1000 [ 85%]  (Sampling)
FALSE Chain 1: Iteration: 900 / 1000 [ 90%]  (Sampling)
FALSE Chain 1: Iteration: 950 / 1000 [ 95%]  (Sampling)
FALSE Chain 1: Iteration: 1000 / 1000 [100%]  (Sampling)
FALSE Chain 1:
FALSE Chain 1:  Elapsed Time: 2.326 seconds (Warm-up)
FALSE Chain 1:                1.723 seconds (Sampling)
FALSE Chain 1:                4.049 seconds (Total)
FALSE Chain 1:
```

```
FALSE
FALSE SAMPLING FOR MODEL 'dgu' NOW (CHAIN 1).
FALSE Chain 1:
FALSE Chain 1: Gradient evaluation took 0.00012 seconds
FALSE Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 1.2 seconds.
FALSE Chain 1: Adjust your expectations accordingly!
FALSE Chain 1:
FALSE Chain 1:
FALSE Chain 1: Iteration:   1 / 1000 [  0%]  (Warmup)
FALSE Chain 1: Iteration:  50 / 1000 [  5%]  (Warmup)
FALSE Chain 1: Iteration: 100 / 1000 [ 10%]  (Warmup)
FALSE Chain 1: Iteration: 150 / 1000 [ 15%]  (Warmup)
FALSE Chain 1: Iteration: 200 / 1000 [ 20%]  (Warmup)
FALSE Chain 1: Iteration: 250 / 1000 [ 25%]  (Warmup)
FALSE Chain 1: Iteration: 300 / 1000 [ 30%]  (Warmup)
FALSE Chain 1: Iteration: 350 / 1000 [ 35%]  (Warmup)
FALSE Chain 1: Iteration: 400 / 1000 [ 40%]  (Warmup)
FALSE Chain 1: Iteration: 450 / 1000 [ 45%]  (Warmup)
FALSE Chain 1: Iteration: 500 / 1000 [ 50%]  (Warmup)
FALSE Chain 1: Iteration: 501 / 1000 [ 50%]  (Sampling)
FALSE Chain 1: Iteration: 550 / 1000 [ 55%]  (Sampling)
FALSE Chain 1: Iteration: 600 / 1000 [ 60%]  (Sampling)
FALSE Chain 1: Iteration: 650 / 1000 [ 65%]  (Sampling)
FALSE Chain 1: Iteration: 700 / 1000 [ 70%]  (Sampling)
FALSE Chain 1: Iteration: 750 / 1000 [ 75%]  (Sampling)
FALSE Chain 1: Iteration: 800 / 1000 [ 80%]  (Sampling)
FALSE Chain 1: Iteration: 850 / 1000 [ 85%]  (Sampling)
FALSE Chain 1: Iteration: 900 / 1000 [ 90%]  (Sampling)
FALSE Chain 1: Iteration: 950 / 1000 [ 95%]  (Sampling)
FALSE Chain 1: Iteration: 1000 / 1000 [100%]  (Sampling)
FALSE Chain 1:
FALSE Chain 1:  Elapsed Time: 2.476 seconds (Warm-up)
FALSE Chain 1:                1.677 seconds (Sampling)
FALSE Chain 1:                4.153 seconds (Total)
FALSE Chain 1:
```

```
FALSE
FALSE SAMPLING FOR MODEL 'dgu' NOW (CHAIN 1).
FALSE Chain 1:
FALSE Chain 1: Gradient evaluation took 0.000129 seconds
FALSE Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 1.29 seconds.
FALSE Chain 1: Adjust your expectations accordingly!
FALSE Chain 1:
FALSE Chain 1:
FALSE Chain 1: Iteration:   1 / 1000 [  0%]  (Warmup)
FALSE Chain 1: Iteration:  50 / 1000 [  5%]  (Warmup)
FALSE Chain 1: Iteration: 100 / 1000 [ 10%]  (Warmup)
FALSE Chain 1: Iteration: 150 / 1000 [ 15%]  (Warmup)
FALSE Chain 1: Iteration: 200 / 1000 [ 20%]  (Warmup)
FALSE Chain 1: Iteration: 250 / 1000 [ 25%]  (Warmup)
FALSE Chain 1: Iteration: 300 / 1000 [ 30%]  (Warmup)
FALSE Chain 1: Iteration: 350 / 1000 [ 35%]  (Warmup)
FALSE Chain 1: Iteration: 400 / 1000 [ 40%]  (Warmup)
FALSE Chain 1: Iteration: 450 / 1000 [ 45%]  (Warmup)
FALSE Chain 1: Iteration: 500 / 1000 [ 50%]  (Warmup)
FALSE Chain 1: Iteration: 501 / 1000 [ 50%]  (Sampling)
FALSE Chain 1: Iteration: 550 / 1000 [ 55%]  (Sampling)
FALSE Chain 1: Iteration: 600 / 1000 [ 60%]  (Sampling)
FALSE Chain 1: Iteration: 650 / 1000 [ 65%]  (Sampling)
FALSE Chain 1: Iteration: 700 / 1000 [ 70%]  (Sampling)
FALSE Chain 1: Iteration: 750 / 1000 [ 75%]  (Sampling)
FALSE Chain 1: Iteration: 800 / 1000 [ 80%]  (Sampling)
FALSE Chain 1: Iteration: 850 / 1000 [ 85%]  (Sampling)
FALSE Chain 1: Iteration: 900 / 1000 [ 90%]  (Sampling)
FALSE Chain 1: Iteration: 950 / 1000 [ 95%]  (Sampling)
FALSE Chain 1: Iteration: 1000 / 1000 [100%]  (Sampling)
FALSE Chain 1:
FALSE Chain 1:  Elapsed Time: 2.966 seconds (Warm-up)
FALSE Chain 1:                1.671 seconds (Sampling)
FALSE Chain 1:                4.637 seconds (Total)
FALSE Chain 1:
```

```
FALSE
FALSE SAMPLING FOR MODEL 'dgu' NOW (CHAIN 1).
FALSE Chain 1:
FALSE Chain 1: Gradient evaluation took 0.00013 seconds
FALSE Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 1.3 seconds.
FALSE Chain 1: Adjust your expectations accordingly!
FALSE Chain 1:
FALSE Chain 1:
FALSE Chain 1: Iteration:   1 / 1000 [  0%]  (Warmup)
FALSE Chain 1: Iteration:  50 / 1000 [  5%]  (Warmup)
FALSE Chain 1: Iteration: 100 / 1000 [ 10%]  (Warmup)
FALSE Chain 1: Iteration: 150 / 1000 [ 15%]  (Warmup)
FALSE Chain 1: Iteration: 200 / 1000 [ 20%]  (Warmup)
FALSE Chain 1: Iteration: 250 / 1000 [ 25%]  (Warmup)
FALSE Chain 1: Iteration: 300 / 1000 [ 30%]  (Warmup)
FALSE Chain 1: Iteration: 350 / 1000 [ 35%]  (Warmup)
FALSE Chain 1: Iteration: 400 / 1000 [ 40%]  (Warmup)
FALSE Chain 1: Iteration: 450 / 1000 [ 45%]  (Warmup)
FALSE Chain 1: Iteration: 500 / 1000 [ 50%]  (Warmup)
FALSE Chain 1: Iteration: 501 / 1000 [ 50%]  (Sampling)
FALSE Chain 1: Iteration: 550 / 1000 [ 55%]  (Sampling)
FALSE Chain 1: Iteration: 600 / 1000 [ 60%]  (Sampling)
FALSE Chain 1: Iteration: 650 / 1000 [ 65%]  (Sampling)
FALSE Chain 1: Iteration: 700 / 1000 [ 70%]  (Sampling)
FALSE Chain 1: Iteration: 750 / 1000 [ 75%]  (Sampling)
FALSE Chain 1: Iteration: 800 / 1000 [ 80%]  (Sampling)
FALSE Chain 1: Iteration: 850 / 1000 [ 85%]  (Sampling)
FALSE Chain 1: Iteration: 900 / 1000 [ 90%]  (Sampling)
FALSE Chain 1: Iteration: 950 / 1000 [ 95%]  (Sampling)
FALSE Chain 1: Iteration: 1000 / 1000 [100%]  (Sampling)
FALSE Chain 1:
FALSE Chain 1:  Elapsed Time: 2.149 seconds (Warm-up)
FALSE Chain 1:                1.666 seconds (Sampling)
FALSE Chain 1:                3.815 seconds (Total)
FALSE Chain 1:
```

Next, we collected the results (GU and DGU) from each LOO iteration:

```
L_gu <- do.call(rbind, lapply(X = L, FUN = function(x){return(x$gu)}))
L_dgu <- do.call(rbind, lapply(X = L, FUN = function(x){return(x$dgu)}))
```

… and plot them:

## 5.1 LOO-DGU: variability of effect size \(\gamma\)

```
ggplot(data = L_dgu)+
  facet_wrap(facets = ~contrast, ncol = 1)+
  geom_hline(yintercept = 0, linetype = "dashed", col = "gray")+
  geom_errorbar(aes(x = gene_name, y = es_mean, ymin = es_L,
                    ymax = es_H, col = contrast, group = loo_id),
                width = 0.1, position = position_dodge(width = 0.75))+
  geom_point(aes(x = gene_name, y = es_mean, col = contrast,
                 group = loo_id), size = 1,
             position = position_dodge(width = 0.75))+
  theme_bw(base_size = 11)+
  theme(legend.position = "none")+
  ylab(expression(gamma))
```

![](data:image/png;base64...)

## 5.2 LOO-DGU: variability of \(\pi\)

```
ggplot(data = L_dgu)+
  facet_wrap(facets = ~contrast, ncol = 1)+
  geom_point(aes(x = gene_name, y = pmax, col = contrast,
                 group = loo_id), size = 1,
             position = position_dodge(width = 0.5))+
  theme_bw(base_size = 11)+
  theme(legend.position = "none")+
  ylab(expression(pi))
```

![](data:image/png;base64...)

## 5.3 LOO-GU: variability of the gene usage

```
ggplot(data = L_gu)+
  geom_hline(yintercept = 0, linetype = "dashed", col = "gray")+
  geom_errorbar(aes(x = gene_name, y = prob_mean, ymin = prob_L,
                    ymax = prob_H, col = condition,
                    group = interaction(loo_id, condition)),
                width = 0.1, position = position_dodge(width = 1))+
  geom_point(aes(x = gene_name, y = prob_mean, col = condition,
                 group = interaction(loo_id, condition)), size = 1,
             position = position_dodge(width = 1))+
  theme_bw(base_size = 11)+
  theme(legend.position = "top")+
  ylab("GU [probability]")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.4))
```

![](data:image/png;base64...)

# 6 Case Study B: analyzing IRRs containing biological replicates

```
data("d_zibb_4", package = "IgGeneUsage")
knitr::kable(head(d_zibb_4))
```

| individual\_id | condition | gene\_name | replicate | gene\_usage\_count |
| --- | --- | --- | --- | --- |
| I\_1 | C\_1 | G\_1 | R\_1 | 29 |
| I\_1 | C\_1 | G\_2 | R\_1 | 66 |
| I\_1 | C\_1 | G\_3 | R\_1 | 285 |
| I\_1 | C\_1 | G\_4 | R\_1 | 20 |
| I\_1 | C\_1 | G\_5 | R\_1 | 38 |
| I\_1 | C\_1 | G\_6 | R\_1 | 709 |

We can also visualize `d_zibb_4` with *[ggplot](https://CRAN.R-project.org/package%3Dggplot)*:

```
ggplot(data = d_zibb_4)+
  geom_point(aes(x = gene_name, y = gene_usage_count, col = condition,
                 shape = replicate), position = position_dodge(width = 0.8))+
  theme_bw(base_size = 11)+
  ylab(label = "Gene usage [count]")+
  xlab(label = '')+
  theme(legend.position = "top")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.4))
```

![](data:image/png;base64...)

## 6.1 Modeling

```
M <- DGU(ud = d_zibb_4, # input data
         mcmc_warmup = 500, # how many MCMC warm-ups per chain (default: 500)
         mcmc_steps = 1500, # how many MCMC steps per chain (default: 1,500)
         mcmc_chains = 2, # how many MCMC chain to run (default: 4)
         mcmc_cores = 1, # how many PC cores to use? (e.g. parallel chains)
         hdi_lvl = 0.95, # highest density interval level (de fault: 0.95)
         adapt_delta = 0.8, # MCMC target acceptance rate (default: 0.95)
         max_treedepth = 10) # tree depth evaluated at each step (default: 12)
```

```
FALSE
FALSE SAMPLING FOR MODEL 'dgu_rep' NOW (CHAIN 1).
FALSE Chain 1:
FALSE Chain 1: Gradient evaluation took 0.000396 seconds
FALSE Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 3.96 seconds.
FALSE Chain 1: Adjust your expectations accordingly!
FALSE Chain 1:
FALSE Chain 1:
FALSE Chain 1: Iteration:    1 / 1500 [  0%]  (Warmup)
FALSE Chain 1: Iteration:   50 / 1500 [  3%]  (Warmup)
FALSE Chain 1: Iteration:  100 / 1500 [  6%]  (Warmup)
FALSE Chain 1: Iteration:  150 / 1500 [ 10%]  (Warmup)
FALSE Chain 1: Iteration:  200 / 1500 [ 13%]  (Warmup)
FALSE Chain 1: Iteration:  250 / 1500 [ 16%]  (Warmup)
FALSE Chain 1: Iteration:  300 / 1500 [ 20%]  (Warmup)
FALSE Chain 1: Iteration:  350 / 1500 [ 23%]  (Warmup)
FALSE Chain 1: Iteration:  400 / 1500 [ 26%]  (Warmup)
FALSE Chain 1: Iteration:  450 / 1500 [ 30%]  (Warmup)
FALSE Chain 1: Iteration:  500 / 1500 [ 33%]  (Warmup)
FALSE Chain 1: Iteration:  501 / 1500 [ 33%]  (Sampling)
FALSE Chain 1: Iteration:  550 / 1500 [ 36%]  (Sampling)
FALSE Chain 1: Iteration:  600 / 1500 [ 40%]  (Sampling)
FALSE Chain 1: Iteration:  650 / 1500 [ 43%]  (Sampling)
FALSE Chain 1: Iteration:  700 / 1500 [ 46%]  (Sampling)
FALSE Chain 1: Iteration:  750 / 1500 [ 50%]  (Sampling)
FALSE Chain 1: Iteration:  800 / 1500 [ 53%]  (Sampling)
FALSE Chain 1: Iteration:  850 / 1500 [ 56%]  (Sampling)
FALSE Chain 1: Iteration:  900 / 1500 [ 60%]  (Sampling)
FALSE Chain 1: Iteration:  950 / 1500 [ 63%]  (Sampling)
FALSE Chain 1: Iteration: 1000 / 1500 [ 66%]  (Sampling)
FALSE Chain 1: Iteration: 1050 / 1500 [ 70%]  (Sampling)
FALSE Chain 1: Iteration: 1100 / 1500 [ 73%]  (Sampling)
FALSE Chain 1: Iteration: 1150 / 1500 [ 76%]  (Sampling)
FALSE Chain 1: Iteration: 1200 / 1500 [ 80%]  (Sampling)
FALSE Chain 1: Iteration: 1250 / 1500 [ 83%]  (Sampling)
FALSE Chain 1: Iteration: 1300 / 1500 [ 86%]  (Sampling)
FALSE Chain 1: Iteration: 1350 / 1500 [ 90%]  (Sampling)
FALSE Chain 1: Iteration: 1400 / 1500 [ 93%]  (Sampling)
FALSE Chain 1: Iteration: 1450 / 1500 [ 96%]  (Sampling)
FALSE Chain 1: Iteration: 1500 / 1500 [100%]  (Sampling)
FALSE Chain 1:
FALSE Chain 1:  Elapsed Time: 34.808 seconds (Warm-up)
FALSE Chain 1:                77.023 seconds (Sampling)
FALSE Chain 1:                111.831 seconds (Total)
FALSE Chain 1:
FALSE
FALSE SAMPLING FOR MODEL 'dgu_rep' NOW (CHAIN 2).
FALSE Chain 2:
FALSE Chain 2: Gradient evaluation took 0.000318 seconds
FALSE Chain 2: 1000 transitions using 10 leapfrog steps per transition would take 3.18 seconds.
FALSE Chain 2: Adjust your expectations accordingly!
FALSE Chain 2:
FALSE Chain 2:
FALSE Chain 2: Iteration:    1 / 1500 [  0%]  (Warmup)
FALSE Chain 2: Iteration:   50 / 1500 [  3%]  (Warmup)
FALSE Chain 2: Iteration:  100 / 1500 [  6%]  (Warmup)
FALSE Chain 2: Iteration:  150 / 1500 [ 10%]  (Warmup)
FALSE Chain 2: Iteration:  200 / 1500 [ 13%]  (Warmup)
FALSE Chain 2: Iteration:  250 / 1500 [ 16%]  (Warmup)
FALSE Chain 2: Iteration:  300 / 1500 [ 20%]  (Warmup)
FALSE Chain 2: Iteration:  350 / 1500 [ 23%]  (Warmup)
FALSE Chain 2: Iteration:  400 / 1500 [ 26%]  (Warmup)
FALSE Chain 2: Iteration:  450 / 1500 [ 30%]  (Warmup)
FALSE Chain 2: Iteration:  500 / 1500 [ 33%]  (Warmup)
FALSE Chain 2: Iteration:  501 / 1500 [ 33%]  (Sampling)
FALSE Chain 2: Iteration:  550 / 1500 [ 36%]  (Sampling)
FALSE Chain 2: Iteration:  600 / 1500 [ 40%]  (Sampling)
FALSE Chain 2: Iteration:  650 / 1500 [ 43%]  (Sampling)
FALSE Chain 2: Iteration:  700 / 1500 [ 46%]  (Sampling)
FALSE Chain 2: Iteration:  750 / 1500 [ 50%]  (Sampling)
FALSE Chain 2: Iteration:  800 / 1500 [ 53%]  (Sampling)
FALSE Chain 2: Iteration:  850 / 1500 [ 56%]  (Sampling)
FALSE Chain 2: Iteration:  900 / 1500 [ 60%]  (Sampling)
FALSE Chain 2: Iteration:  950 / 1500 [ 63%]  (Sampling)
FALSE Chain 2: Iteration: 1000 / 1500 [ 66%]  (Sampling)
FALSE Chain 2: Iteration: 1050 / 1500 [ 70%]  (Sampling)
FALSE Chain 2: Iteration: 1100 / 1500 [ 73%]  (Sampling)
FALSE Chain 2: Iteration: 1150 / 1500 [ 76%]  (Sampling)
FALSE Chain 2: Iteration: 1200 / 1500 [ 80%]  (Sampling)
FALSE Chain 2: Iteration: 1250 / 1500 [ 83%]  (Sampling)
FALSE Chain 2: Iteration: 1300 / 1500 [ 86%]  (Sampling)
FALSE Chain 2: Iteration: 1350 / 1500 [ 90%]  (Sampling)
FALSE Chain 2: Iteration: 1400 / 1500 [ 93%]  (Sampling)
FALSE Chain 2: Iteration: 1450 / 1500 [ 96%]  (Sampling)
FALSE Chain 2: Iteration: 1500 / 1500 [100%]  (Sampling)
FALSE Chain 2:
FALSE Chain 2:  Elapsed Time: 34.341 seconds (Warm-up)
FALSE Chain 2:                39.917 seconds (Sampling)
FALSE Chain 2:                74.258 seconds (Total)
FALSE Chain 2:
```

## 6.2 Posterior predictive checks

```
ggplot(data = M$ppc$ppc_rep)+
  facet_wrap(facets = ~individual_id, ncol = 3)+
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", col = "darkgray")+
  geom_errorbar(aes(x = observed_count, y = ppc_mean_count,
                    ymin = ppc_L_count, ymax = ppc_H_count), col = "darkgray")+
  geom_point(aes(x = observed_count, y = ppc_mean_count), size = 1)+
  theme_bw(base_size = 11)+
  theme(legend.position = "top")+
  xlab(label = "Observed usage [counts]")+
  ylab(label = "PPC usage [counts]")
```

![](data:image/png;base64...)

## 6.3 Analysis of estimated effect sizes

The top panel shows the average gene usage (GU) in different biological
conditions. The bottom panels shows the differential gene usage (DGU)
between pairs of biological conditions.

```
g1 <- ggplot(data = M$gu)+
  geom_errorbar(aes(x = gene_name, y = prob_mean, ymin = prob_L,
                    ymax = prob_H, col = condition),
                width = 0.1, position = position_dodge(width = 0.4))+
  geom_point(aes(x = gene_name, y = prob_mean, col = condition), size = 1,
             position = position_dodge(width = 0.4))+
  theme_bw(base_size = 11)+
  theme(legend.position = "top")+
  ylab(label = "GU [probability]")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.4))

stats <- M$dgu
stats <- stats[order(abs(stats$es_mean), decreasing = FALSE), ]
stats$gene_fac <- factor(x = stats$gene_name, levels = unique(stats$gene_name))

g2 <- ggplot(data = stats)+
  facet_wrap(facets = ~contrast)+
  geom_hline(yintercept = 0, linetype = "dashed", col = "gray")+
  geom_errorbar(aes(x = pmax, y = es_mean, ymin = es_L, ymax = es_H),
                col = "darkgray")+
  geom_point(aes(x = pmax, y = es_mean, col = contrast))+
  geom_text_repel(data = stats[stats$pmax >= 0.95, ],
                  aes(x = pmax, y = es_mean, label = gene_fac),
                  min.segment.length = 0, size = 2.75)+
  theme_bw(base_size = 11)+
  theme(legend.position = "top")+
  xlab(label = expression(pi))+
  xlim(c(0, 1))+
  ylab(expression(gamma))
```

```
(g1/g2)
```

![](data:image/png;base64...)

# 7 Session

```
sessionInfo()
```

```
FALSE R version 4.5.1 Patched (2025-08-23 r88802)
FALSE Platform: x86_64-pc-linux-gnu
FALSE Running under: Ubuntu 24.04.3 LTS
FALSE
FALSE Matrix products: default
FALSE BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
FALSE LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
FALSE
FALSE locale:
FALSE  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
FALSE  [3] LC_TIME=en_GB              LC_COLLATE=C
FALSE  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
FALSE  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
FALSE  [9] LC_ADDRESS=C               LC_TELEPHONE=C
FALSE [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
FALSE
FALSE time zone: America/New_York
FALSE tzcode source: system (glibc)
FALSE
FALSE attached base packages:
FALSE [1] stats     graphics  grDevices utils     datasets  methods   base
FALSE
FALSE other attached packages:
FALSE  [1] patchwork_1.3.2     reshape2_1.4.4      ggrepel_0.9.6
FALSE  [4] ggforce_0.5.0       ggplot2_4.0.0       knitr_1.50
FALSE  [7] rstan_2.32.7        StanHeaders_2.32.10 IgGeneUsage_1.24.0
FALSE [10] BiocStyle_2.38.0
FALSE
FALSE loaded via a namespace (and not attached):
FALSE  [1] SummarizedExperiment_1.40.0 gtable_0.3.6
FALSE  [3] xfun_0.53                   bslib_0.9.0
FALSE  [5] QuickJSR_1.8.1              inline_0.3.21
FALSE  [7] Biobase_2.70.0              lattice_0.22-7
FALSE  [9] vctrs_0.6.5                 tools_4.5.1
FALSE [11] generics_0.1.4              stats4_4.5.1
FALSE [13] curl_7.0.0                  parallel_4.5.1
FALSE [15] tibble_3.3.0                pkgconfig_2.0.3
FALSE [17] Matrix_1.7-4                RColorBrewer_1.1-3
FALSE [19] S7_0.2.0                    S4Vectors_0.48.0
FALSE [21] RcppParallel_5.1.11-1       lifecycle_1.0.4
FALSE [23] compiler_4.5.1              farver_2.1.2
FALSE [25] stringr_1.5.2               tinytex_0.57
FALSE [27] Seqinfo_1.0.0               codetools_0.2-20
FALSE [29] htmltools_0.5.8.1           sass_0.4.10
FALSE [31] yaml_2.3.10                 pillar_1.11.1
FALSE [33] jquerylib_0.1.4             tidyr_1.3.1
FALSE [35] MASS_7.3-65                 DelayedArray_0.36.0
FALSE [37] cachem_1.1.0                magick_2.9.0
FALSE [39] abind_1.4-8                 tidyselect_1.2.1
FALSE [41] digest_0.6.37               stringi_1.8.7
FALSE [43] dplyr_1.1.4                 purrr_1.1.0
FALSE [45] bookdown_0.45               labeling_0.4.3
FALSE [47] polyclip_1.10-7             fastmap_1.2.0
FALSE [49] grid_4.5.1                  cli_3.6.5
FALSE [51] SparseArray_1.10.0          magrittr_2.0.4
FALSE [53] loo_2.8.0                   S4Arrays_1.10.0
FALSE [55] dichromat_2.0-0.1           pkgbuild_1.4.8
FALSE [57] withr_3.0.2                 scales_1.4.0
FALSE [59] rmarkdown_2.30              XVector_0.50.0
FALSE [61] matrixStats_1.5.0           gridExtra_2.3
FALSE [63] evaluate_1.0.5              GenomicRanges_1.62.0
FALSE [65] IRanges_2.44.0              V8_8.0.1
FALSE [67] rstantools_2.5.0            rlang_1.1.6
FALSE [69] Rcpp_1.1.0                  glue_1.8.0
FALSE [71] tweenr_2.0.3                BiocManager_1.30.26
FALSE [73] BiocGenerics_0.56.0         jsonlite_2.0.0
FALSE [75] R6_2.6.1                    plyr_1.8.9
FALSE [77] MatrixGenerics_1.22.0
```