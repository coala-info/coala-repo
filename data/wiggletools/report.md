# wiggletools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| wiggletools_AUC | PASS |  |
| wiggletools_CV | PASS | Uses the population standard deviation; matches an independent calculation. |
| wiggletools_CVI | PASS | Uses the sample standard deviation; matches an independent calculation. |
| wiggletools_abs | PASS |  |
| wiggletools_apply | PASS |  |
| wiggletools_apply_paste | PASS | Output equals the tool's own expected test output; regions without data give nan for meanI. |
| wiggletools_bin | PASS |  |
| wiggletools_cat | Failed | tool bug: a file on the same chromosome as the first one is silently dropped (concatenation of a.bg and a_next.bg gives 201 lines, not 400, and repeats the last line); only files on different chromosomes are concatenated. |
| wiggletools_compress | PASS |  |
| wiggletools_coverage | PASS |  |
| wiggletools_default | PASS | Output equals the input track; the default value only matters inside other operators. |
| wiggletools_diff | PASS |  |
| wiggletools_energy | PASS |  |
| wiggletools_entropy | Failed | tool bug: the entropy reducer returns the standard deviation (reducers.c uses StdDevReductionPop for entropy). |
| wiggletools_exp | PASS |  |
| wiggletools_extend | PASS |  |
| wiggletools_fillIn | PASS |  |
| wiggletools_floor | PASS |  |
| wiggletools_ftest | Failed | tool bug: the output is 0 at every position on 3 vs 3 real tracks (expected p-values near 1); the source uses the wrong loop variable (index instead of index2) in the group-mean and variance loops. |
| wiggletools_gt | PASS |  |
| wiggletools_gte | PASS |  |
| wiggletools_histogram | PASS | The tool says the histogram is approximate: bin midpoints and the total count of 200 are right, but bin counts are fractional and differ from exact counts. |
| wiggletools_isZero | PASS | The tool prints nothing and only sets an exit status, so the wrapper saves the status; gives 1 for a non-zero track and 0 for an all-zero track. |
| wiggletools_ln | PASS |  |
| wiggletools_log | PASS |  |
| wiggletools_lt | PASS |  |
| wiggletools_lte | PASS |  |
| wiggletools_max | PASS |  |
| wiggletools_maxI | PASS |  |
| wiggletools_mean | PASS |  |
| wiggletools_meanI | PASS |  |
| wiggletools_median | PASS |  |
| wiggletools_min | PASS |  |
| wiggletools_minI | PASS |  |
| wiggletools_mult | PASS | The help lists this reducer as product, but the program only accepts mult; wrapped as mult. |
| wiggletools_mwrite | PASS |  |
| wiggletools_mwrite_bg | PASS |  |
| wiggletools_ndpearson | PASS |  |
| wiggletools_nearest | PASS | Distances to the nearest exon match an independent calculation except a one-base convention difference downstream of regions. |
| wiggletools_noverlaps | PASS |  |
| wiggletools_offset | PASS |  |
| wiggletools_overlaps | PASS |  |
| wiggletools_pearson | PASS |  |
| wiggletools_pow | PASS |  |
| wiggletools_print | PASS |  |
| wiggletools_profile | PASS | Output equals the tool's own expected test output for its test files, and matches an independent simulation on the real data (the last half bin of a region is dropped by the tool's rounding). |
| wiggletools_profiles | PASS | Output equals the tool's own expected test output for its test files, and matches an independent simulation on the real data. |
| wiggletools_ratio | PASS |  |
| wiggletools_read_count | PASS | Counts every alignment record that has a position, including unmapped reads placed at their mate (200 reads); matches an independent BAM parse. |
| wiggletools_scale | PASS |  |
| wiggletools_seek | PASS | Region is 1-based and the end position is excluded; matches an independent calculation. |
| wiggletools_shiftPos | PASS |  |
| wiggletools_smooth | PASS | Centered window; the output also extends one base beyond the data, with missing positions counted as 0. |
| wiggletools_stddev | PASS |  |
| wiggletools_stddevI | PASS | Sample standard deviation (n-1); matches an independent calculation. |
| wiggletools_sum | PASS |  |
| wiggletools_toInt | PASS |  |
| wiggletools_trim | PASS |  |
| wiggletools_trimFill | PASS |  |
| wiggletools_ttest | Failed | tool bug: p-values differ from Welch's t-test by up to 0.09 because the tool uses population variance. |
| wiggletools_unit | PASS |  |
| wiggletools_var | PASS | The reducer divides by n (population variance); matches an independent calculation at all 200 positions. |
| wiggletools_varI | PASS | Sample variance (divides by n-1); matches an independent calculation. |
| wiggletools_wilcoxon | Failed | tool bug: output is a signed 2*erf(z) value between -2 and 0, not a p-value (integer division in sigma, missing sqrt 2). |
| wiggletools_write | PASS |  |
| wiggletools_write_bg | PASS |  |

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

## wiggletools_abs

### Tool Description
Absolute value of a track (unary operator abs).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_apply_paste

### Tool Description
Compute a statistic of a track over each region of a BED file and append it to each BED line (extraction apply_paste).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_AUC

### Tool Description
Area under the curve of a track, the sum of value times length (statistic AUC).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_bin

### Tool Description
Sum the values of a track into fixed-size bins (unary operator bin).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_cat

### Tool Description
Concatenate the tracks one after the other (reducer cat).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_compress

