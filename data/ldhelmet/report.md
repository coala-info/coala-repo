# ldhelmet CWL Generation Report

## ldhelmet_find_confs

### Tool Description
Finds configurations for LDHelmet.

### Metadata
- **Docker Image**: quay.io/biocontainers/ldhelmet:1.10--h0704011_8
- **Homepage**: http://sourceforge.net/projects/ldhelmet/
- **Package**: https://anaconda.org/channels/bioconda/packages/ldhelmet/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ldhelmet/overview
- **Total Downloads**: 7.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: ldhelmet find_confs [options] seq-file1 [seq-file2 ...]

General options:
  -v [ --version ]                Display version.
  -h [ --help ]                   Display help.

Component-specific options:
  --num_threads arg (=1)          Number of threads to use.
  -w [ --window_size ] arg (=50)  Window size.
  -o [ --output_file ] arg        Name for output file.
```


## ldhelmet_table_gen

### Tool Description
Generate tables for LDHelmet

### Metadata
- **Docker Image**: quay.io/biocontainers/ldhelmet:1.10--h0704011_8
- **Homepage**: http://sourceforge.net/projects/ldhelmet/
- **Package**: https://anaconda.org/channels/bioconda/packages/ldhelmet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ldhelmet table_gen [options]

General options:
  -v [ --version ]          Display version.
  -h [ --help ]             Display help.

Component-specific options:
  --num_threads arg (=1)    Number of threads to use.
  -c [ --conf_file ] arg    Two-site configuration file.
  -o [ --output_file ] arg  Name for output file.
  -t [ --theta ] arg        Theta value.
  -r [ --rhos ] arg         Rho values.
```


## ldhelmet_convert_table

### Tool Description
Converts LDhat style tables to a format suitable for LDhelmet.

### Metadata
- **Docker Image**: quay.io/biocontainers/ldhelmet:1.10--h0704011_8
- **Homepage**: http://sourceforge.net/projects/ldhelmet/
- **Package**: https://anaconda.org/channels/bioconda/packages/ldhelmet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ldhelmet convert_table [options]

General options:
  -v [ --version ]       Display version.
  -h [ --help ]          Display help.

Component-specific options:
  --input_table arg      LDhat style table to be converted.
  --output_table arg     Name for output file.
  --config_file arg      (Optional) File with configs.  This is only necessary 
                         if you have missing data.
```


## ldhelmet_pade

### Tool Description
Compute Pade coefficients for LDHelmet

### Metadata
- **Docker Image**: quay.io/biocontainers/ldhelmet:1.10--h0704011_8
- **Homepage**: http://sourceforge.net/projects/ldhelmet/
- **Package**: https://anaconda.org/channels/bioconda/packages/ldhelmet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ldhelmet pade [options]

General options:
  -v [ --version ]              Display version.
  -h [ --help ]                 Display help.

Component-specific options:
  --num_threads arg (=1)        Number of threads to use.
  -c [ --conf_file ] arg        Two-site configuration file.
  -o [ --output_file ] arg      Name for output file.
  -t [ --theta ] arg            Theta value.
  -x [ --num_coeff ] arg (=11)  Number of Pade coefficients to compute.
  --defect_threshold arg (=40)  Defect threshold for Pade coefficients.
```


## ldhelmet_rjmcmc

### Tool Description
Run rjmcmc

### Metadata
- **Docker Image**: quay.io/biocontainers/ldhelmet:1.10--h0704011_8
- **Homepage**: http://sourceforge.net/projects/ldhelmet/
- **Package**: https://anaconda.org/channels/bioconda/packages/ldhelmet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ldhelmet rjmcmc [options]

General options:
  -v [ --version ]                      Display version.
  -h [ --help ]                         Display help.

