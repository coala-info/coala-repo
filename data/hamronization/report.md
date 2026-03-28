# hamronization CWL Generation Report

## hamronization_hamronize

### Tool Description
Convert AMR gene detection tool output(s) to hAMRonization specification format

### Metadata
- **Docker Image**: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
- **Homepage**: https://github.com/pha4ge/hAMRonization
- **Package**: https://anaconda.org/channels/bioconda/packages/hamronization/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hamronization/overview
- **Total Downloads**: 10.2K
- **Last updated**: 2025-11-25
- **GitHub**: https://github.com/pha4ge/hAMRonization
- **Stars**: N/A
### Original Help Text
```text
usage: hamronize <tool> <options>

Convert AMR gene detection tool output(s) to hAMRonization specification
format

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit

Tools with hAMRonizable reports:
  {abricate,amrfinderplus,amrplusplus,ariba,csstar,deeparg,fargene,groot,kmerresistance,resfams,resfinder,mykrobe,rgi,srax,srst2,staramr,tbprofiler,summarize}
    abricate            hAMRonize abricate's output report i.e., OUTPUT.tsv
    amrfinderplus       hAMRonize amrfinderplus's output report i.e.,
                        OUTPUT.tsv
    amrplusplus         hAMRonize amrplusplus's output report i.e., gene.tsv
    ariba               hAMRonize ariba's output report i.e.,
                        OUTDIR/OUTPUT.tsv
    csstar              hAMRonize csstar's output report i.e., OUTPUT.tsv
    deeparg             hAMRonize deeparg's output report i.e.,
                        OUTDIR/OUTPUT.mapping.ARG
    fargene             hAMRonize fargene's output report i.e., retrieved-
                        genes-*-hmmsearched.out
    groot               hAMRonize groot's output report i.e., OUTPUT.tsv (from
                        `groot report`)
    kmerresistance      hAMRonize kmerresistance's output report i.e.,
                        OUTPUT.res
    resfams             hAMRonize resfams's output report i.e., resfams.tblout
    resfinder           hAMRonize resfinder's output report i.e.,
                        data_resfinder.json
    mykrobe             hAMRonize mykrobe's output report i.e., OUTPUT.json
    rgi                 hAMRonize rgi's output report i.e., OUTPUT.txt or
                        OUTPUT_bwtoutput.gene_mapping_data.txt
    srax                hAMRonize srax's output report i.e.,
                        sraX_detected_ARGs.tsv
    srst2               hAMRonize srst2's output report i.e.,
                        OUTPUT_srst2_report.tsv
    staramr             hAMRonize staramr's output report i.e., resfinder.tsv
    tbprofiler          hAMRonize tbprofiler's output report i.e.,
                        OUTPUT.results.json
    summarize           Provide a list of paths to the reports you wish to
                        summarize
```


## hamronization_hamronize summarize

### Tool Description
Concatenate and summarize AMR detection reports

### Metadata
- **Docker Image**: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
- **Homepage**: https://github.com/pha4ge/hAMRonization
- **Package**: https://anaconda.org/channels/bioconda/packages/hamronization/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hamronize summarize <options> <list of reports>

Concatenate and summarize AMR detection reports

positional arguments:
  hamronized_reports    list of hAMRonized reports

options:
  -h, --help            show this help message and exit
  -t, --summary_type {tsv,json,interactive}
                        Which summary report format to generate
  -o, --output OUTPUT   Output file path for summary
```


## hamronization_hamronize interactive

### Tool Description
hamronize: error: argument analysis_tool: invalid choice: 'interactive' (choose from abricate, amrfinderplus, amrplusplus, ariba, csstar, deeparg, fargene, groot, kmerresistance, resfams, resfinder, mykrobe, rgi, srax, srst2, staramr, tbprofiler, summarize)

### Metadata
- **Docker Image**: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
- **Homepage**: https://github.com/pha4ge/hAMRonization
- **Package**: https://anaconda.org/channels/bioconda/packages/hamronization/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hamronize <tool> <options>
hamronize: error: argument analysis_tool: invalid choice: 'interactive' (choose from abricate, amrfinderplus, amrplusplus, ariba, csstar, deeparg, fargene, groot, kmerresistance, resfams, resfinder, mykrobe, rgi, srax, srst2, staramr, tbprofiler, summarize)
```


## Metadata
- **Skill**: generated
