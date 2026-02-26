# iucn_sim CWL Generation Report

## iucn_sim_get_iucn_data

### Tool Description
Download IUCN data for future simulations

### Metadata
- **Docker Image**: quay.io/biocontainers/iucn_sim:2.2.0--pyr40_0
- **Homepage**: https://github.com/tobiashofmann88/iucn_extinction_simulator
- **Package**: https://anaconda.org/channels/bioconda/packages/iucn_sim/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/iucn_sim/overview
- **Total Downloads**: 26.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tobiashofmann88/iucn_extinction_simulator
- **Stars**: N/A
### Original Help Text
```text
usage: iucn_sim get_iucn_data [-h] [--reference_group taxon-group]
                              [--reference_rank rank]
                              [--target_species_list <path>] --outdir <path>
                              [--iucn_key <IUCN-key>] [--no_online_sync]

Download IUCN data for future simulations Created on Thu Apr 9 12:05:39 2020
@author: Tobias Andermann (tobias.andermann@bioenv.gu.se)

optional arguments:
  -h, --help            show this help message and exit
  --reference_group taxon-group
                        Name of taxonomic group (or list of groups) to be used
                        for calculating status transition rates (e.g.
                        'Mammalia' or 'Rodentia,Chiroptera'). Alternatively
                        provide path to text file containing a list of species
                        names, compatible with IUCN taxonomy (>1000 species
                        recommended). If none provided, the target species
                        list ('--target_species_list') will be used for
                        calculating transition rates. Tip: Use precompiled
                        group for faster processing and in case you don't have
                        an IUCN key (see available groups at github.com/tobias
                        hofmann88/iucn_extinction_simulator/data/precompiled/i
                        ucn_history/ or request specific groups to be added:
                        tobias.andermann@bioenv.gu.se)
  --reference_rank rank
                        Provide the taxonomic rank of the provided reference
                        group(s). E.g. in case of 'Mammalia', provide 'class'
                        for this flag, in case of 'Rodentia,Chiroptera'
                        provide 'order,order'. Has to be at least 'Family' or
                        above. This flag is not needed if species list is
                        provided as reference_group or if reference group is
                        already pre-compiled.
  --target_species_list <path>
                        File containing the list of species that you want to
                        simulate future extinctions for. In case you have
                        generation length (GL) data available, provide the
                        file containing the GL data for each species here
                        (including the species names). This function will
                        output one central data file for downstream processing
                        that contains the current status information as well
                        as the GL data (if available) for each species. You
                        can provide multiple GL values for each species, e.g.
                        several randomely sampled values from the GL
                        uncertainty interval of a given species. Set this flag
                        to 0 if you want to supress downloading of current
                        status information, e.g. if you already have current
                        status information for your species (may be necessary
                        if you don't have a valid IUCN key). Set to 1 if you
                        want to use the same taxa that are present in the
                        reference group. See https://github.com/tobiashofmann8
                        8/iucn_extinction_simulator/data/precompiled/ for
                        examples of the format of GL data input files and the
                        format of the output file conataining current status
                        information.
  --outdir <path>       Provide path to outdir where results will be saved.
  --iucn_key <IUCN-key>
                        Provide your IUCN API key (see
                        https://apiv3.iucnredlist.org/api/v3/token) for
                        downloading IUCN history of your provided reference
                        group. Not required if using precompiled reference
                        group and a manually compiled current status list (to
                        be used in the 'transition_rates' function). Also not
                        required if all species in your target_species_list
                        are present in the precompiled reference_group).
  --no_online_sync      Turn off the online-search for precompiled IUCN
                        history files for your reference group.
```


## iucn_sim_transition_rates

### Tool Description
MCMC-estimation of status transition rates from IUCN record

### Metadata
- **Docker Image**: quay.io/biocontainers/iucn_sim:2.2.0--pyr40_0
- **Homepage**: https://github.com/tobiashofmann88/iucn_extinction_simulator
- **Package**: https://anaconda.org/channels/bioconda/packages/iucn_sim/overview
- **Validation**: PASS

### Original Help Text
```text
usage: iucn_sim transition_rates [-h] --species_data <path> --iucn_history
                                 <path> --outdir <path>
                                 [--extinction_probs_mode N]
                                 [--possibly_extinct_list <path>]
                                 [--species_specific_regression]
                                 [--rate_samples N] [--n_gen N] [--burnin N]
                                 [--seed SEED]

MCMC-estimation of status transition rates from IUCN record Created on Mon Oct
28 14:43:44 2019 @author: Tobias Andermann (tobias.andermann@bioenv.gu.se)

optional arguments:
  -h, --help            show this help message and exit
  --species_data <path>
                        File containing species list and current IUCN status
                        of species, as well as generation length (GL) data
                        estimates if available. GL data is only used for '--
                        extinction_probs_mode 0' ('species_data.txt' output
                        from get_iucn_data function).
  --iucn_history <path>
                        File containing IUCN history of the reference group
                        for transition rate estimation ('*_iucn_history.txt'
                        output of get_iucn_data function).
  --outdir <path>       Provide path to outdir where results will be saved.
  --extinction_probs_mode N
                        Set to '0' to use the critE EX mode to determine
                        extinction probabilities for each status (e.g. Mooers
                        et al, 2008 approach). Set to '1' to use empirical EX
                        mode, based on the recorded extinction in the IUCN
                        history of the reference group (e.g. Monroe et al,
                        2019 approach). GL data can only be used in the critE
                        EX mode ('0').
  --possibly_extinct_list <path>
                        File containing list of taxa that are likely extinct,
                        but that are listed as extant in IUCN, including the
                        year of their assessment as possibly extinct
                        ('possibly_extinct_reference_taxa.txt' output from
                        get_iucn_data function). These species will then be
                        modeled as extinct by the esimate_rates function,
                        which will effect the estimated extinction
                        probabilities when chosing `--extinction_probs_mode 1`
  --species_specific_regression
                        Enables species-specific regression fitting to model
                        LC, NT, and VU extinction probabilities. Only
                        applicable with --extinction_probs_mode 0 (critE mode)
                        and if GL is provided.
  --rate_samples N      How many rates to sample from the posterior transition
                        rate estimates. These rates will be used to populate
                        transition rate q-matrices for downstream simulations.
                        Later on you can still chose to run more simulation
                        replicates than the here specified number of produced
                        transition rate q-matrices, in which case the
                        `run_sim` function will randomely resample from the
                        available q-matrices (default=100, this is ususally
                        sufficient, larger numbers can lead to very high
                        output file size volumes).
  --n_gen N             Number of generations for MCMC for transition rate
                        estimation (default=100000).
  --burnin N            Burn-in for MCMC for transition rate estimation
                        (default=1000).
  --seed SEED           Set starting seed for the MCMC.
```


