# pepsirf CWL Generation Report

## pepsirf_enrich

### Tool Description
The enrich module determines which peptides are enriched in samples that have been assayed in n-replicate, as determined by user-specified thresholds.

### Metadata
- **Docker Image**: quay.io/biocontainers/pepsirf:1.7.1--h077b44d_0
- **Homepage**: https://github.com/LadnerLab/PepSIRF
- **Package**: https://anaconda.org/channels/bioconda/packages/pepsirf/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pepsirf/overview
- **Total Downloads**: 2.7K
- **Last updated**: 2025-04-27
- **GitHub**: https://github.com/LadnerLab/PepSIRF
- **Stars**: N/A
### Original Help Text
```text
PepSIRF (v1.7.1): Peptide-based Serological Immune Response Framework Enrichment module.
The enrich module determines which peptides are enriched in samples that have been assayed in n-replicate, as determined by user-specified thresholds. Thresholds can be provided either as single integers or comma-delimted integer pairs. In order for a peptide to be considered enriched, all replicates must meet or exceed the lower threshold and at least one replicate must meet or exceed the higher threshold, independent of order. Note that a peptide must meet each specified threshold (e.g., zscore, norm count, etc.) in order to be considered enriched. If any replicates fail the --raw_score_constraint, that sample will be omitted from the analysis.
:
  -h [ --help ]                                        Produce help message and exit.
                                                       
  -t [ --threshhold_file ] arg                         The name of a tab-delimited file containing one tab-delimited matrix filename and threshold(s), one per line. If using more than one threshold for a given matrix, then separate by comma. A matrix file may contain any score of interest, as long as it includes scores for each peptide in every sample of interest, with peptides on the rows and sample names on the columns. The provided thresholds should be comma-separated if more than one is provided for a single matrix file.
                                                       
  -s [ --samples ] arg                                 The name of the tab-delimited file containing sample information, denoting which samples, in the input matrices, are replicates. This file must be tab-delimited with each line containing a set of replicates.
                                                       
  -r [ --raw_scores ] arg                              Optionally, a tab-delimited matrix containing raw counts can be provided. This matrix must contain the raw counts for each Peptide for every sample of interest. If included, '--raw_score_constraint' must also be specified.
                                                       
  --raw_score_constraint arg                           The minimum total raw count across all peptides for a sample to be included in the analysis.This provides a way to impose a minimum read count for a sample to be evaluated.
                                                       
  -f [ --enrichment_failure_reason ] arg               For each sample set that does not result in the generation of an enriched peptide file, a row of two tab-delimited columns is provided: the first column contains the replicate names (comma-delimited) and the second column provides the reason why the sample did not result in an enriched peptide file.
                                                       This file is output to the same directory as the enriched peptide files. The 'Reason' column will contain one of the following: 'Raw read count threshold' or 'No enriched peptides'.
                                                       
  -x [ --outfile_suffix ] arg                          Suffix to add to all output files. Together, the sample name(s) and the suffix will form the name of the output file for each sample. For example, with a suffix of '_enriched.txt' and a sample name of ‘sample1’, the name of the output file for this sample would be ‘sample1_enriched.txt’. By default, no suffix is used.
                                                       
  -j [ --join_on ] arg (=~)                            A character or string to use to join replicate sample names in order to create output file names. For a pair of samples, 'A' and 'B', the resulting file will have the name 'A~B' if this flag is not given. Otherwise, the given value will be used in place of '~'.
                                                       
  --output_filename_truncate                           By default each filename in the output directory will include every replicate name joined by the 'join_on' value. Alternatively, if more than two replicates are being evaluated, then you may include this flag to stop the filenames from including more than 3 samplenames in the output. When this flag is used, the output names will be of the form 'A~B~C~1more', for example.
                                                       
  -l [ --low_raw_reads ]                               By default samples with any replicates below the raw read threshold will be dropped when this flag is included, replicates with reads above the threshold will be kept 
                                                       
  -o [ --output ] arg (=enriched)                      Directory name to which output files will be written. An output file will be generated for each sample with at least one enriched peptide. This directory will be created by the module.
                                                       
  --logfile arg (=Enrich_Sat_Feb_14_05-40-35_2026.log) Designated file to which the module's processes are logged. By default, the logfile's name will include the module's name and the time the module started running.
```


## pepsirf_bin

### Tool Description
The bin module is used to create groups of peptides with similar starting abundances (i.e. bins), based on the normalized read counts for >= 1 negative controls. These bins can be provided as an input for zscore calculations using the zscore module.

