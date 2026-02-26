# qualimap CWL Generation Report

## qualimap_bamqc

### Tool Description
Performs a quality control analysis on BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/qualimap:2.3--hdfd78af_0
- **Homepage**: http://qualimap.bioinfo.cipf.es/
- **Package**: https://anaconda.org/channels/bioconda/packages/qualimap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/qualimap/overview
- **Total Downloads**: 222.8K
- **Last updated**: 2026-02-24
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Java memory size is set to 1200M
Launching application...

QualiMap v.2.3
Built on 2023-05-19 16:57

Selected tool: bamqc

ERROR: Missing required option: bam

usage: qualimap bamqc -bam <arg> [-c] [-cl <arg>] [-dl <arg>] [-gd <arg>] [-gff
       <arg>] [-hm <arg>] [-ip] [-nr <arg>] [-nt <arg>] [-nw <arg>] [-oc <arg>]
       [-os] [-outdir <arg>] [-outfile <arg>] [-outformat <arg>] [-p <arg>]
       [-sd] [-sdmode <arg>]
 -bam <arg>                           Input mapping file in BAM format
 -c,--paint-chromosome-limits         Paint chromosome limits inside charts
 -cl,--cov-hist-lim <arg>             Upstream limit for targeted per-bin
                                      coverage histogram (default is 50X)
 -dl,--dup-rate-lim <arg>             Upstream limit for duplication rate
                                      historgram (default is 50)
 -gd,--genome-gc-distr <arg>          Species to compare with genome GC
                                      distribution. Possible values: HUMAN -
                                      hg19, hg38; MOUSE - mm9(default), mm10
 -gff,--feature-file <arg>            Feature file with regions of interest in
                                      GFF/GTF or BED format
 -hm <arg>                            Minimum size of a homopolymer to be
                                      considered in indel analysis (default is
                                      3)
 -ip,--collect-overlap-pairs          Activate this option to collect statistics
                                      of overlapping paired-end reads
 -nr <arg>                            Number of reads analyzed in a chunk
                                      (default is 1000)
 -nt <arg>                            Number of threads (default is 20)
 -nw <arg>                            Number of windows (default is 400)
 -oc,--output-genome-coverage <arg>   File to save per base non-zero coverage.
                                      Warning: large files are expected for
                                      large genomes
 -os,--outside-stats                  Report information for the regions outside
                                      those defined by feature-file  (ignored
                                      when -gff option is not set)
 -outdir <arg>                        Output folder for HTML report and raw
                                      data.
 -outfile <arg>                       Output file for PDF report (default value
                                      is report.pdf).
 -outformat <arg>                     Format of the output report (PDF, HTML or
                                      both PDF:HTML, default is HTML).
 -p,--sequencing-protocol <arg>       Sequencing library protocol:
                                      strand-specific-forward,
                                      strand-specific-reverse or
                                      non-strand-specific (default)
 -sd,--skip-duplicated                Activate this option to skip duplicated
                                      alignments from the analysis. If the
                                      duplicates are not flagged in the BAM
                                      file, then they will be detected by
                                      Qualimap and can be selected for skipping.
 -sdmode,--skip-dup-mode <arg>        Specific type of duplicated alignments to
                                      skip (if this option is activated).
                                      0 : only flagged duplicates (default)
                                      1 : only estimated by Qualimap
                                      2 : both flagged and estimated
```


## qualimap_rnaseq

### Tool Description
QualiMap v.2.3

### Metadata
- **Docker Image**: quay.io/biocontainers/qualimap:2.3--hdfd78af_0
- **Homepage**: http://qualimap.bioinfo.cipf.es/
- **Package**: https://anaconda.org/channels/bioconda/packages/qualimap/overview
- **Validation**: PASS

### Original Help Text
```text
Java memory size is set to 1200M
Launching application...

QualiMap v.2.3
Built on 2023-05-19 16:57

Selected tool: rnaseq

ERROR: Missing required options: bam, gtf

