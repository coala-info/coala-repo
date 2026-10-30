# parallel-meta-suite CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| parallel-meta-suite_PM-comp-corr | PASS | Feature and meta-data correlations on the same OTU table plus real example meta data; one Pearson value matches numpy. The network plot needs R scripts that are not in the image. |
| parallel-meta-suite_PM-comp-func | Not completed | Needs the reference database, which is not in the image; the installer download server is unreachable. |
| parallel-meta-suite_PM-comp-taxa | Not completed | Needs the reference database, which is not in the image; the installer download server is unreachable. |
| parallel-meta-suite_PM-extract-rna | Not completed | The tool runs but needs hidden Markov models from the missing database folder, so it finds 0 rRNA reads; models are not in the image. |
| parallel-meta-suite_PM-format-seq | PASS | Checked a real 16S FASTA of 3430 reads; reported it as OK and wrote it back unchanged. |
| parallel-meta-suite_PM-parallel-meta | Not completed | Needs the reference database, which is not in the image; the installer download server is unreachable. |
| parallel-meta-suite_PM-pipeline | Not completed | pipeline, skipped (it also needs a reference database that is not in the image). |
| parallel-meta-suite_PM-plot-taxa | Not completed | Needs the reference database, which is not in the image; the installer download server is unreachable. |
| parallel-meta-suite_PM-predict-func | Not completed | Needs the reference database, which is not in the image; the installer download server is unreachable. |
| parallel-meta-suite_PM-predict-func-contribute | Not completed | Needs the reference database, which is not in the image; the installer download server is unreachable. |
| parallel-meta-suite_PM-predict-func-nsti | Not completed | Needs the reference database, which is not in the image; the installer download server is unreachable. |
| parallel-meta-suite_PM-rand-rare | Not completed | Needs the reference database, which is not in the image; the installer download server is unreachable. |
| parallel-meta-suite_PM-rare-curv | PASS | Rarefaction tables from a 4-sample OTU count table (OTUs clustered from real 16S reads with vsearch); the plot step fails because the R scripts are not in the image. |
| parallel-meta-suite_PM-select-func | Not completed | Needs the reference database, which is not in the image; the installer download server is unreachable. |
| parallel-meta-suite_PM-select-taxa | Not completed | Needs the reference database, which is not in the image; the installer download server is unreachable. |
| parallel-meta-suite_PM-split-seq | PASS | Split a 4-sample QIIME-format FASTA (real 16S reads) into 4 files; per-sample read counts match the input. |
| parallel-meta-suite_PM-update-taxa | Not completed | Needs the reference database, which is not in the image; the installer download server is unreachable. |

## parallel-meta-suite_PM-pipeline

### Tool Description
Parallel-Meta Suite Pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
- **Homepage**: https://github.com/qdu-bioinfo/parallel-meta-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/parallel-meta-suite/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/parallel-meta-suite/overview
- **Total Downloads**: 3.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/qdu-bioinfo/parallel-meta-suite
- **Stars**: N/A
### Original Help Text
```text
Welcome to Parallel-Meta Suite Pipeline
Version: 3.7Alpha
Usage: 
PM-pipeline [Option] Value
Options: 

	-D (upper) ref database, Empty database
	-m Meta data file [Required]

	[Input options, required]
	  -i Sequence files list, pair-ended sequences are supported [Conflicts with -l]
	  -p List file path prefix [Optional for -i]
	or
	  -l Taxonomic analysis results list [Conflicts with -i]
	  -p List file path prefix [Optional for -l]
	or
	  -T (upper) Input OTU count table (*.OTU.Count) [Conflicts with -i]

	[Output options]
	  -o Output path, default is "default_out"

	[Profiling parameters]
	  -M (upper) Sequence type, T (Shotgun) or F (rRNA), default is F
	  -r rRNA copy number correction, T(rue) or F(alse), default is T
	  -a rRNA length threshold of rRNA extraction. 0 is disabled, default is 0 [optional for -M T]
	  -k Sequence format check, T(rue) or F(alse), default is F
	  -f Functional analysis, T(rue) or F(alse), default is T
	  -v ASV denoising, T(rue) or F(alse), default is T [optional for -i]
	  -c Chimera removal, T(rue) or F(alse), default is T [optional for -i]
	  -d Sequence alignment threshold (float value 0~1), default is 0.99 for ASV enabled and 0.97 for ASV disabled (-v F) [optional for -i]

	[Statistic parameters]
	  -L (upper) Taxonomical levels (1-6: Phylum - Species). Multiple levels are accepted
	  -w Taxonomical distance type, 0: weighted, 1: unweigthed, 2: both, default is 2
	  -F (upper) Functional levels (Level 1, 2, 3 or 4 (KO number)). Multiple levels are accepted
	  -s Sequence number normalization depth, 0 is disabled, default is disable
	  -b Bootstrap for sequence number normalization, default is 200, maximum is 1000
	  -R (upper) Rarefaction curve, T(rue) or F(alse), default is F
	  -E (upper) If the samples are paired, T(rue) or F(alse), default is F
	  -C (upper) Cluster number, default is 2
	  -G (upper) Network analysis edge threshold, default is 0.5

	[Other options]
	  -t Number of thread, default is auto
	  -h help
```

