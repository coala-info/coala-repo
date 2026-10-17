# pybdei CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pybdei_bdei_infer | PASS | synthetic data: the repo's simulated 5650-tip tree; estimates match the true mu, lambda, psi; tree staged writable because the tool writes a temp file beside it |
| pybdei_bdei_loglikelihood | PASS | synthetic data: the repo's simulated 5650-tip tree with its true parameters gives a finite log-likelihood (-16047.2); new CWL |
| pybdei_bdei_u | PASS | synthetic data: the repo's simulated 5650-tip tree; estimates 0.236 hidden trees; new CWL |
| pybdei_generate_bdei | PASS | new CWL; the simulated tree has the requested 100 tips and the log holds the given parameters |
| pybdei_generate_bdeiss | PASS | new CWL; the simulated tree has the requested 100 tips and the log holds the given parameters |

## pybdei_bdei_infer

### Tool Description
BDEI model parameter inference from phylogenetic trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybdei:0.13--py310hef477bb_1
- **Homepage**: https://github.com/evolbioinfo/bdei
- **Package**: https://anaconda.org/channels/bioconda/packages/pybdei/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pybdei/overview
- **Total Downloads**: 2.7K
- **Last updated**: 2025-08-14
- **GitHub**: https://github.com/evolbioinfo/bdei
- **Stars**: N/A
### Original Help Text
```text
usage: bdei_infer [-h] --nwk NWK [-u U] [--mu MU] [--la LA] [--psi PSI] [-p P]
                  [--start START START START START]
                  [--upper_bounds UPPER_BOUNDS UPPER_BOUNDS UPPER_BOUNDS UPPER_BOUNDS]
                  [--pi_E PI_E] [--T T] [--u_policy {min,median,mean,max}]
                  [-c CI_REPETITIONS] [--log LOG] [--time_log TIME_LOG]
                  [-t THREADS] [--log_level LOG_LEVEL] [-v]

BDEI model parameter inference from phylogenetic trees.

options:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads for parallelization.
  --log_level LOG_LEVEL
                        level of logging information (the lower, the less
                        information will be printed to the output). Possible
                        levels are: 0 (errors only), 1 (errors+warnings), 2
                        (errors+warnings+info), 3
                        (errors+warnings+info+debug).
  -v, --version         show program's version number and exit

tree-related arguments:
  --nwk NWK             Input tree(s) in newick format (must be rooted).
  -u U, --u U           Number of unobserved trees. By default (-1) is
                        estimated.

parameter-related arguments:
  --mu MU               Value to fix BDEI becoming-infectious rate mu. If not
                        given, will be estimated.
  --la LA               Value to fix BDEI transmission rate lambda. If not
                        given, will be estimated.
  --psi PSI             Value to fix BDEI removal rate psi. If not given, will
                        be estimated.
  -p P, --p P           Value to fix BDEI sampling probability. If not given,
                        will be estimated.
  --start START START START START
                        Starting values for parameter optimisation, should be
                        4 values in the following order: mu, lambda, psi, p.
                        If not given, will be estimated.
  --upper_bounds UPPER_BOUNDS UPPER_BOUNDS UPPER_BOUNDS UPPER_BOUNDS
                        Upper bound on parameter values for parameter
                        optimisation, should be in the following order: mu,
                        lambda, psi, p. If not given, will be estimated.
  --pi_E PI_E           Frequency of E at time 0, should be between 0 and 1.
                        If not given, will be estimated from the model
                        parameters.
  --T T                 Total time between the tree roots and the end of the
                        sampling period. If a positive value is given, the
                        total time will be set to the maximum between this
                        value and the maximal time between the start and the
                        last sampled tip of all the trees. If a zero or
                        negative value is given, the time will be tree-
                        specific and estimated as the time between the root
                        and the last sampled tip for each tree. In the latter
                        case, one can additionally annotate each tree root
                        with a feature 'T' (e.g. '(a:2,b:3):1[&&NHX:T=5];' is
                        a tree with two tips, a and b, and the tree-specific
                        time annotated to 5): then the tree-specific time will
                        be set to the maximum between the annotated value and
                        the time between the root and the last sampled tip of
                        this tree.
  --u_policy {min,median,mean,max}
                        How to estimate the time for unobserved trees in case
                        of tree-specific observed tree times. By default, the
                        mean of tree-specific observed times is taken.

output-related arguments:
  -c CI_REPETITIONS, --CI_repetitions CI_REPETITIONS
                        Number of repetitions for CI calculation (the higher,
                        the more precise but also longer; a typical value is
                        100). If not specified, CIs will not be calculated.
  --log LOG             Path to the output file where to write the estimates.
                        If not given, the estimates will only be printed in
                        the stdout
  --time_log TIME_LOG   Path to the output file where to write the time. If
                        not given, the time will only be printed in the stdout
```

