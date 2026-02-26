# physiofit4galaxy CWL Generation Report

## physiofit4galaxy

### Tool Description
Extracellular flux estimation software

### Metadata
- **Docker Image**: quay.io/biocontainers/physiofit4galaxy:2.2.1--pyhdfd78af_1
- **Homepage**: https://github.com/MetaSys-LISBP/PhysioFit4Galaxy
- **Package**: https://anaconda.org/channels/bioconda/packages/physiofit4galaxy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/physiofit4galaxy/overview
- **Total Downloads**: 5.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/MetaSys-LISBP/PhysioFit4Galaxy
- **Stars**: N/A
### Original Help Text
```text
usage: Physiofit: Extracellular flux estimation software [-h] [-t DATA]
                                                         [-c CONFIG] [-l]
                                                         [-d DEG]
                                                         [-mc MONTECARLO]
                                                         [-i VINI] [-s SD]
                                                         [-cm CONC_MET_BOUNDS]
                                                         [-fm FLUX_MET_BOUNDS]
                                                         [-cb CONC_BIOM_BOUNDS]
                                                         [-fb FLUX_BIOM_BOUNDS]
                                                         [-g] [-v]
                                                         [-op OUTPUT_PDF]
                                                         [-of OUTPUT_FLUXES]
                                                         [-os OUTPUT_STATS]
                                                         [-oc OUTPUT_CONFIG]

options:
  -h, --help            show this help message and exit
  -t DATA, --data DATA  Path to data file in tabulated format (txt or tsv)
  -c CONFIG, --config CONFIG
                        Path to config file in json format
  -l, --lag             Should lag phase be estimated. Add for True
  -d DEG, --deg DEG     Should degradation constants be taken into
                        consideration. Add for True. Constants should then be
                        given in dictionary format
  -mc MONTECARLO, --montecarlo MONTECARLO
                        Should sensitivity analysis be performed. Number of
                        iterations should be given as an integer
  -i VINI, --vini VINI  Select an initial value for fluxes to estimate
  -s SD, --sd SD        Standard deviation on measurements. Give sds in
                        dictionary format
  -cm CONC_MET_BOUNDS, --conc_met_bounds CONC_MET_BOUNDS
                        Bounds on initial metabolite concentrations. Give
                        bounds as a tuple.
  -fm FLUX_MET_BOUNDS, --flux_met_bounds FLUX_MET_BOUNDS
                        Bounds on initial metabolite fluxes. Give bounds as a
                        tuple.
  -cb CONC_BIOM_BOUNDS, --conc_biom_bounds CONC_BIOM_BOUNDS
                        Bounds on initial biomass concentrations.Give bounds
                        as a tuple.
  -fb FLUX_BIOM_BOUNDS, --flux_biom_bounds FLUX_BIOM_BOUNDS
                        Bounds on initial biomass fluxes. Give bounds as a
                        tuple.
  -g, --galaxy          Is the CLI being used on the galaxy platform
  -v, --debug_mode      Activate the debug logs
  -op OUTPUT_PDF, --output_pdf OUTPUT_PDF
                        Path to output the pdf file containing plots
  -of OUTPUT_FLUXES, --output_fluxes OUTPUT_FLUXES
                        Path to output the flux results
  -os OUTPUT_STATS, --output_stats OUTPUT_STATS
                        Path to output the khi² test
  -oc OUTPUT_CONFIG, --output_config OUTPUT_CONFIG
                        Path to output the json config file
```


## Metadata
- **Skill**: generated

## physiofit4galaxy

### Tool Description
Extracellular flux estimation software

### Metadata
- **Docker Image**: quay.io/biocontainers/physiofit4galaxy:2.2.1--pyhdfd78af_1
- **Homepage**: https://github.com/MetaSys-LISBP/PhysioFit4Galaxy
- **Package**: https://anaconda.org/channels/bioconda/packages/physiofit4galaxy/overview
- **Validation**: PASS
### Original Help Text
```text
usage: Physiofit: Extracellular flux estimation software [-h] [-t DATA]
                                                         [-c CONFIG] [-l]
                                                         [-d DEG]
                                                         [-mc MONTECARLO]
                                                         [-i VINI] [-s SD]
                                                         [-cm CONC_MET_BOUNDS]
                                                         [-fm FLUX_MET_BOUNDS]
                                                         [-cb CONC_BIOM_BOUNDS]
                                                         [-fb FLUX_BIOM_BOUNDS]
                                                         [-g] [-v]
                                                         [-op OUTPUT_PDF]
                                                         [-of OUTPUT_FLUXES]
                                                         [-os OUTPUT_STATS]
                                                         [-oc OUTPUT_CONFIG]

options:
  -h, --help            show this help message and exit
  -t DATA, --data DATA  Path to data file in tabulated format (txt or tsv)
  -c CONFIG, --config CONFIG
                        Path to config file in json format
  -l, --lag             Should lag phase be estimated. Add for True
  -d DEG, --deg DEG     Should degradation constants be taken into
                        consideration. Add for True. Constants should then be
                        given in dictionary format
  -mc MONTECARLO, --montecarlo MONTECARLO
                        Should sensitivity analysis be performed. Number of
                        iterations should be given as an integer
  -i VINI, --vini VINI  Select an initial value for fluxes to estimate
  -s SD, --sd SD        Standard deviation on measurements. Give sds in
                        dictionary format
  -cm CONC_MET_BOUNDS, --conc_met_bounds CONC_MET_BOUNDS
                        Bounds on initial metabolite concentrations. Give
                        bounds as a tuple.
  -fm FLUX_MET_BOUNDS, --flux_met_bounds FLUX_MET_BOUNDS
                        Bounds on initial metabolite fluxes. Give bounds as a
                        tuple.
  -cb CONC_BIOM_BOUNDS, --conc_biom_bounds CONC_BIOM_BOUNDS
                        Bounds on initial biomass concentrations.Give bounds
                        as a tuple.
  -fb FLUX_BIOM_BOUNDS, --flux_biom_bounds FLUX_BIOM_BOUNDS
                        Bounds on initial biomass fluxes. Give bounds as a
                        tuple.
  -g, --galaxy          Is the CLI being used on the galaxy platform
  -v, --debug_mode      Activate the debug logs
  -op OUTPUT_PDF, --output_pdf OUTPUT_PDF
                        Path to output the pdf file containing plots
  -of OUTPUT_FLUXES, --output_fluxes OUTPUT_FLUXES
                        Path to output the flux results
  -os OUTPUT_STATS, --output_stats OUTPUT_STATS
                        Path to output the khi² test
  -oc OUTPUT_CONFIG, --output_config OUTPUT_CONFIG
                        Path to output the json config file
```