### Metadata
- **Docker Image**: quay.io/biocontainers/pepsirf:1.7.1--h077b44d_0
- **Homepage**: https://github.com/LadnerLab/PepSIRF
- **Package**: https://anaconda.org/channels/bioconda/packages/pepsirf/overview
- **Validation**: PASS

### Original Help Text
```text
PepSIRF (v1.7.1): Peptide-based Serological Immune Response Framework bin module.
:
  -h [ --help ]                                     Produce help message and exit.
                                                    The bin module is used to create groups of peptides with similar starting abundances (i.e. bins), based on the normalized read counts for >= 1 negative controls. These bins can be provided as an input for zscore calculations using the zscore module.
                                                    
  -s [ --scores ] arg                               Input tab-delimited normalized score matrix file to use for peptide binning. This matrix should only contain info for the negative control samples that should be used to generate bins (see subjoin module for help generatinig input matrix). Peptides with similar scores, summed across the negative controls, will be binned together.
                                                    
  -b [ --bin_size ] arg (=300)                      The minimum number of peptides that a bin must contain. If a bin would be created with fewer than bin_size peptides, it will be combined with the next bin until at least bin_size peptides are found.
                                                    
  -r [ --round_to ] arg (=0)                        The 'rounding factor' for the scores parsed from the score matrix prior to binning. Scores found in the matrix will be rounded to the nearest 1/10^x for a rounding factor x. For example, a rounding factor of 0 will result in rounding to the nearest integer, while a rounding factor of 1 will result in rounding to the nearest tenth.
                                                    
  -o [ --output ] arg (=bin_output.tsv)             Name for the output bins file. This file will contain one bin per line and each bin will be a tab-delimited list of the names of the peptides in the bin.
                                                    
  --logfile arg (=Bin_Sat_Feb_14_05-40-49_2026.log) Designated file to which the module's processes are logged. By default, the logfile's name will include the module's name and the time the module started running.
```


## pepsirf_zscore

### Tool Description
The zscore module is used to calculate Z scores for each peptide in each sample. These Z scores represent the number of standard deviations away from the mean, with the mean and standard deviation both calculated separately for each bin of peptides.

### Metadata
- **Docker Image**: quay.io/biocontainers/pepsirf:1.7.1--h077b44d_0
- **Homepage**: https://github.com/LadnerLab/PepSIRF
- **Package**: https://anaconda.org/channels/bioconda/packages/pepsirf/overview
- **Validation**: PASS

### Original Help Text
```text
PepSIRF (v1.7.1): Peptide-based Serological Immune Response Framework zscore module:
  -h [ --help ]                                        Produce help message
                                                       The zscore module is used to calculate Z scores for each peptide in each sample. These Z scores represent the number of standard deviations away from the mean, with the mean and standard deviation both calculated separately for each bin of peptides.
                                                       
  -s [ --scores ] arg                                  Name of the file to use as input. Should be a score matrix in the format as output by the demux and subjoin modules. Raw or normalized read counts can be used.
                                                       
  -b [ --bins ] arg                                    Name of the file containing bins, one bin per line, as output by the bin module. Each bin contains a tab-delimited list of peptide names.
                                                       
  -t [ --trim ] arg (=2.5)                             Percentile of lowest and highest counts within a bin to ignore when calculating the mean and standard deviation. This value must be in the range [0.00,100.0].
                                                       
  -d [ --hdi ] arg (=0)                                Alternative approach for discarding outliers prior to calculating mean and stdev. If provided, this argument will override --trim, which trims evenly from both sides of the distribution. For --hdi, the user should provide the high density interval to be used for calculation of mean and stdev. For example, "--hdi 0.95" would instruct the program to utilize the 95% highest density interval (from each bin) for these calculations.
                                                       
  -o [ --output ] arg (=zscore_output.tsv)             Name for the output Z scores file. This file will be a tab-delimited matrix file with the same dimensions as the input score file. Each peptide will be written with its z-score within each sample.
                                                       
  -n [ --nan_report ] arg                              Name of the file to write out information regarding peptides that are given a zscore of 'nan'. This occurs when the mean score of a bin and the score of the focal peptide are both zero. This will be a tab-delimited file, with three columns per line. The first column will contain the name of the peptide, the second will be the name of the sample, and the third will be the bin number of the probe. This bin number corresponds to the line number in the bins file, within which the probe was found.
                                                       
  --num_threads arg (=2)                               The number of threads to use for analyses.
                                                       
  --logfile arg (=Zscore_Sat_Feb_14_05-40-59_2026.log) Designated file to which the module's processes are logged. By default, the logfile's name will include the module's name and the time the module started running.
```