usage: qualimap rnaseq [-a <arg>] -bam <arg> -gtf <arg> [-npb <arg>] [-ntb
       <arg>] [-oc <arg>] [-outdir <arg>] [-outfile <arg>] [-outformat <arg>]
       [-p <arg>] [-pe] [-s]
 -a,--algorithm <arg>             Counting algorithm:
                                  uniquely-mapped-reads(default) or
                                  proportional.
 -bam <arg>                       Input mapping file in BAM format.
 -gtf <arg>                       Annotations file in Ensembl GTF format.
 -npb,--num-pr-bases <arg>        Number of upstream/downstream nucleotide bases
                                  to compute 5'-3' bias (default is 100).
 -ntb,--num-tr-bias <arg>         Number of top highly expressed transcripts to
                                  compute 5'-3' bias (default is 1000).
 -oc <arg>                        Output file for computed counts. If only name
                                  of the file is provided, then the file will be
                                  saved in the output folder.
 -outdir <arg>                    Output folder for HTML report and raw data.
 -outfile <arg>                   Output file for PDF report (default value is
                                  report.pdf).
 -outformat <arg>                 Format of the output report (PDF, HTML or both
                                  PDF:HTML, default is HTML).
 -p,--sequencing-protocol <arg>   Sequencing library protocol:
                                  strand-specific-forward,
                                  strand-specific-reverse or non-strand-specific
                                  (default)
 -pe,--paired                     Setting this flag for paired-end experiments
                                  will result in counting fragments instead of
                                  reads
 -s,--sorted                      This flag indicates that the input file is
                                  already sorted by name. If not set, additional
                                  sorting by name will be performed. Only
                                  required for paired-end analysis.
```


## qualimap_counts

### Tool Description
QualiMap v.2.3

### Metadata
- **Docker Image**: quay.io/biocontainers/qualimap:2.3--hdfd78af_0
- **Homepage**: http://qualimap.bioinfo.cipf.es/
- **Package**: https://anaconda.org/channels/bioconda/packages/qualimap/overview
- **Validation**: PASS

### Original Help Text
```text
Java memory size is set to 1200M
Launching application...

QualiMap v.2.3
Built on 2023-05-19 16:57

Selected tool: counts

ERROR: Missing required option: d

usage: qualimap counts [-c] -d <arg> [-i <arg>] [-k <arg>] [-outdir <arg>]
       [-outfile <arg>] [-outformat <arg>] [-R <arg>] [-s <arg>]
 -c,--compare             Perform comparison of conditions. Currently 2 maximum
                          is possible.
 -d,--data <arg>          File describing the input data. Format of the file is
                          a 4-column tab-delimited table.
                          Column 1: sample name
                          Column 2: condition of the sample
                          Column 3: path to the counts data for the sample
                          Column 4: index of the column with counts
 -i,--info <arg>          Path to info file containing genes GC-content, length
                          and type.
 -k,--threshold <arg>     Threshold for the number of counts
 -outdir <arg>            Output folder for HTML report and raw data.
 -outfile <arg>           Output file for PDF report (default value is
                          report.pdf).
 -outformat <arg>         Format of the output report (PDF, HTML or both
                          PDF:HTML, default is HTML).
 -R,--rscriptpath <arg>   Path to Rscript executable (by default it is assumed
                          to be available from system $PATH)
 -s,--species <arg>       Use built-in info file for the given species: HUMAN or
                          MOUSE.
```


## qualimap_multi-bamqc

### Tool Description
Multi-sample BAM quality control analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/qualimap:2.3--hdfd78af_0
- **Homepage**: http://qualimap.bioinfo.cipf.es/
- **Package**: https://anaconda.org/channels/bioconda/packages/qualimap/overview
- **Validation**: PASS

### Original Help Text
```text
Java memory size is set to 1200M
Launching application...

QualiMap v.2.3
Built on 2023-05-19 16:57

Selected tool: multi-bamqc

ERROR: Missing required option: d

usage: qualimap multi-bamqc [-c] -d <arg> [-gff <arg>] [-hm <arg>] [-nr <arg>]
       [-nw <arg>] [-outdir <arg>] [-outfile <arg>] [-outformat <arg>] [-p
       <arg>] [-r]
 -c,--paint-chromosome-limits     Only for -r mode. Paint chromosome limits
                                  inside charts
 -d,--data <arg>                  File describing the input data. Format of the
                                  file is a 2- or 3-column tab-delimited table.
                                  Column 1: sample name
                                  Column 2: either path to the BAM QC result or
                                  path to BAM file (-r mode)
                                  Column 3: group name (activates sample group
                                  marking)
 -gff,--feature-file <arg>        Only for -r mode. Feature file with regions of
                                  interest in GFF/GTF or BED format
 -hm <arg>                        Only for -r mode. Minimum size for a
                                  homopolymer to be considered in indel analysis
                                  (default is 3)
 -nr <arg>                        Only for -r mode. Number of reads analyzed in
                                  a chunk (default is 1000)
 -nw <arg>                        Only for -r mode. Number of windows (default
                                  is 400)
 -outdir <arg>                    Output folder for HTML report and raw data.
 -outfile <arg>                   Output file for PDF report (default value is
                                  report.pdf).
 -outformat <arg>                 Format of the output report (PDF, HTML or both
                                  PDF:HTML, default is HTML).
 -p,--sequencing-protocol <arg>   Only for -r mode. Sequencing library protocol:
                                  strand-specific-forward,
                                  strand-specific-reverse or non-strand-specific
                                  (default)
 -r,--run-bamqc                   Raw BAM files are provided as input. If this
                                  option is activated BAM QC process first will
                                  be run for each sample, then multi-sample
                                  analysis will be performed.
