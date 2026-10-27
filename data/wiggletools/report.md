# wiggletools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| wiggletools_apply | PASS |  |
| wiggletools_entropy | Failed | tool bug: the entropy reducer returns the standard deviation (reducers.c uses StdDevReductionPop for entropy). |
| wiggletools_mean | PASS |  |
| wiggletools_median | PASS |  |
| wiggletools_min | PASS |  |
| wiggletools_nearest | PASS | Distances to the nearest exon match an independent calculation except a one-base convention difference downstream of regions. |
| wiggletools_ratio | PASS |  |
| wiggletools_stddev | PASS |  |
| wiggletools_ttest | Failed | tool bug: p-values differ from Welch's t-test by up to 0.09 because the tool uses population variance. |
| wiggletools_wilcoxon | Failed | tool bug: output is a signed 2*erf(z) value between -2 and 0, not a p-value (integer division in sigma, missing sqrt 2). |

## wiggletools_ratio

### Tool Description
Ratio of two tracks (binary operator ratio).

### Metadata
- **Docker Image**: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
- **Homepage**: https://github.com/Ensembl/WiggleTools
- **Package**: https://anaconda.org/channels/bioconda/packages/wiggletools/overview
- **Validation**: PASS

### Original Help Text
```text
WiggleTools

Copyright [1999-2017] EMBL-European Bioinformatics Institute
Development contact: Daniel Zerbino zerbino@ebi.ac.uk

Citation: Zerbino DR, Johnson N, Juettemann T, Wilder SP and Flicek PR: WiggleTools: parallel processing of large collections of genome-wide datasets for visualization and statistical analysis. Bioinformatics 2014 30:1008-1009.

This library parses wiggle files and executes various operations on them streaming through lazy evaluators.

Inputs:
	The program takes in Wig, BigWig, BedGraph, Bed, BigBed, Bam, VCF, and BCF files, which are distinguished thanks to their suffix (.wig, (.bw|.bigWig|.bigwig), .bg, .bed, .bb, .bam, .cram, .vcf, .bcf respectively).
	Note that wiggletools assumes that every bam file has an index .bai file next to it.

Outputs:
	The program outputs a wiggle file in stdout unless the output is squashed

Command line:
	wiggletools --help
	wiggletools program

Program grammar:
	program = (iterator) | do (iterator) | (extraction) | (statistic) | run (file)
	iterator = (in_filename) | (unary_operator) (iterator) | (binary_operator) (iterator) (iterator) | (reducer) (multiplex) | (setComparison) (multiplex_list) | print (output) (statistic)
	unary_operator = unit | coverage | write (output) | write_bg (ouput) | smooth (int) | abs | exp | ln | log (float) | pow (float) | offset (float) | shiftPos (int) | scale (float) | gt (float) | gte (float) | lt (float) | lte (float) | default (float) | isZero | toInt | floor | extend (int) | bin (int) | compress | (statistic)
	output = (out_filename) | -
	in_filename = *.wig | *.bw | *.bed | *.bb | *.bg | *.sam | *.bam | *.cram | read_count *.sam | read_count *.bam | read_count *.cram | *.vcf | *.bcf | - | sam -
	statistic = (statistic_function) (iterator) | ndpearson (multiplex) (multiplex)
	statistic_function = AUC | meanI | varI | minI | maxI | stddevI | CVI | energy (wavelength) | pearson (iterator)
	binary_operator = diff | ratio | overlaps | trim | noverlaps | nearest | apply (statistic) | fillIn | trimFill
	reducer = cat | sum | product | mean | var | stddev | entropy | CV | median | min | max
	setComparison = ttest | ftest | wilcoxon
	multiplex_list = (multiplex) | (multiplex) : (multiplex_list)
	multiplex = (iterator_list) | map (unary_operator) (multiplex) | strict (multiplex)
	iterator_list = (iterator) | (iterator) : (iterator_list)
```

## wiggletools_entropy

### Tool Description
Entropy of several tracks at each position (reducer entropy).

### Metadata
- **Docker Image**: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
- **Homepage**: https://github.com/Ensembl/WiggleTools
- **Package**: https://anaconda.org/channels/bioconda/packages/wiggletools/overview
- **Validation**: PASS