### Tool Description
Merge consecutive regions with the same value (unary operator compress).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_coverage

### Tool Description
Coverage plot of overlapping regions, typically read from a BED file (unary operator coverage).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_CV

### Tool Description
Coefficient of variation (standard deviation / mean) of several tracks at each position (reducer CV).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_CVI

### Tool Description
Coefficient of variation of a track across all its points (statistic CVI).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_default

### Tool Description
Set the default value of a track, used where it has no data (unary operator default).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_diff

### Tool Description
Difference of two tracks, first minus second (binary operator diff).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_energy

### Tool Description
Energy density of a track at a given wavelength (statistic energy).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_exp

### Tool Description
Exponential of a track (unary operator exp).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_extend

### Tool Description
Extend each region of a track on both sides (unary operator extend).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_fillIn

### Tool Description
Values of the second track, filled with its default value over the regions of the first track (binary operator fillIn).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_floor

### Tool Description
Floor of the track values, rounding toward negative infinity (unary operator floor).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_ftest

### Tool Description
F-test between two sets of tracks at each position (set comparison ftest).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_gt

### Tool Description
Regions where the track is strictly greater than a cutoff (unary operator gt).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_gte

### Tool Description
Regions where the track is greater than or equal to a cutoff (unary operator gte).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_histogram

### Tool Description
Histogram of the values of one or several tracks (extraction histogram); the bin widths are adapted to the data.

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_isZero

### Tool Description
Test whether a track is zero everywhere: prints nothing and exits with 1 at the first non-zero value (unary operator isZero). The wrapper saves the exit status in a file.

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_ln

### Tool Description
Natural logarithm of a track (unary operator ln).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_log

### Tool Description
Logarithm of a track in an arbitrary base (unary operator log).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_lt

### Tool Description
Regions where the track is strictly less than a cutoff (unary operator lt).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_lte

### Tool Description
Regions where the track is less than or equal to a cutoff (unary operator lte).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_max

### Tool Description
Maximum of several tracks at each position (reducer max).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_maxI

### Tool Description
Maximum of a track across all its points (statistic maxI).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_meanI

### Tool Description
Mean of a track across all its points (statistic meanI).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_minI

### Tool Description
Minimum of a track across all its points (statistic minI).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_mult

### Tool Description
Product of several tracks at each position (reducer mult; the help calls it product).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_mwrite_bg

### Tool Description
Write several tracks side by side into one multidimensional bedGraph file (the mwrite_bg operator).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_mwrite

### Tool Description
Write several tracks side by side into one multidimensional wiggle file (the mwrite operator).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_ndpearson

### Tool Description
Pearson correlation between two sets of tracks, computed over all pairs of the multiplexed inputs (statistic ndpearson).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_noverlaps

### Tool Description
Values of the second track that do not overlap regions of the first track (binary operator noverlaps).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_offset

### Tool Description
Add a constant to each value of a track (unary operator offset).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_overlaps

### Tool Description
Values of the second track that overlap regions of the first track (binary operator overlaps).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_pearson

### Tool Description
Pearson correlation between two tracks across all their points (statistic pearson).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_pow

### Tool Description
Each value raised to a power (unary operator pow).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_print

### Tool Description
Save a statistic of a track into a text file (the print statement).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_profile

### Tool Description
Summed profile of a track across a set of regions: one fixed-width profile that adds up all regions (extraction profile).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_profiles

### Tool Description
Fixed-width profile of a track for each region of a set of regions, one line per region (extraction profiles).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_read_count

### Tool Description
Count the reads that start at each position of an alignment file (file reader read_count), written as a track.

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_scale

### Tool Description
Multiply each value of a track by a constant (unary operator scale).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_seek

### Tool Description
Output only the points of a track inside a genomic region (unary operator seek).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_shiftPos

### Tool Description
Shift the start and end positions of a track downwards (unary operator shiftPos).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_smooth

### Tool Description
Running mean of a track over a window of the given size (unary operator smooth).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_stddevI

### Tool Description
Standard deviation of a track across all its points (statistic stddevI).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_sum

### Tool Description
Sum of several tracks at each position (reducer sum).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_toInt

### Tool Description
Cast the track values to integers, rounding toward zero (unary operator toInt).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_trim

### Tool Description
Values of the second track trimmed to the regions of the first track (binary operator trim).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_trimFill

### Tool Description
Like trim, but fills the trimmed regions with the default value of the second track (binary operator trimFill).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_unit

### Tool Description
Set the value to 1 where the track is non-zero and 0 elsewhere, merging contiguous equal positions (unary operator unit).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_var

### Tool Description
Variance of several tracks at each position (reducer var).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_varI

### Tool Description
Variance of a track across all its points (statistic varI).

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_write_bg

### Tool Description
Write a track into a bedGraph file (the write_bg operator), for example to convert a wiggle or bigWig into bedGraph.

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## wiggletools_write

### Tool Description
Write a track into a wiggle file (the write operator), for example to convert a bigWig or bedGraph into wiggle format.

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
	extraction = profile (output) (int) (iterator) (iterator) | profiles (output) (int) (iterator) (iterator) | histogram (output) (width) (iterator_list) | mwrite (output) (multiplex) | mwrite_bg (output) (multiplex)
		| apply_paste (out_filename) (statistic) (bed_file) (iterator)
```

## Metadata
- **Skill**: generated
