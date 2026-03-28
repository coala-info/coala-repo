# centroid_rna_package CWL Generation Report

## centroid_rna_package_centroid_fold

### Tool Description
CentroidFold v0.0.16 for predicting RNA secondary structures

### Metadata
- **Docker Image**: quay.io/biocontainers/centroid_rna_package:0.0.16--0
- **Homepage**: https://github.com/satoken/centroid-rna-package
- **Package**: https://anaconda.org/channels/bioconda/packages/centroid_rna_package/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/centroid_rna_package/overview
- **Total Downloads**: 10.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/satoken/centroid-rna-package
- **Stars**: N/A
### Original Help Text
```text
CentroidFold v0.0.16 for predicting RNA secondary structures
  (available engines: CONTRAfold, McCaskill, pfold, AUX)
Usage:
 centroid_fold [options] seq [bp_matrix ...]

Options:
  -h [ --help ]          show this message
  -e [ --engine ] arg    specify the inference engine (default: "McCaskill")
  -w [ --mixture ] arg   mixture weights of inference engines
  -g [ --gamma ] arg     weight of base pairs
  -t [ --threshold ] arg thereshold of base pairs (this option overwrites 
                         'gamma')
  --ea arg               compute (pseudo-)expected accuracy (pseudo if arg==0, 
                         sampling if arg>0; arg: # of sampling)
  --max-mcc arg          predict secondary structure by maximizing 
                         pseudo-expected MCC (arg: # of sampling)
  --mea                  run as an MEA estimator
  --noncanonical         allow non-canonical base-pairs
  -C [ --constraints ]   use structure constraints
  -o [ --output ] arg    specify filename to output predicted secondary 
                         structures. If empty, use the standard output.
  --posteriors arg       output base-pairing probability matrices which contain
                         base-pairing probabilities more than the given value.
  --oposteriors arg      specify filename to output base-pairing probability 
                         matrices. If empty, use the standard output.
  --postscript arg       draw predicted secondary structures with the 
                         postscript (PS) format
  --params arg           use the parameter file

Options for CONTRAfold model:
  -d [ --max-dist ] arg (=0) the maximum distance of base-pairs

Options for sampling:
  -s [ --sampling ] arg           specify the number of samples to be generated
                                  for each sequence
  -c [ --max-clusters ] arg (=10) the maximum number of clusters for the 
                                  stochastic sampling algorithm
  --seed arg (=0)                 specify the seed for the random number 
                                  generator (set this automatically if seed=0)
```


## centroid_rna_package_centroid_alifold

### Tool Description
CentroidAlifold v0.0.16 for predicting common RNA secondary structures

### Metadata
- **Docker Image**: quay.io/biocontainers/centroid_rna_package:0.0.16--0
- **Homepage**: https://github.com/satoken/centroid-rna-package
- **Package**: https://anaconda.org/channels/bioconda/packages/centroid_rna_package/overview
- **Validation**: PASS

### Original Help Text
```text
CentroidAlifold v0.0.16 for predicting common RNA secondary structures
  (available engines: CONTRAfold, McCaskill, Alifold, pfold, AUX)
Usage:
 centroid_alifold [options] seq [bp_matrix ...]

Options:
  -h [ --help ]           show this message
  -e [ --engine ] arg     specify the inference engine (default: "McCaskill & 
                          Alifold")
  -w [ --mixture ] arg    mixture weights of inference engines
  -g [ --gamma ] arg      weight of base pairs
  -t [ --threshold ] arg  thereshold of base pairs (this option overwrites 
                          'gamma')
  --ea arg                compute (pseudo-)expected accuracy (pseudo if arg==0,
                          sampling if arg>0; arg: # of sampling)
  --max-mcc arg           predict secondary structure by maximizing 
                          pseudo-expected MCC (arg: # of sampling)
  --mea                   run as an MEA estimator
  --noncanonical          allow non-canonical base-pairs
  -C [ --constraints ]    use structure constraints
  -o [ --output ] arg     specify filename to output predicted secondary 
                          structures. If empty, use the standard output.
  --posteriors arg        output base-pairing probability matrices which 
                          contain base-pairing probabilities more than the 
                          given value.
  --posteriors-output arg specify filename to output base-pairing probability 
                          matrices. If empty, use the standard output.
  --postscript arg        draw predicted secondary structures with the 
                          postscript (PS) format
  --params arg            use the parameter file

Options for CONTRAfold model:
  -d [ --max-dist ] arg (=0) the maximum distance of base-pairs

Options for sampling:
  -s [ --sampling ] arg           specify the number of samples to be generated
                                  for each sequence
  -c [ --max-clusters ] arg (=10) the maximum number of clusters for the 
                                  stochastic sampling algorithm
  --seed arg (=0)                 specify the seed for the random number 
                                  generator (set this automatically if seed=0)
```


## Metadata
- **Skill**: generated
