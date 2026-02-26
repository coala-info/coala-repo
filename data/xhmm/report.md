# xhmm CWL Generation Report

## xhmm_preparetargets

### Tool Description
Uses principal component analysis (PCA) normalization and a hidden Markov model (HMM) to detect and genotype copy number variation (CNV) from normalized read-depth data from targeted sequencing experiments.

### Metadata
- **Docker Image**: quay.io/biocontainers/xhmm:0.0.0.2016_01_04.cc14e52--hedee03e_3
- **Homepage**: http://atgu.mgh.harvard.edu/xhmm/index.shtml
- **Package**: https://anaconda.org/channels/bioconda/packages/xhmm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/xhmm/overview
- **Total Downloads**: 6.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
xhmm 1.0

Uses principal component analysis (PCA) normalization and a hidden Markov model 
(HMM) to detect and genotype copy number variation (CNV) from normalized 
read-depth data from targeted sequencing experiments.

Usage: xhmm [OPTIONS]...

Developed by Menachem Fromer and Shaun Purcell

  -h, --help                    Print help and exit
      --detailed-help           Print help, including all details and hidden 
                                  options, and exit
      --full-help               Print help, including hidden options, and exit
  -V, --version                 Print version and exit

*******************************************************************
Options for modes: 'prepareTargets', 'genotype':
  -F, --referenceFASTA=STRING   Reference FASTA file (MUST have .fai index 
                                  file)

