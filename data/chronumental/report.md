# chronumental CWL Generation Report

## chronumental

### Tool Description
Convert a distance tree into time tree with distances in days.

### Metadata
- **Docker Image**: quay.io/biocontainers/chronumental:0.0.65--pyhdfd78af_0
- **Homepage**: https://github.com/theosanderson/chronumental
- **Package**: https://anaconda.org/channels/bioconda/packages/chronumental/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chronumental/overview
- **Total Downloads**: 10.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/theosanderson/chronumental
- **Stars**: N/A
### Original Help Text
```text
Chronumental 0.0.65
Platform: cpu
usage: chronumental [-h] --tree TREE --dates DATES [--dates_out DATES_OUT]
                    [--tree_out TREE_OUT]
                    [--treat_mutation_units_as_normalised_to_genome_size TREAT_MUTATION_UNITS_AS_NORMALISED_TO_GENOME_SIZE]
                    [--clock CLOCK] [--variance_dates VARIANCE_DATES]
                    [--initial_tau INITIAL_TAU] [--hs_scale HS_SCALE]
                    [--steps STEPS] [--lr LR] [--name_all_nodes]
                    [--expected_min_between_transmissions EXPECTED_MIN_BETWEEN_TRANSMISSIONS]
                    [--only_use_full_dates] [--model MODEL]
                    [--output_unit {days,years}] [--variance_on_clock_rate]
                    [--enforce_exact_clock] [--use_gpu] [--use_wandb]
                    [--wandb_project_name WANDB_PROJECT_NAME] [--clipped_adam]
                    [--reference_node REFERENCE_NODE]
                    [--always_use_final_params]

Convert a distance tree into time tree with distances in days.

options:
  -h, --help            show this help message and exit
  --tree TREE           an input newick tree, potentially gzipped, with branch
                        lengths reflecting genetic distance in integer number
                        of mutations
  --dates DATES         A metadata file with columns strain and date (in
                        "2020-01-02" format, or less precisely, "2021-01",
                        "2021")
  --dates_out DATES_OUT
                        Output for date tsv (otherwise will use default)
  --tree_out TREE_OUT   Output for tree (otherwise will use default)
  --treat_mutation_units_as_normalised_to_genome_size TREAT_MUTATION_UNITS_AS_NORMALISED_TO_GENOME_SIZE
                        If your branch sizes, and mutation rate, are
                        normalised to per-site values, then enter the genome
                        size here.
  --clock CLOCK         Molecular clock rate. This should be in units of
                        something per year, where the "something" is the units
                        on the tree. If not given we will attempt to estimate
                        this by RTT. This is only used as a starting point,
                        unless you supply --enforce_exact_clock.
  --variance_dates VARIANCE_DATES
                        Scale factor for date distribution. Essentially a
                        measure of how uncertain we think the measured dates
                        are.
  --initial_tau INITIAL_TAU
                        Initial value for the tau parameter in the model. Only
                        applies to Horseshoe.
  --hs_scale HS_SCALE   hs scale parameter in the model. Only applies to
                        Horseshoe.
  --steps STEPS         Number of steps to use for the SVI. Increasing this
                        number will make runtime increase, but yield more
                        accurate results.
  --lr LR               Adam learning rate
  --name_all_nodes      Should we name all nodes in the output tree?
  --expected_min_between_transmissions EXPECTED_MIN_BETWEEN_TRANSMISSIONS
                        For forming the prior, an expected minimum time
                        between transmissions in days
  --only_use_full_dates
                        Only use full dates, given to the precision of a day
  --model MODEL         Model type to use
  --output_unit {days,years}
                        Unit for the output branch lengths on the time tree.
  --variance_on_clock_rate
                        Will cause the clock rate to be drawn from a random
                        distribution with a learnt variance.
  --enforce_exact_clock
                        Will cause the clock rate to be exactly fixed at the
                        value specified in clock, rather than learnt
  --use_gpu             Will attempt to use the GPU. You will need a version
                        of CUDA installed to suit Numpyro.
  --use_wandb           This flag will trigger the use of Weights and Biases
                        to log the fitting process. This must be installed
                        with 'pip install wandb'
  --wandb_project_name WANDB_PROJECT_NAME
                        Wandb project name
  --clipped_adam        Will use the clipped version of Adam
  --reference_node REFERENCE_NODE
                        A reference node to use for computing dates. This
                        should be early in the tree, and have a correct date.
                        If not specified it will be picked as the oldest node,
                        but often these can be metadata errors.
  --always_use_final_params
                        Will force the model to always use the final
                        parameters, rather than simply using those that gave
                        the lowest loss
```