## pepsirf_info

### Tool Description
This module is used to gather information about a score matrix. By default, the number of samples and peptides in the matrix will be output. Additional flags may be provided to extract different types of information. Each of these flags should be accompanied by an output file name, to which the information be written.

### Metadata
- **Docker Image**: quay.io/biocontainers/pepsirf:1.7.1--h077b44d_0
- **Homepage**: https://github.com/LadnerLab/PepSIRF
- **Package**: https://anaconda.org/channels/bioconda/packages/pepsirf/overview
- **Validation**: PASS

### Original Help Text
```text
PepSIRF (v1.7.1): Peptide-based Serological Immune Response Framework info module:
  -h [ --help ]                                      Produce help message and exit.
                                                     This module is used to gather information about a score matrix. By default, the number of samples and peptides in the matrix will be output. Additional flags may be provided to extract different types of information. Each of these flags should be accompanied by an output file name, to which the information be written.
                                                     
  -i [ --input ] arg                                 An input score matrix to gather information from.
                                                     
  -s [ --get_samples ] arg                           Name of a file to which sample names (i.e., column headers) should be written. Output will be in the form of a file with no header, one sample name per line.
                                                     
  -p [ --get_probes ] arg                            Name of a file to which peptide/probe names (i.e., row names) should be written. Output will be in the form of a file with no header, one peptide/probe name per line.
                                                     
  -c [ --col_sums ] arg                              Name of a file to which the sum of column scores should be written. Output will be a tab-delimited file with a header. The first entry in each column will be the name of the sample, and the second will be the sum of the peptide/probe scores for the sample.
                                                     
  -n [ --rep_names ] arg                             An input file that the sample names of replicates can be found. The first element of each row contains the name of a base sample, and every other element in a row contains the name of a sample based off the base sample. This file is required to run -a, --get_avgs. 
                                                     
  -a [ --get_avgs ] arg                              Name of a file to which the average of different replicate values should be written. Output will be a tab-delimted file with sample names as the column headers and peptide names as row names. Each entry consists of the average of the replicate values for the given sample and peptide. 
                                                     
  --logfile arg (=Info_Sat_Feb_14_05-41-10_2026.log) Designated file to which the module's processes are logged. By default, the logfile's name will include the module's name and the time the module started running.
```


## pepsirf_subjoin

### Tool Description
The subjoin module is used to manipulate matrix files. This module can create a subset of an existing matrix, can combine multiple matrices together or perform a combination of these two functions.

### Metadata
- **Docker Image**: quay.io/biocontainers/pepsirf:1.7.1--h077b44d_0
- **Homepage**: https://github.com/LadnerLab/PepSIRF
- **Package**: https://anaconda.org/channels/bioconda/packages/pepsirf/overview
- **Validation**: PASS

### Original Help Text
```text
PepSIRF (v1.7.1): Peptide-based Serological Immune Response Framework subjoin module:
  -h [ --help ]                                         Produce help message
                                                        The subjoin module is used to manipulate matrix files. This module can create a subset of an existing matrix, can combine multiple matrices together or perform a combination of these two functions.
                                                        
  -m [ --multi_file ] arg                               The name of a tab-delimited file containing score matrix and sample name list filename pairs, one per line. Each of these pairs must be a score matrix and a file containing the names of samples (or peptides, if specified) to keep from the input the score matrix. The score matrix should be of the format output by the demux module, with sample names on the columns and peptide names on the rows. The namelist must have one name per line, but can optionally have 2, if renaming samples in the subjoin output. Optionally, a name list can be omitted if all samples from the input matrix should be included in the output. A regex pattern wrapped in quotation marks can also be provided instead of a name list which will filter through the names in the score matrix file in they contain the regex pattern.
                                                        
  -i [ --input ] arg                                    Comma-separated filenames (For example: score_matrix.tsv,sample_names.txt ). Each of these pairs must be a score matrix and a file containing the names of samples (or peptides, if specified) to keep in the score matrix. The score matrix should be of the format output by the demux module, with sample names on the columns and peptide names on the rows. The namelist must have one name per line, but can optionally have 2. If 2 tab-delimited names are included on one line, the name in the first column should match the name in the input matrix file, while the name in the second column will be output. Therefore, this allows for the renaming of samples in the output. To use multiple name lists with multiple score matrices, include this argument multiple times. Optionally, a name list can be omitted if all samples from the input matrix should be included in the output. A regex pattern wrapped in quotation marks can also be provided instead of a name list which will filter through the names in the score matrix file in they contain the regex pattern.
                                                        
  --filter_peptide_names                                Flag to include if the name lists input to the input or multi_file options should be treated as peptide (i.e. row) names instead of sample (i.e. column) names. With the inclusion of this flag, the input files will be filtered on peptide names (rows) instead of sample names (column).
                                                        
  -e [ --exclude ]                                      New data file will contain all of the input samples (or peptides) except the ones specified in the sample names.
                                                        
  -d [ --duplicate_evaluation ] arg (=include)          Defines what should be done when sample or peptide names are not unique across files being joined. Currently, three different duplicate evaluation strategies are available: 
                                                         - combine: Combine (with addition) the values associated with identical sample/peptide names from different files.
                                                        
                                                         - include: Include each duplicate, adding a suffix to the duplicate name detailing the file from which the sample came.
                                                        
                                                         - ignore: Ignore the possibility of duplicates. Behavior is undefined when duplicates are  encountered in this mode Therefore, this mode is not recommended.
                                                        
                                                        
  -o [ --output ] arg (=subjoin_output.tsv)             Name for the output score matrix file. The output will be in the form of the input, but with only the specified values (samplenames or peptides) found in the namelists. 
                                                        
  --logfile arg (=Subjoin_Sat_Feb_14_05-41-21_2026.log) Designated file to which the module's processes are logged. By default, the logfile's name will include the module's name and the time the module started running.
```


