# picrust CWL Generation Report

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

