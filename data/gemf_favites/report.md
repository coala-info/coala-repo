# gemf_favites CWL Generation Report

## gemf_favites_GEMF_FAVITES.py

### Tool Description
User-friendly GEMF wrapper for use in FAVITES (or elsewhere). Niema Moshiri
2022

### Metadata
- **Docker Image**: quay.io/biocontainers/gemf_favites:1.0.3--h7b50bb2_1
- **Homepage**: https://github.com/niemasd/GEMF
- **Package**: https://anaconda.org/channels/bioconda/packages/gemf_favites/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gemf_favites/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/niemasd/GEMF
- **Stars**: N/A
### Original Help Text
```text
usage: GEMF_FAVITES.py [-h] -c CONTACT_NETWORK -s INITIAL_STATES
                       -i INFECTED_STATES -r RATES -t END_TIME -o OUTPUT
                       [--max_events MAX_EVENTS] [--output_all_transitions]
                       [--quiet] [--rng_seed RNG_SEED] [--gemf_path GEMF_PATH]

User-friendly GEMF wrapper for use in FAVITES (or elsewhere). Niema Moshiri
2022

options:
  -h, --help            show this help message and exit
  -c, --contact_network CONTACT_NETWORK
                        Contact Network (TSV) (default: None)
  -s, --initial_states INITIAL_STATES
                        Initial States (TSV) (default: None)
  -i, --infected_states INFECTED_STATES
                        Infected States (one per line) (default: None)
  -r, --rates RATES     State Transition Rates (TSV) (default: None)
  -t, --end_time END_TIME
                        End Time (default: None)
  -o, --output OUTPUT   Output Directory (default: None)
  --max_events MAX_EVENTS
                        Max Number of Events (default: 4294967295)
  --output_all_transitions
                        Output All Transition Events (slower) (default: False)
  --quiet               Suppress log messages (default: False)
  --rng_seed RNG_SEED   Random Number Generation Seed (default: None)
  --gemf_path GEMF_PATH
                        Path to GEMF Executable (default: GEMF)
```

