# modle CWL Generation Report

## modle_simulate

### Tool Description
Simulate loop extrusion and write resulting molecular contacts in a .cool file.

### Metadata
- **Docker Image**: quay.io/biocontainers/modle:1.1.0--h63853f4_0
- **Homepage**: https://github.com/paulsengroup/MoDLE
- **Package**: https://anaconda.org/channels/bioconda/packages/modle/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/modle/overview
- **Total Downloads**: 4.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/paulsengroup/MoDLE
- **Stars**: N/A
### Original Help Text
```text
Simulate loop extrusion and write resulting molecular contacts in a .cool file.
Usage: modle simulate [OPTIONS]

Options:
  -h,--help                   Print this help message and exit
[Option Group: IO]
  Options controlling MoDLE input, output and logs.
  Options:
    -c,--chrom-sizes REQUIRED   Path to file with chromosome sizes in chrom.sizes format.
    -b,--extrusion-barrier-file REQUIRED
                                Path to a file in BED6+ format with the genomic coordinates of extrusion barriers to be
                                simulated. The score field in a BED record should be a number between 0 and 1 and is
                                interpreted as the extrusion barrier occupancy for the extrusion barrier described
                                by the record.
                                Barriers mapping on chromosomes not listed in the chrom.sizes file passed through
                                the --chrom-sizes option are ignored.
    -g,--genomic-intervals      Path to BED3+ file with the genomic regions to be simulated.
                                Intervals listed in this file should be a subset of the chromosomes defined in the .chrom.sizes files.
                                Intervals referring to chromosomes not listed in the .chrom.sizes file are ignored.
    -f,--force                  Overwrite existing files (if any).
    -o,--output-prefix REQUIRED Output prefix.
                                Can be an absolute or relative path including the file name but without the extension.
                                Example: running modle sim -o /tmp/my_simulation ... yields the following files:
                                         - /tmp/my_simulation.cool
                                         - /tmp/my_simulation.log
                                         - /tmp/my_simulation_config.toml
                                         - /tmp/my_simulation_lef_1d_occupancy.bw
    --assembly-name=unknown     Name of the genome assembly to be simulated.
                                This is only used to populate the "assembly" attribute in the output .cool file.
    -q,--quiet excludes: --verbose
                                Suppress console output to stderr.
                                Only fatal errors will be logged to the console.
                                Does not affect entries written to the log file.
    -v,--verbose excludes: --quiet
                                Increase verbosity of log to console.
                                Does not affect entries written to the log file.
[Option Group: Extrusion Barriers and Factors]
  Options controlling how extrusion barrier and LEFs are simulated.
  Options:
    --lef-density,--lefs-per-mbp=20.0 (0, inf)
                                Loop extrusion factor (LEF) density expressed as the number of LEF per Mbp of DNA simulated.
    --avg-lef-processivity=300000 (0, inf)
                                Average LEF processivity in bp.
                                The average LEF processivity corresponds to the average size of loops extruded by
                                unobstructed LEFs.
    --probability-of-lef-bypass=0.1 [0, 1]
                                Probability that two colliding LEFs will avoid collision by bypassing each other.
    --extrusion-barrier-occupancy [0, 1] excludes: --extrusion-barrier-bound-stp
                                Probability that an extrusion barrier is occupied (i.e. blocking) at any given time.
                                This parameter provides an easier mean to set --extrusion-barrier-bound-stp.
                                Passing this parameter will override barrier occupancies read from the BED file specified
                                through --extrusion-barrier-file.
    --track-1d-lef-position,--no-track-1d-lef-position{false}
                                Toggle on/off tracking of LEF positions in 1D space.
                                LEF positions are aggregated across all simulated cells and are written to disk in BigWig format
                                under the prefix specified through --output-prefix.
                                
[Option Group: Contact generation]
  Options affecting contact sampling and registration.
  Options:
    --contact-sampling-strategy=tad-plus-loop-with-noise
                                Strategy to use when sampling contacts.
                                Should be one of:
                                 - loop-only
                                 - loop-only-with-noise
                                 - tad-only
                                 - tad-only-with-noise
                                 - tad-plus-loop
                                 - tad-plus-loop-with-noise
                                When one of the *-with-noise strategies is specified, contacts are randomized by
                                applying a random offset to the location of LEF extrusion units.
                                Offsets are drawn from a genextreme distrubution.
                                The distribution parameters can be controlled through the options --mu, --sigma
                                and --xi.
    --contact-sampling-interval=50000 (0, inf)
                                Average number of base-pairs extruded by one LEF between two subsequent sampling events
                                (assuming no collision have occurred).
                                Specifying shorter intervals will increase the frequency of sampling frequency, producing more
                                contacts when --stopping-criterion=simulation-epochs or reducing the number of epochs simulated
                                in case --stopping-criterion=contact-density.
                                Using sampling intervals that are significantly smaller than the average LEF processivity is usually
                                not recommended, as will cause MoDLE to sample many contacts from a single loop.
    -r,--resolution=5000 (0, inf)
                                Resolution in base-pairs for the output contact matrix in cooler format.
                                NOTE: MoDLE simulation always take place at 1 bp resolution.
                                      This parameter only affects the resolution of the output contact matrix.
    -w,--diagonal-width=3000000 (0, inf)
                                Width of the subdiagonal window for the in-memory contact matrix.
                                This setting affects the maximum distance of a pair of bins whose interactions will be
                                tracked by MoDLE.
                                As a rule of thumb, --diagonal-width should roughly 10x the average LEF processivity.
                                Setting --diagonal-width to very large values (i.e. tens of Mbp) will significantly
                                increase MoDLE's memory requirements.
[Option Group: Stopping criterion]
  Options defining the simulation stopping criterion.
  Options:
    -s,--stopping-criterion=contact-density
                                Simulation stopping criterion. Should be one of contact-density or simulation-epochs.
    --target-number-of-epochs=2000 (0, inf) excludes: --target-contact-density
                                Target number of epochs to be simulated.
                                Each simulation instance will run exactly --target-number-of-epochs epochs after burn-in
                                phase. Has no effect when --stopping-criterion="contact-density".
    --target-contact-density (0, inf) excludes: --target-number-of-epochs
                                Average contact density to be reached before the simulation is halted.
                                The target contact density applies independently to each chromosome.
                                Example: modle sim --chrom-sizes hg38.chr1.chrom.sizes \
                                                   --diagonal-width 3000000            \
                                                   --resolution 100000                 \
                                                   --target-contact-density 2
                                         Assuming chr1 is exactly 250 Mbp long, MoDLE will schedule simulation instances to yield
                                         a total of 150 000 contacts for chr1: 2 * (250e6 / 100e3) * (3e6 / 100e3) = 150e3.
[Option Group: Miscellaneous]
  Options:
    --ncells=512 (0, inf)       Number of simulation instances or cells to simulate.
                                Loop extrusion will be simulated independently for every chromosome across --ncells
                                simulation instances. The final contact matrix is produced by accumulating contacts
                                generated across all simulation instances. To achieve good performance and CPU utilization
                                we recommend setting --ncells equal to the number of available CPU cores.
    -t,--threads=20 (0, inf)    Number of worker threads used to run simulation instances.
                                By default MoDLE will spawn a number of worker threads equal to the number of logical CPU
                                cores. On high core count machines a slightly better performance can usually be obtained
                                by setting --threads equal to the number of physical CPU cores.
                                
    --seed=0 [0, inf)           Base seed to use for random number generation.
[Option Group: Advanced]
  [Option Group: IO]
    Advanced options controlling MoDLE input, output and logs.
    Options:
      --log-model-internal-state excludes: --skip-output
                                  Collect detailed statistics regarding the internal state of MoDLE simulation instance(s).
                                  Statistics will be written to a compressed file under the prefix specified through the
                                  --output-prefix option.
                                  Example: modle sim --output-prefix=/tmp/myprefix
                                  statistics will be written to file /tmp/myprefix_internal_state.log.gz.
                                  Depending on the input file(s) and parameters, specifying this option may hinder
                                  simulation throughput. Currently the following metrics are collected:
                                   - task_id
                                   - epoch
                                   - cell_id
                                   - chrom
                                   - start
                                   - end
                                   - burnin
                                   - barrier_occupancy
                                   - num_active_lefs
                                   - num_stalls_rev
                                   - num_stalls_fwd
                                   - num_stalls_both
                                   - num_lef_bar_collisions
                                   - num_primary_lef_lef_collisions
                                   - num_secondary_lef_lef_collisions
                                   - avg_loop_size
                                  
      --simulate-chromosomes-wo-barriers,--skip-chromosomes-wo-barriers{false}
                                  Enable/disable simulation of loop extrusion for chromosomes with 0 extrusion barriers.
                                  When --skip-chromosomes-wo-barriers is passed, entries for chromosomes without barriers
                                  will still be written to the output .cool file, but no contacts will be generated for
                                  those chromosomes.
      --skip-output excludes: --log-model-internal-state
                                  Do not write output files. Mostly useful for profiling.
  [Option Group: Extrusion Factors]
    Advanced options controlling how LEFs are simulated.
    Options:
      --hard-stall-lef-stability-multiplier=5.0 [0, inf)
                                  Coefficient to control the DNA-binding stability of LEFs that are stalled on both sides by a
                                  pair of extrusion barriers in convergent orientation.
                                  Setting this to 1 makes the DNA-binding stability of hard-stalled LEFs identical to that of
                                  unobstructed LEFs. Has no effects when --lef-bar-major-collision-prob=0.
      --soft-stall-lef-stability-multiplier=1.0 [0, inf)
                                  Coefficient to control the DNA-binding stability of LEFs stalled by one or more extrusion
                                  barriers in a non-blocking orientation. Setting this to 1 makes the DNA-binding stability
                                  of soft-stalled LEFs identical to that of unobstructed LEFs.
                                  Has no effects when --lef-bar-minor-collision-prob=0.
      --fwd-extrusion-speed=4000 [0, inf)
                                  Average extrusion speed expressed in bp/epoch for forward-moving extrusion units.
                                  Extrusion units are assigned a candidate moving distance at the beginning of every epoch.
                                  Moves are sampled from a normal distribution centered around --fwd-extrusion-speed and with
                                  --fwd-extrusion-speed-std as its standard deviation. Candidate moves represent the maximum
                                  distance a given extrusion unit is set to travel during the current epoch.
                                  Moving distances can be shortened by collision events taking place during the current epoch.
                                  By deafult extrusion speed is set to half the bin size specified through the --resolution
                                  option.
      --rev-extrusion-speed=4000 [0, inf)
                                  Same as --fwd-extrusion-speed but for extrusion units moving in 3'-5' direction.
      --fwd-extrusion-speed-std=0.05 [0, inf)
                                  Standard deviation of the normal distribution used to sample candidate moves for extrusion
                                  units moving in 5'-3' direction. See help message for --fwd-extrusion-speed for more details
                                  regarding candidate moves.
                                  Specifying --fwd-extrusion-speed-std=0 will make candidate moves deterministic.
                                  Standard deviations between 0 and 1 are interpreted a percentage of the average extrusion
                                  speed.
                                  Example: when running modle sim --fwd-extrusion-speed=10000 ...
                                           --fwd-extrusion-speed-std=0.1 and --fwd-extrusion-speed-std=1000 are equivalent.
      --rev-extrusion-speed-std=0.05 [0, inf)
                                  Same as --fwd-extrusion-speed-std but for extrusion units moving in 3'-5' direction.
  [Option Group: Extrusion Barriers]
    Advanced options controlling how extrusion are simulated.
    Options:
      --lef-bar-major-collision-prob=1.0 [0, 1]
                                  Probability of collision between LEFs and extrusion barriers where barriers are pointing
                                  towards the extrusion direction.
      --lef-bar-minor-collision-prob=0.0 [0, 1]
                                  Probability of collision between LEFs and extrusion barriers where barriers are pointing
                                  away from the extrusion direction.
      --extrusion-barrier-bound-stp [0, 1] excludes: --extrusion-barrier-occupancy
                                  Self-transition probability for extrusion barriers in the "bound" state.
                                  In other words, the probability that an extrusion barrier that is active in the current epoch
                                  will remain active during the next epoch.
      --extrusion-barrier-not-bound-stp=0.7 [0, 1] excludes: --interpret-extrusion-barrier-name-as-not-bound-stp
                                  Self-transition probability for extrusion barriers in the "not-bound" state.
                                  In other words, the probability that an extrusion barrier that is inactive in the current
                                  epoch will remain inactive during the next epoch.
      --interpret-extrusion-barrier-name-as-not-bound-stp excludes: --extrusion-barrier-not-bound-stp
                                  Interpret the name field of the extrusion barrier BED file passed through --extrusion-barrier-file
                                  as the not-bound stp for the barrier defined by the BED record.
  [Option Group: Contact generation]
    Advanced options affecting contact sampling and registration.
    Options:
      --tad-to-loop-contact-ratio=5.0 [0, inf)
                                  Ratio between the number of TAD and loop contacts.
                                  Loop contacts are sampled using the position of the extrusion units of a LEF.
                                  This type of contact visually correspond to stripes and dots in the output matrix.
                                  TAD contacts are sampled from the body of a loop and visually correspond to TADs.
                                  Use "0" to disable sampling of TAD contacts.
                                  Use "inf" to disable sampling of loop contacts.
      --mu,--genextr-location=0.0 [0, inf)
                                  Location parameter (mu) of the generalized extreme value distribution used to add noise to
                                  molecular contacts.
      --sigma,--genextr-scale=5000.0 [0, inf)
                                  Scale parameter (sigma) of the generalized extreme value distribution used to add noise to
                                  molecular contacts.
      --xi,--genextr-shape=0.001 [0, inf)
                                  Shape parameter (xi) of the generalized extreme value distribution used to add noise to
                                  molecular contacts.
  [Option Group: Burn-in]
    Options defining the simulation stopping criterion.
    Options:
      --skip-burnin               Skip the burn-in phase and start collecting contacts from the first extrusion round.
      --burnin-target-epochs-for-lef-activation=320 (0, inf)
                                  Number of epochs over which LEFs are progressively activated and bound to DNA.
                                  Note: this number is approximate, as LEFs are activated using a Possion process.
                                  By default this parameter is computed based on the average LEF processivity, overall
                                  extrusion speed and burn-in extrusion speed coefficient (--avg-lef-processivity,
                                  --fwd/rev-extrusion-speed and --burn-in-extr-speed-coefficient respectively).
      --burnin-history-length=100 (0, inf)
                                  Number of epochs used to determine whether a simulation instance has reached a stable state.
      --burnin-smoothing-window-size=5 (0, inf)
                                  Window size used to smooth metrics monitored to decide when the burn-in phase should be
                                  terminated.
      --min-burnin-epochs=0 [0, inf)
                                  Lower bound for the burn-in phase duration.
      --max-burnin-epochs=inf (0, inf)
                                  Upper bound for the burn-in phase duration.
                                  This is especially useful when simlating loop extrusion with very few LEFs.
                                  When this is the case, --max-burnin-epochs=100000 can be used as a very conservative
                                  threshold.
      --burnin-extr-speed-coefficient=1.0 (0, inf)
                                  Extrusion speed coefficient to apply during the burn-in phase.
                                  Setting this to numbers > 1.0 will speed-up the burn-in phase, as the average loop size will
                                  stabilize faster.
                                  IMPORTANT: Setting this parameter to values other than 1.0 comes with many gotchas.
                                             For the time being, tuning this parameter is not reccommended.
  [Option Group: Miscellaneous]
    Options:
      --probability-normalization-factor=8000 (0, inf)
                                  Normalization factor used to scale probabilities based on the overall average extrusion speed.
                                  This is needed in order for the transition and collision probabilities to make sense when simulating
                                  using different extrusion speeds.
                                  Example: let us consider a simulation where:
                                           - --extrusion-barrier-occupancy=0.5
                                           - --extrusion-barrier-not-bound-stp=0.5
                                           - --rev-extrusion-speed=5000
                                           - --fwd-extrusion-speed=5000
                                           In this scenario we expect extrusion barriers to flip between active and inactive state
                                           every simulation epoch, that is every N bp of DNA extruded, where N is the product between
                                           the overall extrusion speed (10kbp/epoch) and the number of LEFs that are being simulated in
                                           one simulation instance.
                                           If now we consider the same simulation carried out at much slower extrusion speed
                                           (e.g. 100bp/epoch), the situation is quite different, as extrusion barriers switch between
                                           active and inactive states once every N * (100 / 10 000) bp of DNA extruded.
                                  This parameter is used to normalize transition and collision probabilities to avoid the issue outlined
                                  in the example above. Basically specifying --probability-normalization-factor=10kb and
                                  --extrusion-barrier-not-bound-stp=0.8 instructs MoDLE to interpret the self-transition probability
                                  specified through the CLI at an extrusion speed of 10kbp, and adjust the transition probability
                                  based on the actual extrusion speed.
                                  Currently, changing this parameter affects the probabilities corresponding to the following CLI options:
                                   - --extrusion-barrier-bound-stp
                                   - --extrusion-barrier-not-bound-stp
                                   - --lef-bar-major-collision-prob
                                   - --lef-bar-minor-collision-prob
                                   - --probability-of-lef-bypass
      --normalize-probabilities,--no-normalize-probabilities{false}
                                  Toggle on/off normalization of transition and collision probabilities using --probability-normalization-factor.
```


