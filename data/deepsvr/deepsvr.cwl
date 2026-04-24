cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepsvr
label: deepsvr
doc: "Deep learning variant caller for whole genome sequencing data.\n\nTool homepage:
  https://github.com/griffithlab/deepsvr"
inputs:
  - id: input_vcf
    type: File
    doc: Input VCF file containing variants.
    inputBinding:
      position: 1
  - id: input_bam
    type: File
    doc: Input BAM file containing aligned reads.
    inputBinding:
      position: 2
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Batch size for model inference.
    inputBinding:
      position: 103
      prefix: --batch-size
  - id: enable_cuda
    type:
      - 'null'
      - boolean
    doc: Enable CUDA for GPU acceleration.
    inputBinding:
      position: 103
      prefix: --enable-cuda
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level (DEBUG, INFO, WARNING, ERROR).
    inputBinding:
      position: 103
      prefix: --log-level
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Maximum sequencing depth to consider a variant.
    inputBinding:
      position: 103
      prefix: --max-depth
  - id: min_allele_fraction
    type:
      - 'null'
      - float
    doc: Minimum allele fraction to consider a variant.
    inputBinding:
      position: 103
      prefix: --min-allele-fraction
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum sequencing depth to consider a variant.
    inputBinding:
      position: 103
      prefix: --min-depth
  - id: model_path
    type: Directory
    doc: Path to the pre-trained deep learning model.
    inputBinding:
      position: 103
      prefix: --model-path
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel processing.
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: output_vcf
    type: File
    doc: Output VCF file for predicted variants.
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepsvr:0.1.0--py_0
