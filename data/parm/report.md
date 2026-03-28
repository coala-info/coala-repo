# parm CWL Generation Report

## parm_train

### Tool Description
Promoter Activity Regulatory Model

### Metadata
- **Docker Image**: quay.io/biocontainers/parm:0.1.44--pyh7e72e81_0
- **Homepage**: https://github.com/vansteensellab/PARM
- **Package**: https://anaconda.org/channels/bioconda/packages/parm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/parm/overview
- **Total Downloads**: 4.1K
- **Last updated**: 2025-11-21
- **GitHub**: https://github.com/vansteensellab/PARM
- **Stars**: N/A
### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: parm train --input INPUT [INPUT ...]
                  --validation VALIDATION [VALIDATION ...] --output OUTPUT
                  --cell_type CELL_TYPE [--n_workers N_WORKERS]
                  [--n_epochs [N_EPOCHS]] [--batch_size [BATCH_SIZE]]
                  [--betas BETAS [BETAS ...]] [--lr [LR]]
                  [--cosine_scheduler [COSINE_SCHEDULER]]
                  [--weight_decay [WEIGHT_DECAY]]
                  [--adaptor ADAPTOR [ADAPTOR ...]] [--L_max [L_MAX]]
                  [--n_blocks N_BLOCKS] [--filter_size FILTER_SIZE]
                  [--initial_weights INITIAL_WEIGHTS] [-h] [--version]
                  [--check_cuda]

██████╗  █████╗ ██████╗ ███╗   ███╗
██╔══██╗██╔══██╗██╔══██╗████╗ ████║
██████╔╝███████║██████╔╝██╔████╔██║
██╔═══╝ ██╔══██║██╔══██╗██║╚██╔╝██║
██║     ██║  ██║██║  ██║██║ ╚═╝ ██║
╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝
 
 Promoter Activity Regulatory Model
 Version: 0.1.44
 

Required arguments:
  --input INPUT [INPUT ...]
                          Path to input files. This should be a pre-processed
                          MPRA data file. saved as a .h5 file. If you have
                          multiple files, you can pass them as a space-
                          separated list.
  --validation VALIDATION [VALIDATION ...]
                          Path to validation files. This should be a pre-
                          processed MPRA data file. saved as a .h5 file. If
                          you have multiple files
  --output OUTPUT         Path to the directory to store all the output files.
  --cell_type CELL_TYPE   The name of the cell type that you want to create a
                          model to. This should be the same name as in the
                          input h5 files

Advanced arguments (for model training):
  --n_workers N_WORKERS   How many subprocesses to use for data loading
                          (default: 0)
  --n_epochs [N_EPOCHS]   Number of epochs to train the data to (default: 7)
  --batch_size [BATCH_SIZE]
                          Number of samples in ech batch to train the data to
                          (default: 128)
  --betas BETAS [BETAS ...]
                          L1 and L2 regularization terms respectively.
                          (default: (0.005, 0.005) ) run like -betas 0.1 0.2
  --lr [LR]               Learning rate (default: 0.001)
  --cosine_scheduler [COSINE_SCHEDULER]
                          If True, implement a cosine schedueler for learning
                          rate. Otherwise, learning rate will be constant
                          after warmup. (default:True)
  --weight_decay [WEIGHT_DECAY]
                          Weight decay (default: 0.0)
  --adaptor ADAPTOR [ADAPTOR ...]
                          If not false, give adaptor in 5 and 3 prima to use
                          as padding. e.g. -adaptor CAGTGAT ACGACTG (default:
                          CAGTGAT ACGACTG)
  --L_max [L_MAX]         Maximum length of fragments. Necessary if we want to
                          downsample. (default: 600)
  --n_blocks N_BLOCKS     Number of convolution blocks. (default: 5)
  --filter_size FILTER_SIZE
                          Number of filters in convolution layers (default:
                          125)
  --initial_weights INITIAL_WEIGHTS
                          Path to initial weights file. If None, random
                          initialization is used. (default: None)

Other:
  -h, --help              Show this help message and exit
  --version               Show program's version number and exit
  --check_cuda            Check if CUDA is available and exit
