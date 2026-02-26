# meta-apo CWL Generation Report

## meta-apo_meta-apo-train

### Tool Description
Model training using gene profiles of paired WGS-amplicon microbiomes

### Metadata
- **Docker Image**: quay.io/biocontainers/meta-apo:1.1--h9f5acd7_4
- **Homepage**: https://github.com/qibebt-bioinfo/meta-apo
- **Package**: https://anaconda.org/channels/bioconda/packages/meta-apo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/meta-apo/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/qibebt-bioinfo/meta-apo
- **Stars**: N/A
### Original Help Text
```text
meta-apo-train version : 1.01 for KEGG
	Model training using gene profiles of paired WGS-amplicon microbiomes
Usage: 
meta-apo-train [Option] Value
Options: 
	[Input options, required]
	  -L (upper) Input files list of training WGS samples
	  -l Input files list of training amplicon samples
	  -p List files path prefix [Optional for -l and -L]
	or
	  -T (upper) Input KO table (*.ko.abd) of training WGS samples
	  -t Input KO table (*.ko.abd) of training amplicon samples
	  -R (upper) If the input table is reversed, T(rue) or F(alse), default is false [Optional for -T and -t]
	[Output options]
	  -o Output mode file, default is "meta-apo.model" 
	[Other options]
	  -h Help
```


## meta-apo_meta-apo-calibrate

### Tool Description
Calibration of predicted gene profiles of amplicon microbiomes

### Metadata
- **Docker Image**: quay.io/biocontainers/meta-apo:1.1--h9f5acd7_4
- **Homepage**: https://github.com/qibebt-bioinfo/meta-apo
- **Package**: https://anaconda.org/channels/bioconda/packages/meta-apo/overview
- **Validation**: PASS

### Original Help Text
```text
meta-apo-calibrate version : 1.01 for KEGG
	Calibration of predicted gene profiles of amplicon microbiomes
Usage: 
meta-apo-calibrate [Option] Value
Options: 
	[Input options, required]
	  -i Input a gene profile file for a single sample
	or
	  -l Input files list for multiple samples
	  -p List files path prefix [Optional for -l]
	or
	  -t Input KO table (*.ko.abd) for multiple samples
	  -R (upper) If the input table is reversed, T(rue) or F(alse), default is false [Optional for -t]
	  -m Input model file
	[Output options]
	  -o Output path, default is "functions.calibrated"
	[Other options]
	  -h Help
```