## pybdei_bdei_loglikelihood

### Tool Description
BDEI model likelihood calculation on phylogenetic trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybdei:0.13--py310hef477bb_1
- **Homepage**: https://github.com/evolbioinfo/bdei
- **Package**: https://anaconda.org/channels/bioconda/packages/pybdei/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bdei_loglikelihood [-h] --nwk NWK [-u U] --mu MU --la LA --psi PSI -p P
                          [--pi_E PI_E] [--T T]
                          [--u_policy {min,median,mean,max}] [-t THREADS]
                          [--log_level LOG_LEVEL] [-v]

BDEI model likelihood calculation on phylogenetic trees.

options:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads for parallelization.
  --log_level LOG_LEVEL
                        level of logging information (the lower, the less
                        information will be printed to the output). Possible
                        levels are: 0 (errors only), 1 (errors+warnings), 2
                        (errors+warnings+info), 3
                        (errors+warnings+info+debug).
  -v, --version         show program's version number and exit

tree-related arguments:
  --nwk NWK             input tree(s) in newick format (must be rooted).
  -u U, --u U           Number of unobserved trees. Specify -1 if you want u
                        to be estimated.

parameter-related arguments:
  --mu MU               Value to fix BDEI becoming-infectious rate mu. If not
                        given, will be estimated.
  --la LA               Value to fix BDEI transmission rate lambda. If not
                        given, will be estimated.
  --psi PSI             Value to fix BDEI removal rate psi. If not given, will
                        be estimated.
  -p P, --p P           Value to fix BDEI sampling probability. If not given,
                        will be estimated.
  --pi_E PI_E           Frequency of E at time 0, should be between 0 and 1.
                        If not given, will be estimated from the model
                        parameters.
  --T T                 Total time between the tree roots and the end of the
                        sampling period. If a positive value is given, the
                        total time will be set to the maximum between this
                        value and the maximal time between the start and the
                        last sampled tip of all the trees. If a zero or
                        negative value is given, the time will be tree-
                        specific and estimated as the time between the root
                        and the last sampled tip for each tree. In the latter
                        case, one can additionally annotate each tree root
                        with a feature 'T' (e.g. '(a:2,b:3):1[&&NHX:T=5];' is
                        a tree with two tips, a and b, and the tree-specific
                        time annotated to 5): then the tree-specific time will
                        be set to the maximum between the annotated value and
                        the time between the root and the last sampled tip of
                        this tree.
  --u_policy {min,median,mean,max}
                        How to estimate the time for unobserved trees in case
                        of tree-specific observed tree times. By default, the
                        mean of tree-specific observed times is taken.
```

## pybdei_bdei_u

### Tool Description
Calculator of the number of hidden trees in the forest under given BDEI model parameters.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybdei:0.13--py310hef477bb_1
- **Homepage**: https://github.com/evolbioinfo/bdei
- **Package**: https://anaconda.org/channels/bioconda/packages/pybdei/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bdei_u [-h] [--nwk NWK] [--f F] --mu MU --la LA --psi PSI -p P
              [--pi_E PI_E] [--T T] [--u_policy {min,median,mean,max}]
              [--log_level LOG_LEVEL] [-v]

Calculator of the number of hidden trees in the forest under given BDEI model
parameters.

options:
  -h, --help            show this help message and exit
  --log_level LOG_LEVEL
                        level of logging information (the lower, the less
                        information will be printed to the output). Possible
                        levels are: 0 (errors only), 1 (errors+warnings), 2
                        (errors+warnings+info), 3
                        (errors+warnings+info+debug).
  -v, --version         show program's version number and exit

tree-related arguments:
  --nwk NWK             Observed tree(s) in newick format to calculate the
                        total time T and the number of observed trees. If not
                        given, --f and --T must be specified.
  --f F                 Number of observed trees. If not given, --nwk must be
                        specified.

parameter-related arguments:
  --mu MU               Value to fix BDEI becoming-infectious rate mu. If not
                        given, will be estimated.
  --la LA               Value to fix BDEI transmission rate lambda. If not
                        given, will be estimated.
  --psi PSI             Value to fix BDEI removal rate psi. If not given, will
                        be estimated.
  -p P, --p P           Value to fix BDEI sampling probability. If not given,
                        will be estimated.
  --pi_E PI_E           Frequency of E at time 0, should be between 0 and 1.
                        If not given, will be estimated from the model
                        parameters.
  --T T                 Total time between the hidden tree roots and the end
                        of the sampling period. If the observed forest is not
                        specified as --nwk, this time must be positive and
                        will be taken as is.If the observed forest is
                        specified as --nwk and a positive --T value is given,
                        the total time will be set to the maximum between this
                        value and the maximal time between the start and the
                        last sampled tip of all the trees. If a zero or
                        negative --T value is given, the observed forest must
                        be specified as --nwk: The time will be calculated
                        based on the observed tree-specific times according to
                        the measure specified in --u_policy. Observed tree-
                        specific times are estimated as the time between the
                        root and the last sampled tip for each tree. In the
                        latter case, one can additionally annotate each tree
                        root with a feature 'T' (e.g.
                        '(a:2,b:3):1[&&NHX:T=5];' is a tree with two tips, a
                        and b, and the tree-specific time annotated to 5):
                        then the tree-specific time will be set to the maximum
                        between the annotated value and the time between the
                        root and the last sampled tip of this tree.
  --u_policy {min,median,mean,max}
                        How to estimate the time for unobserved trees in case
                        of tree-specific observed tree times. By default, the
                        mean of tree-specific observed times is taken.
```

