# deepmicro CWL Generation Report

## deepmicro_DM.py

### Tool Description
DeepMicro: A deep learning framework for microbiome analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepmicro:1.4--pyhdfd78af_1
- **Homepage**: https://github.com/paulzierep/DeepMicro
- **Package**: https://anaconda.org/channels/bioconda/packages/deepmicro/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepmicro/overview
- **Total Downloads**: 5.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/paulzierep/DeepMicro
- **Stars**: N/A
### Original Help Text
```text
usage: DM.py [-h]
             [-d {abundance_Cirrhosis,abundance_Colorectal,abundance_IBD,abundance_Obesity,abundance_T2D,abundance_WT2D,marker_Cirrhosis,marker_Colorectal,marker_IBD,marker_Obesity,marker_T2D,marker_WT2D}]
             [-cd CUSTOM_DATA] [-cl CUSTOM_DATA_LABELS] [-p DATA_DIR]
             [-dt {float16,float32,float64}] [-s SEED] [-r REPEAT]
             [-f NUMFOLDS] [-m {all,svm,rf,mlp,svm_rf}] [-sc SVM_CACHE]
             [-t NUMJOBS] [--scoring {roc_auc,accuracy,f1,recall,precision}]
             [--pca] [--rp] [--ae] [--vae] [--cae] [--save_rep]
             [--load_rep LOAD_REP] [--aeloss {mse,binary_crossentropy}]
             [--ae_oact] [-a {relu,sigmoid}] [-dm DIMS] [-e MAX_EPOCHS]
             [-pt PATIENCE] [--ae_lact] [--vae_beta VAE_BETA] [--vae_warmup]
             [--vae_warmup_rate VAE_WARMUP_RATE] [--rf_rate RF_RATE]
             [--st_rate ST_RATE] [--no_trn] [--no_clf]

Loading data:
  -d {abundance_Cirrhosis,abundance_Colorectal,abundance_IBD,abundance_Obesity,abundance_T2D,abundance_WT2D,marker_Cirrhosis,marker_Colorectal,marker_IBD,marker_Obesity,marker_T2D,marker_WT2D}, --data {abundance_Cirrhosis,abundance_Colorectal,abundance_IBD,abundance_Obesity,abundance_T2D,abundance_WT2D,marker_Cirrhosis,marker_Colorectal,marker_IBD,marker_Obesity,marker_T2D,marker_WT2D}
                        prefix of dataset to open (e.g. abundance_Cirrhosis)
  -cd CUSTOM_DATA, --custom_data CUSTOM_DATA
                        filename for custom input data under the 'data' folder
  -cl CUSTOM_DATA_LABELS, --custom_data_labels CUSTOM_DATA_LABELS
                        filename for custom input labels under the 'data'
                        folder
  -p DATA_DIR, --data_dir DATA_DIR
                        custom path for both '/data' and '/results' folders
  -dt {float16,float32,float64}, --dataType {float16,float32,float64}
                        Specify data type for numerical values (float16,
                        float32, float64)

Experiment design:
  -s SEED, --seed SEED  random seed for train and test split
  -r REPEAT, --repeat REPEAT
                        repeat experiment x times by changing random seed for
                        splitting data

Classification:
  -f NUMFOLDS, --numFolds NUMFOLDS
                        The number of folds for cross-validation in the
                        tranining set
  -m {all,svm,rf,mlp,svm_rf}, --method {all,svm,rf,mlp,svm_rf}
                        classifier(s) to use
  -sc SVM_CACHE, --svm_cache SVM_CACHE
                        cache size for svm run
  -t NUMJOBS, --numJobs NUMJOBS
                        The number of jobs used in parallel GridSearch. (-1:
                        utilize all possible cores; -2: utilize all possible
                        cores except one.)

Representation learning:
  --pca                 run PCA
  --rp                  run Random Projection
  --ae                  run Autoencoder or Deep Autoencoder
  --vae                 run Variational Autoencoder
  --cae                 run Convolutional Autoencoder
  --save_rep            write the learned representation of the training set
                        as a file
  --load_rep LOAD_REP   load the learned representation of the training set as
                        a file

Common options for representation learning (SAE,DAE,VAE,CAE):
  --aeloss {mse,binary_crossentropy}
                        set autoencoder reconstruction loss function
  --ae_oact             output layer sigmoid activation function on/off
  -a {relu,sigmoid}, --act {relu,sigmoid}
                        activation function for hidden layers
  -dm DIMS, --dims DIMS
                        Comma-separated dimensions for deep representation
                        learning e.g. (-dm 50,30,20)
  -e MAX_EPOCHS, --max_epochs MAX_EPOCHS
                        Maximum epochs when training autoencoder
  -pt PATIENCE, --patience PATIENCE
                        The number of epochs which can be executed without the
                        improvement in validation loss, right after the last
                        improvement.

SAE & DAE-specific arguments:
  --ae_lact             latent layer activation function on/off

VAE-specific arguments:
  --vae_beta VAE_BETA   weight of KL term
  --vae_warmup          turn on warm up
  --vae_warmup_rate VAE_WARMUP_RATE
                        warm-up rate which will be multiplied by current epoch
                        to calculate current beta

CAE-specific arguments:
  --rf_rate RF_RATE     What percentage of input size will be the receptive
                        field (kernel) size? [0,1]
  --st_rate ST_RATE     What percentage of receptive field (kernel) size will
                        be the stride size? [0,1]

other optional arguments:
  --no_trn              stop before learning representation to see specified
                        autoencoder structure
  --no_clf              skip classification tasks
```

