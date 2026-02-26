# graphmb CWL Generation Report

## graphmb

### Tool Description
Train graph embedding model

### Metadata
- **Docker Image**: quay.io/biocontainers/graphmb:0.2.5--pyh7cba7a3_0
- **Homepage**: https://github.com/MicrobialDarkMatter/GraphMB
- **Package**: https://anaconda.org/channels/bioconda/packages/graphmb/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/graphmb/overview
- **Total Downloads**: 3.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/MicrobialDarkMatter/GraphMB
- **Stars**: N/A
### Original Help Text
```text
usage: graphmb [-h] [--assembly ASSEMBLY] [--assembly_name ASSEMBLY_NAME]
               [--graph_file GRAPH_FILE] [--edge_threshold EDGE_THRESHOLD]
               [--depth DEPTH] [--features FEATURES] [--labels LABELS]
               [--embs EMBS] [--model_name MODEL_NAME]
               [--activation ACTIVATION] [--layers_vae LAYERS_VAE]
               [--layers_gnn LAYERS_GNN] [--hidden_gnn HIDDEN_GNN]
               [--hidden_vae HIDDEN_VAE] [--embsize_gnn EMBSIZE_GNN]
               [--embsize_vae EMBSIZE_VAE] [--batchsize BATCHSIZE]
               [--batchtype BATCHTYPE] [--dropout_gnn DROPOUT_GNN]
               [--dropout_vae DROPOUT_VAE] [--lr_gnn LR_GNN] [--lr_vae LR_VAE]
               [--graph_alpha GRAPH_ALPHA] [--kld_alpha KLD_ALPHA]
               [--ae_alpha AE_ALPHA] [--scg_alpha SCG_ALPHA]
               [--clusteringalgo CLUSTERINGALGO] [--kclusters KCLUSTERS]
               [--aggtype AGGTYPE] [--decoder_input DECODER_INPUT]
               [--vaepretrain VAEPRETRAIN] [--ae_only] [--negatives NEGATIVES]
               [--quick] [--classify] [--fanout FANOUT] [--epoch EPOCH]
               [--print PRINT] [--evalepochs EVALEPOCHS] [--evalskip EVALSKIP]
               [--eval_split EVAL_SPLIT] [--kmer KMER] [--rawfeatures]
               [--clusteringloss] [--targetmetric TARGETMETRIC]
               [--concatfeatures] [--no_loss_weights] [--no_sample_weights]
               [--early_stopping EARLY_STOPPING] [--nruns NRUNS]
               [--mincontig MINCONTIG] [--minbin MINBIN] [--mincomp MINCOMP]
               [--randomize] [--labelgraph] [--binarize] [--noedges]
               [--read_embs] [--reload] [--markers MARKERS] [--post POST]
               [--writebins] [--skip_preclustering] [--outname OUTNAME]
               [--cuda] [--noise] [--savemodel] [--tsne] [--numcores NUMCORES]
               [--outdir OUTDIR] [--assembly_type ASSEMBLY_TYPE]
               [--contignodes] [--seed SEED] [--quiet] [--read_cache]
               [--version] [--loglevel LOGLEVEL]

Train graph embedding model

options:
  -h, --help            show this help message and exit
  --assembly ASSEMBLY   Assembly base path
  --assembly_name ASSEMBLY_NAME
                        File name with contigs
  --graph_file GRAPH_FILE
                        File name with graph
  --edge_threshold EDGE_THRESHOLD
                        Remove edges with weight lower than this (keep only
                        >=)
  --depth DEPTH         Depth file from jgi
  --features FEATURES   Features file mapping contig name to features
  --labels LABELS       File mapping contig to label
  --embs EMBS           No train, load embs
  --model_name MODEL_NAME
                        One of the implemented models: gcn, gat, sage,
                        sage_lstm, _ccvae variation
  --activation ACTIVATION
                        Activation function to use(relu, prelu, sigmoid, tanh)
  --layers_vae LAYERS_VAE
                        Number of layers of the VAE
  --layers_gnn LAYERS_GNN
                        Number of layers of the GNN
  --hidden_gnn HIDDEN_GNN
                        Dimension of hidden layers of GNN
  --hidden_vae HIDDEN_VAE
                        Dimension of hidden layers of VAE
  --embsize_gnn EMBSIZE_GNN, --zg EMBSIZE_GNN
                        Output embedding dimension of GNN
  --embsize_vae EMBSIZE_VAE, --zl EMBSIZE_VAE
                        Output embedding dimension of VAE
  --batchsize BATCHSIZE
                        batchsize to train the VAE
  --batchtype BATCHTYPE
                        Batch type, nodes or edges
  --dropout_gnn DROPOUT_GNN
                        dropout of the GNN
  --dropout_vae DROPOUT_VAE
                        dropout of the VAE
  --lr_gnn LR_GNN       learning rate
  --lr_vae LR_VAE       learning rate
  --graph_alpha GRAPH_ALPHA
                        Coeficient for graph loss
  --kld_alpha KLD_ALPHA
                        Coeficient for KLD loss
  --ae_alpha AE_ALPHA   Coeficient for AE loss
  --scg_alpha SCG_ALPHA
                        Coeficient for SCG loss
  --clusteringalgo CLUSTERINGALGO
                        clustering algorithm: vamb, kmeans
  --kclusters KCLUSTERS
                        Number of clusters (only for some clustering methods)
  --aggtype AGGTYPE     Aggregation type for GraphSAGE (mean, pool, lstm, gcn)
  --decoder_input DECODER_INPUT
                        What to use for input to the decoder
  --vaepretrain VAEPRETRAIN
                        How many epochs to pretrain VAE
  --ae_only             Do not use GNN (ae model must be used and decoder
                        input must be ae
  --negatives NEGATIVES
                        Number of negatives to train GraphSAGE
  --quick               Reduce number of nodes to run quicker
  --classify            Run classification instead of clustering
  --fanout FANOUT       Fan out, number of positive neighbors sampled at each
                        level
  --epoch EPOCH         Number of epochs to train model
  --print PRINT         Print interval during training
  --evalepochs EVALEPOCHS
                        Epoch interval to run eval
  --evalskip EVALSKIP   Skip eval of these epochs
  --eval_split EVAL_SPLIT
                        Percentage of dataset to use for eval
  --kmer KMER
  --rawfeatures         Use raw features
  --clusteringloss      Train with clustering loss
  --targetmetric TARGETMETRIC
                        Metric to pick best epoch
  --concatfeatures      Concat learned and original features before clustering
  --no_loss_weights     Using edge weights for loss (positive only)
  --no_sample_weights   Using edge weights to sample negatives
  --early_stopping EARLY_STOPPING
                        Stop training if delta between last two losses is less
                        than this
  --nruns NRUNS         Number of runs
  --mincontig MINCONTIG
                        Minimum size of input contigs
  --minbin MINBIN       Minimum size of clusters in bp
  --mincomp MINCOMP     Minimum size of connected components
  --randomize           Randomize graph
  --labelgraph          Create graph based on labels (ignore assembly graph)
  --binarize            Binarize adj matrix
  --noedges             Remove all but self edges from adj matrix
  --read_embs           Read embeddings from file
  --reload              Reload data
  --markers MARKERS     File with precomputed checkm results to eval. If not
                        found, it will assume it does not exist.
  --post POST           Output options
  --writebins           Write bins to fasta files
  --skip_preclustering  Use precomputed checkm results to eval
  --outname OUTNAME, --outputname OUTNAME
                        Output (experiment) name
  --cuda                Use gpu
  --noise               Use noise generator
  --savemodel           Save best model to disk
  --tsne                Plot tsne at checkpoints
  --numcores NUMCORES   Number of cores to use
  --outdir OUTDIR, --outputdir OUTDIR
                        Output dir (same as input assembly dir if not defined
  --assembly_type ASSEMBLY_TYPE
                        flye or spades
  --contignodes         Use contigs as nodes instead of edges
  --seed SEED           Set seed
  --quiet, -q           Do not output epoch progress
  --read_cache          Do not check assembly files, read cached files only
  --version, -v         Print version and exit
  --loglevel LOGLEVEL, -l LOGLEVEL
                        Log level
```

