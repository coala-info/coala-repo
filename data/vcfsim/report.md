# vcfsim CWL Generation Report

## vcfsim

### Tool Description
VCFSim is used to accurately simulate VCFs

### Metadata
- **Docker Image**: quay.io/biocontainers/vcfsim:1.0.27.alpha--pyhdc42f0e_0
- **Homepage**: https://github.com/Pie115/VCFSimulator-SamukLab
- **Package**: https://anaconda.org/channels/bioconda/packages/vcfsim/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vcfsim/overview
- **Total Downloads**: 7.3K
- **Last updated**: 2025-12-27
- **GitHub**: https://github.com/Pie115/VCFSimulator-SamukLab
- **Stars**: N/A
### Original Help Text
```text
usage: vcfsim [-h] [--chromosome [CHROMOSOME]] [--replicates [REPLICATES]]
              --seed [SEED] [--sequence_length [SEQUENCE_LENGTH]]
              [--ploidy [PLOIDY]] [--Ne [NE]] [--mu [MU]]
              [--percent_missing_sites [PERCENT_MISSING_SITES]]
              --percent_missing_genotypes [PERCENT_MISSING_GENOTYPES]
              [--hmm_baseline [HMM_BASELINE]]
              [--hmm_multiplier [HMM_MULTIPLIER]]
              [--hmm_p_good_to_bad [HMM_P_GOOD_TO_BAD]]
              [--hmm_p_bad_to_good [HMM_P_BAD_TO_GOOD]]
              [--output_file [OUTPUT_FILE]]
              [--chromosome_file [CHROMOSOME_FILE]]
              [--population_mode [POPULATION_MODE]] [--time [TIME]]
              (--sample_size [SAMPLE_SIZE] | --samples [SAMPLES ...] |
              --samples_file [SAMPLES_FILE])

VCFSim is used to accurately simulate VCFs

required arguments:
  --seed [SEED]         Random seed for VCFSim to use
  --percent_missing_sites [PERCENT_MISSING_SITES]
                        Percent of rows missing from your VCF
  --percent_missing_genotypes [PERCENT_MISSING_GENOTYPES]
                        Percent of samples missing from your VCF

optional arguments:
  --chromosome [CHROMOSOME]
                        Chromosome name
  --replicates [REPLICATES]
                        Amount of times for Simulator to run
  --sequence_length [SEQUENCE_LENGTH]
                        Size of your site
  --ploidy [PLOIDY]     Ploidy for your VCF
  --Ne [NE]             Effective population size of the simulated population
  --mu [MU]             Mutation rate in the simulated population
  --hmm_baseline [HMM_BASELINE]
                        Baseline site missing probability in good regions
  --hmm_multiplier [HMM_MULTIPLIER]
                        Multiplier for missingness in bad regions
  --hmm_p_good_to_bad [HMM_P_GOOD_TO_BAD]
                        Probability of switching from good to bad region
  --hmm_p_bad_to_good [HMM_P_BAD_TO_GOOD]
                        Probability of switching from bad to good region
  --output_file [OUTPUT_FILE]
                        Filename of outputed vcf, will automatically be
                        followed by seed
  --chromosome_file [CHROMOSOME_FILE]
                        Specified file for multiple chromosome inputs
  --population_mode [POPULATION_MODE]
                        1 = single population (default), 2 = population C
                        splits into A and B at given time
  --time [TIME]         Time of split (only used if --population_mode is 2)
```