### Original Help Text
```text
WiggleTools

Copyright [1999-2017] EMBL-European Bioinformatics Institute
Development contact: Daniel Zerbino zerbino@ebi.ac.uk

Citation: Zerbino DR, Johnson N, Juettemann T, Wilder SP and Flicek PR: WiggleTools: parallel processing of large collections of genome-wide datasets for visualization and statistical analysis. Bioinformatics 2014 30:1008-1009.

This library parses wiggle files and executes various operations on them streaming through lazy evaluators.

Inputs:
	The program takes in Wig, BigWig, BedGraph, Bed, BigBed, Bam, VCF, and BCF files, which are distinguished thanks to their suffix (.wig, (.bw|.bigWig|.bigwig), .bg, .bed, .bb, .bam, .cram, .vcf, .bcf respectively).
	Note that wiggletools assumes that every bam file has an index .bai file next to it.

Outputs:
	The program outputs a wiggle file in stdout unless the output is squashed

Command line:
	wiggletools --help
	wiggletools program

Program grammar:
	program = (iterator) | do (iterator) | (extraction) | (statistic) | run (file)
	iterator = (in_filename) | (unary_operator) (iterator) | (binary_operator) (iterator) (iterator) | (reducer) (multiplex) | (setComparison) (multiplex_list) | print (output) (statistic)
	unary_operator = unit | coverage | write (output) | write_bg (ouput) | smooth (int) | abs | exp | ln | log (float) | pow (float) | offset (float) | shiftPos (int) | scale (float) | gt (float) | gte (float) | lt (float) | lte (float) | default (float) | isZero | toInt | floor | extend (int) | bin (int) | compress | (statistic)
	output = (out_filename) | -
	in_filename = *.wig | *.bw | *.bed | *.bb | *.bg | *.sam | *.bam | *.cram | read_count *.sam | read_count *.bam | read_count *.cram | *.vcf | *.bcf | - | sam -
	statistic = (statistic_function) (iterator) | ndpearson (multiplex) (multiplex)
	statistic_function = AUC | meanI | varI | minI | maxI | stddevI | CVI | energy (wavelength) | pearson (iterator)
	binary_operator = diff | ratio | overlaps | trim | noverlaps | nearest | apply (statistic) | fillIn | trimFill
	reducer = cat | sum | product | mean | var | stddev | entropy | CV | median | min | max
	setComparison = ttest | ftest | wilcoxon
	multiplex_list = (multiplex) | (multiplex) : (multiplex_list)
	multiplex = (iterator_list) | map (unary_operator) (multiplex) | strict (multiplex)
	iterator_list = (iterator) | (iterator) : (iterator_list)
```

## wiggletools_nearest

### Tool Description
Regions of the second track with their distance to the nearest region of the first track (binary operator nearest).

### Metadata
- **Docker Image**: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
- **Homepage**: https://github.com/Ensembl/WiggleTools
- **Package**: https://anaconda.org/channels/bioconda/packages/wiggletools/overview
- **Validation**: PASS

### Original Help Text
```text
WiggleTools

Copyright [1999-2017] EMBL-European Bioinformatics Institute
Development contact: Daniel Zerbino zerbino@ebi.ac.uk

Citation: Zerbino DR, Johnson N, Juettemann T, Wilder SP and Flicek PR: WiggleTools: parallel processing of large collections of genome-wide datasets for visualization and statistical analysis. Bioinformatics 2014 30:1008-1009.

This library parses wiggle files and executes various operations on them streaming through lazy evaluators.

Inputs:
	The program takes in Wig, BigWig, BedGraph, Bed, BigBed, Bam, VCF, and BCF files, which are distinguished thanks to their suffix (.wig, (.bw|.bigWig|.bigwig), .bg, .bed, .bb, .bam, .cram, .vcf, .bcf respectively).
	Note that wiggletools assumes that every bam file has an index .bai file next to it.

Outputs:
	The program outputs a wiggle file in stdout unless the output is squashed

Command line:
	wiggletools --help
	wiggletools program

Program grammar:
	program = (iterator) | do (iterator) | (extraction) | (statistic) | run (file)
	iterator = (in_filename) | (unary_operator) (iterator) | (binary_operator) (iterator) (iterator) | (reducer) (multiplex) | (setComparison) (multiplex_list) | print (output) (statistic)
	unary_operator = unit | coverage | write (output) | write_bg (ouput) | smooth (int) | abs | exp | ln | log (float) | pow (float) | offset (float) | shiftPos (int) | scale (float) | gt (float) | gte (float) | lt (float) | lte (float) | default (float) | isZero | toInt | floor | extend (int) | bin (int) | compress | (statistic)
	output = (out_filename) | -
	in_filename = *.wig | *.bw | *.bed | *.bb | *.bg | *.sam | *.bam | *.cram | read_count *.sam | read_count *.bam | read_count *.cram | *.vcf | *.bcf | - | sam -
	statistic = (statistic_function) (iterator) | ndpearson (multiplex) (multiplex)
	statistic_function = AUC | meanI | varI | minI | maxI | stddevI | CVI | energy (wavelength) | pearson (iterator)
	binary_operator = diff | ratio | overlaps | trim | noverlaps | nearest | apply (statistic) | fillIn | trimFill
	reducer = cat | sum | product | mean | var | stddev | entropy | CV | median | min | max
	setComparison = ttest | ftest | wilcoxon
	multiplex_list = (multiplex) | (multiplex) : (multiplex_list)
	multiplex = (iterator_list) | map (unary_operator) (multiplex) | strict (multiplex)
	iterator_list = (iterator) | (iterator) : (iterator_list)
```