```


## parm_predict

### Tool Description
Promoter Activity Regulatory Model

### Metadata
- **Docker Image**: quay.io/biocontainers/parm:0.1.44--pyh7e72e81_0
- **Homepage**: https://github.com/vansteensellab/PARM
- **Package**: https://anaconda.org/channels/bioconda/packages/parm/overview
- **Validation**: PASS

### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: parm predict --model MODEL --input INPUT --output OUTPUT
                    [--n_seqs_per_batch N_SEQS_PER_BATCH]
                    [--header_only | --no-header_only]
                    [--predict_test_fold | --no-predict_test_fold]
                    [--L_max L_MAX] [--filter_size FILTER_SIZE]
                    [--type_loss {MSE,poisson,heteroscedastic}] [-h]
                    [--version]

██████╗  █████╗ ██████╗ ███╗   ███╗
██╔══██╗██╔══██╗██╔══██╗████╗ ████║
██████╔╝███████║██████╔╝██╔████╔██║
██╔═══╝ ██╔══██║██╔══██╗██║╚██╔╝██║
██║     ██║  ██║██║  ██║██║ ╚═╝ ██║
╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝
 
 Promoter Activity Regulatory Model
 Version: 0.1.44
 

Required arguments:
  --model MODEL           Path to the directory of the model. If you want to
                          perform predictions for the pre-trained K562 model,
                          for instance, this should be
                          pre_trained_models/K562. If you have trained your
                          own model, you should pass the path to the directory
                          where the .parm files are stored.
  --input INPUT           Path to the input fasta file with the sequences to
                          be predicted.
  --output OUTPUT         Path to the output file where the predictions will
                          be saved. Output is a tab-separated file with the
                          sequence, header, and the predicted score.
  --n_seqs_per_batch N_SEQS_PER_BATCH
                          Number of sequences to predict simultaneously,
                          increase only if your memory allows it. (Default: 1)
  --header_only, --no-header_only
                          If this flag is set, the output file will not
                          contain the sequences of the input fasta. By
                          default, PARM shows both the sequence and the
                          header.

Advanced arguments (if you trained your own model):
  --predict_test_fold, --no-predict_test_fold
                          If this flag is set, PARM will assume the input is
                          the hdf5 file of the test fold of a trained model.
                          This is useful if you want to evaluate the
                          performance of a model that you trained. (default:
                          False)
  --L_max L_MAX           The maximum length of the sequences allowed by the
                          model. All pre-trained models have `--L_max 600`.
                          However, if you trained your own PARM model with a
                          different L_max value, you should specify it here.
                          (Default: 600)
  --filter_size FILTER_SIZE
                          The model size that torch expects (Default: 125)
  --type_loss {MSE,poisson,heteroscedastic}
                          Type of loss function to use for the model. Default
                          is "poisson". Other options are "MSE" and
                          "heteroscedastic".

Other:
  -h, --help              Show this help message and exit
  --version               Show program's version number and exit
```


## parm_mutagenesis

### Tool Description
Promoter Activity Regulatory Model

### Metadata
- **Docker Image**: quay.io/biocontainers/parm:0.1.44--pyh7e72e81_0
- **Homepage**: https://github.com/vansteensellab/PARM
- **Package**: https://anaconda.org/channels/bioconda/packages/parm/overview
- **Validation**: PASS

### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: parm mutagenesis --model MODEL --input INPUT --output OUTPUT
                        [--motif_database MOTIF_DATABASE] [--L_max L_MAX]
                        [--filter_size FILTER_SIZE] [-h] [--version]

██████╗  █████╗ ██████╗ ███╗   ███╗
██╔══██╗██╔══██╗██╔══██╗████╗ ████║
██████╔╝███████║██████╔╝██╔████╔██║
██╔═══╝ ██╔══██║██╔══██╗██║╚██╔╝██║
██║     ██║  ██║██║  ██║██║ ╚═╝ ██║
╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝
 
 Promoter Activity Regulatory Model
 Version: 0.1.44
 

