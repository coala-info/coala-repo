---
name: bioconductor-raresim
description: RAREsim estimates the expected number of rare variants and their frequency spectrum to match real-world sequencing data for genetic simulations. Use when user asks to estimate variant density, calculate allele frequency spectrum proportions, or determine expected variant counts for specific ancestry populations.
homepage: https://bioconductor.org/packages/release/bioc/html/RAREsim.html
---

# bioconductor-raresim

## Overview
RAREsim is an R package designed to estimate the expected number of rare variants in specific Minor Allele Count (MAC) bins. It serves as the parameter-estimation step (Step 2) in a larger simulation workflow. It allows users to match the variant density and frequency spectrum of real-world sequencing data (like gnomAD) by either using pre-defined ancestry parameters or fitting functions to custom target data.

## Core Workflow

### 1. Estimate Number of Variants (nvariant)
This step calculates the expected number of variants per Kb for a given sample size $N$.

*   **Using Default Ancestry Parameters:**
    Supported populations: `'AFR'`, `'EAS'`, `'NFE'`, `'SAS'`.
    ```r
    library(RAREsim)
    # Estimate variants per Kb for 5000 African ancestry individuals
    nv_per_kb <- nvariant(N = 5000, pop = 'AFR')
    ```
*   **Fitting Custom Target Data:**
    Requires a data frame with columns `n` (sample size) and `per_kb` (variants per Kb).
    ```r
    # Fit parameters phi and omega
    params <- fit_nvariant(my_target_data)
    # Calculate for specific N
    nv_per_kb <- nvariant(phi = params$phi, omega = params$omega, N = 5000)
    ```

### 2. Estimate Allele Frequency Spectrum (AFS)
This step calculates the proportion of variants that fall into specific MAC bins.

*   **Define MAC Bins:**
    Create a data frame with `Lower` and `Upper` boundaries.
    ```r
    # Example bins for N > 3500
    mac_bins <- data.frame(Lower = c(1, 2, 3, 6, 11, 21), 
                           Upper = c(1, 2, 5, 10, 20, 100))
    ```
*   **Calculate Proportions:**
    ```r
    # Using defaults
    prob_bins <- afs(mac_bins = mac_bins, pop = 'AFR')
    
    # Fitting target data (requires 'Prop' column in target)
    af_fit <- fit_afs(Observed_bin_props = my_afs_target_data)
    prob_bins <- af_fit$Fitted_results
    ```

### 3. Calculate Expected Variants
Combine the total variant count with the AFS proportions to get the final counts needed for pruning.

```r
# Calculate total variants for a 20kb region
total_vars <- 20 * nv_per_kb

# Get final counts per bin
final_estimates <- expected_variants(Total_num_var = total_vars, 
                                     mac_bin_prop = prob_bins)
```

## Implementation Tips
*   **Region Size:** The `nvariant` function returns variants *per Kb*. Always multiply this result by the length of your simulation region in kilobases to get the `Total_num_var`.
*   **Sample Size Constraints:** 
    *   For $N > 3500$, use standard MAC bins.
    *   For $2000 < N < 3500$, use adjusted bins (e.g., capping at MAF 0.25% or 0.5%).
    *   For $N < 2000$, it is recommended to simulate 2000 individuals and downsample.
*   **Pruning:** The output of `expected_variants()` is intended to be used as the target distribution for pruning simulated haplotypes (Step 3 of the RAREsim pipeline).

## Reference documentation
- [RAREsim Vignette](./references/RAREsim_Vignette.md)