## pepsirf_norm

### Tool Description
Peptide-based Serological Immune Response Framework score normalization module. The norm module is used to normalize raw count data to allow for meaningful comparison among samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/pepsirf:1.7.1--h077b44d_0
- **Homepage**: https://github.com/LadnerLab/PepSIRF
- **Package**: https://anaconda.org/channels/bioconda/packages/pepsirf/overview
- **Validation**: PASS

### Original Help Text
```text
PepSIRF (v1.7.1): Peptide-based Serological Immune Response Framework score normalization module. 
:
  -h [ --help ]                                      Produce help message
                                                     The norm module is used to normalize raw count data to allow for meaningful comparison among samples.
                                                     
  -p [ --peptide_scores ] arg                        Name of tab-delimited matrix file containing peptide scores. This file should be in the same format as the output from the demux module.
                                                     
  -a [ --normalize_approach ] arg (=col_sum)         Options: 'col_sum', 'size_factors', 'diff', 'ratio', 'diff_ratio', By default, col_sum normalization is used.
                                                     'col_sum': Normalize the scores using a column-sum method. Output per peptide is the score per million for the sample (i.e., summed across all peptides).
                                                     'size_factors': Normalize the scores using the size factors method (Anders and Huber 2010).
                                                     'diff': Normalize the scores using the difference method. For each peptide and sample, the difference between the score and the respective peptide's mean score in the negative controls is determined.
                                                     'ratio': Normalize the scores using the ratio method. For each peptide and sample, the ratio of score to the respective peptide's mean score in the negative controls is determined.
                                                     'diff_ratio': Normalize the scores using the difference-ratio method. For each peptide and sample, the difference between the score and the respective peptide's mean score in the negative controls is first determined. This difference is then divided by the respective peptide's mean score in the negative controls.
                                                     
  --negative_control arg                             Optional data matrix for sb samples.
                                                     
  -s [ --negative_id ] arg                           Optional approach for identifying negative controls. Provide a unique string at the start of all negative control samples.
                                                     
  -n [ --negative_names ] arg                        Optional approach for identifying negative controls. Comma-separated list of negative control sample names.
                                                     
  --precision arg (=2)                               Output score precision. The scores written to the output will be output to this many decimal places. For example, a value of 2 will result in values output in the form '23.45', and a value of 3 will result in output of the form '23.449.
                                                     
  -o [ --output ] arg (=norm_output.tsv)             Name for the output file. The output is formatted in the same way the input file provided with 'peptide_scores' (i.e., a score matrix with samples on the columns and scores for a certain peptide on the rows). The score for each peptide in the output has been normalized in the manner specified.
                                                     
  --logfile arg (=Norm_Sat_Feb_14_05-41-31_2026.log) Designated file to which the module's processes are logged. By default, the logfile's name will include the module's name and the time the module started running.
```


## pepsirf_deconv

### Tool Description
The deconv module converts a list of enriched peptides into a parsimony-based list of likely taxa to which the assayed individual has likely been exposed. It supports both batch and singular modes.

### Metadata
- **Docker Image**: quay.io/biocontainers/pepsirf:1.7.1--h077b44d_0
- **Homepage**: https://github.com/LadnerLab/PepSIRF
- **Package**: https://anaconda.org/channels/bioconda/packages/pepsirf/overview
- **Validation**: PASS