## wiggletools_ttest

### Tool Description
Welch t-test between two sets of tracks at each position (set comparison ttest).

### Metadata
- **Docker Image**: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
- **Homepage**: https://github.com/Ensembl/WiggleTools
- **Package**: https://anaconda.org/channels/bioconda/packages/wiggletools/overview
- **Validation**: PASS

### Original Help Text
```text
WiggleTools

Copyright [1999-2017] EMBL-European Bioinformatics Institute
Development contact: Daniel Zerbino zerbino@ebi.ac.uk

Citation: Zerbino DR, Johnson N, Juettemann T, Wilder SP and Flicek PR: WiggleTools: parallel processing of large collections of genome-wide datasets for visualization and statistical analysis. Bioinformatics 2014 30:1008-1009.

This library parses wiggle files and executes various operations on them streaming through lazy evaluators.

Inputs:
	The program takes in Wig, BigWig, BedGraph, Bed, BigBed, Bam, VCF, and BCF files, which are distinguished thanks to their suffix (.wig, (.bw|.bigWig|.bigwig), .bg, .bed, .bb, .bam, .cram, .vcf, .bcf respectively).
	Note that wiggletools assumes that every bam file has an index .bai file next to it.

Outputs:
	The program outputs a wiggle file in stdout unless the output is squashed

Command line:
	wiggletools --help
	wiggletools program

Program grammar:
	program = (iterator) | do (iterator) | (extraction) | (statistic) | run (file)
	iterator = (in_filename) | (unary_operator) (iterator) | (binary_operator) (iterator) (iterator) | (reducer) (multiplex) | (setComparison) (multiplex_list) | print (output) (statistic)
	unary_operator = unit | coverage | write (output) | write_bg (ouput) | smooth (int) | abs | exp | ln | log (float) | pow (float) | offset (float) | shiftPos (int) | scale (float) | gt (float) | gte (float) | lt (float) | lte (float) | default (float) | isZero | toInt | floor | extend (int) | bin (int) | compress | (statistic)
	output = (out_filename) | -
	in_filename = *.wig | *.bw | *.bed | *.bb | *.bg | *.sam | *.bam | *.cram | read_count *.sam | read_count *.bam | read_count *.cram | *.vcf | *.bcf | - | sam -
	statistic = (statistic_function) (iterator) | ndpearson (multiplex) (multiplex)
	statistic_function = AUC | meanI | varI | minI | maxI | stddevI | CVI | energy (wavelength) | pearson (iterator)
	binary_operator = diff | ratio | overlaps | trim | noverlaps | nearest | apply (statistic) | fillIn | trimFill
	reducer = cat | sum | product | mean | var | stddev | entropy | CV | median | min | max
	setComparison = ttest | ftest | wilcoxon
	multiplex_list = (multiplex) | (multiplex) : (multiplex_list)
	multiplex = (iterator_list) | map (unary_operator) (multiplex) | strict (multiplex)
	iterator_list = (iterator) | (iterator) : (iterator_list)
```

## wiggletools_apply

### Tool Description
Apply a statistic to a data track over each region of a region track (binary operator apply).

### Metadata
- **Docker Image**: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
- **Homepage**: https://github.com/Ensembl/WiggleTools
- **Package**: https://anaconda.org/channels/bioconda/packages/wiggletools/overview
- **Validation**: PASS