Component-specific options:
  --seed arg (=5489)                    Seed for pseudo-random number 
                                        generator.
  --num_threads arg (=1)                Number of threads.
  -o [ --output_file ] arg              Name of output file.
  --stats_thin arg (=1000)              Thinning parameter for summary 
                                        statistics.
  -n [ --num_iter ] arg (=10000)        Number of iterations to run rjMCMC.
  --burn_in arg (=1000)                 Number of iterations for burn-in (in 
                                        addition to number of iterations to run
                                        rjMCMC).
  -b [ --block_penalty ] arg (=10)      Block penalty for rjMCMC.
  --prior_rate arg (=1)                 Prior mean on recombination rate.
  -s [ --seq_file ] arg                 Sequence file.
  -l [ --lk_file ] arg                  Two-site likelihood table.
  -p [ --pade_file ] arg                Pade coefficients.
  -a [ --prior_file ] arg               Prior on ancestral allele for each 
                                        site.
  -m [ --mut_mat_file ] arg             Mutation matrix.
  -w [ --window_size ] arg (=50)        Window size.
  --pade_resolution arg (=10)           Pade grid increment.
  --pade_max_rho arg (=1000)            Maximum Pade grid value.
  --partition_length arg (=4001)        Partition length (number of SNPs).
  --overlap_length arg (=200)           Overlap length.
  --pos_file arg                        SNP positions for alternative input 
                                        format.
  --snps_file arg                       SNPs file for alternative input format.
  --max_lk_start arg (=0.001)           Rho value to begin maximum likelihood 
                                        estimation of background rate.
  --max_lk_end arg (=0.29999999999999999)
                                        Rho value to end maximum likelihood 
                                        estimation of background rate.
  --max_lk_resolution arg (=0.001)      Amount to increment by for maximum 
                                        likelihood estimation of background 
                                        rate.
```


## ldhelmet_post_to_text

### Tool Description
Converts LDHelmet output files to text format.

### Metadata
- **Docker Image**: quay.io/biocontainers/ldhelmet:1.10--h0704011_8
- **Homepage**: http://sourceforge.net/projects/ldhelmet/
- **Package**: https://anaconda.org/channels/bioconda/packages/ldhelmet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ldhelmet post_to_text [options] input_file

General options:
  -v [ --version ]          Display version.
  -h [ --help ]             Display help.

Component-specific options:
  -m [ --mean ]             Specify option to output mean.
  -p [ --perc ] arg         Percentile value. Specify option multiple times for
                            multiple percentiles.
  -o [ --output_file ] arg  Name of output file.
```


## ldhelmet_max_lk

### Tool Description
Maximum likelihood estimation of recombination rate

### Metadata
- **Docker Image**: quay.io/biocontainers/ldhelmet:1.10--h0704011_8
- **Homepage**: http://sourceforge.net/projects/ldhelmet/
- **Package**: https://anaconda.org/channels/bioconda/packages/ldhelmet/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ldhelmet max_lk [options]

General options:
  -v [ --version ]                      Display version.
  -h [ --help ]                         Display help.

Component-specific options:
  --num_threads arg (=1)                Number of threads.
  -s [ --seq_file ] arg                 Sequence file.
  -l [ --lk_file ] arg                  Two-site likelihood table.
  -p [ --pade_file ] arg                Pade coefficients.
  -a [ --prior_file ] arg               Prior on ancestral allele for each 
                                        site.
  -m [ --mut_mat_file ] arg             Mutation matrix.
  -w [ --window_size ] arg (=50)        Window size.
  --pade_resolution arg (=10)           Pade grid increment.
  --pade_max_rho arg (=1000)            Maximum Pade grid value.
  --pos_file arg                        SNP positions for alternative input 
                                        format.
  --snps_file arg                       SNPs file for alternative input format.
  --max_lk_start arg (=0.001)           Rho value to begin maximum likelihood 
                                        estimation.
  --max_lk_end arg (=0.29999999999999999)
                                        Rho value to end maximum likelihood 
                                        estimation.
  --max_lk_resolution arg (=0.001)      Amount to increment by for maximum 
                                        likelihood estimation.
```


## Metadata
- **Skill**: generated
