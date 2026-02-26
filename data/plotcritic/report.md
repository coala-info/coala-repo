# plotcritic CWL Generation Report

## plotcritic

### Tool Description
Deploy a website for image curation

### Metadata
- **Docker Image**: quay.io/biocontainers/plotcritic:1.0.1--pyh5e36f6f_0
- **Homepage**: https://github.com/jbelyeu/PlotCritic
- **Package**: https://anaconda.org/channels/bioconda/packages/plotcritic/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/plotcritic/overview
- **Total Downloads**: 4.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jbelyeu/PlotCritic
- **Stars**: N/A
### Original Help Text
```text
usage: plotcritic [-h] -p PROJECT -i IMAGES_DIR [-s] -q CURATION_QUESTION -A
                  CURATION_ANSWERS [CURATION_ANSWERS ...]
                  [-R REPORT_FIELDS [REPORT_FIELDS ...]]
                  [-S SUMMARY_FIELDS [SUMMARY_FIELDS ...]]

Deploy a website for image curation

optional arguments:
  -h, --help            show this help message and exit
  -p PROJECT, --project PROJECT
                        Unique name for the project (default: None)
  -i IMAGES_DIR, --images_dir IMAGES_DIR
                        directory of images and metadata files for curation
                        (default: None)
  -s, --use_samplot_defaults
                        Use samplot-oriented default reporting_fields and
                        summary_fields. Ignores `--summary_fields` and
                        `--reporting_fields`. Default reporting fields: Image,
                        chrom, start, end, sv_type, reference, bams, titles,
                        output_file, transcript_file, window, max_depth
                        Default summary fields: Image, chrom, start, end,
                        sv_type (default: False)
  -q CURATION_QUESTION, --curation_question CURATION_QUESTION
                        The curation question to show in the PlotCritic
                        website. (default: None)
  -A CURATION_ANSWERS [CURATION_ANSWERS ...], --curation_answers CURATION_ANSWERS [CURATION_ANSWERS ...]
                        colon-separated key,values pairs of 1-letter codes and
                        associated curation answers for the curation question
                        (i.e: 'key1','value1' 'key2','value2'). (default:
                        None)
  -R REPORT_FIELDS [REPORT_FIELDS ...], --report_fields REPORT_FIELDS [REPORT_FIELDS ...]
                        space-separated list of info fields about the image.
                        If omitted, only the image name will be included in
                        report (default: None)
  -S SUMMARY_FIELDS [SUMMARY_FIELDS ...], --summary_fields SUMMARY_FIELDS [SUMMARY_FIELDS ...]
                        subset of the report fields that will be shown in the
                        web report after scoring.Space-separated. If omitted,
                        only the image name will be included in report
                        (default: None)
```