## parallel-meta-suite_PM-split-seq

### Tool Description
Split sequences by sample

### Metadata
- **Docker Image**: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
- **Homepage**: https://github.com/qdu-bioinfo/parallel-meta-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/parallel-meta-suite/overview
- **Validation**: PASS

### Original Help Text
```text
Split-seq version: 3.7Alpha
	Split sequences by sample
Usage: 
PM-split-seq [Option] Value
Options: 
	[Input options, required]
	  -i Input sequence file in FASTA or FASTQ format [Required]
	  -b Input barcode file [Conflicts with -g and -q]
	  or
	  -g Input group file [Conflicts with -b and -q]
	  or
	  -q T or F, if the input in QIIME format [Conflicts with -g and -b]
	[Output options]
	  -o Result output path, default is "Out"
	[Other options]
	  -h Help
```

## parallel-meta-suite_PM-format-seq

### Tool Description
Sequence format check and reformat for Parallel-Meta Suite

### Metadata
- **Docker Image**: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
- **Homepage**: https://github.com/qdu-bioinfo/parallel-meta-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/parallel-meta-suite/overview
- **Validation**: PASS

### Original Help Text
```text
Format-seq version: 3.7Alpha
	Sequence format check and reformat for Parallel-Meta Suite
Usage:
PM-format-seq [Option] Value
Options: 
	[Input options, required]
	  -i Input single sequence file in FASTA or FASTQ format
	  or
	  -l Input sequence files list
	  -p List file path prefix for '-l' [Optional for -l]
	[Other options]
	  -h Help
```

## parallel-meta-suite_PM-rare-curv

### Tool Description
Make the rarefaction curve

### Metadata
- **Docker Image**: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
- **Homepage**: https://github.com/qdu-bioinfo/parallel-meta-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/parallel-meta-suite/overview
- **Validation**: PASS

### Original Help Text
```text
Rare-curv version : 3.7Alpha
	Make the rarefaction curve
Usage: 
PM-rare-curv [Option] Value
Options: 
	[Input options, required]
	  -i or -T (upper) Input feature count table (*.OTU.Count)
	[Output options]
	  -o Output file directory, default is "result"
	  -p Prefix name of output, default is "out"
	[Other options]
	  -b The bootstrap value, default is 20
	  -s The rarefaction step, default is 100
	  -l The rarefaction curve label, T is enable and F is disable, default is F
	  -t Number of thread, default is auto
	  -h Help
```

## parallel-meta-suite_PM-comp-corr

### Tool Description
Compute the correlation and network by feature table

### Metadata
- **Docker Image**: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
- **Homepage**: https://github.com/qdu-bioinfo/parallel-meta-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/parallel-meta-suite/overview
- **Validation**: PASS

### Original Help Text
```text
Comp-corr version: 3.7Alpha
	Compute the correlation and network by feature table
Usage:
PM-comp-corr [Option] Value
Options: 
	[Input options, required]
	  -i or -T (upper) Input feature table file (*.Abd)
	  -m Meta data name [Optional]
	  -c Selected feature, separated by "," [Optional for -m]
	[Output options]
	  -o Output prefix, default is "corr_matrix"
	[Other options]
	  -f 0:(Spearman) or 1:(Pearson) metrics,default is 0
	  -N (upper) Network based co-occurrence analysis, T(rue) or F(alse), default is F
	  -G (upper) Netowrk analysis threshold, default is 0.5
	  -t Number of thread, default is auto
	  -h Help
```

