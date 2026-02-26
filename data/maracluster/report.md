# maracluster CWL Generation Report

## maracluster_batch

### Tool Description
MaRaCluster version 1.02.1, Build Date Aug 11 2022 12:04:26
Copyright (c) 2015-19 Matthew The. All rights reserved.
Written by Matthew The (matthewt@kth.se) in the
School of Biotechnology at the Royal Institute of Technology in Stockholm.

### Metadata
- **Docker Image**: biocontainers/maracluster:1.02.1_cv1
- **Homepage**: https://github.com/statisticalbiotechnology/maracluster
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/maracluster/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/statisticalbiotechnology/maracluster
- **Stars**: N/A
### Original Help Text
```text
MaRaCluster version 1.02.1, Build Date Aug 11 2022 12:04:26
Copyright (c) 2015-19 Matthew The. All rights reserved.
Written by Matthew The (matthewt@kth.se) in the
School of Biotechnology at the Royal Institute of Technology in Stockholm.

Usage:
  maracluster batch -b <msfile_list> [-f <output_folder>]
    where msfile_list is a flat text file with absolute paths
    to the spectrum files to be clustered, one on each line.


Options:
 -h
 --help                         Display this message
 -b <filename>
 --batch <filename>             File with spectrum files to be processed in 
                                batch, one per line. Files should be readable by 
                                ProteoWizard (e.g. ms2, mgf, mzML).
 -f <path>
 --output-folder <path>         Writable folder for output files (default: 
                                ./maracluster_output).
 -p <string>
 --precursorTolerance <string>  Set precursor tolerance in units of ppm or Da. 
                                The units have to be "Da" or "ppm", case 
                                sensitive; if no unit is specified ppm is 
                                assumed (default: 20.0ppm).
 -t <double>
 --pvalThreshold <double>       Set log(p-value) threshold (default: -5.0).
 -c <string>
 --clusterThresholds <string>   Clustering thresholds at which to produce 
                                cluster files; listed as a comma separated list 
                                (default: -30.0,-25.0,-20.0,-15.0,-10.0,-5.0)
 -v <int>
 --verbatim <int>               Set the verbatim level (lowest: 0, highest: 5, 
                                default: 3).
 -a <name>
 --prefix <name>                Output files will be prefixed as e.g. 
                                <prefix>.clusters_p10.tsv (default: 
                                'MaRaCluster')
 -l <filename>
 --clusterFile <filename>       Input file for generating consensus spectra 
                                containing filepaths and scan numbers, separated 
                                by tabs.
 -o <filename>
 --specOut <filename>           Output file for the consensus spectra. Can be in 
                                any format supported by ProteoWizard (e.g. ms2, 
                                mzML).
 -M <int>
 --minClusterSize <int>         Set the minimum size for a cluster for producing 
                                consensus spectra (default: 1).
 -S
 --splitMassChargeStates        Split mass charge states in spectrum output file 
                                into separate spectrum copies with the same peak 
                                list, as some formats (e.g. mgf) and software 
                                packages (e.g. MS-GF+) do not support multiple 
                                charge states for a single peak list (default: 
                                auto-detect from output file format).
 -i <filename>
 --specIn <filename>            Input file readable by ProteoWizard (e.g. ms2, 
                                mzML). For multiple input files use the 
                                -b/--batch option instead.
 -y <filename>
 --pvalueVecFile <filename>     Input file with pvalue vectors
 -r <filename>
 --pvecOut <filename>           Output file basename for p-values vectors.
 -w <filename>
 --overlapBatch <filename>      File with 2 tab separated columns as: tail_file 
                                <tab> head_file for which overlapping p-values 
                                should be calculated
 -W <filename>
 --overlapBatchIdx <filename>   Index of overlap to process, requires 
                                -j/--datFNfile to be specified.
 -q <filename>
 --pvalOut <filename>           File where p-values will be written to.
 -d <filename>
 --percOut <filename>           Tab delimited percolator output file containing 
                                peptides and qvalues. This is meant for 
                                annotation of the clusterfile.
 -g <filename>
 --peakCountsFN <filename>      File to write/read peak counts binary file
 -s <filename>
 --scanInfoFN <filename>        File to write/read scan number list binary file
 -j <filename>
 --datFNfile <filename>         File with a list of binary spectrum files, one 
                                per line
 -m <filename>
 --clusteringMatrix <filename>  File containing the pvalue distance matrix input 
                                used for clustering in binary format.
 -u <filename>
 --clusteringTree <filename>    File containing the clustering tree result as a 
                                list of merged scannrs with corresponding p 
                                value.
 -e
 --skipFilterAndSort            Skips filtering and sorting of the input matrix, 
                                only use if the input is a filtered and sorted 
                                binary list p-values.
 -C <int>
 --chargeUncertainty <int>      Set charge uncertainty, i.e. if set to 1, then 
                                for a spectrum with precursor ion charge C, also 
                                precursor ion charges C-1 and C+1 are considered 
                                (default: 0).
 -z <filename>
 --lib <filename>               File readable by ProteoWizard (e.g. ms2, mzML) 
                                with spectral library
```

