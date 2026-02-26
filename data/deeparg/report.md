# deeparg CWL Generation Report

## deeparg_predict

### Tool Description
Predicts antimicrobial resistance genes from sequence data.

### Metadata
- **Docker Image**: quay.io/biocontainers/deeparg:1.0.4--pyhdfd78af_0
- **Homepage**: https://bitbucket.org/gusphdproj/deeparg-ss/
- **Package**: https://anaconda.org/channels/bioconda/packages/deeparg/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deeparg/overview
- **Total Downloads**: 5.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: deeparg predict [-h] --model MODEL [-i INPUT_FILE] -o OUTPUT_FILE
                       [-d DATA_PATH] [--type TYPE] [--min-prob MIN_PROB]
                       [--arg-alignment-identity ARG_ALIGNMENT_IDENTITY]
                       [--arg-alignment-evalue ARG_ALIGNMENT_EVALUE]
                       [--arg-alignment-overlap ARG_ALIGNMENT_OVERLAP]
                       [--arg-num-alignments-per-entry ARG_NUM_ALIGNMENTS_PER_ENTRY]
                       [--model-version MODEL_VERSION]

optional arguments:
  -h, --help            show this help message and exit
  --model MODEL         Select model to use (short sequences for reads | long
                        sequences for genes) SS|LS [No default]
  -i INPUT_FILE, --input-file INPUT_FILE
                        Input file (Fasta input file)
  -o OUTPUT_FILE, --output-file OUTPUT_FILE
                        Output file where to store results
  -d DATA_PATH, --data-path DATA_PATH
                        Path where data was downloaded [see deeparg download-
                        data --help for details]
  --type TYPE           Molecular data type prot/nucl [Default: nucl]
  --min-prob MIN_PROB   Minimum probability cutoff [Default: 0.8]
  --arg-alignment-identity ARG_ALIGNMENT_IDENTITY
                        Identity cutoff for sequence alignment in percent
                        [Default: 50]
  --arg-alignment-evalue ARG_ALIGNMENT_EVALUE
                        Evalue cutoff [Default: 1e-10]
  --arg-alignment-overlap ARG_ALIGNMENT_OVERLAP
                        Alignment overlap cutoff between read and genes
                        [Default: 0.8]
  --arg-num-alignments-per-entry ARG_NUM_ALIGNMENTS_PER_ENTRY
                        Diamond, minimum number of alignments per entry
                        [Default: 1000]
  --model-version MODEL_VERSION
                        Model deepARG version [Default: v2]
```


## deeparg_download_data

### Tool Description
Download data for deeparg

### Metadata
- **Docker Image**: quay.io/biocontainers/deeparg:1.0.4--pyhdfd78af_0
- **Homepage**: https://bitbucket.org/gusphdproj/deeparg-ss/
- **Package**: https://anaconda.org/channels/bioconda/packages/deeparg/overview
- **Validation**: PASS

### Original Help Text
```text
WARNING (theano.configdefaults): g++ not detected ! Theano will be unable to execute optimized C-implementations (for both CPU and GPU) and will default to Python implementations. Performance will be severely degraded. To remove this warning, set Theano flags cxx to an empty string.
/usr/local/lib/python2.7/site-packages/theano/tensor/signal/downsample.py:6: UserWarning: downsample module has been moved to the theano.tensor.signal.pool module.
  "downsample module has been moved to the theano.tensor.signal.pool module.")
/usr/local/lib/python2.7/site-packages/sklearn/cross_validation.py:41: DeprecationWarning: This module was deprecated in version 0.18 in favor of the model_selection module into which all the refactored classes and functions are moved. Also note that the interface of the new CV iterators are different from that of this module. This module will be removed in 0.20.
  "This module will be removed in 0.20.", DeprecationWarning)
usage: deeparg download_data [-h] [-o OUTPUT_PATH]
deeparg download_data: error: argument -h/--help: ignored explicit argument 'elp'
```


## deeparg_short_reads_pipeline

### Tool Description
Pipeline for short reads to predict ARGs and 16S rRNA genes.

### Metadata
- **Docker Image**: quay.io/biocontainers/deeparg:1.0.4--pyhdfd78af_0
- **Homepage**: https://bitbucket.org/gusphdproj/deeparg-ss/
- **Package**: https://anaconda.org/channels/bioconda/packages/deeparg/overview
- **Validation**: PASS

### Original Help Text
```text
usage: deeparg short_reads_pipeline [-h] --forward_pe_file FORWARD_PE_FILE
                                    --reverse_pe_file REVERSE_PE_FILE
                                    --output_file OUTPUT_FILE
                                    [-d DEEPARG_DATA_PATH]
                                    [--deeparg_identity DEEPARG_IDENTITY]
                                    [--deeparg_probability DEEPARG_PROBABILITY]
                                    [--deeparg_evalue DEEPARG_EVALUE]
                                    [--gene_coverage GENE_COVERAGE]
                                    [--bowtie_16s_identity BOWTIE_16S_IDENTITY]

optional arguments:
  -h, --help            show this help message and exit
  --forward_pe_file FORWARD_PE_FILE
                        forward mate from paired end library
  --reverse_pe_file REVERSE_PE_FILE
                        reverse mate from paired end library
  --output_file OUTPUT_FILE
                        save results to this file prefix
  -d DEEPARG_DATA_PATH, --deeparg_data_path DEEPARG_DATA_PATH
                        Path where data was downloaded [see deeparg download-
                        data --help for details]
  --deeparg_identity DEEPARG_IDENTITY
                        minimum identity for ARG alignments [default 80]
  --deeparg_probability DEEPARG_PROBABILITY
                        minimum probability for considering a reads as ARG-
                        like [default 0.8]
  --deeparg_evalue DEEPARG_EVALUE
                        minimum e-value for ARG alignments [default 1e-10]
  --gene_coverage GENE_COVERAGE
                        minimum coverage required for considering a full gene
                        in percentage. This parameter looks at the full gene
                        and all hits that align to the gene. If the overlap of
                        all hits is below the threshold the gene is discarded.
                        Use with caution [default 1]
  --bowtie_16s_identity BOWTIE_16S_IDENTITY
                        minimum identity a read as a 16s rRNA gene [default
                        0.8]
```


## Metadata
- **Skill**: generated
