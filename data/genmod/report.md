# genmod CWL Generation Report

## genmod_annotate

### Tool Description
Annotate vcf variants.

Annotate variants with a number of different sources. Please use --help for
more info.

### Metadata
- **Docker Image**: quay.io/biocontainers/genmod:3.10.2--pyh7e72e81_0
- **Homepage**: http://github.com/moonso/genmod
- **Package**: https://anaconda.org/channels/bioconda/packages/genmod/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/genmod/overview
- **Total Downloads**: 8.1K
- **Last updated**: 2025-12-15
- **GitHub**: https://github.com/moonso/genmod
- **Stars**: N/A
### Original Help Text
```text
Usage: genmod annotate [OPTIONS] <vcf_file> or -

  Annotate vcf variants.

  Annotate variants with a number of different sources. Please use --help for
  more info.

Options:
  -r, --annotate_regions, --annotate-regions, --regions
                                  Annotate what regions a variant belongs to
                                  (eg. genes).
  --region-file, --region_file PATH
                                  Choose a bed file with regions that should
                                  be used.
  -b, --genome-build [37|38]      Choose what genome build to use.  [default:
                                  37]
  -c, --cadd-file, --cadd_file PATH
                                  Specify the path to a bgzipped cadd file
                                  (with index) with variant scores. This
                                  command can be used multiple times if
                                  multiple cadd files.
  --thousand-g, --thousand_g PATH
                                  Specify the path to a bgzipped vcf file
                                  (with index) with 1000g variants
  --exac PATH                     Specify the path to a bgzipped vcf file
                                  (with index) with exac variants.
  --cosmic PATH                   Specify the path to a bgzipped vcf file
                                  (with index) with COSMIC variants.
  --max-af, --max_af              If the MAX AF should be annotated
  --spidex PATH                   Specify the path to a bgzipped tsv file
                                  (with index) with spidex information.
  --cadd-raw, --cadd_raw          If the raw cadd scores should be annotated.
  -o, --outfile FILENAME          Specify the path to a file where results
                                  should be stored.
  -s, --silent                    Do not print the variants.
  --temp_dir PATH                 Path to tempdir
  --help                          Show this message and exit.
```


## genmod_compound

### Tool Description
Score compound variants in a vcf file based on their rank score.

### Metadata
- **Docker Image**: quay.io/biocontainers/genmod:3.10.2--pyh7e72e81_0
- **Homepage**: http://github.com/moonso/genmod
- **Package**: https://anaconda.org/channels/bioconda/packages/genmod/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: genmod compound [OPTIONS] <vcf_file> or -

  Score compound variants in a vcf file based on their rank score.

Options:
  -s, --silent             Do not print the variants.
  -o, --outfile FILENAME   Specify the path to a file where results should be
                           stored.
  -p, --processes INTEGER  Define how many processes that should be use for
                           annotation.
  --temp_dir PATH          Path to tempdir
  --vep                    If variants are annotated with the Variant Effect
                           Predictor.
  --threshold INTEGER      Threshold for model-dependent penalty if no
                           compounds with passing score
  --penalty INTEGER        Penalty applied together with --threshold
  --help                   Show this message and exit.
```


## genmod_filter

### Tool Description
Filter vcf variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/genmod:3.10.2--pyh7e72e81_0
- **Homepage**: http://github.com/moonso/genmod
- **Package**: https://anaconda.org/channels/bioconda/packages/genmod/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: genmod filter [OPTIONS] <vcf_file> or -

  Filter vcf variants.

  Filter variants based on their annotation

Options:
  -a, --annotation TEXT   Specify the info annotation to search for. Default
                          1000GAF
  -t, --threshold FLOAT   Threshold for filter variants. Default 0.05
  -d, --discard           If variants without the annotation should be
                          discarded
  -g, --greater           If greater than threshold should be used instead of
                          less thatn threshold.
  -s, --silent            Do not print the variants.
  -o, --outfile FILENAME  Specify the path to a file where results should be
                          stored.
  --help                  Show this message and exit.
```