Required arguments:
  --model MODEL           Path to the directory of the model. If you want to
                          perform predictions for the pre-trained K562 model,
                          for instance, this should be
                          pre_trained_models/K562. If you have trained your
                          own model, you should pass the path to the directory
                          where the .parm files are stored.
  --input INPUT           Path to the input fasta file with the sequences to
                          have to mutagenesis for.
  --output OUTPUT         Path to the directory where the files will be
                          stored. Will be created if it does not exist.

Optional arguments:
  --motif_database MOTIF_DATABASE
                          Path or url to the motif databae (JASPAR format).
                          Default is HOCOMOCOv11: https://hocomoco11.autosome.
                          org/final_bundle/hocomoco11/core/HUMAN/mono/HOCOMOCO
                          v11_core_HUMAN_mono_jaspar_format.txt

Advanced arguments (if you trained your own model):
  --L_max L_MAX           The maximum length of the sequences allowed by the
                          model. All pre-trained models have `--L_max 600`.
                          However, if you trained your own PARM model with a
                          different L_max value, you should specify it here.
                          (Default: 600)
  --filter_size FILTER_SIZE
                          The model size that torch expects (Default: 125)

Other:
  -h, --help              Show this help message and exit
  --version               Show program's version number and exit
```


## parm_plot

### Tool Description
Promoter Activity Regulatory Model

### Metadata
- **Docker Image**: quay.io/biocontainers/parm:0.1.44--pyh7e72e81_0
- **Homepage**: https://github.com/vansteensellab/PARM
- **Package**: https://anaconda.org/channels/bioconda/packages/parm/overview
- **Validation**: PASS

### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: parm plot --input INPUT [--output OUTPUT]
                 [--correlation_threshold CORRELATION_THRESHOLD]
                 [--attribution_threshold ATTRIBUTION_THRESHOLD]
                 [--min_relative_attribution MIN_RELATIVE_ATTRIBUTION]
                 [--attribution_range ATTRIBUTION_RANGE ATTRIBUTION_RANGE]
                 [--plot_format {pdf,svg,jpg,png}] [-h] [--version]

██████╗  █████╗ ██████╗ ███╗   ███╗
██╔══██╗██╔══██╗██╔══██╗████╗ ████║
██████╔╝███████║██████╔╝██╔████╔██║
██╔═══╝ ██╔══██║██╔══██╗██║╚██╔╝██║
██║     ██║  ██║██║  ██║██║ ╚═╝ ██║
╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝
 
 Promoter Activity Regulatory Model
 Version: 0.1.44
 

Required arguments:
  --input INPUT           Path to the directory containing the
                          `mutagenesis_[ID].txt.gz` and `hits_[ID].txt.gz`
                          files generated by PARM mutagenesis. PARM assumes
                          that the ID values are the same for each sequence,
                          otherwise an error will be raised.

Optional arguments:
  --output OUTPUT         Path to the directory where the files will be
                          stored. Default behaviour is to save the PDFs in the
                          same directory as the input data.
  --correlation_threshold CORRELATION_THRESHOLD
                          The minimum value of Pearson correlation that a
                          scanned motif needs to present in order to be shown
                          in the plot (Default: 0.75).
  --attribution_threshold ATTRIBUTION_THRESHOLD
                          The minimum value of attribution (i.e., the mean
                          attribution score for the bases of a motif) that a
                          scanned motif needs to present in order to be shown
                          in the plot (Default: 0.001).
  --min_relative_attribution MIN_RELATIVE_ATTRIBUTION
                          The minimum mean attribution threshold for motif to
                          be shown, expressed as a percentage of the maximum
                          letter attribution within any motif. i.e. only
                          motifs with mean attribution above this percentage
                          of the highest attributed letter will be shown.
                          (Default: 0.15).
  --attribution_range ATTRIBUTION_RANGE ATTRIBUTION_RANGE
                          Space-separated range of attribution values to be
                          shown in the plot. (like 0.001 0.01). If not
                          provided, the range will be calculated based on the
                          values present in the data.
  --plot_format {pdf,svg,jpg,png}
                          Which format should the plots be saved? Available
                          formats are pdf, svg, jpg, and png. (Default: pdf).

Other:
  -h, --help              Show this help message and exit
  --version               Show program's version number and exit
```


## Metadata
- **Skill**: generated
