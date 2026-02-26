# dca CWL Generation Report

## dca

### Tool Description
Autoencoder

### Metadata
- **Docker Image**: quay.io/biocontainers/dca:0.3.4--pyhdfd78af_0
- **Homepage**: https://github.com/theislab/dca
- **Package**: https://anaconda.org/channels/bioconda/packages/dca/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dca/overview
- **Total Downloads**: 39.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/theislab/dca
- **Stars**: N/A
### Original Help Text
```text
usage: dca [-h] [--normtype NORMTYPE] [-t] [--testsplit] [--type TYPE]
           [--threads THREADS] [-b BATCHSIZE] [--sizefactors]
           [--nosizefactors] [--norminput] [--nonorminput] [--loginput]
           [--nologinput] [-d DROPOUTRATE] [--batchnorm] [--nobatchnorm]
           [--l2 L2] [--l1 L1] [--l2enc L2ENC] [--l1enc L1ENC] [--ridge RIDGE]
           [--gradclip GRADCLIP] [--activation ACTIVATION]
           [--optimizer OPTIMIZER] [--init INIT] [-e EPOCHS]
           [--earlystop EARLYSTOP] [--reducelr REDUCELR] [-s HIDDENSIZE]
           [--inputdropout INPUTDROPOUT] [-r LEARNINGRATE] [--saveweights]
           [--no-saveweights] [--hyper] [--hypern HYPERN]
           [--hyperepoch HYPEREPOCH] [--debug] [--tensorboard] [--checkcounts]
           [--nocheckcounts] [--denoisesubset DENOISESUBSET]
           input outputdir

Autoencoder

positional arguments:
  input                 Input is raw count data in TSV/CSV or H5AD (anndata)
                        format. Row/col names are mandatory. Note that TSV/CSV
                        files must be in gene x cell layout where rows are
                        genes and cols are cells (scRNA-seq convention).Use
                        the -t/--transpose option if your count matrix in cell
                        x gene layout. H5AD files must be in cell x gene
                        format (stats and scanpy convention).
  outputdir             The path of the output directory

optional arguments:
  -h, --help            show this help message and exit
  --normtype NORMTYPE   Type of size factor estimation. Possible values:
                        deseq, zheng. (default: zheng)
  -t, --transpose       Transpose input matrix (default: False)
  --testsplit           Use one fold as a test set (default: False)
  --type TYPE           Type of autoencoder. Possible values: normal, poisson,
                        nb, nb-shared, nb-conddisp (default), nb-fork, zinb,
                        zinb-shared, zinb-conddisp( zinb-fork
  --threads THREADS     Number of threads for training (default is all cores)
  -b BATCHSIZE, --batchsize BATCHSIZE
                        Batch size (default:32)
  --sizefactors         Normalize means by library size (default: True)
  --nosizefactors       Do not normalize means by library size
  --norminput           Zero-mean normalize input (default: True)
  --nonorminput         Do not zero-mean normalize inputs
  --loginput            Log-transform input (default: True)
  --nologinput          Do not log-transform inputs
  -d DROPOUTRATE, --dropoutrate DROPOUTRATE
                        Dropout rate (default: 0)
  --batchnorm           Batchnorm (default: True)
  --nobatchnorm         Do not use batchnorm
  --l2 L2               L2 regularization coefficient (default: 0.0)
  --l1 L1               L1 regularization coefficient (default: 0.0)
  --l2enc L2ENC         Encoder-specific L2 regularization coefficient
                        (default: 0.0)
  --l1enc L1ENC         Encoder-specific L1 regularization coefficient
                        (default: 0.0)
  --ridge RIDGE         L2 regularization coefficient for dropout
                        probabilities (default: 0.0)
  --gradclip GRADCLIP   Clip grad values (default: 5.0)
  --activation ACTIVATION
                        Activation function of hidden units (default: relu)
  --optimizer OPTIMIZER
                        Optimization method (default: RMSprop)
  --init INIT           Initialization method for weights (default:
                        glorot_uniform)
  -e EPOCHS, --epochs EPOCHS
                        Max number of epochs to continue training in case of
                        no improvement on validation loss (default: 300)
  --earlystop EARLYSTOP
                        Number of epochs to stop training if no improvement in
                        loss occurs (default: 15)
  --reducelr REDUCELR   Number of epochs to reduce learning rate if no
                        improvement in loss occurs (default: 10)
  -s HIDDENSIZE, --hiddensize HIDDENSIZE
                        Size of hidden layers (default: 64,32,64)
  --inputdropout INPUTDROPOUT
                        Input layer dropout probability
  -r LEARNINGRATE, --learningrate LEARNINGRATE
                        Learning rate (default: 0.001)
  --saveweights         Save weights (default: False)
  --no-saveweights      Do not save weights
  --hyper               Optimizer hyperparameters (default: False)
  --hypern HYPERN       Number of samples drawn from hyperparameter
                        distributions during optimization. (default: 1000)
  --hyperepoch HYPEREPOCH
                        Number of epochs used in each hyperpar optimization
                        iteration. (default: 100)
  --debug               Enable debugging. Checks whether every term in loss
                        functions is finite. (default: False)
  --tensorboard         Use tensorboard for saving weight distributions and
                        visualization. (default: False)
  --checkcounts         Check if the expression matrix has raw (unnormalized)
                        counts (default: True)
  --nocheckcounts       Do not check if the expression matrix has raw
                        (unnormalized) counts
  --denoisesubset DENOISESUBSET
                        Perform denoising only for the subset of genes in the
                        given file. Gene names should be line separated.
```

