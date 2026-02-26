cwlVersion: v1.2
class: CommandLineTool
baseCommand: torchbiggraph_train
label: simba_pbg_torchbiggraph_train
doc: "Train a knowledge graph embedding model.\n\nTool homepage: https://github.com/pinellolab/simba_pbg"
inputs:
  - id: config
    type: File
    doc: Path to config file
    inputBinding:
      position: 1
  - id: config_background_io
    type:
      - 'null'
      - boolean
    doc: Whether to do load/save in a background process. DEPRECATED.
    inputBinding:
      position: 102
  - id: config_batch_size
    type:
      - 'null'
      - int
    doc: The number of edges per batch.
    inputBinding:
      position: 102
  - id: config_bias
    type:
      - 'null'
      - boolean
    doc: If enabled, withhold the first dimension of the embeddings from the 
      comparator and instead use it as a bias, adding back to the score. Makes 
      sense for logistic and softmax loss functions.
    inputBinding:
      position: 102
  - id: config_bucket_order
    type:
      - 'null'
      - string
    doc: The order in which to iterate over the buckets.
    inputBinding:
      position: 102
  - id: config_checkpoint_preservation_interval
    type:
      - 'null'
      - int
    doc: If set, every so many epochs a snapshot of the checkpoint will be 
      archived. The snapshot will be located inside a `epoch_{N}` sub-directory 
      of the checkpoint directory, and will contain symbolic links to the 
      original checkpoint files, which will not be cleaned-up as it would 
      normally happen.
    inputBinding:
      position: 102
  - id: config_comparator
    type:
      - 'null'
      - string
    doc: How the embeddings of the two sides of an edge (after having already 
      undergone some processing) are compared to each other to produce a score.
    inputBinding:
      position: 102
  - id: config_dimension
    type:
      - 'null'
      - int
    doc: The dimension of the real space the embedding live in.
    inputBinding:
      position: 102
  - id: config_disable_lhs_negs
    type:
      - 'null'
      - boolean
    doc: Disable negative sampling on the left-hand side.
    inputBinding:
      position: 102
  - id: config_disable_rhs_negs
    type:
      - 'null'
      - boolean
    doc: Disable negative sampling on the right-hand side.
    inputBinding:
      position: 102
  - id: config_distributed_init_method
    type:
      - 'null'
      - string
    doc: A URI defining how to synchronize all the workers of a distributed run.
      Must start with a scheme (e.g., file:// or tcp://) supported by PyTorch.
    inputBinding:
      position: 102
  - id: config_distributed_tree_init_order
    type:
      - 'null'
      - boolean
    doc: If enabled, then distributed training can occur on a bucket only if at 
      least one of its partitions was already trained on before in the same 
      round (or if one of its partitions is 0, for bootstrapping).
    inputBinding:
      position: 102
  - id: config_dynamic_relations
    type:
      - 'null'
      - boolean
    doc: If enabled, activates the dynamic relation mode, in which case, there 
      must be a single relation type in the config (whose parameters will apply 
      to all dynamic relations types) and there must be a file called 
      dynamic_rel_count.txt in the entity path that contains the number of 
      dynamic relations. In this mode, batches will contain edges of multiple 
      relation types and negatives will be sampled differently.
    inputBinding:
      position: 102
  - id: config_early_stopping
    type:
      - 'null'
      - boolean
    doc: Stop training when validation loss increases.
    inputBinding:
      position: 102
  - id: config_edge_paths
    type:
      - 'null'
      - type: array
        items: Directory
    doc: A list of paths to directories containing (partitioned) edgelists. 
      Typically a single path is provided.
    inputBinding:
      position: 102
  - id: config_entities
    type:
      - 'null'
      - string
    doc: The entity types. The ID with which they are referenced by the relation
      types is the key they have in this dict.
    inputBinding:
      position: 102
  - id: config_entity_path
    type:
      - 'null'
      - Directory
    doc: The path of the directory containing entity count files.
    inputBinding:
      position: 102
  - id: config_eval_fraction
    type:
      - 'null'
      - float
    doc: The fraction of edges withheld from training and used to track 
      evaluation metrics during training.
    inputBinding:
      position: 102
  - id: config_eval_num_batch_negs
    type:
      - 'null'
      - int
    doc: If set, overrides the number of negatives per positive edge sampled 
      from the batch during the evaluation steps that occur before and after 
      each training step.
    inputBinding:
      position: 102
  - id: config_eval_num_uniform_negs
    type:
      - 'null'
      - int
    doc: If set, overrides the number of uniformly-sampled negatives per 
      positive edge during the evaluation steps that occur before and after each
      training step.
    inputBinding:
      position: 102
  - id: config_global_emb
    type:
      - 'null'
      - boolean
    doc: If enabled, add to each embedding a vector that is common to all the 
      entities of a certain type. This vector is learned during training.
    inputBinding:
      position: 102
  - id: config_half_precision
    type:
      - 'null'
      - boolean
    doc: Use half-precision training (GPU ONLY)
    inputBinding:
      position: 102
  - id: config_hogwild_delay
    type:
      - 'null'
      - float
    doc: The number of seconds by which to delay the start of all "Hogwild!" 
      processes except the first one, on the first epoch.
    inputBinding:
      position: 102
  - id: config_init_path
    type:
      - 'null'
      - Directory
    doc: If set, it must be a path to a directory that contains initial values 
      for the embeddings of all the entities of some types.
    inputBinding:
      position: 102
  - id: config_init_scale
    type:
      - 'null'
      - float
    doc: If no initial embeddings are provided, they are generated by sampling 
      each dimension from a centered normal distribution having this standard 
      deviation. (For performance reasons, sampling isn't fully independent.)
    inputBinding:
      position: 102
  - id: config_loss_fn
    type:
      - 'null'
      - string
    doc: How the scores of positive edges and their corresponding negatives are 
      evaluated.
    inputBinding:
      position: 102
  - id: config_lr
    type:
      - 'null'
      - float
    doc: The learning rate for the optimizer.
    inputBinding:
      position: 102
  - id: config_margin
    type:
      - 'null'
      - float
    doc: When using ranking loss, this value controls the minimum separation 
      between positive and negative scores, below which a (linear) loss is 
      incured.
    inputBinding:
      position: 102
  - id: config_max_edges_per_chunk
    type:
      - 'null'
      - int
    doc: The maximum number of edges that each edge chunk should contain if the 
      number of edge chunks is left unspecified and has to be automatically 
      figured out. Each edge takes up at least 12 bytes (3 int64s), more if 
      using featurized entities.
    inputBinding:
      position: 102
  - id: config_max_norm
    type:
      - 'null'
      - float
    doc: If set, rescale the embeddings if their norm exceeds this value.
    inputBinding:
      position: 102
  - id: config_num_batch_negs
    type:
      - 'null'
      - int
    doc: The number of negatives sampled from the batch, per positive edge.
    inputBinding:
      position: 102
  - id: config_num_edge_chunks
    type:
      - 'null'
      - int
    doc: The number of equally-sized parts each bucket will be split into. 
      Training will first proceed over all the first chunks of all buckets, then
      over all the second chunks, and so on. A higher value allows better mixing
      of partitions, at the cost of more time spent on I/O. If unset, will be 
      automatically calculated so that no chunk has more than 
      max_edges_per_chunk edges.
    inputBinding:
      position: 102
  - id: config_num_epochs
    type:
      - 'null'
      - int
    doc: The number of times the training loop iterates over all the edges.
    inputBinding:
      position: 102
  - id: config_num_gpus
    type:
      - 'null'
      - int
    doc: 'Number of GPUs to use for GPU training. Experimental: Not yet supported.'
    inputBinding:
      position: 102
  - id: config_num_groups_for_partition_server
    type:
      - 'null'
      - int
    doc: Number of td.distributed 'groups' to use. Setting this to a value 
      around 16 typically increases communication bandwidth.
    inputBinding:
      position: 102
  - id: config_num_machines
    type:
      - 'null'
      - int
    doc: The number of machines for distributed training.
    inputBinding:
      position: 102
  - id: config_num_partition_servers
    type:
      - 'null'
      - int
    doc: If -1, use trainer as partition servers. If 0, don't use partition 
      servers (instead, swap partitions through disk). If >1, then that number 
      of partition servers must be started manually.
    inputBinding:
      position: 102
  - id: config_num_uniform_negs
    type:
      - 'null'
      - int
    doc: The number of negatives uniformly sampled from the currently active 
      partition, per positive edge.
    inputBinding:
      position: 102
  - id: config_regularization_coef
    type:
      - 'null'
      - float
    doc: coefficient by which the regularization loss is multiplied before being
      added to the data loss.
    inputBinding:
      position: 102
  - id: config_regularizer
    type:
      - 'null'
      - string
    doc: Type of regularization to be applied.
    inputBinding:
      position: 102
  - id: config_relation_lr
    type:
      - 'null'
      - float
    doc: If set, the learning rate for the optimizerfor relations. Otherwise, 
      `lr' is used.
    inputBinding:
      position: 102
  - id: config_relations
    type:
      - 'null'
      - string
    doc: The relation types. The ID with which they will be referenced in the 
      edge lists is their index in this list.
    inputBinding:
      position: 102
  - id: config_verbose
    type:
      - 'null'
      - int
    doc: The verbosity level of logging, currently 0 or 1.
    inputBinding:
      position: 102
  - id: config_wd
    type:
      - 'null'
      - float
    doc: Simple (unweighted) weight decay
    inputBinding:
      position: 102
  - id: config_wd_interval
    type:
      - 'null'
      - int
    doc: Interval to amortize weight decay
    inputBinding:
      position: 102
  - id: config_workers
    type:
      - 'null'
      - int
    doc: The number of worker processes for "Hogwild!" training. If not given, 
      set to CPU count.
    inputBinding:
      position: 102
  - id: entity_dimension
    type:
      - 'null'
      - int
    doc: Override the default dimension for this entity.
    inputBinding:
      position: 102
  - id: entity_featurized
    type:
      - 'null'
      - boolean
    doc: Whether the entities of this type are represented as sets of features.
    inputBinding:
      position: 102
  - id: entity_num_partitions
    type:
      - 'null'
      - int
    doc: Number of partitions for this entity type. Set to 1 if unpartitioned. 
      All other entity types must have the same number of partitions.
    inputBinding:
      position: 102
  - id: params
    type:
      - 'null'
      - type: array
        items: string
    doc: Config parameters
    inputBinding:
      position: 102
      prefix: --param
  - id: rank
    type:
      - 'null'
      - int
    doc: For multi-machine, this machine's rank
    inputBinding:
      position: 102
      prefix: --rank
  - id: relation_all_negs
    type:
      - 'null'
      - boolean
    doc: If enabled, the negatives for (x, r, y) will consist of (x, r, y') for 
      all entities y' of the same type and in the same partition as y, and, 
      symmetrically, of (x', r, y) for all entities x' of the same type and in 
      the same partition as x.
    inputBinding:
      position: 102
  - id: relation_lhs
    type:
      - 'null'
      - string
    doc: The type of entities on the left-hand side of this relation, i.e., its 
      key in the entities dict.
    inputBinding:
      position: 102
  - id: relation_name
    type:
      - 'null'
      - string
    doc: A human-readable identifier for the relation type. Not needed for 
      training, only used for logging.
    inputBinding:
      position: 102
  - id: relation_operator
    type:
      - 'null'
      - string
    doc: The transformation to apply to the embedding of one of the sides of the
      edge (typically the right-hand one) before comparing it with the other 
      one.
    inputBinding:
      position: 102
  - id: relation_rhs
    type:
      - 'null'
      - string
    doc: The type of entities on the right-hand side of this relation, i.e., its
      key in the entities dict.
    inputBinding:
      position: 102
  - id: relation_weight
    type:
      - 'null'
      - float
    doc: The weight by which the loss induced by edges of this relation type 
      will be multiplied.
    inputBinding:
      position: 102
outputs:
  - id: config_checkpoint_path
    type:
      - 'null'
      - Directory
    doc: The path to the directory where checkpoints (and thus the output) will 
      be written to. If checkpoints are found in it, training will resume from 
      them.
    outputBinding:
      glob: $(inputs.config_checkpoint_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simba:1.2--pyh7cba7a3_0
