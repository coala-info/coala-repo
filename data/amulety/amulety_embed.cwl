cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - amulety
  - embed
label: amulety_embed
doc: "Embeds sequences from an AIRR rearrangement file using the specified model. It returns the embeddings in the specified output format along with the filtered input AIRR data.\n\nTool homepage: https://github.com/immcantation/amulety"
inputs:
  - id: input_airr
    type: File
    doc: The path to the input data file. The data file should be in AIRR format.
    inputBinding:
      position: 1
      prefix: --input-airr
  - id: chain
    type: string
    doc: 'Input chain to embed. For BCR: H=Heavy, L=Light, HL=Heavy-Light pairs, LH=Light-Heavy pairs, H+L=Both chains separately. For TCR: H=Beta/Delta, L=Alpha/Gamma, HL=Beta-Alpha/Delta-Gamma pairs, LH=Alpha-Beta/Gamma-Delta pairs, H+L=Both chains separately.'
    inputBinding:
      position: 1
      prefix: --chain
  - id: model
    type: string
    doc: "The embedding model to use. BCR: ['ablang', 'antiberta2', 'antiberty', 'balm-paired']. TCR: ['tcr-bert', 'tcrt5']. Immune (BCR & TCR): ['immune2vec']. Protein: ['esm2', 'prott5', 'custom']. Use 'custom' for fine-tuned models with --model-path, --embedding-dimension, and --max-length parameters."
    inputBinding:
      position: 1
      prefix: --model
  - id: output_file_path
    type: string
    doc: The path where the generated embeddings will be saved. The file extension should be .csv, or .tsv. for a dataframe, .pt for a pickled torch object, or .h5ad for an anndata object.
    inputBinding:
      position: 1
      prefix: --output-file-path
  - id: cache_dir
    type: ['null', string]
    doc: 'Cache dir for storing the pre-trained model weights. [default: /tmp/amulety-cache]'
    inputBinding:
      position: 1
      prefix: --cache-dir
  - id: sequence_col
    type: ['null', string]
    doc: 'The name of the column containing the amino acid sequences to embed. [default: sequence_vdj_aa]'
    inputBinding:
      position: 1
      prefix: --sequence-col
  - id: cell_id_col
    type: ['null', string]
    doc: 'The name of the column containing the single-cell barcode. [default: cell_id]'
    inputBinding:
      position: 1
      prefix: --cell-id-col
  - id: batch_size
    type: ['null', int]
    doc: 'The batch size of sequences to embed. [default: 50]'
    inputBinding:
      position: 1
      prefix: --batch-size
  - id: model_path
    type: ['null', string]
    doc: Path to custom model (HuggingFace model name or local path). Required for 'custom' model.
    inputBinding:
      position: 1
      prefix: --model-path
  - id: embedding_dimension
    type: ['null', int]
    doc: Embedding dimension for custom model. Required for 'custom' model.
    inputBinding:
      position: 1
      prefix: --embedding-dimension
  - id: max_length
    type: ['null', int]
    doc: Maximum sequence length for custom model. Required for 'custom' model.
    inputBinding:
      position: 1
      prefix: --max-length
  - id: duplicate_col
    type: ['null', string]
    doc: "The name of the numeric column used to select the best chain when multiple chains of the same type exist per cell. [default: duplicate_count]"
    inputBinding:
      position: 1
      prefix: --duplicate-col
  - id: installation_path
    type: ['null', Directory]
    doc: Custom path to model installation directory. Currently applies to 'immune2vec' model.
    inputBinding:
      position: 1
      prefix: --installation-path
  - id: residue_level
    type: ['null', boolean]
    doc: If True, returns residue-level embeddings of dimension sequence length x embedding dimension (L x D) instead of sequence-level (1 x D).
    inputBinding:
      position: 1
      prefix: --residue-level
  - id: log_file
    type: ['null', string]
    doc: Path to log file. If not provided, logs will be printed to stdout.
    inputBinding:
      position: 1
      prefix: --log-file
  - id: verbose
    type: ['null', boolean]
    doc: Enable verbose logging (DEBUG level).
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: embeddings
    type: File
    doc: The embeddings (.tsv, .csv, .pt or .h5ad)
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: metadata
    type: ['null', File]
    doc: The sequence-filtered input AIRR data (<output name>_metadata.tsv)
    outputBinding:
      glob: '*_metadata.tsv'
  - id: log
    type: ['null', File]
    doc: Log file, when --log-file is given
    outputBinding:
      glob: $(inputs.log_file)
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: EnvVarRequirement
    envDef:
      TORCHINDUCTOR_CACHE_DIR: $(runtime.tmpdir)/torchinductor
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amulety:2.1.2--pyh6d73907_0
