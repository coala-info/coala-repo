# [DTC-AGEF] WF8103: Forecasting maximum magnitude CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://dtgeo.eu/
- **Package**: https://workflowhub.eu/workflows/1985
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1985/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 221
- **Last updated**: 2025-10-15
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: Apache-2.0
- **Workflow type**: Common Workflow Language
- **Main workflow (WorkflowHub):** `WF8103.cwl` (Main Workflow)
- **Project**: WP8 - Anthropogenic geophysical extremes
- **Views**: 607

## Description

The workflow will primarily focus on estimation of the maximum magnitude using various deterministic and statistical models available in the literature. The workflow consists of 5 steps. The first four steps belong to the CB-AGEF1 and ultimately aim at creation of the advanced seismic catalog. The last 5th step (belonging to the CBAGEF3-1) takes the available hydraulic data and advanced seismicity catalog derived in steps 1-4 and performs the actual assessment of the maximum magnitude. Step 1 is an application existing on the platform performing picking of raw waveform data. The output of the Step 1 is passed to the Step 2 (Phase Association module, in development) which gathers the picks from waveform data originating from different stations and performs the coincidence trigger. The output sets of picks are then passed to the 3rd step which performs assessment of earthquake location using the TRMLoc module already available on the EPISODES platform. The information on the location event is then passed to step 4 which uses waveform data and location data to calculate basic source parameters. Steps 1-4 are perpetually performed and provide updates to the advanced seismic catalog. The advanced seismic catalog is then used in Step 5 to perform the assessment of the maximum magnitude. Last 5th step of the workflow is its key element - an application (software module) for the EPISODES platform to compute the maximum magnitude estimates based on the variety of deterministic and probabilistic models available in the literature. The input of the application is catalog data (location, time and magnitude) and hydraulic parameters (time and injection rate). The output data include general info (index and time) of time series, computed parameters as time series (e.g. b-value and seismogenic index), maximum magnitude estimates with corresponding standard errors of estimations and other supplementary parameters (number of events, cumulative fluid injection and seismic efficiency ratio). The maximum magnitude models consist of McGarr (2014), Hallo et al. (2014), Li et al. (2022), van der Elst et al. (2016) and Shapiro et al. (2013). In any model, where the Gutenberg-Richter (GR) b-value is needed there are four possibilities: constant b-value equal to 1, maximum-likelihood estimation assuming (a) the left-hand side truncated exponential (Aki 1965) and (b) the tapered GR (Pareto) frequency-magnitude distribution (Kagan 2002) and ‘b-positive’ estimator of van der Elst (2021). The user can compute simultaneously a maximum magnitude assessment using any combination of four b-values and, for example in van der Elst model, with different confidence levels. The application is at the moment tested on the EPISODES platform and is being implemented to be an official, stand-alone application as well.