### Original Help Text
```text
WiggleTools

Copyright [1999-2017] EMBL-European Bioinformatics Institute
Development contact: Daniel Zerbino zerbino@ebi.ac.uk

Citation: Zerbino DR, Johnson N, Juettemann T, Wilder SP and Flicek PR: WiggleTools: parallel processing of large collections of genome-wide datasets for visualization and statistical analysis. Bioinformatics 2014 30:1008-1009.

This library parses wiggle files and executes various operations on them streaming through lazy evaluators.

Inputs:
	The program takes in Wig, BigWig, BedGraph, Bed, BigBed, Bam, VCF, and BCF files, which are distinguished thanks to their suffix (.wig, (.bw|.bigWig|.bigwig), .bg, .bed, .bb, .bam, .cram, .vcf, .bcf respectively).
	Note that wiggletools assumes that every bam file has an index .bai file next to it.

Outputs:
	The program outputs a wiggle file in stdout unless the output is squashed

Command line:
	wiggletools --help
	wiggletools program

Program grammar:
	program = (iterator) | do (iterator) | (extraction) | (statistic) | run (file)
	iterator = (in_filename) | (unary_operator) (iterator) | (binary_operator) (iterator) (iterator) | (reducer) (multiplex) | (setComparison) (multiplex_list) | print (output) (statistic)
	unary_operator = unit | coverage | write (output) | write_bg (ouput) | smooth (int) | abs | exp | ln | log (float) | pow (float) | offset (float) | shiftPos (int) | scale (float) | gt (float) | gte (float) | lt (float) | lte (float) | default (float) | isZero | toInt | floor | extend (int) | bin (int) | compress | (statistic)
	output = (out_filename) | -
	in_filename = *.wig | *.bw | *.bed | *.bb | *.bg | *.sam | *.bam | *.cram | read_count *.sam | read_count *.bam | read_count *.cram | *.vcf | *.bcf | - | sam -
	statistic = (statistic_function) (iterator) | ndpearson (multiplex) (multiplex)
	statistic_function = AUC | meanI | varI | minI | maxI | stddevI | CVI | energy (wavelength) | pearson (iterator)
	binary_operator = diff | ratio | overlaps | trim | noverlaps | nearest | apply (statistic) | fillIn | trimFill
	reducer = cat | sum | product | mean | var | stddev | entropy | CV | median | min | max
	setComparison = ttest | ftest | wilcoxon
	multiplex_list = (multiplex) | (multiplex) : (multiplex_list)
	multiplex = (iterator_list) | map (unary_operator) (multiplex) | strict (multiplex)
	iterator_list = (iterator) | (iterator) : (iterator_list)
```

## wiggletools_min

### Tool Description
Minimum of several tracks at each position (reducer min).

### Metadata
- **Docker Image**: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
- **Homepage**: https://github.com/Ensembl/WiggleTools
- **Package**: https://anaconda.org/channels/bioconda/packages/wiggletools/overview
- **Validation**: PASS

### Original Help Text
```text
WiggleTools

Copyright [1999-2017] EMBL-European Bioinformatics Institute
Development contact: Daniel Zerbino zerbino@ebi.ac.uk

Citation: Zerbino DR, Johnson N, Juettemann T, Wilder SP and Flicek PR: WiggleTools: parallel processing of large collections of genome-wide datasets for visualization and statistical analysis. Bioinformatics 2014 30:1008-1009.

This library parses wiggle files and executes various operations on them streaming through lazy evaluators.

Inputs:
	The program takes in Wig, BigWig, BedGraph, Bed, BigBed, Bam, VCF, and BCF files, which are distinguished thanks to their suffix (.wig, (.bw|.bigWig|.bigwig), .bg, .bed, .bb, .bam, .cram, .vcf, .bcf respectively).
	Note that wiggletools assumes that every bam file has an index .bai file next to it.

Outputs:
	The program outputs a wiggle file in stdout unless the output is squashed

Command line:
	wiggletools --help
	wiggletools program

Program grammar:
	program = (iterator) | do (iterator) | (extraction) | (statistic) | run (file)
	iterator = (in_filename) | (unary_operator) (iterator) | (binary_operator) (iterator) (iterator) | (reducer) (multiplex) | (setComparison) (multiplex_list) | print (output) (statistic)
	unary_operator = unit | coverage | write (output) | write_bg (ouput) | smooth (int) | abs | exp | ln | log (float) | pow (float) | offset (float) | shiftPos (int) | scale (float) | gt (float) | gte (float) | lt (float) | lte (float) | default (float) | isZero | toInt | floor | extend (int) | bin (int) | compress | (statistic)
	output = (out_filename) | -
	in_filename = *.wig | *.bw | *.bed | *.bb | *.bg | *.sam | *.bam | *.cram | read_count *.sam | read_count *.bam | read_count *.cram | *.vcf | *.bcf | - | sam -
	statistic = (statistic_function) (iterator) | ndpearson (multiplex) (multiplex)
	statistic_function = AUC | meanI | varI | minI | maxI | stddevI | CVI | energy (wavelength) | pearson (iterator)
	binary_operator = diff | ratio | overlaps | trim | noverlaps | nearest | apply (statistic) | fillIn | trimFill
	reducer = cat | sum | product | mean | var | stddev | entropy | CV | median | min | max
	setComparison = ttest | ftest | wilcoxon
	multiplex_list = (multiplex) | (multiplex) : (multiplex_list)
	multiplex = (iterator_list) | map (unary_operator) (multiplex) | strict (multiplex)
	iterator_list = (iterator) | (iterator) : (iterator_list)
```

