cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clairvoyante.py
  - callVar
label: clairvoyante_callVar.py
doc: "Call variants using a trained Clairvoyante model and tensors of candididate variants\n\nTool homepage: https://github.com/aquaskyline/Clairvoyante"
inputs:
  - id: tensor_fn
    type: File
    doc: "Tensor input"
    inputBinding:
      position: 101
      prefix: --tensor_fn
  - id: chkpnt_fn
    type: File
    doc: "Model checkpoint: give the .index file; the checkpoint prefix (path without .index) is passed, with the .meta and .data-00000-of-00001 files beside it"
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
  - id: qual
    type:
      - 'null'
      - int
    doc: "If set, variant with equal or higher quality will be marked PASS, or LowQual otherwise, optional"
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
  - id: showRef
    type:
      - 'null'
      - boolean
    doc: "Show reference calls, optional"
    inputBinding:
      position: 101
      prefix: --showRef
  - id: ref_fn
    type:
      - 'null'
      - File
    doc: "Reference fasta file input, optional, print contig tags in the VCF header if set"
    secondaryFiles:
      - pattern: ".fai"
        required: true
    inputBinding:
      position: 101
      prefix: --ref_fn
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads, optional"
    inputBinding:
      position: 101
      prefix: --threads
  - id: v3
    type:
      - 'null'
      - boolean
    doc: "Use Clairvoyante version 3"
    inputBinding:
      position: 101
      prefix: --v3
  - id: v2
    type:
      - 'null'
      - boolean
    doc: "Use Clairvoyante version 2"
    inputBinding:
      position: 101
      prefix: --v2
  - id: slim
    type:
      - 'null'
      - boolean
    doc: "Train using the slim version of Clairvoyante, optional"
    inputBinding:
      position: 101
      prefix: --slim
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
    dockerPull: quay.io/biocontainers/clairvoyante:1.02--0