## genmod_models

### Tool Description
Annotate genetic models for vcf variants.

  Checks what patterns of inheritance that are followed in a VCF file. The
  analysis is family based so each family that are specified in the family
  file and exists in the variant file will get it's own annotation.

  Note that the "whole_gene" flag has been disabled and will be removed in a
  later version.

### Metadata
- **Docker Image**: quay.io/biocontainers/genmod:3.10.2--pyh7e72e81_0
- **Homepage**: http://github.com/moonso/genmod
- **Package**: https://anaconda.org/channels/bioconda/packages/genmod/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: genmod models [OPTIONS] <vcf_file> or -

  Annotate genetic models for vcf variants.

  Checks what patterns of inheritance that are followed in a VCF file. The
  analysis is family based so each family that are specified in the family
  file and exists in the variant file will get it's own annotation.

  Note that the "whole_gene" flag has been disabled and will be removed in a
  later version.

Options:
  -f, --family_file <ped_file>
  -t, --family_type [ped|alt|cmms|mip]
                                  If the analysis use one of the known setups,
                                  please specify which one.
  -r, --reduced_penetrance, --reduced-penetrance <tsv_file>
                                  File with gene ids that have reduced
                                  penetrance.
  --vep                           If variants are annotated with the Variant
                                  Effect Predictor.
  --phased                        If data is phased use this flag.
  -s, --strict                    If strict model annotations should be
                                  used(see documentation).
  -w, --whole_gene, --whole-gene  DEPRECATED FLAG - on by default
  -p, --processes INTEGER         Define how many processes that should be use
                                  for annotation.
  -s, --silent                    Do not print the variants.
  -k, --keyword TEXT              What annotation keyword that should be used
                                  when  searching for features.
  -o, --outfile FILENAME          Specify the path to a file where results
                                  should be stored.
  --temp_dir PATH                 Path to tempdir
  --help                          Show this message and exit.
```


## genmod_score

### Tool Description
Score variants in a vcf file using a Weighted Sum Model.

### Metadata
- **Docker Image**: quay.io/biocontainers/genmod:3.10.2--pyh7e72e81_0
- **Homepage**: http://github.com/moonso/genmod
- **Package**: https://anaconda.org/channels/bioconda/packages/genmod/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: genmod score [OPTIONS] <vcf_file> or -

  Score variants in a vcf file using a Weighted Sum Model.

  The specific scores should be defined in a config file, see examples on
  github.

Options:
  -i, --family_id TEXT
  -f, --family_file <ped_file>
  -t, --family_type [ped|alt|cmms|mip]
                                  If the analysis use one of the known setups,
                                  please specify which one.
  -s, --silent                    Do not print the variants.
  --skip_plugin_check             If continue even if plugins does not exist
                                  in vcf.
  -r, --rank_results              Add a info field that shows how the
                                  different categories contribute to the rank
                                  score.
  -o, --outfile FILENAME          Specify the path to a file where results
                                  should be stored.
  -c, --score_config PATH         The plug-in config file(.ini)
  --help                          Show this message and exit.
```


## genmod_sort

### Tool Description
Sort a VCF file based on rank score.

### Metadata
- **Docker Image**: quay.io/biocontainers/genmod:3.10.2--pyh7e72e81_0
- **Homepage**: http://github.com/moonso/genmod
- **Package**: https://anaconda.org/channels/bioconda/packages/genmod/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: genmod sort [OPTIONS] <vcf_file> or -

  Sort a VCF file based on rank score.

Options:
  -o, --outfile FILENAME  Specify the path to a file where results should be
                          stored.
  -f, --family_id TEXT    Specify the family id for sorting.
  -s, --silent            Do not print the variants.
  --temp_dir PATH         Path to tempdir
  -p, --position          If variants should be sorted by position.
  --help                  Show this message and exit.
```

