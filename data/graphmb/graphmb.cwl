cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphmb
label: graphmb
doc: "Train graph embedding model\n\nTool homepage: https://github.com/MicrobialDarkMatter/GraphMB"
inputs:
  - id: activation
    type:
      - 'null'
      - string
    doc: Activation function to use(relu, prelu, sigmoid, tanh)
    inputBinding:
      position: 101
      prefix: --activation
  - id: ae_alpha
    type:
      - 'null'
      - float
    doc: Coeficient for AE loss
    inputBinding:
      position: 101
      prefix: --ae_alpha
  - id: ae_only
    type:
      - 'null'
      - boolean
    doc: Do not use GNN (ae model must be used and decoder input must be ae
    inputBinding:
      position: 101
      prefix: --ae_only
  - id: aggtype
    type:
      - 'null'
      - string
    doc: Aggregation type for GraphSAGE (mean, pool, lstm, gcn)
    inputBinding:
      position: 101
      prefix: --aggtype
  - id: assembly
    type:
      - 'null'
      - string
    doc: Assembly base path
    inputBinding:
      position: 101
      prefix: --assembly
  - id: assembly_name
    type:
      - 'null'
      - string
    doc: File name with contigs
    inputBinding:
      position: 101
      prefix: --assembly_name
  - id: assembly_type
    type:
      - 'null'
      - string
    doc: flye or spades
    inputBinding:
      position: 101
      prefix: --assembly_type
  - id: batchsize
    type:
      - 'null'
      - int
    doc: batchsize to train the VAE
    inputBinding:
      position: 101
      prefix: --batchsize
  - id: batchtype
    type:
      - 'null'
      - string
    doc: Batch type, nodes or edges
    inputBinding:
      position: 101
      prefix: --batchtype
  - id: binarize
    type:
      - 'null'
      - boolean
    doc: Binarize adj matrix
    inputBinding:
      position: 101
      prefix: --binarize
  - id: classify
    type:
      - 'null'
      - boolean
    doc: Run classification instead of clustering
    inputBinding:
      position: 101
      prefix: --classify
  - id: clusteringalgo
    type:
      - 'null'
      - string
    doc: 'clustering algorithm: vamb, kmeans'
    inputBinding:
      position: 101
      prefix: --clusteringalgo
  - id: clusteringloss
    type:
      - 'null'
      - boolean
    doc: Train with clustering loss
    inputBinding:
      position: 101
      prefix: --clusteringloss
  - id: concatfeatures
    type:
      - 'null'
      - boolean
    doc: Concat learned and original features before clustering
    inputBinding:
      position: 101
      prefix: --concatfeatures
  - id: contignodes
    type:
      - 'null'
      - boolean
    doc: Use contigs as nodes instead of edges
    inputBinding:
      position: 101
      prefix: --contignodes
  - id: cuda
    type:
      - 'null'
      - boolean
    doc: Use gpu
    inputBinding:
      position: 101
      prefix: --cuda
  - id: decoder_input
    type:
      - 'null'
      - string
    doc: What to use for input to the decoder
    inputBinding:
      position: 101
      prefix: --decoder_input
  - id: depth
    type:
      - 'null'
      - File
    doc: Depth file from jgi
    inputBinding:
      position: 101
      prefix: --depth
  - id: dropout_gnn
    type:
      - 'null'
      - float
    doc: dropout of the GNN
    inputBinding:
      position: 101
      prefix: --dropout_gnn
  - id: dropout_vae
    type:
      - 'null'
      - float
    doc: dropout of the VAE
    inputBinding:
      position: 101
      prefix: --dropout_vae
  - id: early_stopping
    type:
      - 'null'
      - float
    doc: Stop training if delta between last two losses is less than this
    inputBinding:
      position: 101
      prefix: --early_stopping
  - id: edge_threshold
    type:
      - 'null'
      - float
    doc: Remove edges with weight lower than this (keep only >=)
    inputBinding:
      position: 101
      prefix: --edge_threshold
  - id: embs
    type:
      - 'null'
      - File
    doc: No train, load embs
    inputBinding:
      position: 101
      prefix: --embs
  - id: embsize_gnn
    type:
      - 'null'
      - int
    doc: Output embedding dimension of GNN
    inputBinding:
      position: 101
      prefix: --embsize_gnn
  - id: embsize_vae
    type:
      - 'null'
      - int
    doc: Output embedding dimension of VAE
    inputBinding:
      position: 101
      prefix: --embsize_vae
  - id: epoch
    type:
      - 'null'
      - int
    doc: Number of epochs to train model
    inputBinding:
      position: 101
      prefix: --epoch
  - id: eval_split
    type:
      - 'null'
      - float
    doc: Percentage of dataset to use for eval
    inputBinding:
      position: 101
      prefix: --eval_split
  - id: evalepochs
    type:
      - 'null'
      - int
    doc: Epoch interval to run eval
    inputBinding:
      position: 101
      prefix: --evalepochs
  - id: evalskip
    type:
      - 'null'
      - int
    doc: Skip eval of these epochs
    inputBinding:
      position: 101
      prefix: --evalskip
  - id: fanout
    type:
      - 'null'
      - int
    doc: Fan out, number of positive neighbors sampled at each level
    inputBinding:
      position: 101
      prefix: --fanout
  - id: features
    type:
      - 'null'
      - File
    doc: Features file mapping contig name to features
    inputBinding:
      position: 101
      prefix: --features
  - id: graph_alpha
    type:
      - 'null'
      - float
    doc: Coeficient for graph loss
    inputBinding:
      position: 101
      prefix: --graph_alpha
  - id: graph_file
    type:
      - 'null'
      - File
    doc: File name with graph
    inputBinding:
      position: 101
      prefix: --graph_file
  - id: hidden_gnn
    type:
      - 'null'
      - int
    doc: Dimension of hidden layers of GNN
    inputBinding:
      position: 101
      prefix: --hidden_gnn
  - id: hidden_vae
    type:
      - 'null'
      - int
    doc: Dimension of hidden layers of VAE
    inputBinding:
      position: 101
      prefix: --hidden_vae
  - id: kclusters
    type:
      - 'null'
      - int
    doc: Number of clusters (only for some clustering methods)
    inputBinding:
      position: 101
      prefix: --kclusters
  - id: kld_alpha
    type:
      - 'null'
      - float
    doc: Coeficient for KLD loss
    inputBinding:
      position: 101
      prefix: --kld_alpha
  - id: kmer
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --kmer
  - id: l
    type:
      - 'null'
      - string
    doc: Log level
    inputBinding:
      position: 101
      prefix: --loglevel
  - id: labelgraph
    type:
      - 'null'
      - boolean
    doc: Create graph based on labels (ignore assembly graph)
    inputBinding:
      position: 101
      prefix: --labelgraph
  - id: labels
    type:
      - 'null'
      - File
    doc: File mapping contig to label
    inputBinding:
      position: 101
      prefix: --labels
  - id: layers_gnn
    type:
      - 'null'
      - int
    doc: Number of layers of the GNN
    inputBinding:
      position: 101
      prefix: --layers_gnn
  - id: layers_vae
    type:
      - 'null'
      - int
    doc: Number of layers of the VAE
    inputBinding:
      position: 101
      prefix: --layers_vae
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Log level
    inputBinding:
      position: 101
      prefix: --loglevel
  - id: lr_gnn
    type:
      - 'null'
      - float
    doc: learning rate
    inputBinding:
      position: 101
      prefix: --lr_gnn
  - id: lr_vae
    type:
      - 'null'
      - float
    doc: learning rate
    inputBinding:
      position: 101
      prefix: --lr_vae
  - id: markers
    type:
      - 'null'
      - File
    doc: File with precomputed checkm results to eval. If not found, it will 
      assume it does not exist.
    inputBinding:
      position: 101
      prefix: --markers
  - id: minbin
    type:
      - 'null'
      - int
    doc: Minimum size of clusters in bp
    inputBinding:
      position: 101
      prefix: --minbin
  - id: mincomp
    type:
      - 'null'
      - int
    doc: Minimum size of connected components
    inputBinding:
      position: 101
      prefix: --mincomp
  - id: mincontig
    type:
      - 'null'
      - int
    doc: Minimum size of input contigs
    inputBinding:
      position: 101
      prefix: --mincontig
  - id: model_name
    type:
      - 'null'
      - string
    doc: 'One of the implemented models: gcn, gat, sage, sage_lstm, _ccvae variation'
    inputBinding:
      position: 101
      prefix: --model_name
  - id: negatives
    type:
      - 'null'
      - int
    doc: Number of negatives to train GraphSAGE
    inputBinding:
      position: 101
      prefix: --negatives
  - id: no_loss_weights
    type:
      - 'null'
      - boolean
    doc: Using edge weights for loss (positive only)
    inputBinding:
      position: 101
      prefix: --no_loss_weights
  - id: no_sample_weights
    type:
      - 'null'
      - boolean
    doc: Using edge weights to sample negatives
    inputBinding:
      position: 101
      prefix: --no_sample_weights
  - id: noedges
    type:
      - 'null'
      - boolean
    doc: Remove all but self edges from adj matrix
    inputBinding:
      position: 101
      prefix: --noedges
  - id: noise
    type:
      - 'null'
      - boolean
    doc: Use noise generator
    inputBinding:
      position: 101
      prefix: --noise
  - id: nruns
    type:
      - 'null'
      - int
    doc: Number of runs
    inputBinding:
      position: 101
      prefix: --nruns
  - id: numcores
    type:
      - 'null'
      - int
    doc: Number of cores to use
    inputBinding:
      position: 101
      prefix: --numcores
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output dir (same as input assembly dir if not defined
    inputBinding:
      position: 101
      prefix: --outdir
  - id: outname
    type:
      - 'null'
      - string
    doc: Output (experiment) name
    inputBinding:
      position: 101
      prefix: --outname
  - id: outputdir
    type:
      - 'null'
      - Directory
    doc: Output dir (same as input assembly dir if not defined
    inputBinding:
      position: 101
      prefix: --outputdir
  - id: outputname
    type:
      - 'null'
      - string
    doc: Output (experiment) name
    inputBinding:
      position: 101
      prefix: --outputname
  - id: post
    type:
      - 'null'
      - string
    doc: Output options
    inputBinding:
      position: 101
      prefix: --post
  - id: print
    type:
      - 'null'
      - int
    doc: Print interval during training
    inputBinding:
      position: 101
      prefix: --print
  - id: quick
    type:
      - 'null'
      - boolean
    doc: Reduce number of nodes to run quicker
    inputBinding:
      position: 101
      prefix: --quick
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not output epoch progress
    inputBinding:
      position: 101
      prefix: --quiet
  - id: randomize
    type:
      - 'null'
      - boolean
    doc: Randomize graph
    inputBinding:
      position: 101
      prefix: --randomize
  - id: rawfeatures
    type:
      - 'null'
      - boolean
    doc: Use raw features
    inputBinding:
      position: 101
      prefix: --rawfeatures
  - id: read_cache
    type:
      - 'null'
      - boolean
    doc: Do not check assembly files, read cached files only
    inputBinding:
      position: 101
      prefix: --read_cache
  - id: read_embs
    type:
      - 'null'
      - boolean
    doc: Read embeddings from file
    inputBinding:
      position: 101
      prefix: --read_embs
  - id: reload
    type:
      - 'null'
      - boolean
    doc: Reload data
    inputBinding:
      position: 101
      prefix: --reload
  - id: savemodel
    type:
      - 'null'
      - boolean
    doc: Save best model to disk
    inputBinding:
      position: 101
      prefix: --savemodel
  - id: scg_alpha
    type:
      - 'null'
      - float
    doc: Coeficient for SCG loss
    inputBinding:
      position: 101
      prefix: --scg_alpha
  - id: seed
    type:
      - 'null'
      - int
    doc: Set seed
    inputBinding:
      position: 101
      prefix: --seed
  - id: skip_preclustering
    type:
      - 'null'
      - boolean
    doc: Use precomputed checkm results to eval
    inputBinding:
      position: 101
      prefix: --skip_preclustering
  - id: targetmetric
    type:
      - 'null'
      - string
    doc: Metric to pick best epoch
    inputBinding:
      position: 101
      prefix: --targetmetric
  - id: tsne
    type:
      - 'null'
      - boolean
    doc: Plot tsne at checkpoints
    inputBinding:
      position: 101
      prefix: --tsne
  - id: vaepretrain
    type:
      - 'null'
      - int
    doc: How many epochs to pretrain VAE
    inputBinding:
      position: 101
      prefix: --vaepretrain
  - id: writebins
    type:
      - 'null'
      - boolean
    doc: Write bins to fasta files
    inputBinding:
      position: 101
      prefix: --writebins
  - id: zg
    type:
      - 'null'
      - int
    doc: Output embedding dimension of GNN
    inputBinding:
      position: 101
      prefix: --zg
  - id: zl
    type:
      - 'null'
      - int
    doc: Output embedding dimension of VAE
    inputBinding:
      position: 101
      prefix: --zl
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphmb:0.2.5--pyh7cba7a3_0
stdout: graphmb.out
