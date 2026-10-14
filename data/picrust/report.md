# picrust CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| picrust_categorize_by_function.py | PASS |  |
| picrust_compare_biom.py | PASS |  |
| picrust_metagenome_contributions.py | PASS |  |
| picrust_normalize_by_copy_number.py | PASS |  |
| picrust_predict_metagenomes.py | PASS | main mode and accuracy metrics work on Galaxy test data with a custom trait table; option -f crashes in this image (AttributeError) |
| picrust_scale_metagenome.py | PASS |  |

## picrust_normalize_by_copy_number.py

### Tool Description
Normalize the OTU abundances for a given OTU table picked against the newest version of Greengenes

### Metadata
- **Docker Image**: quay.io/biocontainers/picrust:1.1.4--pyh24bf2e0_0
- **Homepage**: http://picrust.github.com
- **Package**: https://anaconda.org/channels/bioconda/packages/picrust/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/picrust/overview
- **Total Downloads**: 37.3K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: normalize_by_copy_number.py [options] {-i/--input_otu_fp INPUT_OTU_FP -o/--output_otu_fp OUTPUT_OTU_FP}

[] indicates optional input (order unimportant)
{} indicates required input (order unimportant)



Example usage: 
Print help message and exit
 normalize_by_copy_number.py -h

Normalize the OTU abundances for a given OTU table picked against the newest version of Greengenes
 normalize_by_copy_number.py -i closed_picked_otus.biom -o normalized_otus.biom

Change the version of Greengenes used for OTU picking
 normalize_by_copy_number.py -g 18may2012 -i closed_picked_otus.biom -o normalized_otus.biom

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -v, --verbose         Print information during execution -- useful for
                        debugging [default: False]
  -g GG_VERSION, --gg_version=GG_VERSION
                        Version of GreenGenes that was used for OTU picking.
                        Valid choices are: 13_5, 18may2012 [default: 13_5]
  -c INPUT_COUNT_FP, --input_count_fp=INPUT_COUNT_FP
                        Precalculated input marker gene copy number
                        predictions on per otu basis in biom format (can be
                        gzipped).Note: using this option overrides
                        --gg_version. [default: none]
  --metadata_identifer=METADATA_IDENTIFER
                        identifier for copy number entry as observation
                        metadata [default: CopyNumber]
  --load_precalc_file_in_biom
                        Instead of loading the precalculated file in tab-
                        delimited format (with otu ids as row ids and traits
                        as columns) load the data in biom format (with otu as
                        SampleIds and traits as ObservationIds) [default:
                        False]

  REQUIRED options:
    The following options must be provided under all circumstances.

    -i INPUT_OTU_FP, --input_otu_fp=INPUT_OTU_FP
                        the input otu table filepath in biom format [REQUIRED]
    -o OUTPUT_OTU_FP, --output_otu_fp=OUTPUT_OTU_FP
                        the output otu table filepath in biom format
                        [REQUIRED]
