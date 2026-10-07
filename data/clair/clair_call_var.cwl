cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clair.py
  - call_var
label: clair_call_var
doc: "Call variants using a trained model and tensors of candididate variants\n\nTool homepage: https://github.com/HKU-BAL/Clair"
inputs:
  - id: tensor_fn
    type: File
    doc: "Tensor input"
    inputBinding:
      position: 101
      prefix: --tensor_fn
  - id: chkpnt_fn
    type: File
    doc: "Input a checkpoint for testing: Trained model checkpoint: give the .index file of the model; the checkpoint prefix (path without .index) is passed, with the .meta and .data-00000-of-00001 files beside it"
    secondaryFiles:
      - pattern: "^.meta"
        required: true
      - pattern: "^.data-00000-of-00001"
        required: true
    inputBinding:
      position: 101
      prefix: --chkpnt_fn
      valueFrom: "$(self.path.replace(/\\.index$/, ''))"
  - id: call_fn
    type: string
    doc: "Output variant predictions (VCF)"
    inputBinding:
      position: 101
      prefix: --call_fn
  - id: bam_fn
    type: File
    doc: "BAM file input (opened to output indel bases; the default bam.bam must exist)"
    secondaryFiles:
      - pattern: ".bai"
        required: true
    inputBinding:
      position: 101
      prefix: --bam_fn
  - id: ref_fn
    type:
      - 'null'
      - File
    doc: "Reference fasta file input, optional, print contig tags in the VCF header if set"
    secondaryFiles:
      - pattern: ".fai"
        required: false
    inputBinding:
      position: 101
      prefix: --ref_fn
  - id: showRef
    type:
      - 'null'
      - boolean
    doc: "Show reference calls"
    inputBinding:
      position: 101
      prefix: --showRef
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads"
    inputBinding:
      position: 101
      prefix: --threads
  - id: input_probabilities
    type:
      - 'null'
      - boolean
    doc: "Accept probabilities as input, using those probabilities to call variant"
    inputBinding:
      position: 101
      prefix: --input_probabilities
  - id: qual
    type:
      - 'null'
      - int
    doc: "If set, variant with equal or higher quality will be marked PASS, or LowQual otherwise"
    inputBinding:
      position: 101
      prefix: --qual
  - id: sampleName
    type:
      - 'null'
      - string
    doc: "Define the sample name to be shown in the VCF file"
    inputBinding:
      position: 101
      prefix: --sampleName
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Debug mode"
    inputBinding:
      position: 101
      prefix: --debug
  - id: pysam_for_all_indel_bases
    type:
      - 'null'
      - boolean
    doc: "Always using pysam for outputting indel bases"
    inputBinding:
      position: 101
      prefix: --pysam_for_all_indel_bases
  - id: haploid_precision
    type:
      - 'null'
      - boolean
    doc: "call haploid instead of diploid (output homo-variant only)"
    inputBinding:
      position: 101
      prefix: --haploid_precision
  - id: haploid_sensitive
    type:
      - 'null'
      - boolean
    doc: "call haploid instead of diploid (output non-multi-variant only)"
    inputBinding:
      position: 101
      prefix: --haploid_sensitive
  - id: activation_only
    type:
      - 'null'
      - boolean
    doc: "Output activation only, no prediction"
    inputBinding:
      position: 101
      prefix: --activation_only
  - id: max_plot
    type:
      - 'null'
      - int
    doc: "The maximum number of plots output, negative number means no limit (plot all), default: 10"
    inputBinding:
      position: 101
      prefix: --max_plot
  - id: log_path
    type:
      - 'null'
      - string
    doc: "The path for tensorflow logging, default: None"
    inputBinding:
      position: 101
      prefix: --log_path
  - id: parallel_level
    type:
      - 'null'
      - int
    doc: "The level of parallelism in plotting (currently available: 0, 2), default: 2"
    inputBinding:
      position: 101
      prefix: --parallel_level
  - id: fast_plotting
    type:
      - 'null'
      - boolean
    doc: "Enable fast plotting."
    inputBinding:
      position: 101
      prefix: --fast_plotting
  - id: workers
    type:
      - 'null'
      - int
    doc: "The number of workers in plotting, default: 8"
    inputBinding:
      position: 101
      prefix: --workers
  - id: output_for_ensemble
    type:
      - 'null'
      - boolean
    doc: "Output for ensemble"
    inputBinding:
      position: 101
      prefix: --output_for_ensemble
outputs:
  - id: calls
    type: File
    doc: "Variant calls (VCF)"
    outputBinding:
      glob: "$(inputs.call_fn)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clair:2.1.1--hdfd78af_1
