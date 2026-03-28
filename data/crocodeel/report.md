# crocodeel CWL Generation Report

## crocodeel_easy_wf

### Tool Description
Detects and quantifies contamination events in metagenomic samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/crocodeel:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/metagenopolis/crocodeel
- **Package**: https://anaconda.org/channels/bioconda/packages/crocodeel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crocodeel/overview
- **Total Downloads**: 3.5K
- **Last updated**: 2026-02-11
- **GitHub**: https://github.com/metagenopolis/crocodeel
- **Stars**: N/A
### Original Help Text
```text
usage: crocodeel easy_wf [-h] -s SPECIES_ABUNDANCE_TABLE
                         [-s2 SPECIES_ABUNDANCE_TABLE_2]
                         [--filter-low-ab AB_THRESHOLD_FACTOR]
                         -c CONTAMINATION_EVENTS_FILE -r PDF_REPORT_FILE
                         [--nproc NPROC]

options:
  -h, --help            show this help message and exit
  -s SPECIES_ABUNDANCE_TABLE
                        Input TSV file corresponding to the species abundance
                        table
  -s2 SPECIES_ABUNDANCE_TABLE_2
                        Optional input TSV file corresponding to another
                        species abundance table. If provided, samples from
                        this table will be considered as contamination targets
                        while those from the first table as contamination
                        sources.
  --filter-low-ab AB_THRESHOLD_FACTOR
                        Filter out low-abundance species that may be
                        inaccurately quantified. In each sample, set the
                        abundance of species to zero if they are up to
                        AB_THRESHOLD_FACTOR times more abundant than the least
                        abundant species. Recommended value for MetaPhlAn4: 20
                        (default: None)
  -c CONTAMINATION_EVENTS_FILE
                        Output TSV file listing all contamination events
  -r PDF_REPORT_FILE    Output PDF file with scatterplots for all
                        contamination events
  --nproc NPROC         Number of parallel processes to search contaminations
                        (default: 20)
```


## crocodeel_search_conta

### Tool Description
Search for contamination events

### Metadata
- **Docker Image**: quay.io/biocontainers/crocodeel:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/metagenopolis/crocodeel
- **Package**: https://anaconda.org/channels/bioconda/packages/crocodeel/overview
- **Validation**: PASS

### Original Help Text
```text
usage: crocodeel search_conta [-h] -s SPECIES_ABUNDANCE_TABLE
                              [-s2 SPECIES_ABUNDANCE_TABLE_2]
                              [--filter-low-ab AB_THRESHOLD_FACTOR]
                              [-m RF_MODEL_FILE]
                              [--probability-cutoff PROBABILITY_CUTOFF]
                              [--rate-cutoff RATE_CUTOFF]
                              -c CONTAMINATION_EVENTS_FILE [--nproc NPROC]

options:
  -h, --help            show this help message and exit
  -s SPECIES_ABUNDANCE_TABLE
                        Input TSV file corresponding to the species abundance
                        table
  -s2 SPECIES_ABUNDANCE_TABLE_2
                        Optional input TSV file corresponding to another
                        species abundance table. If provided, samples from
                        this table will be considered as contamination targets
                        while those from the first table as contamination
                        sources.
  --filter-low-ab AB_THRESHOLD_FACTOR
                        Filter out low-abundance species that may be
                        inaccurately quantified. In each sample, set the
                        abundance of species to zero if they are up to
                        AB_THRESHOLD_FACTOR times more abundant than the least
                        abundant species. Recommended value for MetaPhlAn4: 20
                        (default: None)
  -m RF_MODEL_FILE      Joblib file containing the pre-trained Random Forest
                        model used to detect contamination events (default:
                        /usr/local/lib/python3.14/site-
                        packages/crocodeel/models/crocodeel_rf_Feb2026.joblib)
  --probability-cutoff PROBABILITY_CUTOFF
                        Only report contamination events with a probability
                        greater than PROBABILITY_CUTOFF (default: 0.50)
  --rate-cutoff RATE_CUTOFF
                        Only report events with a contamination rate greater
                        than RATE_CUTOFF (default: 0)
  -c CONTAMINATION_EVENTS_FILE
                        Output TSV file listing all contamination events
  --nproc NPROC         Number of parallel processes to search contaminations
                        (default: 20)
```


