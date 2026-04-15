---
name: evofr
description: evofr is a Python framework for analyzing evolutionary dynamics and estimating the relative fitness of genetic variants using Bayesian inference. Use when user asks to estimate growth advantages, fit multinomial logistic regression models to sequence counts, or forecast viral lineage frequencies.
homepage: https://github.com/blab/evofr
metadata:
  docker_image: "quay.io/biocontainers/evofr:0.2.0--pyhdfd78af_0"
---

# evofr

## Overview
`evofr` is a specialized Python framework for analyzing the evolutionary dynamics of genetic variants. It provides a structured workflow for processing sequence count data, fitting multinomial logistic regression (MLR) or renewal models using Bayesian inference (via JAX and NumPyro), and generating forecasts. It is particularly effective for estimating relative fitness (growth advantage) between competing viral lineages or bacterial strains.

## Core Workflow

### 1. Data Specification
Use `ef.DataSpec` subclasses to format raw data for the models. The most common entry point is `VariantFrequencies`.

```python
import pandas as pd
import evofr as ef

# Load data (expects columns like 'date', 'location', 'variant', 'sequences')
raw_data = pd.read_csv("variant_counts.tsv", sep="\t")

# pivot="C" sets variant 'C' as the reference (fitness = 0)
data_spec = ef.VariantFrequencies(raw_data, pivot="C")
```

### 2. Model Selection
Choose a model based on the complexity of the evolutionary process:
*   `MultinomialLogisticRegression(tau)`: Simple fitness estimation. Requires `tau` (generation time).
*   `HierMLR`: For multi-location or hierarchical datasets.
*   `RenewalModel`: For more complex epidemiological dynamics involving case counts and transmission.

```python
# tau is the generation time used to convert relative fitness to growth advantage
model = ef.MultinomialLogisticRegression(tau=4.2)
```

### 3. Inference
`evofr` uses NumPyro for inference. `InferNUTS` (No-U-Turn Sampler) is the standard for high-quality posterior samples.

```python
# Define sampler settings
inference = ef.InferNUTS(num_samples=1000, num_warmup=1000)

# Fit the model to the data spec
posterior = inference.fit(model, data_spec)
```

### 4. Forecasting and Visualization
Post-inference, you can project frequencies forward and visualize results using the `plotting` module.

```python
# Forecast 50 days into the future
forecast_days = 50
posterior.samples = model.forecast_frequencies(posterior.samples, forecast_days)

# Plotting growth advantages
from evofr.plotting import GrowthAdvantagePlot
import matplotlib.pyplot as plt

fig, ax = plt.subplots()
GrowthAdvantagePlot(posterior).plot(ax=ax)
```

## Expert Tips
*   **Pivot Selection**: Always choose a stable, well-sampled variant as your `pivot`. The growth advantages of all other variants will be relative to this reference.
*   **Generation Time (`tau`)**: The accuracy of the "Growth Advantage" estimate depends heavily on providing a biologically realistic `tau`. If `tau` is unknown, the model still estimates relative fitness, but the scale of the growth advantage will change.
*   **Handling Results**: Use `posterior.save_posterior("results.pkl")` to serialize the `PosteriorHandler` object. This preserves both the samples and the original data spec for later analysis.
*   **SVI for Speed**: If MCMC is too slow for large datasets, use `ef.InferSVI` or `ef.InferMAP` for faster, approximate inference.



## Subcommands

| Command | Description |
|---------|-------------|
| evofr prepare-data | Prepare data for evofr analysis using a configuration file and optional overrides. |
| evofr run-model | Run an evofr model using a configuration file and optional data overrides. |

## Reference documentation
- [Getting started with evofr](./references/blab_github_io_evofr_notebooks_example_mlr.html.md)
- [evofr.data package](./references/blab_github_io_evofr_source_evofr.data.html.md)
- [evofr.models package](./references/blab_github_io_evofr_source_evofr.models.html.md)
- [evofr.plotting package](./references/blab_github_io_evofr_source_evofr.plotting.html.md)