```


## picrust_predict_metagenomes.py

### Tool Description
Predict KO abundances for a given OTU table picked against the newest version of GreenGenes.

### Metadata
- **Docker Image**: quay.io/biocontainers/picrust:1.1.4--pyh24bf2e0_0
- **Homepage**: http://picrust.github.com
- **Package**: https://anaconda.org/channels/bioconda/packages/picrust/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: predict_metagenomes.py [options] {-i/--input_otu_table INPUT_OTU_TABLE -o/--output_metagenome_table OUTPUT_METAGENOME_TABLE}

[] indicates optional input (order unimportant)
{} indicates required input (order unimportant)



Example usage: 
Print help message and exit
 predict_metagenomes.py -h

Predict KO abundances for a given OTU table picked against the newest version of GreenGenes.
 predict_metagenomes.py -i normalized_otus.biom -o predicted_metagenomes.biom

Change output format to plain tab-delimited
 predict_metagenomes.py -f -i normalized_otus.biom -o predicted_metagenomes.txt

Predict KO abundances for a given OTU table, but do not round predictions to nearest whole number (esp. needed for proportional abundances)
 predict_metagenomes.py --no_round -i normalized_otus.biom -o predicted_metagenomes.txt

Predict COG abundances for a given OTU table.
 predict_metagenomes.py -i normalized_otus.biom -t cog -o cog_predicted_metagenomes.biom

Predict RFAM abundances for a given OTU table.
 predict_metagenomes.py -i normalized_otus.biom -t rfam -o rfam_predicted_metagenomes.biom

Output confidence intervals for each prediction.
 predict_metagenomes.py -i normalized_otus.biom -o predicted_metagenomes.biom --with_confidence

Predict metagenomes using a custom trait table in tab-delimited format.
 predict_metagenomes.py -i otu_table_for_custom_trait_table.biom -c custom_trait_table.tab -o output_metagenome_from_custom_trait_table.biom

Predict metagenomes,variances,and 95% confidence intervals for each gene category using a custom trait table in tab-delimited format.
 predict_metagenomes.py -i otu_table_for_custom_trait_table.biom --input_variance_table custom_trait_table_variances.tab -c custom_trait_table.tab -o output_metagenome_from_custom_trait_table.biom --with_confidence

Change the version of GG used to pick OTUs
 predict_metagenomes.py -i normalized_otus.biom -g 18may2012 -o predicted_metagenomes.biom

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -v, --verbose         Print information during execution -- useful for
                        debugging [default: False]
  -t TYPE_OF_PREDICTION, --type_of_prediction=TYPE_OF_PREDICTION
                        Type of functional predictions. Valid choices are: ko,
                        cog, rfam [default: ko]
  -g GG_VERSION, --gg_version=GG_VERSION
                        Version of GreenGenes that was used for OTU picking.
                        Valid choices are: 13_5, 18may2012 [default: 13_5]
  -c INPUT_COUNT_TABLE, --input_count_table=INPUT_COUNT_TABLE
                        Precalculated function predictions on per otu basis in
                        biom format (can be gzipped). Note: using this option
                        overrides --type_of_prediction and --gg_version.
                        [default: none]
  -a ACCURACY_METRICS, --accuracy_metrics=ACCURACY_METRICS
                        If provided, calculate accuracy metrics for the
                        predicted metagenome.  NOTE: requires that per-genome
                        accuracy metrics were calculated using
                        predict_traits.py during genome prediction (e.g. there
                        are "NSTI" values in the genome .biom file metadata)
  --no_round            Disable rounding number of predicted functions to the
                        the nearest whole number. This option is important if
                        you are inputting abundances as proportions [default:
                        False]
  --normalize_by_function
                        Normalizes the predicted functional abundances by
                        dividing each abundance by the sum of functional
                        abundances in the sample. Total sum of abundances for
                        each sample will equal 1.
  --normalize_by_otu    Normalizes the predicted functional abundances by
                        dividing each abundance by the sum of OTUs in the
                        sample. Note: total sum of abundances for each sample
                        will NOT equal 1.
  --suppress_subset_loading
                        Normally, only counts for OTUs present in the sample
                        are loaded.  If this flag is passed, the full biom
                        table is loaded.  This makes no difference for the
                        analysis, but may result in faster load times (at the
                        cost of more memory usage)
  --load_precalc_file_in_biom
                        Instead of loading the precalculated file in tab-
                        delimited format (with otu ids as row ids and traits
                        as columns) load the data in biom format (with otu as
                        SampleIds and traits as ObservationIds) [default:
                        False]
  --input_variance_table=INPUT_VARIANCE_TABLE
                        Precalculated table of variances corresponding to the
                        precalculated table of function predictions.  As with
                        the count table, these are on a per otu basis and in
                        BIOM format (can be gzipped). Note: using this option
                        overrides --type_of_prediction and --gg_version.
                        [default: none]
  --with_confidence     Calculate 95% confidence intervals for metagenome
                        predictions.  By default, this uses the confidence
                        intervals for the precalculated table of genes for
                        greengenes OTUs.  If you pass a custom count table
                        with -c and select this option, you must also specify
                        a corresponding table of confidence intervals for the
                        gene content prediction using --input_variance_table.
                        (these are generated by running predict_traits.py with
                        the --with_confidence option). If this flag is set,
                        three addtional output files will be generated, named
                        the same as the metagenome prediction output, but with
                        .variance .upper_CI or .lower_CI appended immediately
                        before the file extension [default: False]
  -f, --format_tab_delimited
                        output the predicted metagenome table in tab-delimited
                        format [default: False]

  REQUIRED options:
    The following options must be provided under all circumstances.

    -i INPUT_OTU_TABLE, --input_otu_table=INPUT_OTU_TABLE
                        the input otu table in biom format [REQUIRED]
    -o OUTPUT_METAGENOME_TABLE, --output_metagenome_table=OUTPUT_METAGENOME_TABLE
                        the output file for the predicted metagenome
                        [REQUIRED]
```


