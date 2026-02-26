cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnaprot_train
label: rnaprot_train
doc: "Model training\n\nTool homepage: https://github.com/BackofenLab/RNAProt"
inputs:
  - id: add_test
    type:
      - 'null'
      - boolean
    doc: "Use a part of the training set as a test set to\nevaluate final model. Test
      set size is controlled by\n--val-size"
    default: false
    inputBinding:
      position: 101
      prefix: --add-test
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Gradient descent batch size
    default: 50
    inputBinding:
      position: 101
      prefix: --batch-size
  - id: bohb_max_budget
    type:
      - 'null'
      - int
    doc: BOHB maximum budget
    default: 40
    inputBinding:
      position: 101
      prefix: --bohb-max-budget
  - id: bohb_min_budget
    type:
      - 'null'
      - int
    doc: BOHB minimum budget
    default: 5
    inputBinding:
      position: 101
      prefix: --bohb-min-budget
  - id: bohb_n
    type:
      - 'null'
      - int
    doc: Number of BOHB iterations
    default: 80
    inputBinding:
      position: 101
      prefix: --bohb-n
  - id: bohb_workers
    type:
      - 'null'
      - int
    doc: "Number of BOHB worker threads for local multi-core\nparallel computing"
    default: 1
    inputBinding:
      position: 101
      prefix: --bohb-workers
  - id: cv
    type:
      - 'null'
      - boolean
    doc: "Run cross validation in combination with set\nhyperparameters to evaluate
      model generalization\nperformance"
    default: false
    inputBinding:
      position: 101
      prefix: --cv
  - id: cv_k
    type:
      - 'null'
      - int
    doc: "Cross validation k for evaluating generalization\nperformance (use together
      with --cv)"
    default: 10
    inputBinding:
      position: 101
      prefix: --cv-k
  - id: dr
    type:
      - 'null'
      - float
    doc: Rate of dropout applied after RNN layers
    default: 0.5
    inputBinding:
      position: 101
      prefix: --dr
  - id: embed
    type:
      - 'null'
      - boolean
    doc: "Use embedding layer for sequence feature, instead of\none-hot encoding"
    default: false
    inputBinding:
      position: 101
      prefix: --embed
  - id: embed_dim
    type:
      - 'null'
      - int
    doc: Dimension of embedding layer
    default: 10
    inputBinding:
      position: 101
      prefix: --embed-dim
  - id: epochs
    type:
      - 'null'
      - int
    doc: Maximum number of training epochs
    default: 200
    inputBinding:
      position: 101
      prefix: --epochs
  - id: force_cpu
    type:
      - 'null'
      - boolean
    doc: Run on CPU regardless of CUDA available or not
    default: false
    inputBinding:
      position: 101
      prefix: --force-cpu
  - id: in_folder
    type: Directory
    doc: Input training data folder (output of rnaprot gt)
    inputBinding:
      position: 101
      prefix: --in
  - id: keep_order
    type:
      - 'null'
      - boolean
    doc: "Use same train-validation(-test) split for each call\nto train final model.
      Test split only if --add-test or\n--test-ids"
    default: false
    inputBinding:
      position: 101
      prefix: --keep-order
  - id: lr
    type:
      - 'null'
      - float
    doc: Learning rate of optimizer
    default: 0.001
    inputBinding:
      position: 101
      prefix: --lr
  - id: model_type
    type:
      - 'null'
      - int
    doc: 'RNN model type to use. 1: GRU, 2: LSTM, 3: biGRU, 4: biLSTM'
    default: 1
    inputBinding:
      position: 101
      prefix: --model-type
  - id: n_fc_layers
    type:
      - 'null'
      - int
    doc: Number of fully connected layers following RNN layers
    default: 1
    inputBinding:
      position: 101
      prefix: --n-fc-layers
  - id: n_hidden_dim
    type:
      - 'null'
      - int
    doc: Number of RNN layer dimensions
    default: 32
    inputBinding:
      position: 101
      prefix: --n-hidden-dim
  - id: n_rnn_layers
    type:
      - 'null'
      - int
    doc: Number of RNN layers
    default: 1
    inputBinding:
      position: 101
      prefix: --n-rnn-layers
  - id: only_seq
    type:
      - 'null'
      - boolean
    doc: "Use only sequence feature. By default all features\npresent in --in are
      used"
    default: false
    inputBinding:
      position: 101
      prefix: --only-seq
  - id: patience
    type:
      - 'null'
      - int
    doc: "Number of epochs to wait for further improvement on\nvalidation set before
      stopping"
    default: 30
    inputBinding:
      position: 101
      prefix: --patience
  - id: plot_lc
    type:
      - 'null'
      - boolean
    doc: "Plot learning curves (training vs validation loss) for\neach tested hyperparameter
      combination"
    default: false
    inputBinding:
      position: 101
      prefix: --plot-lc
  - id: run_bohb
    type:
      - 'null'
      - boolean
    doc: "Use BOHB to run a hyperparameter optimization. NOTE\nthat this will overwrite
      set hyperparameters, and\ntrains the final model with the found best\nhyperparameter
      setting. ALSO NOTE that this will take\nsome time (!)"
    default: false
    inputBinding:
      position: 101
      prefix: --run-bohb
  - id: seed
    type:
      - 'null'
      - int
    doc: "Set a fixed random seed number (e.g. --seed 1) to\nobtain identical model
      results for identical rnaprot\ntrain runs"
    inputBinding:
      position: 101
      prefix: --seed
  - id: str_mode
    type:
      - 'null'
      - string
    doc: "Define secondary structure feature representation: 1)\nuse probabilities
      of five structural elements\n(E,I,H,M,S) 2) same as 1) but encoded as one-hot\n\
      (element with highest probability gets 1, others 0) 3)\nuse unpaired probabilities
      4) same as 3) but encoded\nas one-hot"
    default: 1
    inputBinding:
      position: 101
      prefix: --str-mode
  - id: test_ids
    type:
      - 'null'
      - string
    doc: "Provide file with test IDs to be used as a test set\nfor testing final model.
      Test IDs need to be part of\n--in training set. Not compatible with --add-test
      or\n--cv"
    inputBinding:
      position: 101
      prefix: --test-ids
  - id: use_add_feat
    type:
      - 'null'
      - boolean
    doc: "Add additional feature annotations. Set --use-xxx to\ndefine which features
      to add on top of sequence\nfeature (by default all --in features are used)"
    inputBinding:
      position: 101
      prefix: --use-add-feat
  - id: use_eia
    type:
      - 'null'
      - boolean
    doc: "Add exon-intron annotations. Set --use-xxx to define\nwhich features to
      add on top of sequence feature (by\ndefault all --in features are used)"
    inputBinding:
      position: 101
      prefix: --use-eia
  - id: use_phastcons
    type:
      - 'null'
      - boolean
    doc: "Add phastCons conservation scores. Set --use-xxx to\ndefine which features
      to add on top of sequence\nfeature (by default all --in features are used)"
    inputBinding:
      position: 101
      prefix: --use-phastcons
  - id: use_phylop
    type:
      - 'null'
      - boolean
    doc: "Add phyloP conservation scores. Set --use-xxx to\ndefine which features
      to add on top of sequence\nfeature (by default all --in features are used)"
    inputBinding:
      position: 101
      prefix: --use-phylop
  - id: use_rra
    type:
      - 'null'
      - boolean
    doc: "Add repeat region annotations. Set --use-xxx to define\nwhich features to
      add on top of sequence feature (by\ndefault all --in features are used)"
    inputBinding:
      position: 101
      prefix: --use-rra
  - id: use_str
    type:
      - 'null'
      - boolean
    doc: "Add secondary structure features (type defined by\n--str-mode). Set --use-xxx
      to define which features to\nadd on top of sequence feature (by default all
      --in\nfeatures are used)"
    inputBinding:
      position: 101
      prefix: --use-str
  - id: use_tra
    type:
      - 'null'
      - boolean
    doc: "Add transcript region annotations. Set --use-xxx to define\nwhich features
      to add on top of sequence feature (by\ndefault all --in features are used)"
    inputBinding:
      position: 101
      prefix: --use-tra
  - id: val_size
    type:
      - 'null'
      - float
    doc: "Validation set size for training final model as\npercentage of all training
      sites. NOTE that if --add-\ntest is set, the test set will have the same size
      (so\nif --val-size 0.2, train on 60 percent, validate on 20\npercent, and test
      on 20 percent)"
    default: 0.2
    inputBinding:
      position: 101
      prefix: --val-size
  - id: verbose_bohb
    type:
      - 'null'
      - boolean
    doc: "Enable verbose output for BOHB hyperparameter\noptimization. By default
      only warnings are print out"
    default: false
    inputBinding:
      position: 101
      prefix: --verbose-bohb
  - id: verbose_train
    type:
      - 'null'
      - boolean
    doc: "Enable verbose output during model training to show\nperformance over epochs"
    default: false
    inputBinding:
      position: 101
      prefix: --verbose-train
  - id: weight_decay
    type:
      - 'null'
      - float
    doc: Weight decay of optimizer
    default: 0.0005
    inputBinding:
      position: 101
      prefix: --weight-decay
outputs:
  - id: out_folder
    type: Directory
    doc: Model training results output folder
    outputBinding:
      glob: $(inputs.out_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnaprot:0.5--pyhdfd78af_1
