# metafx CWL Generation Report

## metafx_metafast

### Tool Description
MetaFX metafast module – unsupervised feature extraction and distance estimation via MetaFast (https://github.com/ctlab/metafast/)

### Metadata
- **Docker Image**: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/ctlab/metafx
- **Package**: https://anaconda.org/channels/bioconda/packages/metafx/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metafx/overview
- **Total Downloads**: 389
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ctlab/metafx
- **Stars**: N/A
### Original Help Text
```text
metafx metafast --help

MetaFX v=0.1.0
MetaFX metafast module – unsupervised feature extraction and distance estimation via MetaFast (https://github.com/ctlab/metafast/)
Usage: metafx metafast [<Launch options>] [<Input parameters>]

Launch options:
    -h | --help                       show this help message and exit
    -t | --threads       <int>        number of threads to use [default: all]
    -m | --memory        <MEM>        memory to use (values with suffix: 1500M, 4G, etc.) [default: 90% of free RAM]
    -w | --work-dir      <dirname>    working directory [default: workDir/]

Input parameters:
    -k  | --k             <int>        k-mer size (in nucleotides, maximum value is 31) [mandatory]
    -i  | --reads         <filenames>  list of reads files from single environment. FASTQ, FASTA, gzip- or bzip2-compressed [mandatory]
    -b  | --bad-frequency <int>        maximal frequency for a k-mer to be assumed erroneous [default: 1]
    -l  | --min-seq-len   <int>        minimal sequence length to be added to a component (in nucleotides) [default: 100]
    -b1 | --min-comp-size <int>        minimum size of extracted components (features) in k-mers [default: 1000]
    -b2 | --max-comp-size <int>        maximum size of extracted components (features) in k-mers [default: 10000]
          --kmers-dir     <dirname>    directory with pre-computed k-mers for samples in binary format [optional, if set '-i' can be omitted]
          --skip-graph                 if TRUE skip de Bruijn graph and fasta construction from components [default: False]
```


## metafx_metaspades

### Tool Description
MetaFX metaspades module – unsupervised feature extraction and distance estimation via metaSpades (https://cab.spbu.ru/software/meta-spades/)

### Metadata
- **Docker Image**: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/ctlab/metafx
- **Package**: https://anaconda.org/channels/bioconda/packages/metafx/overview
- **Validation**: PASS

### Original Help Text
```text
metafx metaspades --help

MetaFX v=0.1.0
MetaFX metaspades module – unsupervised feature extraction and distance estimation via metaSpades (https://cab.spbu.ru/software/meta-spades/)
Usage: metafx metaspades [<Launch options>] [<Input parameters>]

Launch options:
    -h | --help                       show this help message and exit
    -t | --threads       <int>        number of threads to use [default: all]
    -m | --memory        <MEM>        memory to use (values with suffix: 1500M, 4G, etc.) [default: 90% of free RAM]
    -w | --work-dir      <dirname>    working directory [default: workDir/]

Input parameters:
    -k  | --k             <int>        k-mer size (in nucleotides, maximum value is 31) [mandatory]
    -i  | --reads         <filenames>  list of PAIRED-END reads files from single environment. FASTQ, FASTA, gzip-compressed [mandatory]
          --separate                   if TRUE use every spades contig as a separate feature (do not combine them in components; -l, -b1, -b2 ignored) [default: False]
    -l  | --min-seq-len   <int>        minimal sequence length to be added to a component (in nucleotides) [default: 100]
    -b1 | --min-comp-size <int>        minimum size of extracted components (features) in k-mers [default: 1000]
    -b2 | --max-comp-size <int>        maximum size of extracted components (features) in k-mers [default: 10000]
          --kmers-dir     <dirname>    directory with pre-computed k-mers for samples in binary format [optional, if set '-i' can be omitted]
          --skip-graph                 if TRUE skip de Bruijn graph and fasta construction from components [default: False]
```


## metafx_unique

### Tool Description
supervised feature extraction using group-specific k-mers

### Metadata
- **Docker Image**: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/ctlab/metafx
- **Package**: https://anaconda.org/channels/bioconda/packages/metafx/overview
- **Validation**: PASS

### Original Help Text
```text
metafx unique --help

MetaFX v=0.1.0
MetaFX unique module – supervised feature extraction using group-specific k-mers
Usage: metafx unique [<Launch options>] [<Input parameters>]

Launch options:
    -h | --help                       show this help message and exit
    -t | --threads       <int>        number of threads to use [default: all]
    -m | --memory        <MEM>        memory to use (values with suffix: 1500M, 4G, etc.) [default: 90% of free RAM]
    -w | --work-dir      <dirname>    working directory [default: workDir/]

Input parameters:
    -k | --k             <int>        k-mer size (in nucleotides, maximum value is 31) [mandatory]
    -i | --reads-file    <filename>   tab-separated file with 2 values in each row: <path_to_file>\t<category> [mandatory]
    -b | --bad-frequency <int>        maximal frequency for a k-mer to be assumed erroneous [default: 1]
         --min-samples   <int>        k-mer is considered group-specific if present in at least G samples of that group. G iterates in range [--min-samples; --max-samples] [default: 2]
         --max-samples   <int>        k-mer is considered group-specific if present in at least G samples of that group. G iterates in range [--min-samples; --max-samples] [default: #{samples in category}/2 + 1]
         --depth         <int>        Depth of de Bruijn graph traversal from pivot k-mers in number of branches [default: 1]
         --kmers-dir     <dirname>    directory with pre-computed k-mers for samples in binary format [optional]
         --skip-graph                 if TRUE skip de Bruijn graph and fasta construction from components [default: False]
```


## metafx_chisq

### Tool Description
supervised feature extraction using top significant k-mers by chi-squared test

### Metadata
- **Docker Image**: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/ctlab/metafx
- **Package**: https://anaconda.org/channels/bioconda/packages/metafx/overview
- **Validation**: PASS

### Original Help Text
```text
metafx chisq --help

MetaFX v=0.1.0
MetaFX chisq module – supervised feature extraction using top significant k-mers by chi-squared test
Usage: metafx chisq [<Launch options>] [<Input parameters>]

Launch options:
    -h | --help                       show this help message and exit
    -t | --threads       <int>        number of threads to use [default: all]
    -m | --memory        <MEM>        memory to use (values with suffix: 1500M, 4G, etc.) [default: 90% of free RAM]
    -w | --work-dir      <dirname>    working directory [default: workDir/]

Input parameters:
    -k | --k             <int>        k-mer size (in nucleotides, maximum value is 31) [mandatory]
    -i | --reads-file    <filename>   tab-separated file with 2 values in each row: <path_to_file>\t<category> [mandatory]
    -n | --num-kmers     <int>        number of most specific k-mers to be extracted [mandatory]
    -b | --bad-frequency <int>        maximal frequency for a k-mer to be assumed erroneous [default: 1]
         --depth         <int>        Depth of de Bruijn graph traversal from pivot k-mers in number of branches [default: 1]
         --kmers-dir     <dirname>    directory with pre-computed k-mers for samples in binary format [optional]
         --skip-graph                 if TRUE skip de Bruijn graph and fasta construction from components [default: False]
```


## metafx_stats

### Tool Description
supervised feature extraction using statistically significant k-mers

### Metadata
- **Docker Image**: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/ctlab/metafx
- **Package**: https://anaconda.org/channels/bioconda/packages/metafx/overview
- **Validation**: PASS

### Original Help Text
```text
metafx stats --help

MetaFX v=0.1.0
MetaFX stats module – supervised feature extraction using statistically significant k-mers
Usage: metafx stats [<Launch options>] [<Input parameters>]

Launch options:
    -h | --help                       show this help message and exit
    -t | --threads       <int>        number of threads to use [default: all]
    -m | --memory        <MEM>        memory to use (values with suffix: 1500M, 4G, etc.) [default: 90% of free RAM]
    -w | --work-dir      <dirname>    working directory [default: workDir/]

Input parameters:
    -k | --k             <int>        k-mer size (in nucleotides, maximum value is 31) [mandatory]
    -i | --reads-file    <filename>   tab-separated file with 2 values in each row: <path_to_file>\t<category> [mandatory]
    -b | --bad-frequency <int>        maximal frequency for a k-mer to be assumed erroneous [default: 1]
         --pchi2         <float>      p-value for chi-squared test [default: 0.05]
         --pmw           <float>      p-value for Mann–Whitney test [default: 0.05]
         --depth         <int>        Depth of de Bruijn graph traversal from pivot k-mers in number of branches [default: 1]
         --kmers-dir     <dirname>    directory with pre-computed k-mers for samples in binary format [optional]
         --skip-graph                 if TRUE skip de Bruijn graph and fasta construction from components [default: False]
```


## metafx_colored

### Tool Description
supervised feature extraction using group-colored de Bruijn graph

### Metadata
- **Docker Image**: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/ctlab/metafx
- **Package**: https://anaconda.org/channels/bioconda/packages/metafx/overview
- **Validation**: PASS

### Original Help Text
```text
metafx colored --help

MetaFX v=0.1.0
MetaFX colored module – supervised feature extraction using group-colored de Bruijn graph
Important! This module supports up to 3 categories of samples. If you have more, consider using other modules of MetaFX.
Usage: metafx colored [<Launch options>] [<Input parameters>]

Launch options:
    -h | --help                       show this help message and exit
    -t | --threads       <int>        number of threads to use [default: all]
    -m | --memory        <MEM>        memory to use (values with suffix: 1500M, 4G, etc.) [default: 90% of free RAM]
    -w | --work-dir      <dirname>    working directory [default: workDir/]

Input parameters:
    -k | --k             <int>        k-mer size (in nucleotides, maximum value is 31) [mandatory]
    -i | --reads-file    <filename>   tab-separated file with 2 values in each row: <path_to_file>\t<category> [mandatory]
    -b | --bad-frequency <int>        maximal frequency for a k-mer to be assumed erroneous [default: 1]
         --total-coverage             if TRUE count k-mers occurrences in colored graph as total coverage in samples, otherwise as number of samples [default: False]
         --separate                   if TRUE use only color-specific k-mers in components (does not work in linear mode) [default: False]
         --linear                     if TRUE extract only linear components choosing best path on each graph fork [default: False]
         --n-comps       <int>        select not more than <int> components for each category [default: -1, means all components]
         --perc          <float>      relative abundance of k-mer in category to be considered color-specific [default: 0.9]
         --kmers-dir     <dirname>    directory with pre-computed k-mers for samples in binary format [optional]
         --skip-graph                 if TRUE skip de Bruijn graph and fasta construction from components [default: False]
```


## metafx_pca

### Tool Description
PCA dimensionality reduction and visualisation of samples based on extracted features

### Metadata
- **Docker Image**: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/ctlab/metafx
- **Package**: https://anaconda.org/channels/bioconda/packages/metafx/overview
- **Validation**: PASS

### Original Help Text
```text
metafx pca --help

MetaFX v=0.1.0
MetaFX pca module – PCA dimensionality reduction and visualisation of samples based on extracted features
Usage: metafx pca [<Launch options>] [<Input parameters>]

Launch options:
    -h | --help                        show this help message and exit
    -w | --work-dir       <dirname>    working directory [default: workDir/]

Input parameters:
    -f | --feature-table  <filename>   file with feature table in tsv format: rows – features, columns – samples ("workDir/feature_table.tsv" can be used) [mandatory]
    -i | --metadata-file  <filename>   tab-separated file with 2 values in each row: <sample>\t<category> ("workDir/samples_categories.tsv" can be used) [optional, default: None]
         --name           <filename>   name of output image in workDir [optional, default: pca]
         --show                        if TRUE print samples' names on plot [optional, default: False]
```


## metafx_fit

### Tool Description
Machine Learning methods to train classification model based on extracted features

### Metadata
- **Docker Image**: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/ctlab/metafx
- **Package**: https://anaconda.org/channels/bioconda/packages/metafx/overview
- **Validation**: PASS

### Original Help Text
```text
metafx fit --help

MetaFX v=0.1.0
MetaFX fit module – Machine Learning methods to train classification model based on extracted features
Usage: metafx fit [<Launch options>] [<Input parameters>]

Launch options:
    -h | --help                        show this help message and exit
    -w | --work-dir       <dirname>    working directory [default: workDir/]

Input parameters:
    -f | --feature-table  <filename>   file with feature table in tsv format: rows – features, columns – samples ("workDir/feature_table.tsv" can be used) [mandatory]
    -i | --metadata-file  <filename>   tab-separated file with 2 values in each row: <sample>\t<category> ("workDir/samples_categories.tsv" can be used) [mandatory]
    -e | --estimator      [RF, XGB, Torch] classification model: RF – scikit-learn Random Forest, XGB – XGBoost, Torch – PyTorch neural network, default: RF]
         --name           <filename>   name of output trained model in workDir [optional, default: model]
```


## metafx_predict

### Tool Description
MetaFX predict module – Machine Learning methods to classify new samples based on pre-trained model

### Metadata
- **Docker Image**: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/ctlab/metafx
- **Package**: https://anaconda.org/channels/bioconda/packages/metafx/overview
- **Validation**: PASS

### Original Help Text
```text
metafx predict --help

MetaFX v=0.1.0
MetaFX predict module – Machine Learning methods to classify new samples based on pre-trained model
Usage: metafx predict [<Launch options>] [<Input parameters>]

Launch options:
    -h | --help                        show this help message and exit
    -w | --work-dir       <dirname>    working directory [default: workDir/]

Input parameters:
    -f | --feature-table  <filename>   file with feature table in tsv format: rows – features, columns – samples ("workDir/feature_table.tsv" can be used) [mandatory]
         --model          <filename>   file with pre-trained classification model, obtained via 'fit' or 'cv' module ("workDir/model.joblib" can be used) [mandatory]
    -e | --estimator      [RF, XGB, Torch] classification model: RF – scikit-learn Random Forest, XGB – XGBoost, Torch – PyTorch neural network, default: RF]
    -i | --metadata-file  <filename>   tab-separated file with 2 values in each row: <sample>\t<category> to check accuracy of predictions [optional, default: None]
         --name           <filename>   name of output file with samples predicted labels in workDir [optional, default: predictions]
```


## metafx_fit_predict

### Tool Description
Machine Learning methods to train classification model based on extracted features and immediately apply it to classify new samples

### Metadata
- **Docker Image**: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/ctlab/metafx
- **Package**: https://anaconda.org/channels/bioconda/packages/metafx/overview
- **Validation**: PASS

### Original Help Text
```text
metafx fit_predict --help

MetaFX v=0.1.0
MetaFX fit_predict module – Machine Learning methods to train classification model based on extracted features and immediately apply it to classify new samples
Usage: metafx fit_predict [<Launch options>] [<Input parameters>]
Use samples present in 'metadata-file' to train classifier and predict labels for the rest samples in 'feature-table'

Launch options:
    -h | --help                        show this help message and exit
    -w | --work-dir       <dirname>    working directory [default: workDir/]

Input parameters:
    -f | --feature-table  <filename>   file with feature table in tsv format: rows – features, columns – samples ("workDir/feature_table.tsv" can be used) [mandatory]
    -i | --metadata-file  <filename>   tab-separated file with 2 values in each row: <sample>\t<category> ("workDir/samples_categories.tsv" can be used) [mandatory]
         --name           <filename>   name of output files in workDir [optional, default: model]
```


## metafx_cv

### Tool Description
Machine Learning methods to train classification model based on extracted features and check accuracy via cross-validation

### Metadata
- **Docker Image**: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/ctlab/metafx
- **Package**: https://anaconda.org/channels/bioconda/packages/metafx/overview
- **Validation**: PASS

### Original Help Text
```text
metafx cv --help

MetaFX v=0.1.0
MetaFX cv module – Machine Learning methods to train classification model based on extracted features and check accuracy via cross-validation
Usage: metafx cv [<Launch options>] [<Input parameters>]

Launch options:
    -h | --help                        show this help message and exit
    -t | --threads        <int>        number of threads to use [default: 1]
    -w | --work-dir       <dirname>    working directory [default: workDir/]

Input parameters:
    -f | --feature-table  <filename>   file with feature table in tsv format: rows – features, columns – samples ("workDir/feature_table.tsv" can be used) [mandatory]
    -i | --metadata-file  <filename>   tab-separated file with 2 values in each row: <sample>\t<category> ("workDir/samples_categories.tsv" can be used) [mandatory]
    -n | --n-splits       <int>        number of folds in cross-validation. Must be at least 2. [optional, default: 5]
         --name           <filename>   name of output trained model in workDir [optional, default: rf_model_cv]
         --grid                        if TRUE, perform grid search of optimal parameters for classification model [optional, default: False]
```


## metafx_bandage

### Tool Description
MetaFX bandage module – Machine Learning methods to train classifier and prepare for visualisation in Bandage (https://github.com/ctlab/BandageNG)

### Metadata
- **Docker Image**: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/ctlab/metafx
- **Package**: https://anaconda.org/channels/bioconda/packages/metafx/overview
- **Validation**: PASS

### Original Help Text
```text
metafx bandage --help

MetaFX v=0.1.0
MetaFX bandage module – Machine Learning methods to train classifier and prepare for visualisation in Bandage (https://github.com/ctlab/BandageNG)
Usage: metafx bandage [<Launch options>] [<Input parameters>]

Launch options:
    -h | --help                       show this help message and exit
    -w | --work-dir      <dirname>    working directory [default: workDir/]

Input parameters:
    -f | --feature-dir   <dirname>        directory containing folders with contigs for each category, feature_table.tsv and categories_samples.tsv files. Usually, it is workDir from other MetaFX modules (unique, stats, colored, metafast, metaspades) [mandatory]
         --model         <filename>       file with pre-trained classification model, obtained via 'fit' or 'cv' module ("workDir/rf_model.joblib" can be used) [optional, if set '-n', '-d', '-e' will be ignored]
    -n | --n-estimators  <int>            number of estimators in classification model [optional]
    -d | --max-depth     <int>            maximum depth of decision tree base estimator [optional]
    -e | --estimator     [RF, ADA, GBDT]  classification model: RF – Random Forest, ADA – AdaBoost, GBDT – Gradient Boosted Decision Trees [optional, default: RF]
         --gui                            if TRUE opens Bandage GUI and draw images. Does NOT work on servers with command line interface only [default: False]
         --name          <filename>       name of output file with tree model in text format in workDir [optional, default: tree_model]
```


## metafx_feature_analysis

### Tool Description
MetaFX feature_analysis module – pipeline to build de Bruijn graphs for samples with selected feature and visualize them in BandageNG (https://github.com/ctlab/BandageNG)

### Metadata
- **Docker Image**: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/ctlab/metafx
- **Package**: https://anaconda.org/channels/bioconda/packages/metafx/overview
- **Validation**: PASS

### Original Help Text
```text
metafx feature_analysis --help

MetaFX v=0.1.0
MetaFX feature_analysis module – pipeline to build de Bruijn graphs for samples with selected feature and visualize them in BandageNG (https://github.com/ctlab/BandageNG)
Usage: metafx feature_analysis [<Launch options>] [<Input parameters>]

Launch options:
    -h | --help                       show this help message and exit
    -t | --threads       <int>        number of threads to use [default: all]
    -m | --memory        <MEM>        memory to use (values with suffix: 1500M, 4G, etc.) [default: 90% of free RAM]
    -w | --work-dir      <dirname>    working directory [default: workDir/]

Input parameters:
    -k | --k             <int>        k-mer size to build de Bruij graphs (in nucleotides, maximum value is 31) [mandatory]
    -f | --feature-dir   <dirname>    directory containing folders with contigs for each category, feature_table.tsv and categories_samples.tsv files. Usually, it is workDir from other MetaFX modules (unique, stats, colored, metafast, metaspades) [mandatory]
    -n | --feature-name  <string>     name of the feature of interest (should be one of the values from first column of feature_table.tsv) [mandatory]
    -r | --reads-dir     <dirname>    directory containing files with reads for samples. FASTQ, FASTA, gzip- or bzip2-compressed [mandatory]
         --relab         <int>        minimal relative abundance of feature in sample to include sample for further analysis [optional, default: 0.1]
```


## metafx_calc_features

### Tool Description
MetaFX calc_features module – to count values for new samples based on previously extracted features

### Metadata
- **Docker Image**: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/ctlab/metafx
- **Package**: https://anaconda.org/channels/bioconda/packages/metafx/overview
- **Validation**: PASS

### Original Help Text
```text
metafx calc_features --help

MetaFX v=0.1.0
MetaFX calc_features module – to count values for new samples based on previously extracted features
Usage: metafx calc_features [<Launch options>] [<Input parameters>]

Launch options:
    -h | --help                       show this help message and exit
    -t | --threads       <int>        number of threads to use [default: all]
    -m | --memory        <MEM>        memory to use (values with suffix: 1500M, 4G, etc.) [default: 90% of free RAM]
    -w | --work-dir      <dirname>    working directory [default: workDir/]

Input parameters:
    -k | --k             <int>        k-mer size (in nucleotides, maximum value is 31) [mandatory]
    -i | --reads         <filenames>  list of reads files from single environment. FASTQ, FASTA, gzip- or bzip2-compressed [mandatory]
    -d | --feature-dir   <dirname>    directory containing folders with components.bin file for each category and categories_samples.tsv file. Usually, it is workDir from other MetaFX modules (unique, stats, colored, metafast, metaspades) [mandatory]
    -b | --bad-frequency <int>        maximal frequency for a k-mer to be assumed erroneous [default: 1]
         --kmers-dir     <dirname>    directory with pre-computed k-mers for samples in binary format (if given, --reads will be ignored) [optional]
```


## metafx_extract_kmers

### Tool Description
Counting k-mers presence for samples

### Metadata
- **Docker Image**: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/ctlab/metafx
- **Package**: https://anaconda.org/channels/bioconda/packages/metafx/overview
- **Validation**: PASS

### Original Help Text
```text
metafx extract_kmers -help

------------------------------------------------------------------------------------------------------------------------
-----                                     Counting k-mers presence for samples                                     -----
------------------------------------------------------------------------------------------------------------------------

/usr/local/bin/metafx-modules/metafast.sh -t kmer-counter-many -w workDir/
--
26-Feb-26  03:34:28  ERROR: Uncaught exception: ru.ifmo.genetics.utils.tool.NotSetArgumentException: Mandatory argument --k (-k) not set
--
ru.ifmo.genetics.utils.tool.NotSetArgumentException: Mandatory argument --k (-k) not set
	at ru.ifmo.genetics.utils.tool.Tool.checkArguments(Tool.java:732)
	at ru.ifmo.genetics.utils.tool.Tool.run(Tool.java:436)
	at ru.ifmo.genetics.utils.tool.Tool.mainImpl(Tool.java:619)
	at ru.ifmo.genetics.Runner.run(Runner.java:176)
	at Runner.main(Runner.java:83)

************************************************************************************************************************
*****                                         Error during k-mer counting!                                         *****
************************************************************************************************************************
```