## picrust_metagenome_contributions.py

### Tool Description
Partition the predicted contribution to the metagenomes from each organism in the given OTU table

### Metadata
- **Docker Image**: quay.io/biocontainers/picrust:1.1.4--pyh24bf2e0_0
- **Homepage**: http://picrust.github.com
- **Package**: https://anaconda.org/channels/bioconda/packages/picrust/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: metagenome_contributions.py [options] {-i/--input_otu_table INPUT_OTU_TABLE -o/--output_fp OUTPUT_FP}

[] indicates optional input (order unimportant)
{} indicates required input (order unimportant)



Example usage: 
Print help message and exit
 metagenome_contributions.py -h

Partition the predicted contribution to the  metagenomes from each organism in the given OTU table, limited to only K00001, K00002, and K00004.
 metagenome_contributions.py -i normalized_otus.biom -l K00001,K00002,K00004 -o ko_metagenome_contributions.tab

Partition the predicted contribution to the  metagenomes from each organism in the given OTU table, limited to only COG0001 and COG0002.
 metagenome_contributions.py -i normalized_otus.biom -l COG0001,COG0002 -t cog -o cog_metagenome_contributions.tab

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -v, --verbose         Print information during execution -- useful for
                        debugging [default: False]
  -t TYPE_OF_PREDICTION, --type_of_prediction=TYPE_OF_PREDICTION
                        Type of functional predictions. Valid choices are: ko,
                        cog, rfam [default: ko]
  -g GG_VERSION, --gg_version=GG_VERSION
                        Version of GreenGenes that was used for OTU picking.
                        Valid choices are: 13_5, 18may2012 [default: 13_5]
  -c INPUT_COUNT_TABLE, --input_count_table=INPUT_COUNT_TABLE
                        Precalculated function predictions on per otu basis in
                        biom format (can be gzipped). Note: using this option
                        overrides --type_of_prediction and --gg_version.
                        [default: none]
  --suppress_subset_loading
                        Normally, only counts for OTUs present in the sample
                        are loaded.  If this flag is passed, the full biom
                        table is loaded.  This makes no difference for the
                        analysis, but may result in faster load times (at the
                        cost of more memory usage)
  --load_precalc_file_in_biom
                        Instead of loading the precalculated file in tab-
                        delimited format (with otu ids as row ids and traits
                        as columns) load the data in biom format (with otu as
                        SampleIds and traits as ObservationIds) [default:
                        False]
  -f LIMIT_TO_FUNCTIONAL_CATEGORIES, --limit_to_functional_categories=LIMIT_TO_FUNCTIONAL_CATEGORIES
                        If provided only output prediction for functions that
                        match the specified functional category. Multiple
                        categories can be passed as a list separated by |
                        [default: False]
  -l LIMIT_TO_FUNCTION, --limit_to_function=LIMIT_TO_FUNCTION
                        If provided, only output predictions for the specified
                        function ids.  Multiple function ids can be passed
                        using comma delimiters.

  REQUIRED options:
    The following options must be provided under all circumstances.

    -i INPUT_OTU_TABLE, --input_otu_table=INPUT_OTU_TABLE
                        the input otu table in biom format [REQUIRED]
    -o OUTPUT_FP, --output_fp=OUTPUT_FP
                        the output file for the metagenome contributions
                        [REQUIRED]