## parallel-meta-suite_PM-extract-rna

### Tool Description
Extract rRNA fragments from shotgun sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
- **Homepage**: https://github.com/qdu-bioinfo/parallel-meta-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/parallel-meta-suite/overview
- **Validation**: PASS

### Original Help Text
```text
ExtractRNA version: 3.7Alpha
	Extract rRNA fragments from shotgun sequences
Usage:
PM-extract-rna [Option] Value
Options:
	-D (upper) Domain, B (Bacteria, 16S rRNA) or E (Eukaryote, 18S rRNA), default is B
	[Input options, required]
	  -m or -i Input single sequence file (Shotgun)
	[Output options]
	  -o Output Path, default is "Extract_RNA"
	[Other options]
	  -l rRNA length threshold of rRNA extraction. default is 0
	  -t Number of thread, default is auto
	  -h Help
```

## parallel-meta-suite_PM-select-taxa

### Tool Description
Select the taxonomy features

### Metadata
- **Docker Image**: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
- **Homepage**: https://github.com/qdu-bioinfo/parallel-meta-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/parallel-meta-suite/overview
- **Validation**: PASS

### Original Help Text
```text
Select-taxa version:3.7Alpha
	Select the taxonomy features
Usage: 
PM-select-taxa [Option] Value
Option: 
	-D (upper) ref database, Empty database
	[Input options, requried]
	  -l Input files list
	  -p List file path prefix for '-l' [Optional for -l]
	or
	  -T (upper) Input OTU count table (*.OTU.Count)
	[Output options]
	  -o Output file name, default is "taxaonomy_selection"
	  -L (upper) Taxonomical level (1-6: Phylum - Species, 7: OTU). default is 5
	  -P (upper) Print distribution barchart, T(rue) or F(alse), default is F
	[Other options]
	  -r rRNA copy number correction, T(rue) or F(alse), default is T
	  -q Minimum sequence count threshold, default is 2
	  -m Maximum abundance threshold, default is 0.001 (0.1%)
	  -n Minimum abundance threshold, default is 0.0 (0%)
	  -z Minimum No-Zero abundance threshold, default is 0.1 (10%)
	  -v Minimum average abundance threshold, default is 0.001 (0.1%)
	  -h Help
```

## parallel-meta-suite_PM-select-func

### Tool Description
Select the functional features

### Metadata
- **Docker Image**: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
- **Homepage**: https://github.com/qdu-bioinfo/parallel-meta-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/parallel-meta-suite/overview
- **Validation**: PASS

### Original Help Text
```text
Select-func version 3.7Alpha
	Select the functional features
Usage:
PM-select-func [Option] Value
Options: 
	[Input options, required]
	  -l Input files list [Conflicts with -T and -B]
	  -p List file path prefix [Optional for -l]
	or
	  -T (upper) Input KO Absolute Count table (*.KO.Count) [Conflicts with -l and -B]
	[Output options]
	  -o Output file, default is "functions_category"
	  -L (upper) KEGG Pathway level, Level 1, 2, 3 or 4 (KO number), default is 2
	  -P (upper) Print distribution barchart, T(rue) or F(alse), default is F
	[Other options]
	  -h Help
```

## parallel-meta-suite_PM-comp-taxa

### Tool Description
Compute the Meta-Storms similarity/distance among samples

### Metadata
- **Docker Image**: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
- **Homepage**: https://github.com/qdu-bioinfo/parallel-meta-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/parallel-meta-suite/overview
- **Validation**: PASS

### Original Help Text
```text
Comp-taxa version : 3.7Alpha
	Compute the Meta-Storms similarity/distance among samples
Usage: 
PM-comp-taxa [Option] Value
Options: 
	-D (upper) ref database, Empty database
	[Input options, required]
	  -i Two samples path for single sample comparison
	or
	  -l Input files list for multi-sample comparison
	  -p List files path prefix [Optional for -l]
	or
	  -T (upper) Input OTU count table (*.OTU.Count) for multi-sample comparison
	[Output options]
	  -o Output file, default is to output on screen
	  -d Output format, distance (T) or similarity (F), default is T
	  -P (upper) Print heatmap and clusters, T(rue) or F(alse), default is F
	[Other options]
	  -M (upper) Distance Metric, 0: Meta-Storms; 1: Meta-Storms-unweighted; 2: Cosine; 3: Euclidean; 4: Jensen-Shannon; 5: Bray-Curtis, default is 0
	  -r rRNA copy number correction, T(rue) or F(alse), default is T
	  -c Cluster number, default is 2 [Optional for -P]
	  -t Number of thread, default is auto
	  -h Help
```

