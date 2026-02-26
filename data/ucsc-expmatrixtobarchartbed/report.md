# ucsc-expmatrixtobarchartbed CWL Generation Report

## ucsc-expmatrixtobarchartbed_expMatrixToBarchartBed

### Tool Description
Generate a barChart bed6+5 file from a matrix, meta data, and coordinates.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-expmatrixtobarchartbed:469--h664eb37_1
- **Homepage**: http://hgdownload.cse.ucsc.edu/admin/exe/
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-expmatrixtobarchartbed/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-expmatrixtobarchartbed/overview
- **Total Downloads**: 17.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
usage: expMatrixToBarchartBed [-h] [--autoSql AUTOSQL]
                              [--groupOrderFile GROUPORDERFILE] [--useMean]
                              [--verbose]
                              sampleFile matrixFile bedFile outputFile

Generate a barChart bed6+5 file from a matrix, meta data, and coordinates.

positional arguments:
  sampleFile            Two column no header, the first column is the samples
                        which should match the matrix, the second is the
                        grouping (cell type, tissue, etc)
  matrixFile            The input matrix file. The samples in the first row
                        should exactly match the ones in the sampleFile. The
                        labels (ex ENST*****) in the first column should
                        exactly match the ones in the bed file.
  bedFile               Bed6+1 format. File that maps the column labels from
                        the matrix to coordinates. Tab separated; chr, start
                        coord, end coord, label, score, strand, gene name. The
                        score column is ignored.
  outputFile            The output file, bed 6+5 format. See the schema in
                        kent/src/hg/lib/barChartBed.as.

options:
  -h, --help            show this help message and exit
  --autoSql AUTOSQL     Optional autoSql description of extra fields in the
                        input bed.
  --groupOrderFile GROUPORDERFILE
                        Optional file to define the group order, list the
                        groups in a single column in the order desired. The
                        default ordering is alphabetical.
  --useMean             Calculate the group values using mean rather than
                        median.
  --verbose             Show runtime messages.
```