```


## picrust_categorize_by_function.py

### Tool Description
Collapse hierarchical metagenome predictions (KEGG, COG, taxonomy) to a chosen level.

### Metadata
- **Docker Image**: quay.io/biocontainers/picrust:1.1.4--pyh24bf2e0_0
- **Homepage**: https://github.com/picrust/picrust
- **Package**: https://anaconda.org/channels/bioconda/packages/picrust/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: categorize_by_function.py [options] {-i/--input_fp INPUT_FP -o/--output_fp OUTPUT_FP -c/--metadata_category METADATA_CATEGORY -l/--level LEVEL}

[] indicates optional input (order unimportant)
{} indicates required input (order unimportant)

This script collapses hierarchical data to a specified level. For instance, often it is useful to examine KEGG results from a higher level within the pathway hierarchy. Many genes are sometimes involved in multiple pathways, and in these circumstances (also know as a one-to-many relationship), the gene is counted for each pathway. This has a side effect of increasing the total count of genes in the table.

Example usage: 
Print help message and exit
 categorize_by_function.py -h

Collapse predicted metagenome using KEGG Pathway metadata.
 categorize_by_function.py -i predicted_metagenomes.biom -c KEGG_Pathways -l 3 -o predicted_metagenomes.L3.biom

Change output to tab-delimited format (instead of BIOM).
 categorize_by_function.py -f -i predicted_metagenomes.biom -c KEGG_Pathways -l 3 -o predicted_metagenomes.L3.txt

Collapse COG Categories.
 categorize_by_function.py -i cog_predicted_metagenomes.biom -c COG_Category -l 2 -o cog_predicted_metagenomes.L2.biom

Collapse predicted metagenome using taxonomy metadata (not one-to-many).
 categorize_by_function.py -i observation_table.biom -c taxonomy -l 1 -o observation_table.L1.biom

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -v, --verbose         Print information during execution -- useful for
                        debugging [default: False]
  --ignore=IGNORE       Ignore the comma separated list of names. For
                        instance, specifying
                        --ignore_unknown=unknown,unclassified will ignore
                        those labels while collapsing. The default is to not
                        ignore anything. [default: none]
  -f, --format_tab_delimited
                        output the predicted metagenome table in tab-delimited
                        format [default: False]

  REQUIRED options:
    The following options must be provided under all circumstances.

    -i INPUT_FP, --input_fp=INPUT_FP
                        the predicted metagenome table [REQUIRED]
    -o OUTPUT_FP, --output_fp=OUTPUT_FP
                        the resulting table [REQUIRED]
    -c METADATA_CATEGORY, --metadata_category=METADATA_CATEGORY
                        the metadata category that describes the hierarchy
                        (e.g. KEGG_Pathways, COG_Category, etc.). Note: RFAM
                        predictions can not be collapsed because there are no
                        categories to group them into. [REQUIRED]
    -l LEVEL, --level=LEVEL
                        the level in the hierarchy to collapse to. A value of
                        0 is not allowed, a value of 1 is the highest level,
                        and any higher value nears the leaves of the
                        hierarchy. For instance, if the hierarchy contains 4
                        levels, specifying 3 would collapse at one level above
                        being fully specified. [REQUIRED]
```

## picrust_compare_biom.py