## modle_sim

### Tool Description
Simulate loop extrusion and write resulting molecular contacts in a .cool file.

### Metadata
- **Docker Image**: quay.io/biocontainers/modle:1.1.0--h63853f4_0
- **Homepage**: https://github.com/paulsengroup/MoDLE
- **Package**: https://anaconda.org/channels/bioconda/packages/modle/overview
- **Validation**: PASS

### Original Help Text
```text
Simulate loop extrusion and write resulting molecular contacts in a .cool file.
Usage: modle simulate [OPTIONS]

Options:
  -h,--help                   Print this help message and exit
[Option Group: IO]
  Options controlling MoDLE input, output and logs.
  Options:
    -c,--chrom-sizes REQUIRED   Path to file with chromosome sizes in chrom.sizes format.
    -b,--extrusion-barrier-file REQUIRED
                                Path to a file in BED6+ format with the genomic coordinates of extrusion barriers to be
                                simulated. The score field in a BED record should be a number between 0 and 1 and is
                                interpreted as the extrusion barrier occupancy for the extrusion barrier described
                                by the record.
                                Barriers mapping on chromosomes not listed in the chrom.sizes file passed through
                                the --chrom-sizes option are ignored.
    -g,--genomic-intervals      Path to BED3+ file with the genomic regions to be simulated.
                                Intervals listed in this file should be a subset of the chromosomes defined in the .chrom.sizes files.
                                Intervals referring to chromosomes not listed in the .chrom.sizes file are ignored.
    -f,--force                  Overwrite existing files (if any).
    -o,--output-prefix REQUIRED Output prefix.
                                Can be an absolute or relative path including the file name but without the extension.
                                Example: running modle sim -o /tmp/my_simulation ... yields the following files:
                                         - /tmp/my_simulation.cool
                                         - /tmp/my_simulation.log
                                         - /tmp/my_simulation_config.toml
                                         - /tmp/my_simulation_lef_1d_occupancy.bw
    --assembly-name=unknown     Name of the genome assembly to be simulated.
                                This is only used to populate the "assembly" attribute in the output .cool file.
    -q,--quiet excludes: --verbose
                                Suppress console output to stderr.
                                Only fatal errors will be logged to the console.
                                Does not affect entries written to the log file.
    -v,--verbose excludes: --quiet
                                Increase verbosity of log to console.
                                Does not affect entries written to the log file.
[Option Group: Extrusion Barriers and Factors]
  Options controlling how extrusion barrier and LEFs are simulated.
  Options:
    --lef-density,--lefs-per-mbp=20.0 (0, inf)
                                Loop extrusion factor (LEF) density expressed as the number of LEF per Mbp of DNA simulated.
    --avg-lef-processivity=300000 (0, inf)
                                Average LEF processivity in bp.
                                The average LEF processivity corresponds to the average size of loops extruded by
                                unobstructed LEFs.
    --probability-of-lef-bypass=0.1 [0, 1]
                                Probability that two colliding LEFs will avoid collision by bypassing each other.
    --extrusion-barrier-occupancy [0, 1] excludes: --extrusion-barrier-bound-stp
                                Probability that an extrusion barrier is occupied (i.e. blocking) at any given time.
                                This parameter provides an easier mean to set --extrusion-barrier-bound-stp.
                                Passing this parameter will override barrier occupancies read from the BED file specified
                                through --extrusion-barrier-file.
    --track-1d-lef-position,--no-track-1d-lef-position{false}
                                Toggle on/off tracking of LEF positions in 1D space.
                                LEF positions are aggregated across all simulated cells and are written to disk in BigWig format
                                under the prefix specified through --output-prefix.
                                
[Option Group: Contact generation]
  Options affecting contact sampling and registration.
  Options:
    --contact-sampling-strategy=tad-plus-loop-with-noise
                                Strategy to use when sampling contacts.
                                Should be one of:
                                 - loop-only
                                 - loop-only-with-noise
                                 - tad-only
                                 - tad-only-with-noise
                                 - tad-plus-loop
                                 - tad-plus-loop-with-noise
                                When one of the *-with-noise strategies is specified, contacts are randomized by
                                applying a random offset to the location of LEF extrusion units.
                                Offsets are drawn from a genextreme distrubution.
                                The distribution parameters can be controlled through the options --mu, --sigma
                                and --xi.
    --contact-sampling-interval=50000 (0, inf)
                                Average number of base-pairs extruded by one LEF between two subsequent sampling events
                                (assuming no collision have occurred).
                                Specifying shorter intervals will increase the frequency of sampling frequency, producing more
                                contacts when --stopping-criterion=simulation-epochs or reducing the number of epochs simulated
                                in case --stopping-criterion=contact-density.
                                Using sampling intervals that are significantly smaller than the average LEF processivity is usually
                                not recommended, as will cause MoDLE to sample many contacts from a single loop.
    -r,--resolution=5000 (0, inf)
                                Resolution in base-pairs for the output contact matrix in cooler format.
                                NOTE: MoDLE simulation always take place at 1 bp resolution.
                                      This parameter only affects the resolution of the output contact matrix.
    -w,--diagonal-width=3000000 (0, inf)
                                Width of the subdiagonal window for the in-memory contact matrix.
                                This setting affects the maximum distance of a pair of bins whose interactions will be
                                tracked by MoDLE.
                                As a rule of thumb, --diagonal-width should roughly 10x the average LEF processivity.
                                Setting --diagonal-width to very large values (i.e. tens of Mbp) will significantly
                                increase MoDLE's memory requirements.
[Option Group: Stopping criterion]
  Options defining the simulation stopping criterion.
  Options:
    -s,--stopping-criterion=contact-density
                                Simulation stopping criterion. Should be one of contact-density or simulation-epochs.
    --target-number-of-epochs=2000 (0, inf) excludes: --target-contact-density
                                Target number of epochs to be simulated.
                                Each simulation instance will run exactly --target-number-of-epochs epochs after burn-in
                                phase. Has no effect when --stopping-criterion="contact-density".
    --target-contact-density (0, inf) excludes: --target-number-of-epochs
                                Average contact density to be reached before the simulation is halted.
                                The target contact density applies independently to each chromosome.
                                Example: modle sim --chrom-sizes hg38.chr1.chrom.sizes \
                                                   --diagonal-width 3000000            \
                                                   --resolution 100000                 \
                                                   --target-contact-density 2
                                         Assuming chr1 is exactly 250 Mbp long, MoDLE will schedule simulation instances to yield
                                         a total of 150 000 contacts for chr1: 2 * (250e6 / 100e3) * (3e6 / 100e3) = 150e3.
[Option Group: Miscellaneous]
  Options:
    --ncells=512 (0, inf)       Number of simulation instances or cells to simulate.
                                Loop extrusion will be simulated independently for every chromosome across --ncells
                                simulation instances. The final contact matrix is produced by accumulating contacts
                                generated across all simulation instances. To achieve good performance and CPU utilization
                                we recommend setting --ncells equal to the number of available CPU cores.
    -t,--threads=20 (0, inf)    Number of worker threads used to run simulation instances.
                                By default MoDLE will spawn a number of worker threads equal to the number of logical CPU
                                cores. On high core count machines a slightly better performance can usually be obtained
                                by setting --threads equal to the number of physical CPU cores.
                                
    --seed=0 [0, inf)           Base seed to use for random number generation.
[Option Group: Advanced]
  [Option Group: IO]
    Advanced options controlling MoDLE input, output and logs.
    Options:
      --log-model-internal-state excludes: --skip-output
                                  Collect detailed statistics regarding the internal state of MoDLE simulation instance(s).
                                  Statistics will be written to a compressed file under the prefix specified through the
                                  --output-prefix option.
                                  Example: modle sim --output-prefix=/tmp/myprefix
                                  statistics will be written to file /tmp/myprefix_internal_state.log.gz.
                                  Depending on the input file(s) and parameters, specifying this option may hinder
                                  simulation throughput. Currently the following metrics are collected:
                                   - task_id
                                   - epoch
                                   - cell_id
                                   - chrom
                                   - start
                                   - end
                                   - burnin
                                   - barrier_occupancy
                                   - num_active_lefs
                                   - num_stalls_rev
                                   - num_stalls_fwd
                                   - num_stalls_both
                                   - num_lef_bar_collisions
                                   - num_primary_lef_lef_collisions
                                   - num_secondary_lef_lef_collisions
                                   - avg_loop_size
                                  
      --simulate-chromosomes-wo-barriers,--skip-chromosomes-wo-barriers{false}
                                  Enable/disable simulation of loop extrusion for chromosomes with 0 extrusion barriers.
                                  When --skip-chromosomes-wo-barriers is passed, entries for chromosomes without barriers
                                  will still be written to the output .cool file, but no contacts will be generated for
                                  those chromosomes.
      --skip-output excludes: --log-model-internal-state
                                  Do not write output files. Mostly useful for profiling.
  [Option Group: Extrusion Factors]
    Advanced options controlling how LEFs are simulated.
    Options:
      --hard-stall-lef-stability-multiplier=5.0 [0, inf)
                                  Coefficient to control the DNA-binding stability of LEFs that are stalled on both sides by a
                                  pair of extrusion barriers in convergent orientation.
                                  Setting this to 1 makes the DNA-binding stability of hard-stalled LEFs identical to that of
                                  unobstructed LEFs. Has no effects when --lef-bar-major-collision-prob=0.
      --soft-stall-lef-stability-multiplier=1.0 [0, inf)
                                  Coefficient to control the DNA-binding stability of LEFs stalled by one or more extrusion
                                  barriers in a non-blocking orientation. Setting this to 1 makes the DNA-binding stability
                                  of soft-stalled LEFs identical to that of unobstructed LEFs.
                                  Has no effects when --lef-bar-minor-collision-prob=0.
      --fwd-extrusion-speed=4000 [0, inf)
                                  Average extrusion speed expressed in bp/epoch for forward-moving extrusion units.
                                  Extrusion units are assigned a candidate moving distance at the beginning of every epoch.
                                  Moves are sampled from a normal distribution centered around --fwd-extrusion-speed and with
                                  --fwd-extrusion-speed-std as its standard deviation. Candidate moves represent the maximum
                                  distance a given extrusion unit is set to travel during the current epoch.
                                  Moving distances can be shortened by collision events taking place during the current epoch.
                                  By deafult extrusion speed is set to half the bin size specified through the --resolution
                                  option.
      --rev-extrusion-speed=4000 [0, inf)
                                  Same as --fwd-extrusion-speed but for extrusion units moving in 3'-5' direction.
      --fwd-extrusion-speed-std=0.05 [0, inf)
                                  Standard deviation of the normal distribution used to sample candidate moves for extrusion
                                  units moving in 5'-3' direction. See help message for --fwd-extrusion-speed for more details
                                  regarding candidate moves.
                                  Specifying --fwd-extrusion-speed-std=0 will make candidate moves deterministic.
                                  Standard deviations between 0 and 1 are interpreted a percentage of the average extrusion
                                  speed.
                                  Example: when running modle sim --fwd-extrusion-speed=10000 ...
                                           --fwd-extrusion-speed-std=0.1 and --fwd-extrusion-speed-std=1000 are equivalent.
      --rev-extrusion-speed-std=0.05 [0, inf)
                                  Same as --fwd-extrusion-speed-std but for extrusion units moving in 3'-5' direction.
  [Option Group: Extrusion Barriers]
    Advanced options controlling how extrusion are simulated.
    Options:
      --lef-bar-major-collision-prob=1.0 [0, 1]
                                  Probability of collision between LEFs and extrusion barriers where barriers are pointing
                                  towards the extrusion direction.
      --lef-bar-minor-collision-prob=0.0 [0, 1]
                                  Probability of collision between LEFs and extrusion barriers where barriers are pointing
                                  away from the extrusion direction.
      --extrusion-barrier-bound-stp [0, 1] excludes: --extrusion-barrier-occupancy
                                  Self-transition probability for extrusion barriers in the "bound" state.
                                  In other words, the probability that an extrusion barrier that is active in the current epoch
                                  will remain active during the next epoch.
      --extrusion-barrier-not-bound-stp=0.7 [0, 1] excludes: --interpret-extrusion-barrier-name-as-not-bound-stp
                                  Self-transition probability for extrusion barriers in the "not-bound" state.
                                  In other words, the probability that an extrusion barrier that is inactive in the current
                                  epoch will remain inactive during the next epoch.
      --interpret-extrusion-barrier-name-as-not-bound-stp excludes: --extrusion-barrier-not-bound-stp
                                  Interpret the name field of the extrusion barrier BED file passed through --extrusion-barrier-file
                                  as the not-bound stp for the barrier defined by the BED record.
  [Option Group: Contact generation]
    Advanced options affecting contact sampling and registration.
    Options:
      --tad-to-loop-contact-ratio=5.0 [0, inf)
                                  Ratio between the number of TAD and loop contacts.
                                  Loop contacts are sampled using the position of the extrusion units of a LEF.
                                  This type of contact visually correspond to stripes and dots in the output matrix.
                                  TAD contacts are sampled from the body of a loop and visually correspond to TADs.
                                  Use "0" to disable sampling of TAD contacts.
                                  Use "inf" to disable sampling of loop contacts.
      --mu,--genextr-location=0.0 [0, inf)
                                  Location parameter (mu) of the generalized extreme value distribution used to add noise to
                                  molecular contacts.
      --sigma,--genextr-scale=5000.0 [0, inf)
                                  Scale parameter (sigma) of the generalized extreme value distribution used to add noise to
                                  molecular contacts.
      --xi,--genextr-shape=0.001 [0, inf)
                                  Shape parameter (xi) of the generalized extreme value distribution used to add noise to
                                  molecular contacts.
  [Option Group: Burn-in]
    Options defining the simulation stopping criterion.
    Options:
      --skip-burnin               Skip the burn-in phase and start collecting contacts from the first extrusion round.
      --burnin-target-epochs-for-lef-activation=320 (0, inf)
                                  Number of epochs over which LEFs are progressively activated and bound to DNA.
                                  Note: this number is approximate, as LEFs are activated using a Possion process.
                                  By default this parameter is computed based on the average LEF processivity, overall
                                  extrusion speed and burn-in extrusion speed coefficient (--avg-lef-processivity,
                                  --fwd/rev-extrusion-speed and --burn-in-extr-speed-coefficient respectively).
      --burnin-history-length=100 (0, inf)
                                  Number of epochs used to determine whether a simulation instance has reached a stable state.
      --burnin-smoothing-window-size=5 (0, inf)
                                  Window size used to smooth metrics monitored to decide when the burn-in phase should be
                                  terminated.
      --min-burnin-epochs=0 [0, inf)
                                  Lower bound for the burn-in phase duration.
      --max-burnin-epochs=inf (0, inf)
                                  Upper bound for the burn-in phase duration.
                                  This is especially useful when simlating loop extrusion with very few LEFs.
                                  When this is the case, --max-burnin-epochs=100000 can be used as a very conservative
                                  threshold.
      --burnin-extr-speed-coefficient=1.0 (0, inf)
                                  Extrusion speed coefficient to apply during the burn-in phase.
                                  Setting this to numbers > 1.0 will speed-up the burn-in phase, as the average loop size will
                                  stabilize faster.
                                  IMPORTANT: Setting this parameter to values other than 1.0 comes with many gotchas.
                                             For the time being, tuning this parameter is not reccommended.
  [Option Group: Miscellaneous]
    Options:
      --probability-normalization-factor=8000 (0, inf)
                                  Normalization factor used to scale probabilities based on the overall average extrusion speed.
                                  This is needed in order for the transition and collision probabilities to make sense when simulating
                                  using different extrusion speeds.
                                  Example: let us consider a simulation where:
                                           - --extrusion-barrier-occupancy=0.5
                                           - --extrusion-barrier-not-bound-stp=0.5
                                           - --rev-extrusion-speed=5000
                                           - --fwd-extrusion-speed=5000
                                           In this scenario we expect extrusion barriers to flip between active and inactive state
                                           every simulation epoch, that is every N bp of DNA extruded, where N is the product between
                                           the overall extrusion speed (10kbp/epoch) and the number of LEFs that are being simulated in
                                           one simulation instance.
                                           If now we consider the same simulation carried out at much slower extrusion speed
                                           (e.g. 100bp/epoch), the situation is quite different, as extrusion barriers switch between
                                           active and inactive states once every N * (100 / 10 000) bp of DNA extruded.
                                  This parameter is used to normalize transition and collision probabilities to avoid the issue outlined
                                  in the example above. Basically specifying --probability-normalization-factor=10kb and
                                  --extrusion-barrier-not-bound-stp=0.8 instructs MoDLE to interpret the self-transition probability
                                  specified through the CLI at an extrusion speed of 10kbp, and adjust the transition probability
                                  based on the actual extrusion speed.
                                  Currently, changing this parameter affects the probabilities corresponding to the following CLI options:
                                   - --extrusion-barrier-bound-stp
                                   - --extrusion-barrier-not-bound-stp
                                   - --lef-bar-major-collision-prob
                                   - --lef-bar-minor-collision-prob
                                   - --probability-of-lef-bypass
      --normalize-probabilities,--no-normalize-probabilities{false}
                                  Toggle on/off normalization of transition and collision probabilities using --probability-normalization-factor.
```


## Metadata
- **Skill**: generated