## parallel-meta-suite_PM-comp-func

### Tool Description
Compute the Meta-Storms functional distance/similarity among samples

### Metadata
- **Docker Image**: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
- **Homepage**: https://github.com/qdu-bioinfo/parallel-meta-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/parallel-meta-suite/overview
- **Validation**: PASS

### Original Help Text
```text
PM-comp-func version : 3.7Alpha
	Compute the Meta-Storms functional distance/similarity among samples
Usage: 
PM-comp-func [Option] Value
Options: 
	[Input options, required]
	  -i Two samples path for single sample comparison
	or
	  -l Input files list table for multi-sample comparison
	  -p List file path prefix [Optional for -l]
	or
	  -T (upper) Input KO count table (*.KO.Count) for multi-sample comparison
	  -R If the input table is reversed, T(rue) or F(alse), default is false [Optional for -T]
	[Output options]
	  -o Output file, default is to output on screen
	  -d Output format, distance (T) or similarity (F), default is T
	  -P (upper) Print heatmap and clusters, T(rue) or F(alse), default is F
	[Other options]
	  -M (upper) Distance Metric, 0: Hierarchial Meta-Storms; 1: Cosine; 2: Euclidean; 3: Jensen-Shannon, 4: Bray-Curtis; default is 0
	  -c Cluster number, default is 2 [Optional for -P]
	  -t Number of thread, default is auto
	  -h Help
```

## parallel-meta-suite_PM-plot-taxa

### Tool Description
Taxonomy profile visualization by Krona

### Metadata
- **Docker Image**: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
- **Homepage**: https://github.com/qdu-bioinfo/parallel-meta-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/parallel-meta-suite/overview
- **Validation**: PASS

### Original Help Text
```text
Plot-taxa version: 3.7Alpha
	Taxonomy profile visualization by Krona
Usage:
PM-plot-taxa [Option] Value
Options: 
	-D (upper) ref database, Empty database
	[Input options, required]
	  -i Input single file
	or
	  -l Input files list
	  -p List file path prefix [Optional for -l]
	or
	  -T (upper) Input OTU count table (*.OTU.Count)
	[Output options]
	  -o Output Path, default is "Result_Plot"
	[Other options]
	  -r rRNA copy number correction, T(rue) or F(alse), default is T
	  -h Help
```

## parallel-meta-suite_PM-rand-rare

### Tool Description
Rarefy samples by taxonomy profiles

### Metadata
- **Docker Image**: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
- **Homepage**: https://github.com/qdu-bioinfo/parallel-meta-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/parallel-meta-suite/overview
- **Validation**: PASS

### Original Help Text
```text
Random-rare version: 3.7Alpha
	Rarefy samples by taxonomy profiles
Usage: 
PM-rand-rare [Option] Value
Options: 
	-D (upper) ref database, Empty database
	[Input options, required]
	  -i Input single file name
	or
	  -l Input files list
	  -p List file path prefix [Optional or -l]
	or
	  -T (upper) Input OTU count table (*.OTU.Count)
	[Output options]
	  -o Output path (for -i and -l) or output table name (for -T), default is "Rare_Out"
	  -L (upper) If output list, T(rue) or F(alse), default is T [optional for -l]
	[Other options]
	  -s Rarefaction depth [Required]
	  -b Bootstrap for sequence number normalization, default is 200, maximum is 1000
	  -h Help
```

## parallel-meta-suite_PM-predict-func

### Tool Description
Functional prediction

### Metadata
- **Docker Image**: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
- **Homepage**: https://github.com/qdu-bioinfo/parallel-meta-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/parallel-meta-suite/overview
- **Validation**: PASS

### Original Help Text
```text
Predict-func version: 3.7Alpha
	Functional prediction
Usage:
PM-predict-func [Option] Value
Options: 
	-D (upper) ref database, Empty database
	[Input options, required]
	  -i Input single file
	or
	  -l Input files list
	  -p List file path prefix [Optional for -l]
	or
	  -T (upper) Input OTU count table (*.OTU.Count)
	[Output options]
	  -o Output path, default is "Results_Func"
	  -L (upper) If output list (at "Output_path/func.list"), T(rue) or F(alse), default is T [optional for -l]
	[Other options]
	  -t Number of thread, default is auto
	  -h Help
```

