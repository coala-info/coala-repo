---
name: r-grain
description: R package grain (documentation from project home).
homepage: https://cran.r-project.org/web/packages/grain/index.html
---

# r-grain

## Overview
The `gRain` package is a specialized R tool for probability propagation in graphical independence networks, commonly known as Bayesian Networks. It is built on the `gRbase` framework and focuses on discrete variables with finite state spaces. Key capabilities include building networks from CPTs or data, incorporating evidence (including virtual/likelihood evidence), and calculating marginal distributions.

## Installation
To install the stable version from CRAN:
```R
install.packages("gRain")
# It is often necessary to install gRbase as well
install.packages("gRbase")
```

## Core Workflow

### 1. Defining the Network
Networks are typically constructed by defining Conditional Probability Tables (CPTs) for each node.

```R
library(gRain)

# Define states
yn <- c("yes", "no")

# Specify CPTs
a <- cptable(~asia, values=c(1, 99), levels=yn)
t <- cptable(~tub|asia, values=c(5, 95, 1, 99), levels=yn)
s <- cptable(~smoke, values=c(5, 5), levels=yn)
# ... define other nodes ...

# Compile the network
plist <- compileCPT(list(a, t, s))
net <- grain(plist)
```

### 2. Compiling and Triangulating
Before querying, the network must be compiled (which involves moralization and triangulation of the underlying graph).
```R
# Compilation happens automatically in grain(), but can be explicit
net_compiled <- compile(net)
```

### 3. Setting Evidence
Evidence represents observed states of variables. `gRain` supports both hard evidence (exact state) and virtual/likelihood evidence.

```R
# Set hard evidence
net_ev <- setEvidence(net_compiled, nodes=c("asia", "smoke"), states=c("yes", "no"))

# Set virtual (likelihood) evidence
# Example: 5 times more likely to be 'yes' than 'no'
net_virt <- setEvidence(net_compiled, nodes="asia", evidence=list(asia=c(5, 1)))
```

### 4. Querying the Network
Extract marginal probabilities for nodes given the current evidence.

```R
# Query marginals for specific nodes
querygrain(net_ev, nodes=c("tub", "lung"), type="marginal")

# Get the joint distribution
querygrain(net_ev, nodes=c("tub", "lung"), type="joint")
```

## Key Functions
- `cptable()`: Create conditional probability tables.
- `grain()`: Create a graphical independence network object.
- `compile()`: Prepare the network for propagation (triangulation and junction tree construction).
- `propagate()`: Manually trigger probability propagation.
- `setEvidence()`: Add observations to the model.
- `retractEvidence()`: Remove observations.
- `querygrain()`: Extract probabilities from the network.
- `simulate()`: Generate random samples from the network.

## Tips for Large Networks
- For very large networks, ensure `gRbase` is updated to the latest version for efficient graph manipulation.
- Use `type="conditional"` in `querygrain()` to get conditional distributions efficiently.
- If memory is an issue, check the triangulation of the graph; a poor triangulation leads to large cliques in the junction tree.

## Reference documentation
- [gRain Project Home](./references/home_page.md)