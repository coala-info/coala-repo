# hmmratac CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| hmmratac_HMMRATAC | PASS |  |

## hmmratac_HMMRATAC

### Tool Description
Hidden Markov ModeleR for ATAC-seq (HMMRATAC): calls open chromatin peaks from an ATAC-seq BAM file

### Metadata
- **Docker Image**: quay.io/biocontainers/hmmratac:1.2.10--hdfd78af_1
- **Homepage**: https://github.com/LiuLabUB/HMMRATAC
- **Package**: https://anaconda.org/channels/bioconda/packages/hmmratac/overview
- **Validation**: PASS

### Original Help Text
```text
HMMRATAC Version:	1.2.10
Usage: java -jar HMMRATAC_V#_exe.jar

Required Parameters:
	-b , --bam <BAM> Sorted BAM file containing the ATAC-seq reads
	-i , --index <BAI> Index file for the sorted BAM File
	-g , --genome <GenomeFile> Two column, tab delimited file containing genome size stats

Optional Parameters:
	-m , --means <double> Comma separated list of initial mean values for the fragment distribution. Default = 50,200,400,600
	-s , --stddev <double> Comma separated list of initial standard deviation values for fragment distribution. Default = 20,20,20,20
	-f , --fragem <true || false> Whether to perform EM training on the fragment distribution. Default = True
	-q , --minmapq <int> Minimum mapping quality of reads to keep. Default = 30
	-u , --upper <int> Upper limit on fold change range for choosing training sites. Default = 20
	-l , --lower <int> Lower limit on fold change range for choosing training sites. Default = 10
	-z , --zscore <int> Zscored read depth to mask during Viterbi decoding. Default = 100
	-o , --output <String> Name for output files. Default = NA
	-e , --blacklist <BED_File> bed file of blacklisted regions to exclude
	-p , --peaks <true || false> Whether to report peaks in bed format. Default = true
	-k , --kmeans <int> Number of States in the model. Default = 3. If not k=3, recommend NOT calling peaks, use bedgraph
	-t , --training <BED_File> BED file of training regions to use for training model, instead of foldchange settings
	--bedgraph <true || false> Whether to report whole genome bedgraph of all state anntations. Default = false
	--minlen <int> Minimum length of open region to call peak. Note: -p , --peaks must be set. Default = 200
	--score <max || ave || med || fc || zscore || all> What type of score system to use for peaks. Can be used for ranking peaks. Default = max
	--bgscore <true || false> Whether to add the HMMR score to each state annotation in bedgraph. Note: this adds considerable time. Default = False
	--trim <int> How many signals from the end to trim off (ie starting with tri signal then di etc). This may be useful if your data doesn't contain many large fragments. Default = 0
	--window <int> Size of the bins to split the genome into for Viterbi decoding.
		 To save memory, the genome is split into <int> long bins and viterbi decoding occurs across each bin. 
		Default = 25000000. Note: For machines with limited memory, it is recomended to reduce the size of the bins.
	--model <File> Binary model file (generated from previous HMMR run) to use instead of creating new one
	--modelonly <true || false> Whether or not to stop the program after generating model. Default = false
	--maxTrain <int> Maximum number of training regions to use. Default == 1000
	--removeDuplicates <true || false> Whether or not to remove duplicate reads from analysis. Default = true
	--printExclude <true || false> Whether to output excluded regions into Output_exclude.bed. Default = false
	--printTrain <true || false> Whether to output training regions into Output_training.bed. Default = true
	--randomSeed <long> Seed to set for random sampling of training regions. Default is 10151
	--threshold <double> threshold for reporting peaks. Only peaks who's score is >= this value will be reported.
	-h , --help Print this help message and exit.
```

## Metadata
- **Skill**: generated