## pybdei_generate_bdei

### Tool Description
Simulates a tree (or a forest of trees) for given BDEI-CT-Skyline model parameters. If a simulation leads to less than --min_tips tips, it is repeated.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybdei:0.13--py310hef477bb_1
- **Homepage**: https://github.com/evolbioinfo/bdei
- **Package**: https://anaconda.org/channels/bioconda/packages/pybdei/overview
- **Validation**: PASS

### Original Help Text
```text
usage: generate_bdei [-h] --min_tips MIN_TIPS --max_tips MAX_TIPS [--T T] --mu
                     MU [MU ...] --la LA [LA ...] --psi PSI [PSI ...] --p P
                     [P ...] [--skyline_times [SKYLINE_TIMES ...]]
                     [--upsilon [UPSILON ...]] [--phi [PHI ...]]
                     [--max_notified_contacts MAX_NOTIFIED_CONTACTS]
                     [--allow_irremovable_states]
                     [--avg_recipients AVG_RECIPIENTS] [--root_state {E,I}]
                     [--log LOG] --nwk NWK [--ltt LTT] [-v] [-s SEED]

Simulates a tree (or a forest of trees) for given BDEI-CT-Skyline model
parameters. If a simulation leads to less than --min_tips tips, it is
repeated.

options:
  -h, --help            show this help message and exit
  --min_tips MIN_TIPS   desired minimal bound on the total number of simulated
                        leaves. For a tree simulation, if --min_tips and
                        --max_tips are equal, exactly that number of tips will
                        be simulated. If --min_tips is less than --max_tips, a
                        value randomly drawn between one and another will be
                        simulated.
  --max_tips MAX_TIPS   desired maximal bound on the total number of simulated
                        leavesFor a tree simulation, if --min_tips and
                        --max_tips are equal, exactly that number of tips will
                        be simulated. If --min_tips is less than --max_tips, a
                        value randomly drawn between one and another will be
                        simulated.
  --T T                 Total simulation time. If specified, a forest will be
                        simulated instead of one tree. The trees in this
                        forest will be simulated during the given time, till
                        the --min_tips number is reached. If after simulating
                        the last tree, the forest exceeds the --max_tips
                        number, the process will be restarted.
  --mu MU [MU ...]      List of becoming-infectious rates (one per skyline
                        interval).
  --la LA [LA ...]      List of transmission rates (one per skyline interval).
  --psi PSI [PSI ...]   List of removal rates (one per skyline interval).
  --p P [P ...]         List of sampling probabilities (one per skyline
                        interval).
  --skyline_times [SKYLINE_TIMES ...]
                        List of time points specifying when to switch from
                        model i to model i+1 in the Skyline.Must be sorted in
                        ascending order and contain one less elements than the
                        number of models in the Skyline.The first model always
                        starts at time 0.
  --upsilon [UPSILON ...]
                        List of notification probabilities (one per skyline
                        interval). Omit for no contact tracing.
  --phi [PHI ...]       List of notified removal rates (one per skyline
                        interval). Only used if upsilon is specified.
  --max_notified_contacts MAX_NOTIFIED_CONTACTS
                        Maximum notified contacts
  --allow_irremovable_states
                        If specified and the initial model included
                        "irremovable" states (i.e., whose removal rate was
                        zero, e.g., E), then even after notification their
                        removal rate will stay zero, and the corresponding
                        individuals will become "removable" (at a rate phi)
                        only once they change the state to a "removable" one
                        (e.g., from E-C to I-C).
  --avg_recipients AVG_RECIPIENTS
                        average number of recipients per transmission. By
                        default one (one-to-one transmission), but if a larger
                        number is given then one-to-many transmissions become
                        possible.
  --root_state {E,I}    state at the beginning of the root branch(es). By
                        default, one of the model states will be chosen
                        randomly (and independently for each tree) based on
                        the state equilibrium frequencies.
  --log LOG             output file to log BDEI model parameters
  --nwk NWK             output tree or forest file
  --ltt LTT             output LTT file
  -v, --verbose         describe generation process
  -s SEED, --seed SEED  random seed for reproducibility
```

