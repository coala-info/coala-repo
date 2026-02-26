# comet-ms CWL Generation Report

## comet-ms_comet

### Tool Description
Comet search engine for mass spectrometry data.

### Metadata
- **Docker Image**: quay.io/biocontainers/comet-ms:2024011--hb319eff_0
- **Homepage**: http://comet-ms.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/comet-ms/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/comet-ms/overview
- **Total Downloads**: 277.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Comet version "2024.01 rev. 1"
 (c) University of Washington

 Comet usage:  comet [options] <input_files>

 Supported input formats include mzXML, mzML, Thermo raw, mgf, and ms2 variants (cms2, bms2, ms2)

       options:  -p         to print out a comet.params.new file
                 -q         to print out a comet.params.new file with more parameter entries
                 -P<params> to specify an alternate parameters file (default comet.params)
                 -N<name>   to specify an alternate output base name; valid only with one input file
                 -D<dbase>  to specify a sequence database, overriding entry in parameters file
                 -F<num>    to specify the first/start scan to search, overriding entry in parameters file
                 -L<num>    to specify the last/end scan to search, overriding entry in parameters file
                            (-L option is required if -F option is used)
                 -i         create peptide index file only (specify .idx file as database for index search)

       example:  comet file1.mzXML file2.mzXML
            or   comet -F1000 -L1500 file1.mzXML    <- to search scans 1000 through 1500
            or   comet -PParams.txt *.mzXML         <- use parameters in the file 'Params.txt'
```