## wiggletools_median

### Tool Description
Median of several tracks at each position (reducer median).

### Metadata
- **Docker Image**: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
- **Homepage**: https://github.com/Ensembl/WiggleTools
- **Package**: https://anaconda.org/channels/bioconda/packages/wiggletools/overview
- **Validation**: PASS

### Original Help Text
```text
WiggleTools

Copyright [1999-2017] EMBL-European Bioinformatics Institute
Development contact: Daniel Zerbino zerbino@ebi.ac.uk

Citation: Zerbino DR, Johnson N, Juettemann T, Wilder SP and Flicek PR: WiggleTools: parallel processing of large collections of genome-wide datasets for visualization and statistical analysis. Bioinformatics 2014 30:1008-1009.

This library parses wiggle files and executes various operations on them streaming through lazy evaluators.

Inputs:
	The program takes in Wig, BigWig, BedGraph, Bed, BigBed, Bam, VCF, and BCF files, which are distinguished thanks to their suffix (.wig, (.bw|.bigWig|.bigwig), .bg, .bed, .bb, .bam, .cram, .vcf, .bcf respectively).
	Note that wiggletools assumes that every bam file has an index .bai file next to it.

Outputs:
	The program outputs a wiggle file in stdout unless the output is squashed

Command line:
	wiggletools --help
	wiggletools program

Program grammar:
	program = (iterator) | do (iterator) | (extraction) | (statistic) | run (file)
	iterator = (in_filename) | (unary_operator) (iterator) | (binary_operator) (iterator) (iterator) | (reducer) (multiplex) | (setComparison) (multiplex_list) | print (output) (statistic)
	unary_operator = unit | coverage | write (output) | write_bg (ouput) | smooth (int) | abs | exp | ln | log (float) | pow (float) | offset (float) | shiftPos (int) | scale (float) | gt (float) | gte (float) | lt (float) | lte (float) | default (float) | isZero | toInt | floor | extend (int) | bin (int) | compress | (statistic)
	output = (out_filename) | -
	in_filename = *.wig | *.bw | *.bed | *.bb | *.bg | *.sam | *.bam | *.cram | read_count *.sam | read_count *.bam | read_count *.cram | *.vcf | *.bcf | - | sam -
	statistic = (statistic_function) (iterator) | ndpearson (multiplex) (multiplex)
	statistic_function = AUC | meanI | varI | minI | maxI | stddevI | CVI | energy (wavelength) | pearson (iterator)
	binary_operator = diff | ratio | overlaps | trim | noverlaps | nearest | apply (statistic) | fillIn | trimFill
	reducer = cat | sum | product | mean | var | stddev | entropy | CV | median | min | max
	setComparison = ttest | ftest | wilcoxon
	multiplex_list = (multiplex) | (multiplex) : (multiplex_list)
	multiplex = (iterator_list) | map (unary_operator) (multiplex) | strict (multiplex)
	iterator_list = (iterator) | (iterator) : (iterator_list)
```

## wiggletools_wilcoxon

### Tool Description
Wilcoxon rank-sum test between two sets of tracks at each position (set comparison wilcoxon).