## crocodeel_plot_conta

### Tool Description
Generate scatterplots for contamination events.

### Metadata
- **Docker Image**: quay.io/biocontainers/crocodeel:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/metagenopolis/crocodeel
- **Package**: https://anaconda.org/channels/bioconda/packages/crocodeel/overview
- **Validation**: PASS

### Original Help Text
```text
usage: crocodeel plot_conta [-h] -s SPECIES_ABUNDANCE_TABLE
                            [-s2 SPECIES_ABUNDANCE_TABLE_2]
                            [--filter-low-ab AB_THRESHOLD_FACTOR]
                            -c CONTAMINATION_EVENTS_FILE -r PDF_REPORT_FILE
                            [--nrow NROW] [--ncol NCOL] [--no-conta-line]
                            [--color-conta-species]

options:
  -h, --help            show this help message and exit
  -s SPECIES_ABUNDANCE_TABLE
                        Input TSV file corresponding to the species abundance
                        table
  -s2 SPECIES_ABUNDANCE_TABLE_2
                        Optional input TSV file corresponding to another
                        species abundance table. If provided, samples from
                        this table will be considered as contamination targets
                        while those from the first table as contamination
                        sources.
  --filter-low-ab AB_THRESHOLD_FACTOR
                        Filter out low-abundance species that may be
                        inaccurately quantified. In each sample, set the
                        abundance of species to zero if they are up to
                        AB_THRESHOLD_FACTOR times more abundant than the least
                        abundant species. Recommended value for MetaPhlAn4: 20
                        (default: None)
  -c CONTAMINATION_EVENTS_FILE
                        Input TSV file listing all contaminations events.
  -r PDF_REPORT_FILE    Output PDF file with scatterplots for all
                        contamination events
  --nrow NROW           Number of scatterplots to draw vertically on each page
                        (default: 4)
  --ncol NCOL           Number of scatterplots to draw horizontally on each
                        page (default: 4)
  --no-conta-line       Do not show contamination line in scatterplots
  --color-conta-species
                        Use a different color for species introduced by
                        contamination
```


## crocodeel_test_install

### Tool Description
Test the installation of crocodeel

### Metadata
- **Docker Image**: quay.io/biocontainers/crocodeel:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/metagenopolis/crocodeel
- **Package**: https://anaconda.org/channels/bioconda/packages/crocodeel/overview
- **Validation**: PASS

### Original Help Text
```text
usage: crocodeel test_install [-h] [--keep-results]

options:
  -h, --help      show this help message and exit
  --keep-results  Keep all temporary results files.
```


## crocodeel_train_model

### Tool Description
Train a Random Forest model to classify species based on their abundance.

### Metadata
- **Docker Image**: quay.io/biocontainers/crocodeel:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/metagenopolis/crocodeel
- **Package**: https://anaconda.org/channels/bioconda/packages/crocodeel/overview
- **Validation**: PASS

### Original Help Text
```text
usage: crocodeel train_model [-h] -s SPECIES_ABUNDANCE_TABLE -m MODEL_FILE
                             -r JSON_REPORT_FILE [--test-size TEST_SIZE]
                             [--ntrees NTREES] [--rng-seed RNG_SEED]
                             [--nproc NPROC]

options:
  -h, --help            show this help message and exit
  -s SPECIES_ABUNDANCE_TABLE
                        Input TSV file corresponding to the species abundance
                        table
  -m MODEL_FILE         Output file storing the trained Random Forest model
  -r JSON_REPORT_FILE   Output JSON file storing classification performance
                        metrics for train and test splits
  --test-size TEST_SIZE
                        Proportion of dataset to include in test split
                        (default: 0.30)
  --ntrees NTREES       Number of trees in the RandomForest model (default:
                        100)
  --rng-seed RNG_SEED   Seed of the random number generator for
                        reproducibility (default: 0)
  --nproc NPROC         Number of parallel processes to search contaminations
                        (default: 20)
```


## Metadata
- **Skill**: generated
