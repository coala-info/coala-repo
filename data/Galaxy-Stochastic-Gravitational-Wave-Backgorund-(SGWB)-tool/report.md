# Stochastic Gravitational Wave Backgorund (SGWB) tool CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://eurosciencegateway.eu/
- **Package**: https://workflowhub.eu/workflows/815
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/815/ro_crate?version=2
- **Conda**: N/A
- **Total Downloads**: 1.1K
- **Last updated**: 2024-04-18
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 2
- **License**: CC-BY-4.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Stochastic_Gravitational_Wave_Backgorund_(SGWB)_tool.ga` (Main Workflow)
- **Project**: EuroScienceGateway
- **Views**: 6306
- **Creators**: Andrii Neronov, Théo Boyer, Denys Savchenko, Volodymyr Savchenko

## Description

The tool provides a calculation of the power spectrum of Stochastic Gravitational Wave Backgorund (SGWB) from a first-order cosmological phase transition based on the parameterisations of Roper Pol et al. (2023). The power spectrum includes two components: from the sound waves excited by collisions of bubbles of the new phase and from the turbulence that is induced by these collisions.

The cosmological epoch of the phase transition is described by the temperature, T_star and by the number(s) of relativistic degrees of freedom, g_star that should be specified as parameters.

The phase transition itself is characterised by phenomenological parameters, alpha, beta_H and epsilon_turb, the latent heat, the ratio of the Hubble radius to the bubble size at percolation and the fraction of the energy otuput of the phase transition that goes into turbulence.

The product Model spectrum outputs the power spectrum for fixed values of these parameters. The product Phase transition parameters reproduces the constraints on the phase transition parameters from the Pulsar Timing Array gravitational wave detectors, reported by Boyer & Neronov (2024), including the estimate of the cosmological magnetic field induced by turbulence.
