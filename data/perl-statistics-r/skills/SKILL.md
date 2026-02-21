---
name: perl-statistics-r
description: The `perl-statistics-r` skill (based on the `PDL::Stats` module) transforms the Perl Data Language shell into a lightweight statistical environment similar to R.
homepage: https://github.com/PDLPorters/PDL-Stats
---

# perl-statistics-r

## Overview

The `perl-statistics-r` skill (based on the `PDL::Stats` module) transforms the Perl Data Language shell into a lightweight statistical environment similar to R. It provides a suite of modules for common statistical procedures including the General Linear Model (GLM), Principal Component Analysis (PCA), and Time Series analysis. The core advantage of this tool is its integration with PDL's broadcasting system, which allows statistical methods to be applied automatically and efficiently across arbitrary slices of large, multi-dimensional datasets without manual looping.

## Native Usage and Best Practices

### Core Modules
- **PDL::Stats::Basic**: Essential descriptive statistics and basic tests (e.g., t-tests).
- **PDL::Stats::GLM**: General Linear Models, including Ordinary Least Squares (OLS) regression and ANOVA.
- **PDL::Stats::Kmeans**: Vectorized k-means clustering.
- **PDL::Stats::TS**: Time series analysis, including Autocorrelation Function (ACF) and Autocovariance Function (ACVF).
- **PDL::Stats::Distr**: Distribution-related functions (requires PDL::GSL for p-values).

### Common CLI Patterns in the PDL Shell
When working in the `pdl>` or `perldl>` shell, use these patterns for rapid analysis:

1.  **Linear Regression (OLS)**:
    ```perl
    # Perform OLS regression
    # Note: The intercept (constant) is typically returned as the first element
    ($b, $t, $p, $sig) = $y->ols_t($x);
    ```

2.  **K-Means Clustering**:
    ```perl
    # Cluster data into 3 groups
    ($cluster_ids, $centroids) = $data->kmeans({NClust => 3});
    ```

3.  **ANOVA and Design Matrices**:
    Use `anova_design_matrix` to prepare data for complex experimental designs. Note that for 2-way repeated measures, the tool handles interaction coding and subject design-chunks automatically.

### Expert Tips
- **Broadcasting**: Most `PDL::Stats` methods support broadcasting. If you pass a 2D piddle where a 1D piddle is expected, the operation will automatically repeat across the extra dimension.
- **Bad Value Handling**: `PDL::Stats` is designed to handle "bad" (missing) values. Methods like `ols_t` explicitly account for bad values in the dataset to prevent calculation errors.
- **Plotting**: Use the built-in plotting wrappers if `PDL::Graphics::Simple` is installed:
    - `plot_means`: For visualizing ANOVA results.
    - `plot_scores`: For PCA score visualization.
    - `plot_stripchart`: For GLM data distribution.
- **Intercept Handling**: In recent versions of `PDL::Stats::GLM`, the intercept/constant is returned first in the coefficient piddle. Always verify the order if working with legacy scripts.

## Reference documentation
- [PDL-Stats Main Repository](./references/github_com_PDLPorters_PDL-Stats.md)
- [Commit History and Version Changes](./references/github_com_PDLPorters_PDL-Stats_commits_master.md)