### Metadata
- **Docker Image**: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
- **Homepage**: https://github.com/Ensembl/WiggleTools
- **Package**: https://anaconda.org/channels/bioconda/packages/wiggletools/overview
- **Validation**: PASS

### Original Help Text
```text
WiggleTools

Copyright [1999-2017] EMBL-European Bioinformatics Institute
Development contact: Daniel Zerbino zerbino@ebi.ac.uk

Citation: Zerbino DR, Johnson N, Juettemann T, Wilder SP and Flicek PR: WiggleTools: parallel processing of large collections of genome-wide datasets for visualization and statistical analysis. Bioinformatics 2014 30:1008-1009.

This library parses wiggle files and executes various operations on them streaming through lazy evaluators.

Inputs:
	The program takes in Wig, BigWig, BedGraph, Bed, BigBed, Bam, VCF, and BCF files, which are distinguished thanks to their suffix (.wig, (.bw|.bigWig|.bigwig), .bg, .bed, .bb, .bam, .cram, .vcf, .bcf respectively).
	Note that wiggletools assumes that every bam file has an index .bai file next to it.

Outputs:
	The program outputs a wiggle file in stdout unless the output is squashed

Command line:
	wiggletools --help
	wiggletools program

Program grammar:
	program = (iterator) | do (iterator) | (extraction) | (statistic) | run (file)
	iterator = (in_filename) | (unary_operator) (iterator) | (binary_operator) (iterator) (iterator) | (reducer) (multiplex) | (setComparison) (multiplex_list) | print (output) (statistic)
	unary_operator = unit | coverage | write (output) | write_bg (ouput) | smooth (int) | abs | exp | ln | log (float) | pow (float) | offset (float) | shiftPos (int) | scale (float) | gt (float) | gte (float) | lt (float) | lte (float) | default (float) | isZero | toInt | floor | extend (int) | bin (int) | compress | (statistic)
	output = (out_filename) | -
	in_filename = *.wig | *.bw | *.bed | *.bb | *.bg | *.sam | *.bam | *.cram | read_count *.sam | read_count *.bam | read_count *.cram | *.vcf | *.bcf | - | sam -
	statistic = (statistic_function) (iterator) | ndpearson (multiplex) (multiplex)
	statistic_function = AUC | meanI | varI | minI | maxI | stddevI | CVI | energy (wavelength) | pearson (iterator)
	binary_operator = diff | ratio | overlaps | trim | noverlaps | nearest | apply (statistic) | fillIn | trimFill
	reducer = cat | sum | product | mean | var | stddev | entropy | CV | median | min | max
	setComparison = ttest | ftest | wilcoxon
	multiplex_list = (multiplex) | (multiplex) : (multiplex_list)
	multiplex = (iterator_list) | map (unary_operator) (multiplex) | strict (multiplex)
	iterator_list = (iterator) | (iterator) : (iterator_list)
```

## wiggletools_mean

### Tool Description
Mean of several tracks at each position (reducer mean).

### Metadata
- **Docker Image**: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
- **Homepage**: https://github.com/Ensembl/WiggleTools
- **Package**: https://anaconda.org/channels/bioconda/packages/wiggletools/overview
- **Validation**: PASS