### Original Help Text
```text
PepSIRF (v1.7.1): Peptide-based Serological Immune Response Framework species deconvolution module.
:
  -h [ --help ]                                        Produce help message
                                                       The deconv module converts a list of enriched peptides into a parsimony-based list of likely taxa to which the assayed individual has likely been exposed. This module has two modes: batch and singular. In batch mode, the input given to '--enriched' is a directory containing files of enriched peptides for each sample (e.g., as output by enrich). In this case, '--output' is a directory where the output deconvolution reports will be written. In singular mode, both '--enriched' and '--output' are treated as files, not directories. The chosen mode is determined by the type of argument provided with '--enriched'. If a directory is specified, batch mode will be used. If a file is specified, singular mode will be used.
                                                       
  -l [ --linked ] arg                                  Name of linkage map to be used for deconvolution. It should be in the format output by the 'link' module.
                                                       
  -t [ --thresholds ] arg                              Filepath to tab delimited file with a TaxID column and a score threshold for that TaxID. Each threshold is the minimum score that a taxon must obtain in order to be included in the deconvolution report.
                                                       
  --outfile_suffix arg                                 Used for batch mode only. When specified, the name of each file written to the output  directory will have this suffix.
                                                       
  -o [ --output ] arg (=deconv_output.tsv)             Name for the output directory or file. Output will be in the form of either one file or a directory containing files. Each output file will be tab-delimited and will include a header.
                                                       
  -r [ --remove_file_types ]                           Use this flag to exclude input file ('--enrich') extensions from the names of output files. Not used in singular mode.
                                                       
  -s [ --scores_per_round ] arg                        Optional. Name of directory to write counts/scores to after every round. If included, the counts and scores for all remaining taxa will be recorded after every round. Filenames will be written in the format '$dir/round_x', where x is the round number. The original scores will be written to '$dir/round_0'. A new file will be written to the directory after each subsequent round. If this flag is included and the specified directory exists, the program will exit with an error.
                                                       
  --single_threaded                                    By default this module uses two threads. Include this option with no arguments if you only want only one thread to be used. 
                                                       
  --scoring_strategy arg (=summation)                  Scoring strategies "summation", "integer", or "fraction" can be specified. By not including this flag, summation scoring will be used by default.
                                                       The --linked file passed must be of the form created by the link module. This means a file of tab-delimited values, one per line.
                                                       Each line is of the form peptide_name TAB id:score,id:score, and so on. An error will occurif input is not in this format.
                                                       For summation scoring, the score assigned to each peptide/ID pair is determined by the ":score" portion of the --linked file.
                                                       For example, assume a line in the --linked file looks like the following: 
                                                       peptide_1 TAB 123:4,543:8
                                                       The IDs '123' and '543' will receive scores of 4 and 8 respectively.
                                                       For integer scoring, each ID receives a score of 1 for every enriched peptide to which it is linked (":score" is ignored).
                                                       For fractional scoring, the score is assigned to each peptide/ID pair is defined by 1/n for each peptide, where n is the number of IDs to which a peptide is linked. In this method of scoring peptides, a peptide with fewer linked IDs is worth more points.
                                                       
  -e [ --enriched ] arg                                Name of a directory containing files, or a single file containing the names of enriched peptides, one per line. Each peptide contained in this file (or files) should have a corresponding entry in the '--linked' input file.
                                                       
  --score_filtering                                    Include this option if you want filtering to be done by the score of each taxon, rather than the count of linked peptides. If used, any taxon with a score below '--threshold' will be removed from consideration, even if it is the highest scoring taxon. Note that for integer scoring, both score filtering and count filtering (default) are the same. If this flag is not included, then any species whose count falls below '--threshold' will be removed from consideration. Score filtering is best suited for the summation scoring method.
                                                       
  -p [ --peptide_assignment_map ] arg                  Optional output. If specified, a map detailing which peptides were assigned to which taxa will be written. If this module is run in batch mode, this will be used as a directory name for the peptide maps to be stored. Maps will be tab-delimited files with the first column being peptide names; the second column containing a comma-separated list of taxa to which the peptide was assigned; the third column will be a list of the taxa with which the peptide originally shared a kmer. Note that the second column will only contain multiple values in the event of a tie.
                                                       
  --mapfile_suffix arg                                 Used for batch mode only. When specified, the name of each '--peptide_assignment_map' will have this suffix.
                                                       
  --score_tie_threshold arg (=0)                       Threshold for two species to be evaluated as a tie. Note that this value can be either an integer or a ratio that is in (0,1). When provided as an integer this value dictates the difference in score that is allowed for two taxa to be considered as potentially tied. For example, if this flag is provided with the value 0, then two or more taxa must have the exact same score to be tied. If this flag is provided with the value 4, then the difference between the scores of two taxa must be no greater than 4 to be considered tied. For example, if taxon 1 has a score of 5, and taxon 2 has a score anywhere between the integer values in [1,9], then these species will be considered tied, and their tie will be evaluated as dictated by the specified '--score_overlap_threshold'. If the argument provided to this flag is in (0, 1), then the score for a taxon must be at least this proportion of the score for the highest scoring taxon, to trigger a tie. So if species 1 has the highest score with a score of 9, and species 2 has a score of 5, then this flag must be provided with value >= 4/5 = 0.8 for the species 1 and 2 to be considered tied. Note that any values provided to this flag that are in the set { x: x >= 1 } - Z, where Z is the set of integers, will result in an error. So 4.45 is not a valid value, but both 4 and 0.45 are.
                                                       
  --id_name_map arg                                    Optional file containing mappings from taxonomic ID to taxon name. This file should be formatted like the file 'rankedlineage.dmp' from NCBI. It is recommended to either use this file or a subset of this file that contains all of the taxon ids linked to peptides of interest. If included, the output will contain a column denoting the name of the species as well as the id.
                                                       
  --custom_id_name_map_info arg                        Optional file containing mappings from taxonomic IDs to taxon names. The format of this file is dictated by the user. It is recommended to either use this file or a subset of this file that contains all of the taxon ids linked to peptides of interest. If included, the output will contain a column denoting the name of the species as well as the ID. The order should be: filename,key_column,value_column.
                                                       
  --score_overlap_threshold arg (=1)                   Once two species have been determined to be tied, according to '--score_tie_threshold', they are then evaluated as a tie. To use integer tie evaluation, where species must share an integer number of peptides, not a ratio of their total peptides, provide this argument with a value in the interval [1, inf). For ratio tie evaluation, which is used when this argument is provided with a value in the interval (0,1), two taxon must reciprocally share at least the specified proportion of peptides to be reported together. For example, suppose species 1 shares half (0.5) of its peptides with species 2, but species 2 only shares a tenth (0.1) of its peptides with species 1. These two will only be reported together if score_overlap_threshold' <= 0.1.
                                                       
  --enriched_file_ending arg (=_enriched.txt)          Optional flag that specifies what string is expected at the end of each file containing enriched peptides. Set to "_enriched.txt" by default 
                                                       
  --logfile arg (=Deconv_Sat_Feb_14_05-41-42_2026.log) Designated file to which the module's processes are logged. By default, the logfile's name will include the module's name and the time the module started running.
```


