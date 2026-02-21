---
name: nemo-age
description: The `nemo-age` tool is a specialized evolutionary simulation engine.
homepage: https://bitbucket.org/ecoevo/nemo-age-release
---

# nemo-age

## Overview
The `nemo-age` tool is a specialized evolutionary simulation engine. It allows researchers to define life tables and demographic structures to study how traits and genetic diversity evolve when populations are not simple annual or non-overlapping groups. It is particularly useful for modeling species with long life cycles or dormant stages (like seed banks) where age-specific vital rates significantly impact evolutionary trajectories.

## Usage Guidelines
- **Simulation Setup**: Define the population structure by specifying age classes and the transitions between them (e.g., survival probabilities and maturation rates).
- **Evolutionary Parameters**: Configure genetic architecture (loci, mutation rates) and phenotypic traits alongside demographic parameters to observe the interaction between life history and selection.
- **Environmental Factors**: Utilize stage-specific dispersal and fecundity settings to model spatially explicit populations or fluctuating environments.
- **Execution**: Run the simulation via the command line using a configuration file that defines the life cycle and evolutionary constraints.

## Best Practices
- **Demographic Validation**: Before running long evolutionary simulations, verify that the demographic parameters (transition matrix) lead to a stable or desired population growth rate to avoid unexpected extinction.
- **Age-Class Granularity**: Only define as many age classes as necessary for the research question to maintain computational efficiency, especially when modeling many loci.
- **Seed Banks**: When modeling seed banks, ensure the transition rate from the dormant stage back to an active stage is calibrated to the expected environmental triggers.

## Reference documentation
- [Nemo-age Overview](./references/anaconda_org_channels_bioconda_packages_nemo-age_overview.md)
- [Nemo-age Source and Documentation](./references/bitbucket_org_ecoevo_nemo-age-release.md)