## parallel-meta-suite_PM-predict-func-contribute

### Tool Description
Predict the funtional contribution (16S only)

### Metadata
- **Docker Image**: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
- **Homepage**: https://github.com/qdu-bioinfo/parallel-meta-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/parallel-meta-suite/overview
- **Validation**: PASS

### Original Help Text
```text
Predict-func-contribute version: 3.7Alpha
	Predict the funtional contribution (16S only)
Usage:
PM-predict-func-contribute [Option] Value
Options: 
	-D (upper) ref database, Empty database
	[Input options, required]
	  -i Input single file
	or
	  -l Input files list
	  -p List file path prefix [Optional for -l]
	or
	  -T (upper) Input OTU count table (*.OTU.Count)
	[Output options]
	  -L (upper) Selected KO list
	  -o Output file name, default is "func.KO.contribute"
	[Other options]
	  -t Number of thread, default is auto
	  -h Help
```

## parallel-meta-suite_PM-predict-func-nsti

### Tool Description
Compute the N(earest) S(equenced) T(axonomy) I(ndex) (16S only)

### Metadata
- **Docker Image**: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
- **Homepage**: https://github.com/qdu-bioinfo/parallel-meta-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/parallel-meta-suite/overview
- **Validation**: PASS

### Original Help Text
```text
Predict-func-NSTI version: 3.7Alpha
	Compute the N(earest) S(equenced) T(axonomy) I(ndex) (16S only)
Usage:
PM-predict-func-nsti [Option] Value
Options: 
	-D (upper) ref database, Empty database
	[Input options, required]
	  -i Input single file
	or
	  -l Input files list
	  -p List file path prefix [Optional for -l]
	or
	  -T (upper) Input OTU count table (*.OTU.Count)
	[Output options]
	  -o Output file, default is "NSTI.out"
	[Other options]
	  -t Number of thread, default is auto
	  -h Help
```

## parallel-meta-suite_PM-update-taxa

### Tool Description
Update the taxonomy annotation to the latest version

### Metadata
- **Docker Image**: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
- **Homepage**: https://github.com/qdu-bioinfo/parallel-meta-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/parallel-meta-suite/overview
- **Validation**: PASS

### Original Help Text
```text
Update-taxa version: 3.7Alpha
	Update the taxonomy annotation to the latest version
Usage:
PM-update-taxa [Option] Value
Options: 
	-D (upper) ref database, Empty database
	[Input options, required]
	  -i Input single file
	or
	  -l Input files list
	  -p List file path prefix [Optional for -l]
	[Other options]
	  -h Help
```

## parallel-meta-suite_PM-parallel-meta

### Tool Description


### Metadata
- **Docker Image**: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
- **Homepage**: https://github.com/qdu-bioinfo/parallel-meta-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/parallel-meta-suite/overview
- **Validation**: PASS

### Original Help Text
```text
Welcome to Parallel-Meta Suite version 3.7Alpha

Parallel-Meta Suite version: 3.7Alpha
	Microbiome sample profiling
Usage:
PM-parallel-meta [Option] Value
Options: 
	-D (upper) ref database, Empty database
	[Input options, required]
	  -m Input single sequence file (Shotgun) [Conflicts with -r and -R]
	  or
	  -r Input single sequence file (rRNA targeted) [Conflicts with -m]
	  -R (upper) Input paired sequence file [Optional for -r, Conflicts with -m]
	  -v ASV denoising, T(rue) or F(alse), default is T [optional for -i]
	  -c Chimera removal, T(rue) or F(alse), default is T [optional for -i]
	  -d Sequence alignment threshold (float value 0-1), default is 0.99 for ASV enabled and 0.97 for ASV disabled (-v F) [optional for -i]

	[Output options]
	  -o Output path, default is "Result"
	[Other options]
	  -k Sequence format check, T(rue) or F(alse), default is F
	  -L (upper) rRNA length threshold of rRNA extraction. 0 is disabled, default is 0 [Optional for -m, Conflicts with -r]
	  -f Functional analysis, T(rue) or F(alse), default is T
	  -t Number of thread, default is auto
	  -h Help
```