## pepsirf_link

### Tool Description
The link module is used to create the "--linked" input file for the deconv module. The output file from this module defines linkages between taxonomic groups (or other groups of interest) and peptides based on shared kmers.

### Metadata
- **Docker Image**: quay.io/biocontainers/pepsirf:1.7.1--h077b44d_0
- **Homepage**: https://github.com/LadnerLab/PepSIRF
- **Package**: https://anaconda.org/channels/bioconda/packages/pepsirf/overview
- **Validation**: PASS

### Original Help Text
```text
PepSIRF (v1.7.1): Peptide-based Serological Immune Response Framework link module.
:
  -h [ --help ]                                      Produce help message and exit.
                                                     The link module is used to create the "--linked" input file for the deconv module. The output file from this module defines linkages between taxonomic groups (or other groups of interest) and peptides based on shared kmers.
                                                     
  -o [ --output ] arg (=link_output.tsv)             Name of the file to which output is written. Output will be in the form of a tab-delimited file with a header. Each entry/row will be of the form: peptide_name TAB id:score,id:score, and so on. By default, "score" is defined as the number of shared kmers.
                                                     
  --protein_file arg                                 Name of fasta file containing protein sequences of interest.
                                                     
  --peptide_file arg                                 Name of fasta file containing aa peptides of interest. These will generally be peptides that are contained in a particular assay.
                                                     
  --meta arg                                         Optional method for providing taxonomic information for each protein contained in "--protein_file". Three comma-separated strings should be provided: 1) name of tab-delimited metadata file, 2) header for column containing protein sequence name and 3) header for column containing ID to be used in creating the linkage map.
                                                     
  -t [ --tax_id_index ] arg (=1)                     Optional method for parsing taxonomic information from the names of the protein sequences. This is an alternative to the "--meta" argument and will only work if the protein names contain "OXX" tags of the form "OXX=variableID,speciesID,genusID,familyID". If used, a signle integer should be provided that corresponds to the index (0-based, valid values include 0-3) of the tax id to use for creating a linkage map. For example, if this argument is passed with the value 1, 
                                                     the species ID will be used (2 for genus, 3 for family. 0 can vary depending upon the 
                                                     method used for assigning the 0'th ID).
                                                     
  -r [ --kmer_redundancy_control ]                   Optional modification to the way scores are calculated. If this flag is used, then instead of a peptide receiving one point for each kmer it shares with proteins of a given taxonomic group, it receives 1 / ( the number of times the kmer appears in the provided peptides ) points.
                                                     
  -k [ --kmer_size ] arg                             Kmer size to use when creating the linkage map.
                                                     
  --logfile arg (=Link_Sat_Feb_14_05-42-00_2026.log) Designated file to which the module's processes are logged. By default, the logfile's name will include the module's name and the time the module started running.
```