*******************************************************************
Options for modes: 'matrix', 'PCA', 'normalize', 'discover', 'genotype':
  -r, --readDepths=STRING       Matrix of *input* read-depths, where rows 
                                  (samples) and columns (targets) are labeled  
                                  (default=`-')
*******************************************************************

 Mode: prepareTargets
  Sort all target intervals, merge overlapping ones, and print the resulting 
  interval list
  -S, --prepareTargets          
      --targets=STRING          Input targets lists
      --mergedTargets=STRING    Output targets list  (default=`-')

 Mode: mergeGATKdepths
  Merge the output from GATK into a single read depth matrix of samples (rows) 
  by targets (columns)
  -A, --mergeGATKdepths         
      --GATKdepths=STRING       GATK sample_interval_summary output file(s) to 
                                  be merged [must have *IDENTICAL* target 
                                  lists]
      --GATKdepthsList=STRING   A file containing a list of GATK 
                                  sample_interval_summary output files to be 
                                  merged [must have *IDENTICAL* target lists]
      --sampleIDmap=STRING      File containing mappings of sample names to new 
                                  sample names (in columns designated by 
                                  fromID, toID)
      --fromID=INT              Column number of OLD sample IDs to map  
                                  (default=`1')
      --toID=INT                Column number of NEW sample IDs to map  
                                  (default=`2')
      --columnSuffix=STRING     Suffix of columns to be used for merging [where 
                                  columns are in the form: SAMPLE + 
                                  columnSuffix]  (default=`_mean_cvg')
      --rdPrecision=INT         Decimal precision of read depths output  
                                  (default=`2')
      --outputTargetsBySamples  Output targets x samples (instead of samples x 
                                  targets)  (default=off)

 Mode: matrix
  Process (filter, center, etc.) a read depth matrix and output the resulting 
  matrix.  Note that first all excluded samples and targets are removed.  And, 
  sample statistics used for filtering are calculated only *after* filtering 
  out relevant targets.
  -M, --matrix                  
      --excludeTargets=STRING   File(s) of targets to exclude
      --excludeChromosomeTargets=STRING
                                Target chromosome(s) to exclude
      --excludeSamples=STRING   File(s) of samples to exclude
      --minTargetSize=INT       Minimum size of target (in bp) to process  
                                  (default=`0')
      --maxTargetSize=INT       Maximum size of target (in bp) to process
      --minMeanTargetRD=DOUBLE  Minimum per-target mean RD to require for 
                                  target to be processed
      --maxMeanTargetRD=DOUBLE  Maximum per-target mean RD to require for 
                                  target to be processed
      --minSdTargetRD=DOUBLE    Minimum per-target standard deviation of RD to 
                                  require for target to be processed  
                                  (default=`0')
      --maxSdTargetRD=DOUBLE    Maximum per-target standard deviation of RD to 
                                  require for target to be processed
      --minMeanSampleRD=DOUBLE  Minimum per-sample mean RD to require for 
                                  sample to be processed
      --maxMeanSampleRD=DOUBLE  Maximum per-sample mean RD to require for 
                                  sample to be processed
      --minSdSampleRD=DOUBLE    Minimum per-sample standard deviation of RD to 
                                  require for sample to be processed  
                                  (default=`0')
      --maxSdSampleRD=DOUBLE    Maximum per-sample standard deviation of RD to 
                                  require for sample to be processed
      --scaleDataBySum          After any filtering, scale read-depth matrix 
                                  values by sample- or target- sums (as per 
                                  --scaleDataBySumType) [i.e., divide by row or 
                                  column sums], but multiply by factor 
                                  specificied by --scaleDataBySumFactor  
                                  (default=off)
      --scaleDataBySumType=ENUM If --scaleDataBySum given, then scale the data 
                                  within this dimension  (possible 
                                  values="target", "sample")
      --scaleDataBySumFactor=DOUBLE
                                If --scaleDataBySum given, then divide by 
                                  appropriate sum (but multiply by this factor) 
                                   (default=`1e6')
      --log10=DOUBLE            After any filtering and optional scaling steps 
                                  (but before any optional centering steps), 
                                  convert the matrix to log10 values. To deal 
                                  with non-positive and small positive values, 
                                  a truncation and then pseudocount approach is 
                                  taken. Specifically, denote the original 
                                  matrix value as x and this parameter's 
                                  pseudocount value as v (say, 0.5). The matrix 
                                  value used is then log10(max(x, 0) + v)
      --centerData              Output sample- or target- centered read-depth 
                                  matrix (as per --centerType)  (default=off)
      --centerType=ENUM         If --centerData given, then center the data 
                                  around this dimension  (possible 
                                  values="target", "sample")
      --zScoreData              If --centerData given, then additionally 
                                  normalize by standard deviation (outputting 
                                  z-scores)  (default=off)
      --outputExcludedTargets=STRING
                                File in which to output targets excluded by 
                                  some criterion
      --outputExcludedSamples=STRING
                                File in which to output samples excluded by 
                                  some criterion

Options for modes: 'mergeGATKdepths', 'matrix':
  -o, --outputMatrix=STRING     Read-depth matrix output file  (default=`-')
*******************************************************************

 Mode: PCA
  Run PCA to create normalization factors for read depth matrix
  -P, --PCA                     Matrix is read from --readDepths argument; 
                                  normalization factors sent to --PCAfiles 
                                  argument
      --PCA_saveMemory[=STRING] Should XHMM save memory by storing some of the 
                                  intermediate PCA matrices as temporary files 
                                  on disk?  (default=`')

 Mode: normalize
  Apply PCA factors in order to normalize read depth matrix
  -N, --normalize               Matrix is read from --readDepths argument; 
                                  normalization factors read from --PCAfiles 
                                  argument
  -n, --normalizeOutput=STRING  Normalized read-depth matrix output file  
                                  (default=`-')
      --PCnormalizeMethod=ENUM  Method to choose which prinicipal components 
                                  are removed for data normalization  (possible 
                                  values="numPCtoRemove", "PVE_mean", 
                                  "PVE_contrib" default=`PVE_mean')
      --numPCtoRemove=INT       Number of highest principal components to 
                                  filter out  (default=`20')
      --PVE_mean_factor=DOUBLE  Remove all principal components that 
                                  individually explain more variance than this 
                                  factor times the average (in the original 
                                  PCA-ed data)  (default=`0.7')
      --PVE_contrib=DOUBLE      Remove the smallest number of principal 
                                  components that explain this percent of the 
                                  variance (in the original PCA-ed data)  
                                  (default=`50')

Options for modes: 'PCA', 'normalize':
      --PCAfiles=STRING         Base file name for 'PCA' *output*, and 
                                  'normalize' *input*
*******************************************************************

 Mode: discover
  Discover CNVs from normalized read depth matrix
  -D, --discover                Matrix is read from --readDepths argument
  -c, --xcnv=STRING             CNV output file  (default=`-')
  -t, --discoverSomeQualThresh=DOUBLE
                                Quality threshold for discovering a CNV in a 
                                  sample  (default=`30')
  -s, --posteriorFiles=STRING   Base file name for posterior probabilities 
                                  output files; if not given, and --xcnv is not 
                                  '-', this will default to --xcnv argument

 Mode: genotype
  Genotype list of CNVs from normalized read depth matrix
  -G, --genotype                Matrix is read from --readDepths argument
  -g, --gxcnv=STRING            xhmm CNV input file to genotype in 'readDepths' 
                                  sample
      --subsegments             In addition to genotyping the intervals 
                                  specified in gxcnv, genotype all sub-segments 
                                  of these intervals (with 
                                  maxTargetsInSubsegment or fewer targets)  
                                  (default=off)
      --maxTargetsInSubsegment=INT
                                When genotyping sub-segments of input 
                                  intervals, only consider sub-segments 
                                  consisting of this number of targets or fewer 
                                   (default=`30')
  -T, --genotypeQualThresholdWhenNoExact=DOUBLE
                                Quality threshold for calling a genotype, used 
                                  *ONLY* when 'gxcnv' does not contain the 
                                  'Q_EXACT' field for the interval being 
                                  genotyped  (default=`20')

 Mode: mergeVCFs
  Merge VCF files output by multiple runs of the 'genotype' command on the same 
  input intervals (.xcnv file), but for different samples
      --mergeVCFs               
      --mergeVCF=STRING         VCF file(s) to be merged [must have *IDENTICAL* 
                                  genotyped intervals]
      --mergeVCFlist=STRING     A file containing a list of VCF files to be 
                                  merged [must have *IDENTICAL* genotyped 
                                  intervals]

Options for modes: 'discover', 'genotype', 'transition', 'printHMM':
  -p, --paramFile=STRING        (Initial) model parameters file

Options for modes: 'discover', 'genotype':
  -m, --maxNormalizedReadDepthVal=DOUBLE
                                Value at which to cap the absolute value of 
                                  *normalized* input read depth values 
                                  ('readDepths')  (default=`10')
  -q, --maxQualScore=DOUBLE     Value at which to cap the calculated quality 
                                  scores  (default=`99')
  -e, --scorePrecision=INT      Decimal precision of quality scores  
                                  (default=`0')
  -a, --aux_xcnv=STRING         Auxiliary CNV output file (may be VERY LARGE in 
                                  'genotype' mode)
  -u, --auxUpstreamPrintTargs=INT
                                Number of targets to print upstream of CNV in 
                                  'auxOutput' file  (default=`2')
  -w, --auxDownstreamPrintTargs=INT
                                Number of targets to print downstream of CNV in 
                                  'auxOutput' file  (default=`2')
  -R, --origReadDepths=STRING   Matrix of unnormalized read-depths to use for 
                                  CNV annotation, where rows (samples) and 
                                  columns (targets) are labeled
      --keepSampleIDs=STRING    File containing a list of samples to be 
                                  analyzed

Options for modes: 'genotype', 'mergeVCFs':
  -v, --vcf=STRING              Genotyped CNV output VCF file  (default=`-')
*******************************************************************

 Mode: printHMM
  Print HMM model parameters and exit
      --printHMM                

 Mode: transition
  Print HMM transition matrix for user-requested genomic distances
      --transition
```


## xhmm_mergegatkdepths

### Tool Description
Uses principal component analysis (PCA) normalization and a hidden Markov model (HMM) to detect and genotype copy number variation (CNV) from normalized read-depth data from targeted sequencing experiments.

### Metadata
- **Docker Image**: quay.io/biocontainers/xhmm:0.0.0.2016_01_04.cc14e52--hedee03e_3
- **Homepage**: http://atgu.mgh.harvard.edu/xhmm/index.shtml
- **Package**: https://anaconda.org/channels/bioconda/packages/xhmm/overview
- **Validation**: PASS

### Original Help Text
```text
xhmm 1.0

Uses principal component analysis (PCA) normalization and a hidden Markov model 
(HMM) to detect and genotype copy number variation (CNV) from normalized 
read-depth data from targeted sequencing experiments.

Usage: xhmm [OPTIONS]...

Developed by Menachem Fromer and Shaun Purcell

  -h, --help                    Print help and exit
      --detailed-help           Print help, including all details and hidden 
                                  options, and exit
      --full-help               Print help, including hidden options, and exit
  -V, --version                 Print version and exit

*******************************************************************
Options for modes: 'prepareTargets', 'genotype':
  -F, --referenceFASTA=STRING   Reference FASTA file (MUST have .fai index 
                                  file)

*******************************************************************
Options for modes: 'matrix', 'PCA', 'normalize', 'discover', 'genotype':
  -r, --readDepths=STRING       Matrix of *input* read-depths, where rows 
                                  (samples) and columns (targets) are labeled  
                                  (default=`-')
*******************************************************************

 Mode: prepareTargets
  Sort all target intervals, merge overlapping ones, and print the resulting 
  interval list
  -S, --prepareTargets          
      --targets=STRING          Input targets lists
      --mergedTargets=STRING    Output targets list  (default=`-')

 Mode: mergeGATKdepths
  Merge the output from GATK into a single read depth matrix of samples (rows) 
  by targets (columns)
  -A, --mergeGATKdepths         
      --GATKdepths=STRING       GATK sample_interval_summary output file(s) to 
                                  be merged [must have *IDENTICAL* target 
                                  lists]
      --GATKdepthsList=STRING   A file containing a list of GATK 
                                  sample_interval_summary output files to be 
                                  merged [must have *IDENTICAL* target lists]
      --sampleIDmap=STRING      File containing mappings of sample names to new 
                                  sample names (in columns designated by 
                                  fromID, toID)
      --fromID=INT              Column number of OLD sample IDs to map  
                                  (default=`1')
      --toID=INT                Column number of NEW sample IDs to map  
                                  (default=`2')
      --columnSuffix=STRING     Suffix of columns to be used for merging [where 
                                  columns are in the form: SAMPLE + 
                                  columnSuffix]  (default=`_mean_cvg')
      --rdPrecision=INT         Decimal precision of read depths output  
                                  (default=`2')
      --outputTargetsBySamples  Output targets x samples (instead of samples x 
                                  targets)  (default=off)

 Mode: matrix
  Process (filter, center, etc.) a read depth matrix and output the resulting 
  matrix.  Note that first all excluded samples and targets are removed.  And, 
  sample statistics used for filtering are calculated only *after* filtering 
  out relevant targets.
  -M, --matrix                  
      --excludeTargets=STRING   File(s) of targets to exclude
      --excludeChromosomeTargets=STRING
                                Target chromosome(s) to exclude
      --excludeSamples=STRING   File(s) of samples to exclude
      --minTargetSize=INT       Minimum size of target (in bp) to process  
                                  (default=`0')
      --maxTargetSize=INT       Maximum size of target (in bp) to process
      --minMeanTargetRD=DOUBLE  Minimum per-target mean RD to require for 
                                  target to be processed
      --maxMeanTargetRD=DOUBLE  Maximum per-target mean RD to require for 
                                  target to be processed
      --minSdTargetRD=DOUBLE    Minimum per-target standard deviation of RD to 
                                  require for target to be processed  
                                  (default=`0')
      --maxSdTargetRD=DOUBLE    Maximum per-target standard deviation of RD to 
                                  require for target to be processed
      --minMeanSampleRD=DOUBLE  Minimum per-sample mean RD to require for 
                                  sample to be processed
      --maxMeanSampleRD=DOUBLE  Maximum per-sample mean RD to require for 
                                  sample to be processed
      --minSdSampleRD=DOUBLE    Minimum per-sample standard deviation of RD to 
                                  require for sample to be processed  
                                  (default=`0')
      --maxSdSampleRD=DOUBLE    Maximum per-sample standard deviation of RD to 
                                  require for sample to be processed
      --scaleDataBySum          After any filtering, scale read-depth matrix 
                                  values by sample- or target- sums (as per 
                                  --scaleDataBySumType) [i.e., divide by row or 
                                  column sums], but multiply by factor 
                                  specificied by --scaleDataBySumFactor  
                                  (default=off)
      --scaleDataBySumType=ENUM If --scaleDataBySum given, then scale the data 
                                  within this dimension  (possible 
                                  values="target", "sample")
      --scaleDataBySumFactor=DOUBLE
                                If --scaleDataBySum given, then divide by 
                                  appropriate sum (but multiply by this factor) 
                                   (default=`1e6')
      --log10=DOUBLE            After any filtering and optional scaling steps 
                                  (but before any optional centering steps), 
                                  convert the matrix to log10 values. To deal 
                                  with non-positive and small positive values, 
                                  a truncation and then pseudocount approach is 
                                  taken. Specifically, denote the original 
                                  matrix value as x and this parameter's 
                                  pseudocount value as v (say, 0.5). The matrix 
                                  value used is then log10(max(x, 0) + v)
      --centerData              Output sample- or target- centered read-depth 
                                  matrix (as per --centerType)  (default=off)
      --centerType=ENUM         If --centerData given, then center the data 
                                  around this dimension  (possible 
                                  values="target", "sample")
      --zScoreData              If --centerData given, then additionally 
                                  normalize by standard deviation (outputting 
                                  z-scores)  (default=off)
      --outputExcludedTargets=STRING
                                File in which to output targets excluded by 
                                  some criterion
      --outputExcludedSamples=STRING
                                File in which to output samples excluded by 
                                  some criterion

Options for modes: 'mergeGATKdepths', 'matrix':
  -o, --outputMatrix=STRING     Read-depth matrix output file  (default=`-')
*******************************************************************

 Mode: PCA
  Run PCA to create normalization factors for read depth matrix
  -P, --PCA                     Matrix is read from --readDepths argument; 
                                  normalization factors sent to --PCAfiles 
                                  argument
      --PCA_saveMemory[=STRING] Should XHMM save memory by storing some of the 
                                  intermediate PCA matrices as temporary files 
                                  on disk?  (default=`')

 Mode: normalize
  Apply PCA factors in order to normalize read depth matrix
  -N, --normalize               Matrix is read from --readDepths argument; 
                                  normalization factors read from --PCAfiles 
                                  argument
  -n, --normalizeOutput=STRING  Normalized read-depth matrix output file  
                                  (default=`-')
      --PCnormalizeMethod=ENUM  Method to choose which prinicipal components 
                                  are removed for data normalization  (possible 
                                  values="numPCtoRemove", "PVE_mean", 
                                  "PVE_contrib" default=`PVE_mean')
      --numPCtoRemove=INT       Number of highest principal components to 
                                  filter out  (default=`20')
      --PVE_mean_factor=DOUBLE  Remove all principal components that 
                                  individually explain more variance than this 
                                  factor times the average (in the original 
                                  PCA-ed data)  (default=`0.7')
      --PVE_contrib=DOUBLE      Remove the smallest number of principal 
                                  components that explain this percent of the 
                                  variance (in the original PCA-ed data)  
                                  (default=`50')

Options for modes: 'PCA', 'normalize':
      --PCAfiles=STRING         Base file name for 'PCA' *output*, and 
                                  'normalize' *input*
*******************************************************************

 Mode: discover
  Discover CNVs from normalized read depth matrix
  -D, --discover                Matrix is read from --readDepths argument
  -c, --xcnv=STRING             CNV output file  (default=`-')
  -t, --discoverSomeQualThresh=DOUBLE
                                Quality threshold for discovering a CNV in a 
                                  sample  (default=`30')
  -s, --posteriorFiles=STRING   Base file name for posterior probabilities 
                                  output files; if not given, and --xcnv is not 
                                  '-', this will default to --xcnv argument

 Mode: genotype
  Genotype list of CNVs from normalized read depth matrix
  -G, --genotype                Matrix is read from --readDepths argument
  -g, --gxcnv=STRING            xhmm CNV input file to genotype in 'readDepths' 
                                  sample
      --subsegments             In addition to genotyping the intervals 
                                  specified in gxcnv, genotype all sub-segments 
                                  of these intervals (with 
                                  maxTargetsInSubsegment or fewer targets)  
                                  (default=off)
      --maxTargetsInSubsegment=INT
                                When genotyping sub-segments of input 
                                  intervals, only consider sub-segments 
                                  consisting of this number of targets or fewer 
                                   (default=`30')
  -T, --genotypeQualThresholdWhenNoExact=DOUBLE
                                Quality threshold for calling a genotype, used 
                                  *ONLY* when 'gxcnv' does not contain the 
                                  'Q_EXACT' field for the interval being 
                                  genotyped  (default=`20')

 Mode: mergeVCFs
  Merge VCF files output by multiple runs of the 'genotype' command on the same 
  input intervals (.xcnv file), but for different samples
      --mergeVCFs               
      --mergeVCF=STRING         VCF file(s) to be merged [must have *IDENTICAL* 
                                  genotyped intervals]
      --mergeVCFlist=STRING     A file containing a list of VCF files to be 
                                  merged [must have *IDENTICAL* genotyped 
                                  intervals]

Options for modes: 'discover', 'genotype', 'transition', 'printHMM':
  -p, --paramFile=STRING        (Initial) model parameters file

Options for modes: 'discover', 'genotype':
  -m, --maxNormalizedReadDepthVal=DOUBLE
                                Value at which to cap the absolute value of 
                                  *normalized* input read depth values 
                                  ('readDepths')  (default=`10')
  -q, --maxQualScore=DOUBLE     Value at which to cap the calculated quality 
                                  scores  (default=`99')
  -e, --scorePrecision=INT      Decimal precision of quality scores  
                                  (default=`0')
  -a, --aux_xcnv=STRING         Auxiliary CNV output file (may be VERY LARGE in 
                                  'genotype' mode)
  -u, --auxUpstreamPrintTargs=INT
                                Number of targets to print upstream of CNV in 
                                  'auxOutput' file  (default=`2')
  -w, --auxDownstreamPrintTargs=INT
                                Number of targets to print downstream of CNV in 
                                  'auxOutput' file  (default=`2')
  -R, --origReadDepths=STRING   Matrix of unnormalized read-depths to use for 
                                  CNV annotation, where rows (samples) and 
                                  columns (targets) are labeled
      --keepSampleIDs=STRING    File containing a list of samples to be 
                                  analyzed

Options for modes: 'genotype', 'mergeVCFs':
  -v, --vcf=STRING              Genotyped CNV output VCF file  (default=`-')
*******************************************************************

 Mode: printHMM
  Print HMM model parameters and exit
      --printHMM                

 Mode: transition
  Print HMM transition matrix for user-requested genomic distances
      --transition
```


## xhmm_matrix

### Tool Description
Uses principal component analysis (PCA) normalization and a hidden Markov model (HMM) to detect and genotype copy number variation (CNV) from normalized read-depth data from targeted sequencing experiments.

### Metadata
- **Docker Image**: quay.io/biocontainers/xhmm:0.0.0.2016_01_04.cc14e52--hedee03e_3
- **Homepage**: http://atgu.mgh.harvard.edu/xhmm/index.shtml
- **Package**: https://anaconda.org/channels/bioconda/packages/xhmm/overview
- **Validation**: PASS

### Original Help Text
```text
xhmm 1.0

Uses principal component analysis (PCA) normalization and a hidden Markov model 
(HMM) to detect and genotype copy number variation (CNV) from normalized 
read-depth data from targeted sequencing experiments.

Usage: xhmm [OPTIONS]...

Developed by Menachem Fromer and Shaun Purcell

  -h, --help                    Print help and exit
      --detailed-help           Print help, including all details and hidden 
                                  options, and exit
      --full-help               Print help, including hidden options, and exit
  -V, --version                 Print version and exit

*******************************************************************
Options for modes: 'prepareTargets', 'genotype':
  -F, --referenceFASTA=STRING   Reference FASTA file (MUST have .fai index 
                                  file)

*******************************************************************
Options for modes: 'matrix', 'PCA', 'normalize', 'discover', 'genotype':
  -r, --readDepths=STRING       Matrix of *input* read-depths, where rows 
                                  (samples) and columns (targets) are labeled  
                                  (default=`-')
*******************************************************************

 Mode: prepareTargets
  Sort all target intervals, merge overlapping ones, and print the resulting 
  interval list
  -S, --prepareTargets          
      --targets=STRING          Input targets lists
      --mergedTargets=STRING    Output targets list  (default=`-')

 Mode: mergeGATKdepths
  Merge the output from GATK into a single read depth matrix of samples (rows) 
  by targets (columns)
  -A, --mergeGATKdepths         
      --GATKdepths=STRING       GATK sample_interval_summary output file(s) to 
                                  be merged [must have *IDENTICAL* target 
                                  lists]
      --GATKdepthsList=STRING   A file containing a list of GATK 
                                  sample_interval_summary output files to be 
                                  merged [must have *IDENTICAL* target lists]
      --sampleIDmap=STRING      File containing mappings of sample names to new 
                                  sample names (in columns designated by 
                                  fromID, toID)
      --fromID=INT              Column number of OLD sample IDs to map  
                                  (default=`1')
      --toID=INT                Column number of NEW sample IDs to map  
                                  (default=`2')
      --columnSuffix=STRING     Suffix of columns to be used for merging [where 
                                  columns are in the form: SAMPLE + 
                                  columnSuffix]  (default=`_mean_cvg')
      --rdPrecision=INT         Decimal precision of read depths output  
                                  (default=`2')
      --outputTargetsBySamples  Output targets x samples (instead of samples x 
                                  targets)  (default=off)

 Mode: matrix
  Process (filter, center, etc.) a read depth matrix and output the resulting 
  matrix.  Note that first all excluded samples and targets are removed.  And, 
  sample statistics used for filtering are calculated only *after* filtering 
  out relevant targets.
  -M, --matrix                  
      --excludeTargets=STRING   File(s) of targets to exclude
      --excludeChromosomeTargets=STRING
                                Target chromosome(s) to exclude
      --excludeSamples=STRING   File(s) of samples to exclude
      --minTargetSize=INT       Minimum size of target (in bp) to process  
                                  (default=`0')
      --maxTargetSize=INT       Maximum size of target (in bp) to process
      --minMeanTargetRD=DOUBLE  Minimum per-target mean RD to require for 
                                  target to be processed
      --maxMeanTargetRD=DOUBLE  Maximum per-target mean RD to require for 
                                  target to be processed
      --minSdTargetRD=DOUBLE    Minimum per-target standard deviation of RD to 
                                  require for target to be processed  
                                  (default=`0')
      --maxSdTargetRD=DOUBLE    Maximum per-target standard deviation of RD to 
                                  require for target to be processed
      --minMeanSampleRD=DOUBLE  Minimum per-sample mean RD to require for 
                                  sample to be processed
      --maxMeanSampleRD=DOUBLE  Maximum per-sample mean RD to require for 
                                  sample to be processed
      --minSdSampleRD=DOUBLE    Minimum per-sample standard deviation of RD to 
                                  require for sample to be processed  
                                  (default=`0')
      --maxSdSampleRD=DOUBLE    Maximum per-sample standard deviation of RD to 
                                  require for sample to be processed
      --scaleDataBySum          After any filtering, scale read-depth matrix 
                                  values by sample- or target- sums (as per 
                                  --scaleDataBySumType) [i.e., divide by row or 
                                  column sums], but multiply by factor 
                                  specificied by --scaleDataBySumFactor  
                                  (default=off)
      --scaleDataBySumType=ENUM If --scaleDataBySum given, then scale the data 
                                  within this dimension  (possible 
                                  values="target", "sample")
      --scaleDataBySumFactor=DOUBLE
                                If --scaleDataBySum given, then divide by 
                                  appropriate sum (but multiply by this factor) 
                                   (default=`1e6')
      --log10=DOUBLE            After any filtering and optional scaling steps 
                                  (but before any optional centering steps), 
                                  convert the matrix to log10 values. To deal 
                                  with non-positive and small positive values, 
                                  a truncation and then pseudocount approach is 
                                  taken. Specifically, denote the original 
                                  matrix value as x and this parameter's 
                                  pseudocount value as v (say, 0.5). The matrix 
                                  value used is then log10(max(x, 0) + v)
      --centerData              Output sample- or target- centered read-depth 
                                  matrix (as per --centerType)  (default=off)
      --centerType=ENUM         If --centerData given, then center the data 
                                  around this dimension  (possible 
                                  values="target", "sample")
      --zScoreData              If --centerData given, then additionally 
                                  normalize by standard deviation (outputting 
                                  z-scores)  (default=off)
      --outputExcludedTargets=STRING
                                File in which to output targets excluded by 
                                  some criterion
      --outputExcludedSamples=STRING
                                File in which to output samples excluded by 
                                  some criterion

Options for modes: 'mergeGATKdepths', 'matrix':
  -o, --outputMatrix=STRING     Read-depth matrix output file  (default=`-')
*******************************************************************

 Mode: PCA
  Run PCA to create normalization factors for read depth matrix
  -P, --PCA                     Matrix is read from --readDepths argument; 
                                  normalization factors sent to --PCAfiles 
                                  argument
      --PCA_saveMemory[=STRING] Should XHMM save memory by storing some of the 
                                  intermediate PCA matrices as temporary files 
                                  on disk?  (default=`')

 Mode: normalize
  Apply PCA factors in order to normalize read depth matrix
  -N, --normalize               Matrix is read from --readDepths argument; 
                                  normalization factors read from --PCAfiles 
                                  argument
  -n, --normalizeOutput=STRING  Normalized read-depth matrix output file  
                                  (default=`-')
      --PCnormalizeMethod=ENUM  Method to choose which prinicipal components 
                                  are removed for data normalization  (possible 
                                  values="numPCtoRemove", "PVE_mean", 
                                  "PVE_contrib" default=`PVE_mean')
      --numPCtoRemove=INT       Number of highest principal components to 
                                  filter out  (default=`20')
      --PVE_mean_factor=DOUBLE  Remove all principal components that 
                                  individually explain more variance than this 
                                  factor times the average (in the original 
                                  PCA-ed data)  (default=`0.7')
      --PVE_contrib=DOUBLE      Remove the smallest number of principal 
                                  components that explain this percent of the 
                                  variance (in the original PCA-ed data)  
                                  (default=`50')

Options for modes: 'PCA', 'normalize':
      --PCAfiles=STRING         Base file name for 'PCA' *output*, and 
                                  'normalize' *input*
*******************************************************************

 Mode: discover
  Discover CNVs from normalized read depth matrix
  -D, --discover                Matrix is read from --readDepths argument
  -c, --xcnv=STRING             CNV output file  (default=`-')
  -t, --discoverSomeQualThresh=DOUBLE
                                Quality threshold for discovering a CNV in a 
                                  sample  (default=`30')
  -s, --posteriorFiles=STRING   Base file name for posterior probabilities 
                                  output files; if not given, and --xcnv is not 
                                  '-', this will default to --xcnv argument

 Mode: genotype
  Genotype list of CNVs from normalized read depth matrix
  -G, --genotype                Matrix is read from --readDepths argument
  -g, --gxcnv=STRING            xhmm CNV input file to genotype in 'readDepths' 
                                  sample
      --subsegments             In addition to genotyping the intervals 
                                  specified in gxcnv, genotype all sub-segments 
                                  of these intervals (with 
                                  maxTargetsInSubsegment or fewer targets)  
                                  (default=off)
      --maxTargetsInSubsegment=INT
                                When genotyping sub-segments of input 
                                  intervals, only consider sub-segments 
                                  consisting of this number of targets or fewer 
                                   (default=`30')
  -T, --genotypeQualThresholdWhenNoExact=DOUBLE
                                Quality threshold for calling a genotype, used 
                                  *ONLY* when 'gxcnv' does not contain the 
                                  'Q_EXACT' field for the interval being 
                                  genotyped  (default=`20')

 Mode: mergeVCFs
  Merge VCF files output by multiple runs of the 'genotype' command on the same 
  input intervals (.xcnv file), but for different samples
      --mergeVCFs               
      --mergeVCF=STRING         VCF file(s) to be merged [must have *IDENTICAL* 
                                  genotyped intervals]
      --mergeVCFlist=STRING     A file containing a list of VCF files to be 
                                  merged [must have *IDENTICAL* genotyped 
                                  intervals]

Options for modes: 'discover', 'genotype', 'transition', 'printHMM':
  -p, --paramFile=STRING        (Initial) model parameters file

Options for modes: 'discover', 'genotype':
  -m, --maxNormalizedReadDepthVal=DOUBLE
                                Value at which to cap the absolute value of 
                                  *normalized* input read depth values 
                                  ('readDepths')  (default=`10')
  -q, --maxQualScore=DOUBLE     Value at which to cap the calculated quality 
                                  scores  (default=`99')
  -e, --scorePrecision=INT      Decimal precision of quality scores  
                                  (default=`0')
  -a, --aux_xcnv=STRING         Auxiliary CNV output file (may be VERY LARGE in 
                                  'genotype' mode)
  -u, --auxUpstreamPrintTargs=INT
                                Number of targets to print upstream of CNV in 
                                  'auxOutput' file  (default=`2')
  -w, --auxDownstreamPrintTargs=INT
                                Number of targets to print downstream of CNV in 
                                  'auxOutput' file  (default=`2')
  -R, --origReadDepths=STRING   Matrix of unnormalized read-depths to use for 
                                  CNV annotation, where rows (samples) and 
                                  columns (targets) are labeled
      --keepSampleIDs=STRING    File containing a list of samples to be 
                                  analyzed

Options for modes: 'genotype', 'mergeVCFs':
  -v, --vcf=STRING              Genotyped CNV output VCF file  (default=`-')
*******************************************************************

 Mode: printHMM
  Print HMM model parameters and exit
      --printHMM                

 Mode: transition
  Print HMM transition matrix for user-requested genomic distances
      --transition
```

