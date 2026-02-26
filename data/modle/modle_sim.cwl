cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - modle
  - simulate
label: modle_sim
doc: "Simulate loop extrusion and write resulting molecular contacts in a .cool file.\n\
  \nTool homepage: https://github.com/paulsengroup/MoDLE"
inputs:
  - id: assembly_name
    type:
      - 'null'
      - string
    doc: "Name of the genome assembly to be simulated.\n                         \
      \       This is only used to populate the \"assembly\" attribute in the output
      .cool file."
    default: unknown
    inputBinding:
      position: 101
      prefix: --assembly-name
  - id: avg_lef_processivity
    type:
      - 'null'
      - float
    doc: "Average LEF processivity in bp.\n                                The average
      LEF processivity corresponds to the average size of loops extruded by\n    \
      \                            unobstructed LEFs."
    default: 300000.0
    inputBinding:
      position: 101
      prefix: --avg-lef-processivity
  - id: burnin_extr_speed_coefficient
    type:
      - 'null'
      - float
    doc: "Extrusion speed coefficient to apply during the burn-in phase.\n       \
      \                           Setting this to numbers > 1.0 will speed-up the
      burn-in phase, as the average loop size will\n                             \
      \     stabilize faster.\n                                  IMPORTANT: Setting
      this parameter to values other than 1.0 comes with many gotchas.\n         \
      \                                    For the time being, tuning this parameter
      is not reccommended."
    default: 1.0
    inputBinding:
      position: 101
      prefix: --burnin-extr-speed-coefficient
  - id: burnin_history_length
    type:
      - 'null'
      - int
    doc: Number of epochs used to determine whether a simulation instance has 
      reached a stable state.
    default: 100
    inputBinding:
      position: 101
      prefix: --burnin-history-length
  - id: burnin_smoothing_window_size
    type:
      - 'null'
      - int
    doc: "Window size used to smooth metrics monitored to decide when the burn-in
      phase should be\n                                  terminated."
    default: 5
    inputBinding:
      position: 101
      prefix: --burnin-smoothing-window-size
  - id: burnin_target_epochs_for_lef_activation
    type:
      - 'null'
      - int
    doc: "Number of epochs over which LEFs are progressively activated and bound to
      DNA.\n                                  Note: this number is approximate, as
      LEFs are activated using a Possion process.\n                              \
      \    By default this parameter is computed based on the average LEF processivity,
      overall\n                                  extrusion speed and burn-in extrusion
      speed coefficient (--avg-lef-processivity,\n                               \
      \   --fwd/rev-extrusion-speed and --burn-in-extr-speed-coefficient respectively)."
    default: 320
    inputBinding:
      position: 101
      prefix: --burnin-target-epochs-for-lef-activation
  - id: chrom_sizes
    type: File
    doc: Path to file with chromosome sizes in chrom.sizes format.
    inputBinding:
      position: 101
      prefix: --chrom-sizes
  - id: contact_sampling_interval
    type:
      - 'null'
      - int
    doc: "Average number of base-pairs extruded by one LEF between two subsequent
      sampling events\n                                (assuming no collision have
      occurred).\n                                Specifying shorter intervals will
      increase the frequency of sampling frequency, producing more\n             \
      \                   contacts when --stopping-criterion=simulation-epochs or
      reducing the number of epochs simulated\n                                in
      case --stopping-criterion=contact-density.\n                               \
      \ Using sampling intervals that are significantly smaller than the average LEF
      processivity is usually\n                                not recommended, as
      will cause MoDLE to sample many contacts from a single loop."
    default: 50000
    inputBinding:
      position: 101
      prefix: --contact-sampling-interval
  - id: contact_sampling_strategy
    type:
      - 'null'
      - string
    doc: "Strategy to use when sampling contacts.\n                              \
      \  Should be one of:\n                                 - loop-only\n       \
      \                          - loop-only-with-noise\n                        \
      \         - tad-only\n                                 - tad-only-with-noise\n\
      \                                 - tad-plus-loop\n                        \
      \         - tad-plus-loop-with-noise\n                                When one
      of the *-with-noise strategies is specified, contacts are randomized by\n  \
      \                              applying a random offset to the location of LEF
      extrusion units.\n                                Offsets are drawn from a genextreme
      distrubution.\n                                The distribution parameters can
      be controlled through the options --mu, --sigma\n                          \
      \      and --xi."
    default: tad-plus-loop-with-noise
    inputBinding:
      position: 101
      prefix: --contact-sampling-strategy
  - id: diagonal_width
    type:
      - 'null'
      - int
    doc: "Width of the subdiagonal window for the in-memory contact matrix.\n    \
      \                            This setting affects the maximum distance of a
      pair of bins whose interactions will be\n                                tracked
      by MoDLE.\n                                As a rule of thumb, --diagonal-width
      should roughly 10x the average LEF processivity.\n                         \
      \       Setting --diagonal-width to very large values (i.e. tens of Mbp) will
      significantly\n                                increase MoDLE's memory requirements."
    default: 3000000
    inputBinding:
      position: 101
      prefix: --diagonal-width
  - id: extrusion_barrier_bound_stp
    type:
      - 'null'
      - float
    doc: "Self-transition probability for extrusion barriers in the \"bound\" state.\n\
      \                                  In other words, the probability that an extrusion
      barrier that is active in the current epoch\n                              \
      \    will remain active during the next epoch."
    inputBinding:
      position: 101
      prefix: --extrusion-barrier-bound-stp
  - id: extrusion_barrier_file
    type: File
    doc: "Path to a file in BED6+ format with the genomic coordinates of extrusion
      barriers to be simulated. The score field in a BED record should be a number
      between 0 and 1 and is interpreted as the extrusion barrier occupancy for the
      extrusion barrier described by the record.\n                               \
      \ Barriers mapping on chromosomes not listed in the chrom.sizes file passed
      through\n                                the --chrom-sizes option are ignored."
    inputBinding:
      position: 101
      prefix: --extrusion-barrier-file
  - id: extrusion_barrier_not_bound_stp
    type:
      - 'null'
      - float
    doc: "Self-transition probability for extrusion barriers in the \"not-bound\"\
      \ state.\n                                  In other words, the probability
      that an extrusion barrier that is inactive in the current\n                \
      \                  epoch will remain inactive during the next epoch."
    default: 0.7
    inputBinding:
      position: 101
      prefix: --extrusion-barrier-not-bound-stp
  - id: extrusion_barrier_occupancy
    type:
      - 'null'
      - float
    doc: "Probability that an extrusion barrier is occupied (i.e. blocking) at any
      given time.\n                                This parameter provides an easier
      mean to set --extrusion-barrier-bound-stp.\n                               \
      \ Passing this parameter will override barrier occupancies read from the BED
      file specified\n                                through --extrusion-barrier-file."
    inputBinding:
      position: 101
      prefix: --extrusion-barrier-occupancy
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files (if any).
    inputBinding:
      position: 101
      prefix: --force
  - id: fwd_extrusion_speed
    type:
      - 'null'
      - int
    doc: "Average extrusion speed expressed in bp/epoch for forward-moving extrusion
      units.\n                                  Extrusion units are assigned a candidate
      moving distance at the beginning of every epoch.\n                         \
      \         Moves are sampled from a normal distribution centered around --fwd-extrusion-speed
      and with\n                                  --fwd-extrusion-speed-std as its
      standard deviation. Candidate moves represent the maximum\n                \
      \                  distance a given extrusion unit is set to travel during the
      current epoch.\n                                  Moving distances can be shortened
      by collision events taking place during the current epoch.\n               \
      \                   By deafult extrusion speed is set to half the bin size specified
      through the --resolution\n                                  option."
    default: 4000
    inputBinding:
      position: 101
      prefix: --fwd-extrusion-speed
  - id: fwd_extrusion_speed_std
    type:
      - 'null'
      - float
    doc: "Standard deviation of the normal distribution used to sample candidate moves
      for extrusion\n                                  units moving in 5'-3' direction.
      See help message for --fwd-extrusion-speed for more details\n              \
      \                    regarding candidate moves.\n                          \
      \        Specifying --fwd-extrusion-speed-std=0 will make candidate moves deterministic.\n\
      \                                  Standard deviations between 0 and 1 are interpreted
      a percentage of the average extrusion\n                                  speed.\n\
      \                                  Example: when running modle sim --fwd-extrusion-speed=10000
      ...\n                                           --fwd-extrusion-speed-std=0.1
      and --fwd-extrusion-speed-std=1000 are equivalent."
    default: 0.05
    inputBinding:
      position: 101
      prefix: --fwd-extrusion-speed-std
  - id: genextr_location
    type:
      - 'null'
      - float
    doc: "Location parameter (mu) of the generalized extreme value distribution used
      to add noise to\n                                  molecular contacts."
    default: 0.0
    inputBinding:
      position: 101
      prefix: --genextr-location
  - id: genextr_scale
    type:
      - 'null'
      - float
    doc: "Scale parameter (sigma) of the generalized extreme value distribution used
      to add noise to\n                                  molecular contacts."
    default: 5000.0
    inputBinding:
      position: 101
      prefix: --genextr-scale
  - id: genextr_shape
    type:
      - 'null'
      - float
    doc: "Shape parameter (xi) of the generalized extreme value distribution used
      to add noise to\n                                  molecular contacts."
    default: 0.001
    inputBinding:
      position: 101
      prefix: --genextr-shape
  - id: genomic_intervals
    type:
      - 'null'
      - File
    doc: "Path to BED3+ file with the genomic regions to be simulated.\n         \
      \                       Intervals listed in this file should be a subset of
      the chromosomes defined in the .chrom.sizes files.\n                       \
      \         Intervals referring to chromosomes not listed in the .chrom.sizes
      file are ignored."
    inputBinding:
      position: 101
      prefix: --genomic-intervals
  - id: hard_stall_lef_stability_multiplier
    type:
      - 'null'
      - float
    doc: "Coefficient to control the DNA-binding stability of LEFs that are stalled
      on both sides by a\n                                  pair of extrusion barriers
      in convergent orientation.\n                                  Setting this to
      1 makes the DNA-binding stability of hard-stalled LEFs identical to that of\n\
      \                                  unobstructed LEFs. Has no effects when --lef-bar-major-collision-prob=0."
    default: 5.0
    inputBinding:
      position: 101
      prefix: --hard-stall-lef-stability-multiplier
  - id: interpret_extrusion_barrier_name_as_not_bound_stp
    type:
      - 'null'
      - boolean
    doc: "Interpret the name field of the extrusion barrier BED file passed through
      --extrusion-barrier-file\n                                  as the not-bound
      stp for the barrier defined by the BED record."
    inputBinding:
      position: 101
      prefix: --interpret-extrusion-barrier-name-as-not-bound-stp
  - id: lef_bar_major_collision_prob
    type:
      - 'null'
      - float
    doc: "Probability of collision between LEFs and extrusion barriers where barriers
      are pointing\n                                  towards the extrusion direction."
    default: 1.0
    inputBinding:
      position: 101
      prefix: --lef-bar-major-collision-prob
  - id: lef_bar_minor_collision_prob
    type:
      - 'null'
      - float
    doc: "Probability of collision between LEFs and extrusion barriers where barriers
      are pointing\n                                  away from the extrusion direction."
    default: 0.0
    inputBinding:
      position: 101
      prefix: --lef-bar-minor-collision-prob
  - id: lef_density
    type:
      - 'null'
      - float
    doc: Loop extrusion factor (LEF) density expressed as the number of LEF per 
      Mbp of DNA simulated.
    default: 20.0
    inputBinding:
      position: 101
      prefix: --lef-density
  - id: lefs_per_mbp
    type:
      - 'null'
      - float
    doc: Loop extrusion factor (LEF) density expressed as the number of LEF per 
      Mbp of DNA simulated.
    default: 20.0
    inputBinding:
      position: 101
      prefix: --lefs-per-mbp
  - id: log_model_internal_state
    type:
      - 'null'
      - boolean
    doc: "Collect detailed statistics regarding the internal state of MoDLE simulation
      instance(s).\n                                  Statistics will be written to
      a compressed file under the prefix specified through the\n                 \
      \                 --output-prefix option.\n                                \
      \  Example: modle sim --output-prefix=/tmp/myprefix\n                      \
      \            statistics will be written to file /tmp/myprefix_internal_state.log.gz.\n\
      \                                  Depending on the input file(s) and parameters,
      specifying this option may hinder\n                                  simulation
      throughput. Currently the following metrics are collected:\n               \
      \                    - task_id\n                                   - epoch\n\
      \                                   - cell_id\n                            \
      \       - chrom\n                                   - start\n              \
      \                     - end\n                                   - burnin\n \
      \                                  - barrier_occupancy\n                   \
      \                - num_active_lefs\n                                   - num_stalls_rev\n\
      \                                   - num_stalls_fwd\n                     \
      \              - num_stalls_both\n                                   - num_lef_bar_collisions\n\
      \                                   - num_primary_lef_lef_collisions\n     \
      \                              - num_secondary_lef_lef_collisions\n        \
      \                           - avg_loop_size"
    inputBinding:
      position: 101
      prefix: --log-model-internal-state
  - id: max_burnin_epochs
    type:
      - 'null'
      - float
    doc: "Upper bound for the burn-in phase duration.\n                          \
      \        This is especially useful when simlating loop extrusion with very few
      LEFs.\n                                  When this is the case, --max-burnin-epochs=100000
      can be used as a very conservative\n                                  threshold."
    default: inf
    inputBinding:
      position: 101
      prefix: --max-burnin-epochs
  - id: min_burnin_epochs
    type:
      - 'null'
      - int
    doc: Lower bound for the burn-in phase duration.
    default: 0
    inputBinding:
      position: 101
      prefix: --min-burnin-epochs
  - id: mu
    type:
      - 'null'
      - float
    doc: "Location parameter (mu) of the generalized extreme value distribution used
      to add noise to\n                                  molecular contacts."
    default: 0.0
    inputBinding:
      position: 101
      prefix: --mu
  - id: ncells
    type:
      - 'null'
      - int
    doc: "Number of simulation instances or cells to simulate.\n                 \
      \               Loop extrusion will be simulated independently for every chromosome
      across --ncells\n                                simulation instances. The final
      contact matrix is produced by accumulating contacts\n                      \
      \          generated across all simulation instances. To achieve good performance
      and CPU utilization\n                                we recommend setting --ncells
      equal to the number of available CPU cores."
    default: 512
    inputBinding:
      position: 101
      prefix: --ncells
  - id: no_normalize_probabilities
    type:
      - 'null'
      - boolean
    doc: Toggle on/off normalization of transition and collision probabilities 
      using --probability-normalization-factor.
    default: false
    inputBinding:
      position: 101
      prefix: --no-normalize-probabilities
  - id: no_track_1d_lef_position
    type:
      - 'null'
      - boolean
    doc: "Toggle on/off tracking of LEF positions in 1D space.\n                 \
      \               LEF positions are aggregated across all simulated cells and
      are written to disk in BigWig format\n                                under
      the prefix specified through --output-prefix."
    default: false
    inputBinding:
      position: 101
      prefix: --no-track-1d-lef-position
  - id: normalize_probabilities
    type:
      - 'null'
      - boolean
    doc: Toggle on/off normalization of transition and collision probabilities 
      using --probability-normalization-factor.
    inputBinding:
      position: 101
      prefix: --normalize-probabilities
  - id: output_prefix
    type: string
    doc: "Output prefix.\n                                Can be an absolute or relative
      path including the file name but without the extension.\n                  \
      \              Example: running modle sim -o /tmp/my_simulation ... yields the
      following files:\n                                         - /tmp/my_simulation.cool\n\
      \                                         - /tmp/my_simulation.log\n       \
      \                                  - /tmp/my_simulation_config.toml\n      \
      \                                   - /tmp/my_simulation_lef_1d_occupancy.bw"
    inputBinding:
      position: 101
      prefix: --output-prefix
  - id: probability_normalization_factor
    type:
      - 'null'
      - int
    doc: "Normalization factor used to scale probabilities based on the overall average
      extrusion speed.\n                                  This is needed in order
      for the transition and collision probabilities to make sense when simulating\n\
      \                                  using different extrusion speeds.\n     \
      \                             Example: let us consider a simulation where:\n\
      \                                           - --extrusion-barrier-occupancy=0.5\n\
      \                                           - --extrusion-barrier-not-bound-stp=0.5\n\
      \                                           - --rev-extrusion-speed=5000\n \
      \                                          - --fwd-extrusion-speed=5000\n  \
      \                                         In this scenario we expect extrusion
      barriers to flip between active and inactive state\n                       \
      \                    every simulation epoch, that is every N bp of DNA extruded,
      where N is the product between\n                                           the
      overall extrusion speed (10kbp/epoch) and the number of LEFs that are being
      simulated in\n                                           one simulation instance.\n\
      \                                           If now we consider the same simulation
      carried out at much slower extrusion speed\n                               \
      \            (e.g. 100bp/epoch), the situation is quite different, as extrusion
      barriers switch between\n                                           active and
      inactive states once every N * (100 / 10 000) bp of DNA extruded.\n        \
      \                          This parameter is used to normalize transition and
      collision probabilities to avoid the issue outlined\n                      \
      \            in the example above. Basically specifying --probability-normalization-factor=10kb
      and\n                                  --extrusion-barrier-not-bound-stp=0.8
      instructs MoDLE to interpret the self-transition probability\n             \
      \                     specified through the CLI at an extrusion speed of 10kbp,
      and adjust the transition probability\n                                  based
      on the actual extrusion speed.\n                                  Currently,
      changing this parameter affects the probabilities corresponding to the following
      CLI options:\n                                   - --extrusion-barrier-bound-stp\n\
      \                                   - --extrusion-barrier-not-bound-stp\n  \
      \                                 - --lef-bar-major-collision-prob\n       \
      \                            - --lef-bar-minor-collision-prob\n            \
      \                       - --probability-of-lef-bypass"
    default: 8000
    inputBinding:
      position: 101
      prefix: --probability-normalization-factor
  - id: probability_of_lef_bypass
    type:
      - 'null'
      - float
    doc: Probability that two colliding LEFs will avoid collision by bypassing 
      each other.
    default: 0.1
    inputBinding:
      position: 101
      prefix: --probability-of-lef-bypass
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Suppress console output to stderr.\n                                Only
      fatal errors will be logged to the console.\n                              \
      \  Does not affect entries written to the log file."
    inputBinding:
      position: 101
      prefix: --quiet
  - id: resolution
    type:
      - 'null'
      - int
    doc: "Resolution in base-pairs for the output contact matrix in cooler format.\n\
      \                                NOTE: MoDLE simulation always take place at
      1 bp resolution.\n                                      This parameter only
      affects the resolution of the output contact matrix."
    default: 5000
    inputBinding:
      position: 101
      prefix: --resolution
  - id: rev_extrusion_speed
    type:
      - 'null'
      - int
    doc: Same as --fwd-extrusion-speed but for extrusion units moving in 3'-5' 
      direction.
    default: 4000
    inputBinding:
      position: 101
      prefix: --rev-extrusion-speed
  - id: rev_extrusion_speed_std
    type:
      - 'null'
      - float
    doc: Same as --fwd-extrusion-speed-std but for extrusion units moving in 
      3'-5' direction.
    default: 0.05
    inputBinding:
      position: 101
      prefix: --rev-extrusion-speed-std
  - id: seed
    type:
      - 'null'
      - int
    doc: Base seed to use for random number generation.
    default: 0
    inputBinding:
      position: 101
      prefix: --seed
  - id: sigma
    type:
      - 'null'
      - float
    doc: "Scale parameter (sigma) of the generalized extreme value distribution used
      to add noise to\n                                  molecular contacts."
    default: 5000.0
    inputBinding:
      position: 101
      prefix: --sigma
  - id: simulate_chromosomes_wo_barriers
    type:
      - 'null'
      - boolean
    doc: "Enable/disable simulation of loop extrusion for chromosomes with 0 extrusion
      barriers.\n                                  When --skip-chromosomes-wo-barriers
      is passed, entries for chromosomes without barriers\n                      \
      \            will still be written to the output .cool file, but no contacts
      will be generated for\n                                  those chromosomes."
    inputBinding:
      position: 101
      prefix: --simulate-chromosomes-wo-barriers
  - id: skip_burnin
    type:
      - 'null'
      - boolean
    doc: Skip the burn-in phase and start collecting contacts from the first 
      extrusion round.
    inputBinding:
      position: 101
      prefix: --skip-burnin
  - id: skip_chromosomes_wo_barriers
    type:
      - 'null'
      - boolean
    doc: "Enable/disable simulation of loop extrusion for chromosomes with 0 extrusion
      barriers.\n                                  When --skip-chromosomes-wo-barriers
      is passed, entries for chromosomes without barriers\n                      \
      \            will still be written to the output .cool file, but no contacts
      will be generated for\n                                  those chromosomes."
    default: false
    inputBinding:
      position: 101
      prefix: --skip-chromosomes-wo-barriers
  - id: skip_output
    type:
      - 'null'
      - boolean
    doc: Do not write output files. Mostly useful for profiling.
    inputBinding:
      position: 101
      prefix: --skip-output
  - id: soft_stall_lef_stability_multiplier
    type:
      - 'null'
      - float
    doc: "Coefficient to control the DNA-binding stability of LEFs stalled by one
      or more extrusion\n                                  barriers in a non-blocking
      orientation. Setting this to 1 makes the DNA-binding stability\n           \
      \                       of soft-stalled LEFs identical to that of unobstructed
      LEFs.\n                                  Has no effects when --lef-bar-minor-collision-prob=0."
    default: 1.0
    inputBinding:
      position: 101
      prefix: --soft-stall-lef-stability-multiplier
  - id: stopping_criterion
    type:
      - 'null'
      - string
    doc: Simulation stopping criterion. Should be one of contact-density or 
      simulation-epochs.
    default: contact-density
    inputBinding:
      position: 101
      prefix: --stopping-criterion
  - id: tad_to_loop_contact_ratio
    type:
      - 'null'
      - float
    doc: "Ratio between the number of TAD and loop contacts.\n                   \
      \               Loop contacts are sampled using the position of the extrusion
      units of a LEF.\n                                  This type of contact visually
      correspond to stripes and dots in the output matrix.\n                     \
      \             TAD contacts are sampled from the body of a loop and visually
      correspond to TADs.\n                                  Use \"0\" to disable
      sampling of TAD contacts.\n                                  Use \"inf\" to
      disable sampling of loop contacts."
    default: 5.0
    inputBinding:
      position: 101
      prefix: --tad-to-loop-contact-ratio
  - id: target_contact_density
    type:
      - 'null'
      - float
    doc: "Average contact density to be reached before the simulation is halted.\n\
      \                                The target contact density applies independently
      to each chromosome.\n                                Example: modle sim --chrom-sizes
      hg38.chr1.chrom.sizes \\\n                                                 \
      \  --diagonal-width 3000000            \\\n                                \
      \                   --resolution 100000                 \\\n               \
      \                                    --target-contact-density 2\n          \
      \                               Assuming chr1 is exactly 250 Mbp long, MoDLE
      will schedule simulation instances to yield\n                              \
      \           a total of 150 000 contacts for chr1: 2 * (250e6 / 100e3) * (3e6
      / 100e3) = 150e3."
    inputBinding:
      position: 101
      prefix: --target-contact-density
  - id: target_number_of_epochs
    type:
      - 'null'
      - int
    doc: "Target number of epochs to be simulated.\n                             \
      \   Each simulation instance will run exactly --target-number-of-epochs epochs
      after burn-in\n                                phase. Has no effect when --stopping-criterion=\"\
      contact-density\"."
    default: 2000
    inputBinding:
      position: 101
      prefix: --target-number-of-epochs
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of worker threads used to run simulation instances.\n           \
      \                     By default MoDLE will spawn a number of worker threads
      equal to the number of logical CPU\n                                cores. On
      high core count machines a slightly better performance can usually be obtained\n\
      \                                by setting --threads equal to the number of
      physical CPU cores."
    default: 20
    inputBinding:
      position: 101
      prefix: --threads
  - id: track_1d_lef_position
    type:
      - 'null'
      - boolean
    doc: "Toggle on/off tracking of LEF positions in 1D space.\n                 \
      \               LEF positions are aggregated across all simulated cells and
      are written to disk in BigWig format\n                                under
      the prefix specified through --output-prefix."
    inputBinding:
      position: 101
      prefix: --track-1d-lef-position
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase verbosity of log to console.\n                                Does
      not affect entries written to the log file."
    inputBinding:
      position: 101
      prefix: --verbose
  - id: xi
    type:
      - 'null'
      - float
    doc: "Shape parameter (xi) of the generalized extreme value distribution used
      to add noise to\n                                  molecular contacts."
    default: 0.001
    inputBinding:
      position: 101
      prefix: --xi
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/modle:1.1.0--h63853f4_0
stdout: modle_sim.out
