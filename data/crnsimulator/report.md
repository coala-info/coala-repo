# crnsimulator CWL Generation Report

## crnsimulator

### Tool Description
crnsimulator

### Metadata
- **Docker Image**: quay.io/biocontainers/crnsimulator:0.9--pyh5bfb8f1_0
- **Homepage**: https://github.com/bad-ants-fleet/crnsimulator
- **Package**: https://anaconda.org/channels/bioconda/packages/crnsimulator/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crnsimulator/overview
- **Total Downloads**: 5.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bad-ants-fleet/crnsimulator
- **Stars**: N/A
### Original Help Text
```text
usage: crnsimulator [-h] [--version] [-v] [--logfile <str>] [--force]
                    [--dryrun] [-o <str>] [--jacobian] [--t0 <flt>]
                    [--t8 <flt>] [--t-lin <int>] [--t-log <int>]
                    [--p0 <int/str>=<flt> [<int/str>=<flt> ...]] [-a <flt>]
                    [-r <flt>] [--mxstep <int>] [--list-labels]
                    [--labels <str>+ [<str>+ ...]] [--labels-strict] [--nxy]
                    [--header] [--pyplot <str>] [--pyplot-xlim <flt> <flt>]
                    [--pyplot-ylim <flt> <flt>]

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -v, --verbose         Print logging output. (-vv increases verbosity.)
                        (default: 0)
  --logfile <str>       Redirect logging information to a file. (default: )
  --force               Overwrite existing files (default: False)
  --dryrun              Do not run the simulation, only write the files.
                        (default: False)
  -o <str>, --output <str>
                        Name of ODE library files. (default: odesystem)
  --jacobian            Symbolic calculation of Jacobi-Matrix. This may
                        generate a very large simulation file. (default:
                        False)

odeint parameters:
  --t0 <flt>            First time point of the time-course. (default: 0)
  --t8 <flt>            End point of simulation time. (default: 100)
  --p0 <int/str>=<flt> [<int/str>=<flt> ...]
                        Vector of initial species concentrations. E.g. "--p0
                        1=0.5 3=0.7" stands for 1st species at a concentration
                        of 0.5 and 3rd species at a concentration of 0.7. You
                        may chose to address species directly by name, e.g.:
                        --p0 C=0.5. (default: None)
  -a <flt>, --atol <flt>
                        Specify absolute tolerance for the solver. (default:
                        None)
  -r <flt>, --rtol <flt>
                        Specify relative tolerance for the solver. (default:
                        None)
  --mxstep <int>        Maximum number of steps allowed for each integration
                        point in t. (default: 0)

plotting parameters:
  --t-lin <int>         Returns --t-lin evenly spaced numbers on a linear
                        scale from --t0 to --t8. (default: 500)
  --t-log <int>         Returns --t-log evenly spaced numbers on a logarithmic
                        scale from --t0 to --t8. (default: None)
  --list-labels         Print all species and exit. (default: False)
  --labels <str>+ [<str>+ ...]
                        Specify the (order of) species which should appear in
                        the pyplot legend, as well as the order of species for
                        nxy output format. (default: [])
  --labels-strict       When using pyplot, only plot tracjectories
                        corresponding to labels, when using nxy, only print
                        the trajectories corresponding to labels. (default:
                        False)
  --nxy                 Print time course to STDOUT in nxy format. (default:
                        False)
  --header              Print header for trajectories. (default: False)
  --pyplot <str>        Specify a filename to plot the ODE simulation.
                        (default: )
  --pyplot-xlim <flt> <flt>
                        Specify the limits of the x-axis. (default: None)
  --pyplot-ylim <flt> <flt>
                        Specify the limits of the y-axis. (default: None)
```