## iucn_sim_run_sim

### Tool Description
Run future simulations based on IUCN data and status transition rates

### Metadata
- **Docker Image**: quay.io/biocontainers/iucn_sim:2.2.0--pyr40_0
- **Homepage**: https://github.com/tobiashofmann88/iucn_extinction_simulator
- **Package**: https://anaconda.org/channels/bioconda/packages/iucn_sim/overview
- **Validation**: PASS

### Original Help Text
```text
usage: iucn_sim run_sim [-h] --input_data INPUT_DATA --outdir OUTDIR
                        [--n_years N_YEARS] [--n_sim N_SIM]
                        [--status_change STATUS_CHANGE]
                        [--conservation_increase_factor CONSERVATION_INCREASE_FACTOR]
                        [--threat_increase_factor THREAT_INCREASE_FACTOR]
                        [--model_unknown_as_lc MODEL_UNKNOWN_AS_LC]
                        [--until_n_taxa_extinct UNTIL_N_TAXA_EXTINCT]
                        [--extinction_rates EXTINCTION_RATES] [--n_gen N_GEN]
                        [--burnin BURNIN]
                        [--plot_diversity_trajectory PLOT_DIVERSITY_TRAJECTORY]
                        [--plot_status_trajectories PLOT_STATUS_TRAJECTORIES]
                        [--plot_histograms PLOT_HISTOGRAMS]
                        [--plot_posterior PLOT_POSTERIOR]
                        [--plot_status_piechart PLOT_STATUS_PIECHART]
                        [--seed SEED]

Run future simulations based on IUCN data and status transition rates Created
on Wed Oct 30 20:59:28 2019 @author: Tobias Andermann
(tobias.andermann@bioenv.gu.se)

optional arguments:
  -h, --help            show this help message and exit
  --input_data INPUT_DATA
                        Path to 'simulation_input_data.pkl' file created by
                        esimate_rates function.
  --outdir OUTDIR       Provide path to outdir where results will be saved.
  --n_years N_YEARS     How many years to simulate into the future.
  --n_sim N_SIM         How many simulation replicates to run. At least 10,000
                        simulations are recommended for accurate rate
                        estimation (default). If the number of simulation
                        replicates exceeds the number of available transition
                        rate estimates (produced by the 'transition_rates'
                        function), these rates will be randomely resampled for
                        the remaining simulations.
  --status_change STATUS_CHANGE
                        Model IUCN status changes in future simulations.
                        0=off, 1=on (default=1).
  --conservation_increase_factor CONSERVATION_INCREASE_FACTOR
                        The transition rates leading to improvements in IUCN
                        conservation status are multiplied by this factor.
  --threat_increase_factor THREAT_INCREASE_FACTOR
                        Opposite of conservation_increase_factor, multiplies
                        the transition rates leading to worsening in IUCN
                        conservation status.
  --model_unknown_as_lc MODEL_UNKNOWN_AS_LC
                        Model new status for all DD and NE species as LC (best
                        case scenario). 0=off, 1=on (default=0).
  --until_n_taxa_extinct UNTIL_N_TAXA_EXTINCT
                        Setting this value will stop the simulations when n
                        taxa have gone extinct. This can be used to simulate
                        the expected time until n extinctions. The value of
                        the --n_years flag in this case will be interpreted as
                        the maximum possible time frame, so set it large
                        enough to cover a realistic time-frame for these
                        extinctions to occur. Set to 0 to disable this
                        function (default=0).
  --extinction_rates EXTINCTION_RATES
                        Estimation of extinction rates from simulation
                        results: 0=off, 1=on (default=1).
  --n_gen N_GEN         Number of generations for MCMC for extinction rate
                        estimation (default=100000).
  --burnin BURNIN       Burn-in for MCMC for extinction rate estimation
                        (default=1000).
  --plot_diversity_trajectory PLOT_DIVERSITY_TRAJECTORY
                        Plots the simulated diversity trajectory: 0=off, 1=on
                        (default=1).
  --plot_status_trajectories PLOT_STATUS_TRAJECTORIES
                        Plots the simulated IUCN status trajectory: 0=off,
                        1=on (default=0).
  --plot_histograms PLOT_HISTOGRAMS
                        Plots histograms of simulated extinction times for
                        each species: 0=off, 1=on (default=0).
  --plot_posterior PLOT_POSTERIOR
                        Plots histograms of posterior rate estimates for each
                        species: 0=off, 1=on (default=0).
  --plot_status_piechart PLOT_STATUS_PIECHART
                        Plots pie charts of status distribution: 0=off, 1=on
                        (default=1).
  --seed SEED           Set starting seed for future simulations.
```

