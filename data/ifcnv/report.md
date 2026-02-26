# ifcnv CWL Generation Report

## ifcnv_ifCNV

### Tool Description
ifCNV

### Metadata
- **Docker Image**: quay.io/biocontainers/ifcnv:0.2.1--pyh5e36f6f_0
- **Homepage**: https://github.com/SimCab-CHU/ifCNV
- **Package**: https://anaconda.org/channels/bioconda/packages/ifcnv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ifcnv/overview
- **Total Downloads**: 2.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/SimCab-CHU/ifCNV
- **Stars**: N/A
### Original Help Text
```text
usage: ifCNV [-h] -i INPUT -b BED -o OUTPUT [-s SKIP] [-m MODE]
             [-rm READSMATRIXOUPTUT] [-min MINREADS] [-cs CONTASAMPLES]
             [-ct CONTATARGETS] [-sT SCORETHRESHOLD] [-rS REGSAMPLE]
             [-rT REGTARGETS] [-v VERBOSE] [-a AUTOOPEN] [-r RUN] [-sv SAVE]
             [-l LIB_RESSOURCES]

ifCNV

optional arguments:
  -h, --help            show this help message and exit
  -s SKIP, --skip SKIP  A path to the reads matrix
  -m MODE, --mode MODE  fast or extensive
  -rm READSMATRIXOUPTUT, --readsMatrixOuptut READSMATRIXOUPTUT
                        A path to a file to export the reads matrix as a .tsv
                        file
  -min MINREADS, --minReads MINREADS
                        Min mean reads per target
  -cs CONTASAMPLES, --contaSamples CONTASAMPLES
                        Contamination parameter for the AberrantSamples
                        function
  -ct CONTATARGETS, --contaTargets CONTATARGETS
                        Contamination parameter for the AberrantTargets
                        function
  -sT SCORETHRESHOLD, --scoreThreshold SCORETHRESHOLD
                        Threshold on the localisation score
  -rS REGSAMPLE, --regSample REGSAMPLE
                        A pattern for removing controls
  -rT REGTARGETS, --regTargets REGTARGETS
                        A pattern for removing targets
  -v VERBOSE, --verbose VERBOSE
                        A boolean
  -a AUTOOPEN, --autoOpen AUTOOPEN
                        A boolean
  -r RUN, --run RUN     The name of the experiment
  -sv SAVE, --save SAVE
                        A boolean, if True, saves the results in a .tsv file
  -l LIB_RESSOURCES, --lib-ressources LIB_RESSOURCES
                        Path where lib to import for report.

Mandatory:
  -i INPUT, --input INPUT
                        Path to the input bam folder
  -b BED, --bed BED     Path to the bed file
  -o OUTPUT, --output OUTPUT
                        Path to the output report
```

