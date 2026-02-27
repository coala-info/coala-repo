---
name: bioconductor-survcomp
description: This tool provides functions for performance assessment and comparison of risk prediction models in survival analysis. Use when user asks to compute survival metrics like the concordance index or D-index, perform meta-analysis across multiple datasets, compare model performance, or generate forest and Kaplan-Meier plots.
homepage: https://bioconductor.org/packages/release/bioc/html/survcomp.html
---


# bioconductor-survcomp

name: bioconductor-survcomp
description: Performance assessment and comparison for survival analysis. Use this skill to compute and compare survival metrics like the concordance index (C-index), D-index, and hazard ratios, perform meta-analysis across multiple datasets, and generate specialized visualizations like forest plots and Kaplan-Meier curves.

# bioconductor-survcomp

## Overview
The `survcomp` package provides a comprehensive suite of tools for evaluating and comparing risk prediction models in survival analysis. It is particularly useful for validating biomarkers or multi-gene signatures across independent datasets using meta-analytical frameworks.

## Core Workflows

### 1. Performance Metrics
Calculate standard survival performance statistics for a continuous predictor (e.g., gene expression):

*   **Concordance Index (C-index):** Measures the probability that for a pair of individuals, the one with the higher risk score fails first.
    ```r
    cindex <- concordance.index(x=predictor, surv.time=time, surv.event=event, method="noether")
    # Access estimate: cindex$c.index
    ```
*   **D-index:** Measures the prognostic separation (hazard ratio between two groups formed by the predictor).
    ```r
    dind <- D.index(x=predictor, surv.time=time, surv.event=event)
    # Access estimate: dind$d.index
    ```
*   **Hazard Ratio (HR):** Standard Cox regression-based hazard ratio.
    ```r
    hr <- hazard.ratio(x=predictor, surv.time=time, surv.event=event)
    # Access estimate: hr$hazard.ratio
    ```

### 2. Meta-Analysis
Combine estimates from multiple independent studies to get a global performance measure.

```r
# Combine multiple C-indices
global_cindex <- combine.est(x=c(study1_c, study2_c), x.se=c(study1_se, study2_se), na.rm=TRUE)

# Compare two C-indices across multiple datasets
meta_comp <- cindex.comp.meta(list.cindex1=list_of_cindices_model1, 
                              list.cindex2=list_of_cindices_model2)
```

### 3. Visualization
The package provides specialized plotting functions for survival data:

*   **Forest Plots:** Use `forestplot.surv()` to display performance estimates across different datasets or genes.
*   **Kaplan-Meier Plots:** Use `km.coxph.plot()` for high-quality survival curves with "Number at Risk" tables.
    ```r
    km.coxph.plot(formula.s=Surv(time, event) ~ group, data.s=df, 
                  x.label="Time", y.label="Probability", show.n.risk=TRUE)
    ```

## Key Functions Reference

| Function | Purpose |
| :--- | :--- |
| `concordance.index` | Computes C-index with confidence intervals. |
| `D.index` | Computes the Royston and Sauerbrei D-index. |
| `hazard.ratio` | Estimates HR for a continuous or discrete variable. |
| `cindex.comp` | Statistically compares two C-indices from the same dataset. |
| `combine.est` | Combines estimates using a fixed or random-effects model. |
| `censor.time` | Artificially censors survival data at a specific threshold (e.g., 10 years). |
| `tdrocc` | Computes time-dependent ROC curves. |

## Tips for Success
*   **Data Scaling:** When comparing Hazard Ratios across different platforms (e.g., Affymetrix vs. Agilent), rescale your predictors to a comparable range (e.g., [-1, 1]) using a robust scaler to ensure HRs are interpretable.
*   **Censoring:** Use `censor.time()` to standardize follow-up times across datasets before meta-analysis to avoid bias from varying study lengths.
*   **Method Selection:** For `concordance.index`, the "noether" method is generally preferred for calculating standard errors.

## Reference documentation
- [survcomp: a package for performance assessment and comparison for survival analysis](./references/survcomp.md)