### Original Help Text
```text
WiggleTools

Copyright [1999-2017] EMBL-European Bioinformatics Institute
Development contact: Daniel Zerbino zerbino@ebi.ac.uk

Citation: Zerbino DR, Johnson N, Juettemann T, Wilder SP and Flicek PR: WiggleTools: parallel processing of large collections of genome-wide datasets for visualization and statistical analysis. Bioinformatics 2014 30:1008-1009.

This library parses wiggle files and executes various operations on them streaming through lazy evaluators.

Inputs:
	The program takes in Wig, BigWig, BedGraph, Bed, BigBed, Bam, VCF, and BCF files, which are distinguished thanks to their suffix (.wig, (.bw|.bigWig|.bigwig), .bg, .bed, .bb, .bam, .cram, .vcf, .bcf respectively).
	Note that wiggletools assumes that every bam file has an index .bai file next to it.

Outputs:
	The program outputs a wiggle file in stdout unless the output is squashed

Command line:
	wiggletools --help
	wiggletools program

Program grammar:
	program = (iterator) | do (iterator) | (extraction) | (statistic) | run (file)
	iterator = (in_filename) | (unary_operator) (iterator) | (binary_operator) (iterator) (iterator) | (reducer) (multiplex) | (setComparison) (multiplex_list) | print (output) (statistic)
	unary_operator = unit | coverage | write (output) | write_bg (ouput) | smooth (int) | abs | exp | ln | log (float) | pow (float) | offset (float) | shiftPos (int) | scale (float) | gt (float) | gte (float) | lt (float) | lte (float) | default (float) | isZero | toInt | floor | extend (int) | bin (int) | compress | (statistic)
	output = (out_filename) | -
	in_filename = *.wig | *.bw | *.bed | *.bb | *.bg | *.sam | *.bam | *.cram | read_count *.sam | read_count *.bam | read_count *.cram | *.vcf | *.bcf | - | sam -
	statistic = (statistic_function) (iterator) | ndpearson (multiplex) (multiplex)
	statistic_function = AUC | meanI | varI | minI | maxI | stddevI | CVI | energy (wavelength) | pearson (iterator)
	binary_operator = diff | ratio | overlaps | trim | noverlaps | nearest | apply (statistic) | fillIn | trimFill
	reducer = cat | sum | product | mean | var | stddev | entropy | CV | median | min | max
	setComparison = ttest | ftest | wilcoxon
	multiplex_list = (multiplex) | (multiplex) : (multiplex_list)
	multiplex = (iterator_list) | map (unary_operator) (multiplex) | strict (multiplex)
	iterator_list = (iterator) | (iterator) : (iterator_list)
```

## wiggletools_stddev

### Tool Description
Standard deviation of several tracks at each position (reducer stddev).

### Metadata
- **Docker Image**: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
- **Homepage**: https://github.com/Ensembl/WiggleTools
- **Package**: https://anaconda.org/channels/bioconda/packages/wiggletools/overview
- **Validation**: PASS

### Original Help Text
```text
WiggleTools

Copyright [1999-2017] EMBL-European Bioinformatics Institute
Development contact: Daniel Zerbino zerbino@ebi.ac.uk

Citation: Zerbino DR, Johnson N, Juettemann T, Wilder SP and Flicek PR: WiggleTools: parallel processing of large collections of genome-wide datasets for visualization and statistical analysis. Bioinformatics 2014 30:1008-1009.

This library parses wiggle files and executes various operations on them streaming through lazy evaluators.

Inputs:
	The program takes in Wig, BigWig, BedGraph, Bed, BigBed, Bam, VCF, and BCF files, which are distinguished thanks to their suffix (.wig, (.bw|.bigWig|.bigwig), .bg, .bed, .bb, .bam, .cram, .vcf, .bcf respectively).
	Note that wiggletools assumes that every bam file has an index .bai file next to it.

Outputs:
	The program outputs a wiggle file in stdout unless the output is squashed

Command line:
	wiggletools --help
	wiggletools program

Program grammar:
	program = (iterator) | do (iterator) | (extraction) | (statistic) | run (file)
	iterator = (in_filename) | (unary_operator) (iterator) | (binary_operator) (iterator) (iterator) | (reducer) (multiplex) | (setComparison) (multiplex_list) | print (output) (statistic)
	unary_operator = unit | coverage | write (output) | write_bg (ouput) | smooth (int) | abs | exp | ln | log (float) | pow (float) | offset (float) | shiftPos (int) | scale (float) | gt (float) | gte (float) | lt (float) | lte (float) | default (float) | isZero | toInt | floor | extend (int) | bin (int) | compress | (statistic)
	output = (out_filename) | -
	in_filename = *.wig | *.bw | *.bed | *.bb | *.bg | *.sam | *.bam | *.cram | read_count *.sam | read_count *.bam | read_count *.cram | *.vcf | *.bcf | - | sam -
	statistic = (statistic_function) (iterator) | ndpearson (multiplex) (multiplex)
	statistic_function = AUC | meanI | varI | minI | maxI | stddevI | CVI | energy (wavelength) | pearson (iterator)
	binary_operator = diff | ratio | overlaps | trim | noverlaps | nearest | apply (statistic) | fillIn | trimFill
	reducer = cat | sum | product | mean | var | stddev | entropy | CV | median | min | max
	setComparison = ttest | ftest | wilcoxon
	multiplex_list = (multiplex) | (multiplex) : (multiplex_list)
	multiplex = (iterator_list) | map (unary_operator) (multiplex) | strict (multiplex)
	iterator_list = (iterator) | (iterator) : (iterator_list)
```

## Metadata
- **Skill**: generated