## pepsirf_demux

### Tool Description
Peptide-based Serological Immune Response Framework demultiplexing module. This module takes parameters and outputs counts for each reference sequence (i.e. probe/peptide) for each sample.

### Metadata
- **Docker Image**: quay.io/biocontainers/pepsirf:1.7.1--h077b44d_0
- **Homepage**: https://github.com/LadnerLab/PepSIRF
- **Package**: https://anaconda.org/channels/bioconda/packages/pepsirf/overview
- **Validation**: PASS

### Original Help Text
```text
PepSIRF (v1.7.1): Peptide-based Serological Immune Response Framework demultiplexing module. 
This module takes the following parameters and outputs counts for each reference 
sequence (i.e. probe/peptide) for each sample. For this module we define 'distance' as the Hamming distance D between a reference sequence r and a read sequence s. If D(r, s) <= max_mismatches we say that s maps to r. Note that if multiple reference sequences, r1 and r2, are similar to s, D(r1, s) <= max_mismatches and D(r2, s) <= max_mismatches, then we say that s maps to the reference with the minimum distance. Additionally if D(r1, s) == D(r2, q) then we discard s as we cannot say whether s maps to r1 or r2. 
:
  -h [ --help ]                                       Produce help message and exit
  --input_r1 arg                                      Fastq-formatted file containing reads with DNA tags. If PepSIRF was NOT compiled with Zlib support, this file must be uncompressed. If PepSIRF was compiled with Zlib support, then this file can be uncompressed or compressed using gzip. In this case, the file format will be automatically determined.
                                                      
  --input_r2 arg                                      Optional index-only fastq file. If PepSIRF was NOT compiled with Zlib support, this file must be uncompressed. If PepSIRF was compiled with Zlib support, then this file can be uncompressed or compressed using gzip. In this case, the file format will be automatically determined.
                                                      Note that if this argument is not supplied, only "index1" will be used to identify samples.
                                                      
  -i [ --index ] arg                                  Name of fasta-formatted file containing forward and (potentially) reverse index sequences. Sequence names must match exactly with those supplied in the "samplelist".
                                                      
  -l [ --library ] arg                                Fasta-formatted file containing reference DNA tags. If this flag is not included, reference-independent demultiplexing will be performed. In reference-independent mode, each sequence in the region specified by '--seq' will be considered its own reference, and the observed sequences will be used as the row names in the output count matrix.
                                                      
  -r [ --read_per_loop ] arg (=100000)                The number of fastq records read a time. A higher value will result in more memory usage by the program, but will also result in fewer disk accesses, increasing performance of the program.
                                                      
  --index1 arg                                        Positional information for index1 (i.e barcode 1). This argument must be passed as 3 comma-separated values. The first item represents the (0-based) expected start position of the first index; the second represents the length of the first index; and the third represents the number of mismatches that are tolerated for this index. An example is '--index1 12,12,1'. This says that the index starts at (0-based) position 12, the index is 12 nucleotides long, and if a perfect match is not found, then up to one mismatch will be tolerated.
                                                      .
  --index2 arg                                        Positional information for index2, optional. This argument must be passed in the same format specified for "--index1". If "--input2" is provided, this positional information is assummed to refer to the reads contained in this second, index-only fastq file. If "--input_r2" is NOT provided, this positional information is assumed to refer to the reads contained in the "--input_r1" fastq file.
                                                      
  --seq arg                                           Positional information for the DNA tags. This argument must be passed in the same format specified for "index1".
                                                      
  -f [ --fif ] arg                                    The flexible index file can be provided as an alternative to the '--index1' and '--index2' options. The file must use the following format: a tab-delimited file with 5 ordered columns: 1) index name, which should correspond to a header name in the sample sheet, 2) read name, which should be either 'r1' or 'r2' (not case-sensitive) to specify whether the index is in '--input_r1' or '--input_r2', 3) index start location (0-based, inclusive), 4) index length and 5) number of mismatched to allow. '--index1', '--index2', '--sname', '--sindex1', and 'sindex2' will be ignored if this option is provided.
                                                      
  -c [ --concatemer ] arg                             Concatenated adapter/primer sequences (optional). The presence of this sequence within a read indicates that the expected DNA tag is not present. If supplied, the number of times this concatemer is recorded in the input file is reported.
                                                      
  -o [ --output ] arg (=output.csv)                   Name for the output counts file. This output file will be tab-delimited and will contain a header row. The first column will contain probe/peptide names. Each subsequent column will contain probe/peptide counts for a sample, with one column per sample.
                                                      
  -a [ --aa_counts ] arg                              Name for an output file that will contain aggregated aa-level counts. This is relevant when peptides from a designed library have multiple different nt-level encodings. If this option is included without the '--translate_aggregates' flag, names of sequences in the file supplied by the "--library flag" MUST be of the form ID-NUM, where ID can contain any characters except '-', and NUM represents the id of this encoding. ID and NUM MUST be separated by a single dash '-' character. For example, suppose we have TG1_1-1 and TG1_1-2 in our library, which says that we generated two encodings for the TG1_1 peptide. The "--aa_counts" file will have a single TG1_1 entry, with per sample counts that are the sum of the counts from TG1_1-1 and TG1_1-2.
                                                      
  --translate_aggregates                              Include this flag to use translation-based aggregation. In this mode, counts for nt sequences will be combined if they translate into the same aa sequence. Note: When this mode is used, the name of the aggregate sequence will be the sequence that was a result of the translation. Therefore, this mode is most appropriate for use with reference-independent demultiplexing.
                                                      
  -s [ --samplelist ] arg                             A tab-delimited list of samples with a header row and one sample per line. This file must contain at least one index column and one sample name column. Multiple index columns may be included. This file can also include additional columns that will not be used for the demultiplexing. Specify which columns to use with the "--sname", "--sindex1", and "--sindex2" flags. If "-fif" is used, then only "-sname" will be used. 
                                                      
  --sname arg (=SampleName)                           Used to specify the header for the sample name column in the samplelist. By default "SampleName" is set as the column header name.
                                                      
  --sindex arg (=Index1,Index2)                       Used to specify the header for the index 1 and additional optional index column names in the samplelist. Include in comma-delimited format. By default the index name pair "Index1,Index2" is used. This is an alternative to using the "--fif" option.
                                                      
  -d [ --diagnostic_info ] arg                        Include this flag with an output file name to collect diagnostic information on read pair matches in map. The file will be formatted with tab delimited lines "samplename  # index pair matches  # matches to any variable region".
  --phred_base arg (=33)                              Phred base to use when parsing fastq quality scores. Valid options include 33 or 64.
                                                      
  --phred_min_score arg (=0)                          The minimum average phred-scaled quality score for the DNA tag portion of a read for it to be considered for matching. This means that if the average phred33/64 score for a read at the expected locations of the DNA tag is not at least this then the read will be discarded.
                                                      
  -q [ --fastq_output ] arg                           Include this to output sample-level fastq files
                                                      
  --include_toggle arg (=1)                           The position toggling for the indexes. By default this is set to true. By setting this flag to true, the position toggling will be turned on and the normal ref-dependent based demux behavior is used. By setting this flag to false, the position toggling will be turned off and only the exact location specified will be checked for a match.
                                                      
  -t [ --num_threads ] arg (=2)                       Number of threads to use for analyses.
                                                      
  --logfile arg (=Demux_Sat_Feb_14_05-42-11_2026.log) Designated file to which the module's processes are logged. By default, the logfile's name will include the module's name and the time the module started running.
                                                      
  --replicate_info arg                                Include this flag with an output file name to provide a more thorough summary of replicates in the sample list in an output file. The information will be tab-delimited with two headers: "Sample Name" and "Number of Replicates".
                                                      
  --unmapped_reads_output arg                         Include this flag with a .fastq output file name to create a single output fastq file containing all of the reads that have not been mapped to a sample/peptide (i.e., all of those thatwould not be included in any of the files created by the -q option).
                                                      
  --trunc_info_output arg                             Name of directory to output truncated sequence information. This will include outputs for unqiue sequences, non-unqiue sequences, and the new fasta-formatted file.
```


## Metadata
- **Skill**: generated
