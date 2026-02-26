# scar CWL Generation Report

## scar

### Tool Description
scAR (single-cell Ambient Remover) is a deep learning model for removal of the ambient signals in droplet-based single cell omics

### Metadata
- **Docker Image**: quay.io/biocontainers/scar:0.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/Novartis/scAR
- **Package**: https://anaconda.org/channels/bioconda/packages/scar/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scar/overview
- **Total Downloads**: 24.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Novartis/scAR
- **Stars**: N/A
### Original Help Text
```text
usage: scar [-h] [--version] [-ap AMBIENT_PROFILE] [-ft FEATURE_TYPE]
            [-o OUTPUT] [-m COUNT_MODEL] [-sp SPARSITY] [-bk BATCHKEY]
            [-cache CACHECAPACITY] [-gnf GET_NATIVE_FREQUENCIES]
            [-hl1 HIDDEN_LAYER1] [-hl2 HIDDEN_LAYER2] [-ls LATENT_DIM]
            [-epo EPOCHS] [-d DEVICE] [-s SAVE_MODEL] [-batchsize BATCHSIZE]
            [-batchsize_infer BATCHSIZE_INFER] [-adjust ADJUST]
            [-cutoff CUTOFF] [-round2int ROUND2INT] [-clip_to_obs CLIP_TO_OBS]
            [-moi MOI] [-verbose VERBOSE]
            count_matrix [count_matrix ...]

scAR (single-cell Ambient Remover) is a deep learning model for removal of the ambient signals in droplet-based single cell omics

positional arguments:
  count_matrix          The file of raw count matrix, 2D array (cells x genes) or the path of a filtered_feature_bc_matrix.h5

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -ap AMBIENT_PROFILE, --ambient_profile AMBIENT_PROFILE
                        The file of empty profile obtained from empty droplets, 1D array
  -ft FEATURE_TYPE, --feature_type FEATURE_TYPE
                        The feature types, e.g. mRNA, sgRNA, ADT, tag, CMO and ATAC
  -o OUTPUT, --output OUTPUT
                        Output directory
  -m COUNT_MODEL, --count_model COUNT_MODEL
                        Count model
  -sp SPARSITY, --sparsity SPARSITY
                        The sparsity of expected native signals
  -bk BATCHKEY, --batchkey BATCHKEY
                        The batch key for batch correction
  -cache CACHECAPACITY, --cachecapacity CACHECAPACITY
                        The capacity of cache for batch correction
  -gnf GET_NATIVE_FREQUENCIES, --get_native_frequencies GET_NATIVE_FREQUENCIES
                        Whether to get native frequencies, 0 or 1, by default 0, not to get native frequencies
  -hl1 HIDDEN_LAYER1, --hidden_layer1 HIDDEN_LAYER1
                        Number of neurons in the first layer
  -hl2 HIDDEN_LAYER2, --hidden_layer2 HIDDEN_LAYER2
                        Number of neurons in the second layer
  -ls LATENT_DIM, --latent_dim LATENT_DIM
                        Dimension of latent space
  -epo EPOCHS, --epochs EPOCHS
                        Training epochs
  -d DEVICE, --device DEVICE
                        Device used for training, either 'auto', 'cpu', or 'cuda'
  -s SAVE_MODEL, --save_model SAVE_MODEL
                        Save the trained model
  -batchsize BATCHSIZE, --batchsize BATCHSIZE
                        Batch size for training, set a small value upon out of memory error
  -batchsize_infer BATCHSIZE_INFER, --batchsize_infer BATCHSIZE_INFER
                        Batch size for inference, set a small value upon out of memory error
  -adjust ADJUST, --adjust ADJUST
                        Only used  for calculating Bayesfactors to improve performance,  
                        
                                        | 'micro' -- adjust the estimated native counts per cell. Default.
                                        | 'global' -- adjust the estimated native counts globally.
                                        | False -- no adjustment, use the model-returned native counts.
  -cutoff CUTOFF, --cutoff CUTOFF
                        Cutoff for Bayesfactors. See [Ly2020]_
  -round2int ROUND2INT, --round2int ROUND2INT
                        Round the counts
  -clip_to_obs CLIP_TO_OBS, --clip_to_obs CLIP_TO_OBS
                        clip the predicted native counts by observed counts,             use it with caution, as it may lead to overestimation of overall noise.
  -moi MOI, --moi MOI   Multiplicity of Infection. If assigned, it will allow optimized thresholding,         which tests a series of cutoffs to find the best one based on distributions of infections under given moi.         See [Dixit2016]_ for details. Under development.
  -verbose VERBOSE, --verbose VERBOSE
                        Whether to print the logging messages
```


## Metadata
- **Skill**: generated
