# snakesee CWL Generation Report

## snakesee_watch

### Tool Description
Watch a Snakemake workflow in real-time with a TUI dashboard.

### Metadata
- **Docker Image**: quay.io/biocontainers/snakesee:0.6.1--pyhdfd78af_0
- **Homepage**: https://github.com/nh13/snakesee
- **Package**: https://anaconda.org/channels/bioconda/packages/snakesee/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/snakesee/overview
- **Total Downloads**: 147
- **Last updated**: 2026-01-15
- **GitHub**: https://github.com/nh13/snakesee
- **Stars**: N/A
### Original Help Text
```text
usage: snakesee watch [-h] [-r REFRESH] [-n] [-p PROFILE]
                      [--wildcard-timing | --no-wildcard-timing]
                      [--weighting-strategy {index,time}]
                      [--half-life-logs HALF_LIFE_LOGS]
                      [--half-life-days HALF_LIFE_DAYS]
                      [workflow_dir]

Watch a Snakemake workflow in real-time with a TUI dashboard.

Passively monitors the .snakemake/ directory without requiring
special flags when running snakemake. Press 'q' to quit the TUI.

positional arguments:
  workflow_dir          Path to workflow directory containing .snakemake/.
                        (default: .)

options:
  -h, --help            show this help message and exit
  -r, --refresh REFRESH
                        Refresh interval in seconds (0.5 to 60.0).
                        (default: 2.0)
  -n, --no-estimate     Disable time estimation from historical data.
                        (default: False)
  -p, --profile PROFILE
                        Optional path to a timing profile (.snakesee-profile.json)
                        for bootstrapping estimates. If not specified, will auto-discover.
                        (default: None)
  --wildcard-timing, --no-wildcard-timing
                        Use wildcard conditioning for estimates (estimate per
                        sample/batch). Enabled by default. Toggle with 'w' key in TUI.
                        (default: True)
  --weighting-strategy {index,time}
                        Strategy for weighting historical timing data.
                        "index" (default) - weight by run index, ideal for active
                        development where each run may fix issues.
                        "time" - weight by wall-clock time, better for stable pipelines.
                        (default: index)
  --half-life-logs HALF_LIFE_LOGS
                        Half-life in number of runs for index-based weighting.
                        After this many runs, a run's weight is halved. Default: 10.
                        Only used when weighting_strategy="index".
                        (default: 10)
  --half-life-days HALF_LIFE_DAYS
                        Half-life in days for time-based weighting.
                        After this many days, a run's weight is halved. Default: 7.0.
                        Only used when weighting_strategy="time".
                        (default: 7.0)
```


## snakesee_status

### Tool Description
Show a one-time status snapshot (non-interactive).

Useful for scripting or quick checks.

### Metadata
- **Docker Image**: quay.io/biocontainers/snakesee:0.6.1--pyhdfd78af_0
- **Homepage**: https://github.com/nh13/snakesee
- **Package**: https://anaconda.org/channels/bioconda/packages/snakesee/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snakesee status [-h] [-n] [-p PROFILE] [workflow_dir]

Show a one-time status snapshot (non-interactive).

Useful for scripting or quick checks.

positional arguments:
  workflow_dir          Path to workflow directory containing .snakemake/.
                        (default: .)

options:
  -h, --help            show this help message and exit
  -n, --no-estimate     Disable time estimation from historical data.
                        (default: False)
  -p, --profile PROFILE
                        Optional path to a timing profile for bootstrapping estimates.
                        (default: None)
```


## snakesee_profile-export

### Tool Description
Export timing profile from workflow metadata.

Creates a portable JSON file containing historical timing data that can
be shared across machines or used to bootstrap estimates for new runs.

### Metadata
- **Docker Image**: quay.io/biocontainers/snakesee:0.6.1--pyhdfd78af_0
- **Homepage**: https://github.com/nh13/snakesee
- **Package**: https://anaconda.org/channels/bioconda/packages/snakesee/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snakesee profile-export [-h] [-o OUTPUT] [-m] [workflow_dir]

Export timing profile from workflow metadata.

Creates a portable JSON file containing historical timing data that can
be shared across machines or used to bootstrap estimates for new runs.

positional arguments:
  workflow_dir         Path to workflow directory containing .snakemake/.
                       (default: .)

options:
  -h, --help           show this help message and exit
  -o, --output OUTPUT  Output file path. Defaults to .snakesee-profile.json in workflow_dir.
                       (default: None)
  -m, --merge          If output file exists, merge with existing data instead of replacing.
                       (default: False)
```


## snakesee_profile-show

### Tool Description
Display contents of a timing profile.

### Metadata
- **Docker Image**: quay.io/biocontainers/snakesee:0.6.1--pyhdfd78af_0
- **Homepage**: https://github.com/nh13/snakesee
- **Package**: https://anaconda.org/channels/bioconda/packages/snakesee/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snakesee profile-show [-h] profile_path

Display contents of a timing profile.

positional arguments:
  profile_path  Path to the profile file.

options:
  -h, --help    show this help message and exit
```


## snakesee_log-handler-path

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/snakesee:0.6.1--pyhdfd78af_0
- **Homepage**: https://github.com/nh13/snakesee
- **Package**: https://anaconda.org/channels/bioconda/packages/snakesee/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: snakesee log-handler-path [-h]

Print the path to the log handler script for Snakemake 8.x.

Use with: snakemake --log-handler-script $(snakesee log-handler-path) --cores 4

This enables real-time job tracking without requiring Snakemake 9+.

options:
  -h, --help  show this help message and exit
```


## Metadata
- **Skill**: generated
