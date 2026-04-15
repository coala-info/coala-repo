---
name: treesimulator
description: The treesimulator tool generates phylogenetic trees representing pathogen transmission history within a population. Use when user asks to 'model pathogen outbreaks', 'simulate standard, exposed-infectious, or superspreading scenarios', 'incorporate contact tracing', 'simulate time-varying transmission parameters', 'test phylodynamic inference methods', or 'predict public health intervention impacts'.
homepage: https://github.com/evolbioinfo/treesimulator
metadata:
  docker_image: "quay.io/biocontainers/treesimulator:0.2.27--pyhdfd78af_0"
---

# treesimulator

## Overview

The `treesimulator` tool generates phylogenetic trees that represent the transmission history of a pathogen within a population. By utilizing Multitype Birth–Death (MTBD) frameworks, it allows users to define complex infection states and transition rates. This skill provides guidance on configuring these models—ranging from simple single-state outbreaks to multi-state scenarios with incubation periods (BDEI) or transmission heterogeneity (BDSS). It is particularly valuable for testing phylodynamic inference methods or predicting the impact of public health interventions like contact tracing.

## Installation

Install the tool via Bioconda:
```bash
conda install bioconda::treesimulator
```

## Core Model Configuration

### 1. Standard Birth-Death (BD)
The simplest model with one infectious state (I).
- **Transmission rate ($\lambda$):** The rate at which an infected individual infects others.
- **Removal rate ($\psi$):** The rate at which an individual stops being infectious (recovery or death).
- **Sampling probability ($p$):** The probability that an individual is sampled upon removal.

### 2. Exposed-Infectious (BDEI)
Adds an "Exposed" (E) state to model the incubation period.
- **Transition rate ($\mu_{EI}$):** The rate of moving from Exposed to Infectious.
- **Incubation period:** Calculated as $1/\mu_{EI}$.
- **Total infection time:** $1/\mu_{EI} + 1/\psi_I$.

### 3. Superspreading (BDSS)
Models heterogeneity using two infectious states: Standard (I) and Superspreader (S).
- Requires a transmission matrix defining rates between states (e.g., $I \to I$, $I \to S$, $S \to I$, $S \to S$).
- Note the constraint: $\lambda_{SS} / \lambda_{IS} = \lambda_{SI} / \lambda_{II}$.

## Contact Tracing (CT) Extensions

Contact tracing can be added to any MTBD model by appending `-CT` to the model type. This adds "notified" versions of existing states (e.g., $I_C$ for a notified infectious contact).

- **Notification Probability ($\upsilon$):** The probability of notifying a contact.
- **Removal Speed-up ($X_C$):** A multiplier ($X_C \gg 1$) that increases the removal rate of notified individuals.
- **Sampling Speed-up ($X_p$):** A multiplier that increases the sampling probability of notified individuals.
- **Notification Timing:** Use `--notify_at_removal` to trigger notifications when an individual becomes non-infectious, rather than at the moment of sampling.
- **Capacity ($\kappa$):** Defines the maximum number of recent contacts an index case can notify.

## Skyline (Time-Varying) Parameters

To simulate changes in transmission (e.g., due to lockdown or seasonal effects), use the Skyline feature.
- **Model Change Times ($T_1, \dots, T_{k-1}$):** Specify the times at which parameters shift.
- **Piece-wise Constants:** Provide a set of parameters for each interval. All intervals must share the same state definitions.

## CLI Best Practices

- **Matrix Input:** For MTBD models with $m$ states, prepare an $m \times m$ matrix for transition rates ($\mu_{ij}$) where diagonal elements $\mu_{ii}$ must be 0.
- **Termination Conditions:** By default, the simulator runs until a specific condition is met. Ensure you define limits for the number of tips or the time duration to avoid infinite loops in sub-critical scenarios ($R < 1$).
- **Random Seeds:** Always provide a random seed for reproducibility when generating datasets for benchmarking.
- **Full Tree Output:** Use the option to save the "full" tree (including unsampled lineages) if you need to analyze the complete transmission chain rather than just the reconstructed phylogeny.

## Reference documentation
- [github_com_evolbioinfo_treesimulator.md](./references/github_com_evolbioinfo_treesimulator.md)
- [anaconda_org_channels_bioconda_packages_treesimulator_overview.md](./references/anaconda_org_channels_bioconda_packages_treesimulator_overview.md)