```


## qualimap_clustering

### Tool Description
QualiMap v.2.3

### Metadata
- **Docker Image**: quay.io/biocontainers/qualimap:2.3--hdfd78af_0
- **Homepage**: http://qualimap.bioinfo.cipf.es/
- **Package**: https://anaconda.org/channels/bioconda/packages/qualimap/overview
- **Validation**: PASS

### Original Help Text
```text
Java memory size is set to 1200M
Launching application...

QualiMap v.2.3
Built on 2023-05-19 16:57

Selected tool: clustering

ERROR: Missing required options: sample, control, regions

usage: qualimap clustering [-b <arg>] [-c <arg>] -control <arg> [-expr <arg>]
       [-f <arg>] [-l <arg>] [-name <arg>] [-outdir <arg>] [-outfile <arg>]
       [-outformat <arg>] [-R <arg>] [-r <arg>] -regions <arg> -sample <arg>
       [-viz <arg>]
 -b,--bin-size <arg>          Size of the bin (default is 100)
 -c,--clusters <arg>          Comma-separated list of cluster sizes
 -control <arg>               Comma-separated list of control BAM files
 -expr <arg>                  Name of the experiment
 -f,--fragment-length <arg>   Smoothing length of a fragment
 -l <arg>                     Upstream offset (default is 2000)
 -name <arg>                  Comma-separated names of the replicates
 -outdir <arg>                Output folder for HTML report and raw data.
 -outfile <arg>               Output file for PDF report (default value is
                              report.pdf).
 -outformat <arg>             Format of the output report (PDF, HTML or both
                              PDF:HTML, default is HTML).
 -R,--rscriptpath <arg>       Path to Rscript executable (by default it is
                              assumed to be available from system $PATH)
 -r <arg>                     Downstream offset (default is 500)
 -regions <arg>               Path to regions file
 -sample <arg>                Comma-separated list of sample BAM files
 -viz <arg>                   Visualization type: heatmap or line
```


## qualimap_comp-counts

### Tool Description
QualiMap v.2.3

### Metadata
- **Docker Image**: quay.io/biocontainers/qualimap:2.3--hdfd78af_0
- **Homepage**: http://qualimap.bioinfo.cipf.es/
- **Package**: https://anaconda.org/channels/bioconda/packages/qualimap/overview
- **Validation**: PASS

### Original Help Text
```text
Java memory size is set to 1200M
Launching application...

QualiMap v.2.3
Built on 2023-05-19 16:57

Selected tool: comp-counts

ERROR: Missing required options: bam, gtf

usage: qualimap comp-counts [-a <arg>] -bam <arg> -gtf <arg> [-id <arg>] [-out
       <arg>] [-p <arg>] [-pe] [-s] [-type <arg>]
 -a,--algorithm <arg>             Counting algorithm:
                                  uniquely-mapped-reads(default) or proportional
 -bam <arg>                       Mapping file in BAM format
 -gtf <arg>                       Region file in GTF, GFF or BED format. If GTF
                                  format is provided, counting is based on
                                  attributes, otherwise based on feature name
 -id <arg>                        GTF-specific. Attribute of the GTF to be used
                                  as feature ID. Regions with the same ID will
                                  be aggregated as part of the same feature.
                                  Default: gene_id.
 -out <arg>                       Output file of coverage report.
 -p,--sequencing-protocol <arg>   Sequencing library protocol:
                                  strand-specific-forward,
                                  strand-specific-reverse or non-strand-specific
                                  (default)
 -pe,--paired                     Setting this flag for paired-end experiments
                                  will result in counting fragments instead of
                                  reads
 -s,--sorted                      This flag indicates that the input file is
                                  already sorted by name. If not set, additional
                                  sorting by name will be performed. Only
                                  required for paired-end analysis.
 -type <arg>                      GTF-specific. Value of the third column of the
                                  GTF considered for counting. Other types will
                                  be ignored. Default: exon
```