## pybdei_generate_bdeiss

### Tool Description
Simulates a tree (or a forest of trees) for given BDEISS-CT-Skyline model parameters. If a simulation leads to less than --min_tips tips, it is repeated.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybdei:0.13--py310hef477bb_1
- **Homepage**: https://github.com/evolbioinfo/bdei
- **Package**: https://anaconda.org/channels/bioconda/packages/pybdei/overview
- **Validation**: PASS

### Original Help Text
```text
usage: generate_bdeiss [-h] --min_tips MIN_TIPS --max_tips MAX_TIPS [--T T]
                       --mu_n MU_N [MU_N ...] --mu_s MU_S [MU_S ...] --la_n
                       LA_N [LA_N ...] --la_s LA_S [LA_S ...] --psi PSI
                       [PSI ...] --p P [P ...]
                       [--skyline_times [SKYLINE_TIMES ...]]
                       [--upsilon [UPSILON ...]] [--phi [PHI ...]]
                       [--max_notified_contacts MAX_NOTIFIED_CONTACTS]
                       [--allow_irremovable_states]
                       [--avg_recipients AVG_RECIPIENTS AVG_RECIPIENTS]
                       [--root_state {E,I,S}] [--log LOG] --nwk NWK
                       [--ltt LTT] [-v] [-s SEED]

Simulates a tree (or a forest of trees) for given BDEISS-CT-Skyline model
parameters. If a simulation leads to less than --min_tips tips, it is
repeated.

options:
  -h, --help            show this help message and exit
  --min_tips MIN_TIPS   desired minimal bound on the total number of simulated
                        leaves. For a tree simulation, if --min_tips and
                        --max_tips are equal, exactly that number of tips will
                        be simulated. If --min_tips is less than --max_tips, a
                        value randomly drawn between one and another will be
                        simulated.
  --max_tips MAX_TIPS   desired maximal bound on the total number of simulated
                        leavesFor a tree simulation, if --min_tips and
                        --max_tips are equal, exactly that number of tips will
                        be simulated. If --min_tips is less than --max_tips, a
                        value randomly drawn between one and another will be
                        simulated.
  --T T                 Total simulation time. If specified, a forest will be
                        simulated instead of one tree. The trees in this
                        forest will be simulated during the given time, till
                        the --min_tips number is reached. If after simulating
                        the last tree, the forest exceeds the --max_tips
                        number, the process will be restarted.
  --mu_n MU_N [MU_N ...]
                        List of exposed-to-normal spreader state change rates
                        (one per skyline interval).
  --mu_s MU_S [MU_S ...]
                        List of exposed-to-super spreader state change rates
                        (one per skyline interval).
  --la_n LA_N [LA_N ...]
                        List of transmission rates from normal spreaders (one
                        per skyline interval).
  --la_s LA_S [LA_S ...]
                        List of transmission rates from super spreaders (one
                        per skyline interval).
  --psi PSI [PSI ...]   List of removal rates (one per skyline interval).
  --p P [P ...]         List of sampling probabilities (one per skyline
                        interval).
  --skyline_times [SKYLINE_TIMES ...]
                        List of time points specifying when to switch from
                        model i to model i+1 in the Skyline.Must be sorted in
                        ascending order and contain one less elements than the
                        number of models in the Skyline.The first model always
                        starts at time 0.
  --upsilon [UPSILON ...]
                        List of notification probabilities (one per skyline
                        interval). Omit for no contact tracing.
  --phi [PHI ...]       List of notified removal rates (one per skyline
                        interval). Only used if upsilon is specified.
  --max_notified_contacts MAX_NOTIFIED_CONTACTS
                        Maximum notified contacts
  --allow_irremovable_states
                        If specified and the initial model included
                        "irremovable" states (i.e., whose removal rate was
                        zero, e.g., E), then even after notification their
                        removal rate will stay zero, and the corresponding
                        individuals will become "removable" (at a rate phi)
                        only once they change the state to a "removable" one
                        (e.g., from E-C to I-C).
  --avg_recipients AVG_RECIPIENTS AVG_RECIPIENTS
                        average number of recipients per transmission for each
                        donor state (normal spreader, superspreader). By
                        default one and one (one-to-one transmissions
                        independently of the donor state), but if larger
                        numbers are given then one-to-many transmissions
                        become possible.
  --root_state {E,I,S}  state at the beginning of the root branch(es). By
                        default, one of the model states will be chosen
                        randomly (and independently for each tree) based on
                        the state equilibrium frequencies.
  --log LOG             output file to log BDEISS model parameters
  --nwk NWK             output tree or forest file
  --ltt LTT             output LTT file
  -v, --verbose         describe generation process
  -s SEED, --seed SEED  random seed for reproducibility
```

