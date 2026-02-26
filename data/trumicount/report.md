# trumicount CWL Generation Report

## trumicount

### Tool Description
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

### Metadata
- **Docker Image**: quay.io/biocontainers/trumicount:0.9.14--r44hdfd78af_3
- **Homepage**: https://cibiv.github.io/trumicount/
- **Package**: https://anaconda.org/channels/bioconda/packages/trumicount/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/trumicount/overview
- **Total Downloads**: 35.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Cibiv/trumicount
- **Stars**: N/A
### Original Help Text
```text
Usage: trumicount (--input-bam INBAM | --input-umitools-group-out GROUPSINTAB | --input-umis UMISINTAB) [options] [--umitools-option UMITOOLSOPT]...

Version 0.9.14 Copyright 2017-2018 Florian G. Pflug

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

Options:
--input-bam FILE                read UMIs from FILE (uses `umi_tools group`)
--input-umitools-group-out FILE read UMIs from FILE produced by `umi_tools group`
--input-umis FILE               read UMIs from FILE (previously produced by --output-umis)
--output-counts FILE            write bias-corrected per-group counts and models to FILE
--output-umis FILE              write UMIs reported by `umi_tools group` to FILE
--output-final-umis FILE        write strand-combined and filtered UMIs to FILE
--output-readdist FILE          write global reads/UMI distribution (before and after filtering) to FILE
--output-plots PLOT             write diagnostic plots in PDF format to PLOT
--output-groupwise-fits FILE    write group-wise model details to FILE
--output-genewise-fits FILE     obsolete name for --output-groupwise-fits
--umitools UMITOOLS             use executable UMITOOLS to run `umi_tools group` [Default: umi_tools]
--umitools-option UMITOOLSOPT   pass UMITOOLSOPT to `umi_tools group` (see `umi_tools group --help`)
--umi-sep UMISEP                assume UMISEP separates read name and UMI (passed to umi_tools) [Default: _]
--umipair-sep UMIPAIRSEP        assume UMIPAIRSEP separates read1 and read2 UMI (see Strand UMIs) [Default: ]
--paired                        assume BAM file contains paired reads (passed to umi_tools) [Default: FALSE]
--mapping-quality MAPQ          ignored read with mapping quality below MAPQ (passed to umi_tools) [Default: 20]
--filter-strand-umis            filtes UMIs where only one strands was observed [Default: FALSE]
--combine-strand-umis           combine UMIs strand pairs (implies --filter-strand-umis) [Default: FALSE]
--threshold THRESHOLD           remove UMIs with fewer than THRESHOLD reads
--threshold-quantile Q          use quantile Q of the raw read-count distribution for THRESHOLD [Default: 0.2]
--molecules MOLECULES           assume UMIs are initially represented by MOLECULES copies (strands) [Default: 2]
--group-per KEY1,KEY2,...       counts UMIs per distinct key(s), can be "cell" and/or "gene",
                                "cell" implies --umitools-option --per-cell [Default: gene]
--skip-groupwise-fits           skip group-wise model fitting, stop after plotting the global fit
--include-filter-statistics     add filtered and unfiltered read and UMI counts to count table [Default: FALSE]
--groupwise-min-umis MINUMIS    use global estimates for groups with fewer than MINUMIS (strand) UMIs [Default: 5]
--genewise-min-umis MINUMIS     obsolete name for --groupwise-min-umis
--cores CORES                   spread group-wise model fitting over CORES cpus [Default: 1]
--variance-estimator VAREST     use VAREST to estimate variances, can be "lsq" or "mle" [Default: lsq]
--digits DIGITS                 number of digits to output [Default: 3]
--plot-hist-bin PLOTXBIN        make read count histogram bins PLOTXBIN wide
--plot-hist-xmax PLOTXMAX       limit read count histogram plot to at most PLOTXMAX reads per UMI
--plot-skip-phantoms            do not show phantom UMIs in histogram plot [Default: FALSE]
--plot-var-bins PLOTVARBINS     plot PLOTVARBINS separate emprirical variances [Default: 10]
--plot-var-logy                 use log scale for the variance (y) axis [Default: FALSE]
--verbose                       enable verbose output
```

