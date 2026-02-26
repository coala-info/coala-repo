# cegroomer CWL Generation Report

## cegroomer

### Tool Description
FAIL to generate CWL: cegroomer not found in Docker image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/tracegroomer:0.1.4--pyhdfd78af_0
- **Homepage**: Not found
- **Package**: Not found
- **wiki**: https://github.com/cbib/TraceGroomer/wiki
- **Validation**: FAIL (generation failed)

### Generation Failed

FAIL to generate CWL: cegroomer not found in Docker image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: cegroomer not found in Docker image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## cegroomer_tracegroomer

### Tool Description
A tool for grooming and normalizing labeled metabolomics data.

### Metadata
- **Docker Image**: quay.io/biocontainers/tracegroomer:0.1.4--pyhdfd78af_0
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:tracegroomer.__main__:
Time: 20260224-01.02.35
usage: python -m tracegroomer [-h] [-cf CONFIG_FILE] [-lm LABELED_METABO_FILE]
                              [-tf TYPE_OF_FILE]
                              [--amountMaterial_path AMOUNTMATERIAL_PATH]
                              [--alternative_div_amount_material | --no-alternative_div_amount_material]
                              [--div_isotopologues_by_amount_material | --no-div_isotopologues_by_amount_material]
                              [--use_internal_standard USE_INTERNAL_STANDARD]
                              [--remove_these_metabolites REMOVE_THESE_METABOLITES]
                              [--isotopologues_preview | --no-isotopologues_preview]
                              [--isosprop_min_admitted ISOSPROP_MIN_ADMITTED]
                              [--fractions_stomp_values | --no-fractions_stomp_values]
                              [--under_detection_limit_set_nan | --no-under_detection_limit_set_nan]
                              [--subtract_blankavg | --no-subtract_blankavg]
                              [-ox OUTPUT_FILES_EXTENSION]

options:
  -h, --help            show this help message and exit
  -cf CONFIG_FILE, --config_file CONFIG_FILE
                        Configuration file given as absolute path (default:
                        None)
  -lm LABELED_METABO_FILE, --labeled_metabo_file LABELED_METABO_FILE
                        Labeled metabolomics input file, absolute path
                        (default: None)
  -tf TYPE_OF_FILE, --type_of_file TYPE_OF_FILE
                        One of the following:
                        IsoCor_out_tsv|rule_tsv|VIBMEC_xlsx|generic_xlsx
                        (default: None)
  --amountMaterial_path AMOUNTMATERIAL_PATH
                        absolute path to the file having the amount of
                        material (number of cells, tissue weight, etc) by
                        sample, for the normalization (default: None)
  --alternative_div_amount_material, --no-alternative_div_amount_material
                        When dividing values by the amount of material, also
                        multiplies by 'mean(amountMaterial)' to stay in
                        abundance units (default: True)
  --div_isotopologues_by_amount_material, --no-div_isotopologues_by_amount_material
                        Apply normalization by the amount of material, at the
                        level of isotopologue absolute values. After this, re-
                        computes all derived metrics. If False, only total
                        abundances are normalized (default: True)
  --use_internal_standard USE_INTERNAL_STANDARD
                        Internal Standard for performing the division:
                        total_abundances/internal_standard, example:
                        --use_internal_standard Myristic_acid_d27. By default
                        is not performed (default: None)
  --remove_these_metabolites REMOVE_THESE_METABOLITES
                        Absolute path to the file with columns: compartment,
                        metabolite; listing the metabolites to be completely
                        excluded (you know what you are doing) (default: None)
  --isotopologues_preview, --no-isotopologues_preview
                        Plot isotopologue values, as given (default: False)
  --isosprop_min_admitted ISOSPROP_MIN_ADMITTED
                        Metabolites whose isotopologues proportions are less
                        or equal to this cutoff, are removed (default: -0.5)
  --fractions_stomp_values, --no-fractions_stomp_values
                        Stomps fractional contributions (synonym: mean
                        enrichment), and isotopologue proportions, to max 1.0
                        and min 0.0 (default: True)
  --under_detection_limit_set_nan, --no-under_detection_limit_set_nan
                        On VIB results. Any abundance < LOD (Limit Of
                        Detection), is set as NaN (default: True)
  --subtract_blankavg, --no-subtract_blankavg
                        On VIB results. From samples' abundances, subtracts
                        the average of the blanks (default: True)
  -ox OUTPUT_FILES_EXTENSION, --output_files_extension OUTPUT_FILES_EXTENSION
                        Extension for the output files, must be one of the
                        following: csv|tsv|txt (default: csv)
```

