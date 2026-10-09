# kin CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| kin | PASS | synthetic data: the KIN toy example from the tool repo plus interval.txt and target_samples.txt (the two small files kingaroo writes); all 18 parent-child and 2 identical pairs were called correctly |
| kin_kingaroo | PASS | synthetic data: two nf-core human BAMs with the contig renamed to 1 and a bed of 1040 sites; window counts, hmm_parameters and hbd_results were written, 574 overlapping sites |

## kin

### Tool Description
Relatedness and IBD estimates

### Metadata
- **Docker Image**: quay.io/biocontainers/kin:3.1.4--pyhdfd78af_0
- **Homepage**: https://github.com/DivyaratanPopli/Kinship_Inference
- **Package**: https://anaconda.org/channels/bioconda/packages/kin/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kin/overview
- **Total Downloads**: 751
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/DivyaratanPopli/Kinship_Inference
- **Stars**: N/A
### Original Help Text
```text
usage: kin [-h] -I INPUT_LOCATION -O OUTPUT_LOCATION [-r ROH_FILE_LOCATION]
           [-c CORES] [-t THRESHOLD] [-p p_0]

Relatedness and IBD estimates

optional arguments:
  -h, --help            show this help message and exit
  -I INPUT_LOCATION, --input_location INPUT_LOCATION
                        input files location
  -O OUTPUT_LOCATION, --output_location OUTPUT_LOCATION
                        Output files location
  -r ROH_FILE_LOCATION, --ROH_file_location ROH_FILE_LOCATION
                        ROH files location
  -c CORES, --cores CORES
                        Number of cores available
  -t THRESHOLD, --threshold THRESHOLD
                        Minimum number of sites in a window for ROH
                        implementation
  -p p_0, --diversity_parameter_p_0 p_0
                        Input p_0 parameter, if you do not want to calculate
                        it from given samples (Keep it same as that for
                        KINgaroo)
```


## kin_kingaroo

### Tool Description
Input generation pipeline for KIN

### Metadata
- **Docker Image**: quay.io/biocontainers/kin:3.1.4--pyhdfd78af_0
- **Homepage**: https://github.com/DivyaratanPopli/Kinship_Inference
- **Package**: https://anaconda.org/channels/bioconda/packages/kin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kingaroo [-h] -bam BAMFILES_LOCATION -bed BEDFILE -T TARGET_LOCATION
                -cnt CONTAM_PARAMETER [-c CORES] [-i INTERVAL] [-t THRESHOLD]
                [-cest CONTAMINATION_ESTIMATES] [-d DIVERGENCE_FILE]
                [-tar TARGET_IND] [-cont CONTAMINATING_IND] [-r ROH]
                [-p DIVERSITY_PARAMETER_P_0] [-n NOISY_WINS]
                [-test TEST_INPUT] [-N NUMBER_OF_CHROMOSOMES] [-s SORT_INDEX]

Input generation pipeline for KIN

optional arguments:
  -h, --help            show this help message and exit
  -bam BAMFILES_LOCATION, --bamfiles_location BAMFILES_LOCATION
                        bamfiles directory
  -bed BEDFILE, --bedfile BEDFILE
                        path to bedfile
  -T TARGET_LOCATION, --target_location TARGET_LOCATION
                        file with bamfile names that should be used without
                        extension
  -cnt CONTAM_PARAMETER, --contam_parameter CONTAM_PARAMETER
                        Enter 0 for no contamination correction. Enter 1 for
                        contamination correction with divergence calculated
                        from vcf.gz. Enter divergence (between 0 and 1) if
                        known.
  -c CORES, --cores CORES
                        Number of cores available
  -i INTERVAL, --interval INTERVAL
                        Length of a genomic window in bases. Options:1000000,
                        10000000 (by default 10000000)
  -t THRESHOLD, --threshold THRESHOLD
                        p_0 is estimated with all libraries that have atleast
                        t number of informative windows (by default t=10)
  -cest CONTAMINATION_ESTIMATES, --contamination_estimates CONTAMINATION_ESTIMATES
                        tab-separated contamination estimates file with
                        columns: name,contamination
  -d DIVERGENCE_FILE, --divergence_file DIVERGENCE_FILE
                        indexed compressed vcf file with an individual from
                        target and contaminating populations each. Diploid
                        Genotypes (GT) should be represented
  -tar TARGET_IND, --target_ind TARGET_IND
                        Name of target individual in divergence_vcf file
  -cont CONTAMINATING_IND, --contaminating_ind CONTAMINATING_IND
                        Name of contaminating individual in divergence_vcf
                        file
  -r ROH, --roh ROH     Enter 1 if you need ROH estimates. Enter 0 if you
                        already have the positions of ROH tracts (by
                        default:1).
  -p DIVERSITY_PARAMETER_P_0, --diversity_parameter_p_0 DIVERSITY_PARAMETER_P_0
                        Enter p_0 estimate for input to ROH-HMM, if quality of
                        samples is not good enough to estimate p_0.
  -n NOISY_WINS, --noisy_wins NOISY_WINS
                        You can optionally specify the noisy windows that
                        should be filtered out in a file with list of window
                        indexes (0-based).
  -test TEST_INPUT, --test_input TEST_INPUT
                        Enter 1 to test your input files
  -N NUMBER_OF_CHROMOSOMES, --number_of_chromosomes NUMBER_OF_CHROMOSOMES
                        Enter the total number of chromosomes. Default=22
  -s SORT_INDEX, --sort_index SORT_INDEX
                        Enter 1 if you need to sort and index the bamfiles.
                        Enter 0 to skip this step (by default:1).
```