### Tool Description
Compare an observed BIOM table to an expected BIOM table and report accuracy values.

### Metadata
- **Docker Image**: quay.io/biocontainers/picrust:1.1.4--pyh24bf2e0_0
- **Homepage**: https://github.com/picrust/picrust
- **Package**: https://anaconda.org/channels/bioconda/packages/picrust/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: compare_biom.py [options] {-e/--exp_trait_table_fp EXP_TRAIT_TABLE_FP -o/--output_fp OUTPUT_FP}

[] indicates optional input (order unimportant)
{} indicates required input (order unimportant)

 

Example usage: 
Print help message and exit
 compare_biom.py -h

Example 1: Compare an observed table to an expected table using relative abundance
 compare_biom.py -e expected_ra.biom -o compare_results_ra.tab observed_ra.biom

Example 2: Compare an observed table to an expected table using real counts
 compare_biom.py --not_relative_abundance -e expected.biom -o compare_results.tab observed.biom

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -v, --verbose         Print information during execution -- useful for
                        debugging [default: False]
  -c, --compare_observations
                        Calculate accuracy values by comparing between
                        observations (instead of between samples) [default:
                        False]
  -n, --normalize       Convert both expected and observed tables to relative
                        abundances (instead of observations) [default: False]
  -l, --limit_to_expected_observations
                        Ignore observations that are not in the expected
                        table[default: False]
  --limit_to_observed_observations
                        Ignore observations that are not in the observed
                        table[default: False]
  -s, --shuffle_samples
                        Shuffle samples ids randomly before measuring
                        accuracy[default: False]
  --not_relative_abundance_scores
                        Round numbers (instead of taking ceil() which is used
                        for RA) before calculating TP,FP,FN,TN [default:
                        False]

  REQUIRED options:
    The following options must be provided under all circumstances.

    -e EXP_TRAIT_TABLE_FP, --exp_trait_table_fp=EXP_TRAIT_TABLE_FP
                        the expected trait table (biom format) [REQUIRED]
    -o OUTPUT_FP, --output_fp=OUTPUT_FP
                        the output file [REQUIRED]
```

## picrust_scale_metagenome.py

### Tool Description
Scale a BIOM table of trait counts by the sequencing depth of each sample.

### Metadata
- **Docker Image**: quay.io/biocontainers/picrust:1.1.4--pyh24bf2e0_0
- **Homepage**: https://github.com/picrust/picrust
- **Package**: https://anaconda.org/channels/bioconda/packages/picrust/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scale_metagenome.py [options] {-s/--input_seq_depth_file INPUT_SEQ_DEPTH_FILE -i/--input_count_table INPUT_COUNT_TABLE -o/--output_metagenome_table OUTPUT_METAGENOME_TABLE}

[] indicates optional input (order unimportant)
{} indicates required input (order unimportant)



Example usage: 
Print help message and exit
 scale_metagenome.py -h

Predict metagenomes from genomes.biom and otus.biom.
 scale_metagenome.py -i otus.biom -s sample_scaling.tsv -o scaled_otus.biom

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -v, --verbose         Print information during execution -- useful for
                        debugging [default: False]

  REQUIRED options:
    The following options must be provided under all circumstances.

    -s INPUT_SEQ_DEPTH_FILE, --input_seq_depth_file=INPUT_SEQ_DEPTH_FILE
                        an input tab-delimited table, with samples as the
                        first column and an integer sequencing depth as the
                        second [REQUIRED]
    -i INPUT_COUNT_TABLE, --input_count_table=INPUT_COUNT_TABLE
                        the input trait counts on per otu basis in biom format
                        (can be gzipped) [REQUIRED]
    -o OUTPUT_METAGENOME_TABLE, --output_metagenome_table=OUTPUT_METAGENOME_TABLE
                        the output file for the scaled metagenome [REQUIRED]
```

## Metadata
- **Skill**: generated
