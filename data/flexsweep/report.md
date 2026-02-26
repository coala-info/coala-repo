# flexsweep CWL Generation Report

## flexsweep_cnn

### Tool Description
Run the Flexsweep CNN for training or prediction.

  Depending on the inputs the software train, predict or train/predict.

### Metadata
- **Docker Image**: quay.io/biocontainers/flexsweep:1.3--pyhdfd78af_0
- **Homepage**: https://github.com/jmurga/flexsweep
- **Package**: https://anaconda.org/channels/bioconda/packages/flexsweep/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/flexsweep/overview
- **Total Downloads**: 208
- **Last updated**: 2025-09-04
- **GitHub**: https://github.com/jmurga/flexsweep
- **Stars**: N/A
### Original Help Text
```text
Usage: flexsweep cnn [OPTIONS]

  Run the Flexsweep CNN for training or prediction.

  Depending on the inputs the software train, predict or train/predict.

  Train example:
      flexsweep cnn --train_data data/train.parquet --output_folder ./sims/

  Predict example:
      flexsweep cnn --model ./sims/model.keras --predict_data data/test.parquet --output_folder results/
  
  Train/predict example:
      flexsweep cnn --train_data data/train.parquet --predict_data data/train.parquet --output_folder ./sims/

Options:
  --train_data TEXT     Path to feature vectors from simulations for training
                        the CNN.
  --predict_data TEXT   Path to feature vectors from empirical data for
                        prediction.
  --output_folder TEXT  Directory to store the trained model, logs, and
                        predictions.  [required]
  --model TEXT          Path to a pre-trained CNN model. If provided, the CNN
                        will only perform prediction.
  --help                Show this message and exit.
```


## flexsweep_fvs-discoal

### Tool Description
Estimate summary statistics from discoal simulations and build feature vectors.

  This command processes both neutral and sweep simulations in the given
  directory, computes a panel of summary statistics, and generates two
  outputs: a Parquet dataframe containing feature vectors, a Pickle dictionary
  containing neutral expectations and standard deviations (used for
  normalization during CNN training).

### Metadata
- **Docker Image**: quay.io/biocontainers/flexsweep:1.3--pyhdfd78af_0
- **Homepage**: https://github.com/jmurga/flexsweep
- **Package**: https://anaconda.org/channels/bioconda/packages/flexsweep/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: flexsweep fvs-discoal [OPTIONS]

  Estimate summary statistics from discoal simulations and build feature
  vectors.

  This command processes both neutral and sweep simulations in the given
  directory, computes a panel of summary statistics, and generates two
  outputs: a Parquet dataframe containing feature vectors, a Pickle dictionary
  containing neutral expectations and standard deviations (used for
  normalization during CNN training).

Options:
  --simulations_path TEXT  Directory containing neutral and sweeps discoal
                           simulations.  [required]
  --nthreads INTEGER       Number of threads for parallelization  [required]
  --help                   Show this message and exit.
```


## flexsweep_fvs-vcf

### Tool Description
Estimate summary statistics from VCF files and build feature vectors.

### Metadata
- **Docker Image**: quay.io/biocontainers/flexsweep:1.3--pyhdfd78af_0
- **Homepage**: https://github.com/jmurga/flexsweep
- **Package**: https://anaconda.org/channels/bioconda/packages/flexsweep/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: flexsweep fvs-vcf [OPTIONS]

  Estimate summary statistics from VCF files and build feature vectors.

  This command parses VCF files in the given directory, computes summary
  statistics per genomic window, and writes feature vectors suitable as CNN
  input.

  Example usage:
      # Run summary statistics from VCFs using 8 threads, no recombination map
      flexsweep fvs-vcf --vcf_path ./data --nthreads 8
  
      # Run with a recombination map
      flexsweep fvs-vcf --vcf_path ./data --nthreads 8 --recombination_map recomb_map.csv

  Notes: VCF files must be bgzipped and tabix-indexed.

Options:
  --vcf_path TEXT           Directory containing vcfs folder with all the VCF
                            files to analyze.  [required]
  --nthreads INTEGER        Number of threads for parallelization  [required]
  --recombination_map TEXT  Recombination map. Decode CSV format:
                            Chr,Begin,End,cMperMb,cM
  --pop TEXT                Population ID
  --help                    Show this message and exit.
```


## flexsweep_simulator

### Tool Description
Run the discoal Simulator with user-specified parameters.

### Metadata
- **Docker Image**: quay.io/biocontainers/flexsweep:1.3--pyhdfd78af_0
- **Homepage**: https://github.com/jmurga/flexsweep
- **Package**: https://anaconda.org/channels/bioconda/packages/flexsweep/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: flexsweep simulator [OPTIONS]

  Run the discoal Simulator with user-specified parameters.

  flexsweep.Simulator class, parsing mutation and recombination rate
  specifications from the command line, and dispatches neutral and sweep
  simulations to discoal.

  Example usage:
      flexsweep simulate --sample_size 20 --demes model.yaml --output_folder ./sims --nthreads 24

Options:
  --sample_size INTEGER      Number of haplotypes  [required]
  --mutation_rate TEXT       Mutation rate specification. Please input: - Two
                             comma-separated values: lower,upper (uniform
                             distribution bounds):  - Three values: min, max
                             and mean of an exponential distribution.Example:
                             '5e-9,2e-8' or '5e-9,2e-8,1e-8'
  --recombination_rate TEXT  Recombination rate specification. Please input:
                             - Two comma-separated values: lower,upper
                             (uniform distribution bounds):  - Three values:
                             min, max and mean of an exponential
                             distribution.Example: '1e-9,4e-8' or
                             '1e-9,4e-8,1e-8'
  --locus_length INTEGER     Length of the simulated locus in base pairs.
  --demes TEXT               Path to the demes YAML file describing
                             demography.  [required]
  --output_folder TEXT       Directory where simulation outputs will be saved.
                             [required]
  --time TEXT                Adaptive mutation time range in generations. Two
                             comma-separated values: start,end. Default:
                             '0,5000'
  --num_simulations INTEGER  Number of neutral and sweep simulations to
                             generate. Default: 10000.
  --nthreads INTEGER         Number of threads for parallelization. Default:
                             1.
  --discoal_path TEXT        Path to the discoal executable. If not provided,
                             using pre-compiled flexsweep.DISCOAL.
  --help                     Show this message and exit.
```


## Metadata
- **Skill**: generated
