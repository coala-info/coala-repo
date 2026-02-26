# rdp_classifier CWL Generation Report

## rdp_classifier

### Tool Description
Note this is the legacy command for one sample classification

### Metadata
- **Docker Image**: biocontainers/rdp-classifier:v2.10.2-4-deb_cv1
- **Homepage**: http://rdp.cme.msu.edu/
- **Package**: https://anaconda.org/channels/bioconda/packages/rdp_classifier/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rdp_classifier/overview
- **Total Downloads**: 13.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Command Error: outputFile must be specified
usage: ClassifierCmd [options] <samplefile>
Note this is the legacy command for one sample classification
 -f,--format <arg>           tab-delimited output format: [allrank|fixrank|biom|filterbyconf|db]. Default is allRank.
                             allrank: outputs the results for all ranks applied for each sequence: seqname, orientation,
                             taxon name, rank, conf, ...
                             fixrank: only outputs the results for fixed ranks in order: domain, phylum, class, order,
                             family, genus
                             biom: outputs rich dense biom format if OTU or metadata provided
                             filterbyconf: only outputs the results for major ranks as in fixrank, results below the
                             confidence cutoff were bin to a higher rank unclassified_node
                             db: outputs the seqname, trainset_no, tax_id, conf.
 -g,--gene <arg>             16srrna, fungallsu, fungalits_warcup, fungalits_unite. Default is 16srrna. This option can
                             be overwritten by -t option
 -o,--outputFile <arg>       tab-delimited text output file for classification assignment.
 -q,--queryFile              legacy option, no longer needed
 -t,--train_propfile <arg>   property file containing the mapping of the training files if not using the default. Note:
                             the training files and the property file should be in the same directory.
 -w,--minWords <arg>         minimum number of words for each bootstrap trial. Default(maximum) is 1/8 of the words of
                             each sequence. Minimum is 5
```

