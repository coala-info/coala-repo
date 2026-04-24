cwlVersion: v1.2
class: CommandLineTool
baseCommand: clairvoyante_callVar.py
label: clairvoyante_callVar.py
doc: "Call variants using a trained Clairvoyante model\n\nTool homepage: https://github.com/aquaskyline/Clairvoyante"
inputs:
  - id: chkpnt_fn
    type: File
    doc: Clairvoyante model checkpoint file
    inputBinding:
      position: 101
      prefix: --chkpnt_fn
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimum coverage to call a variant
    inputBinding:
      position: 101
      prefix: --minCoverage
  - id: ref_fn
    type: File
    doc: Reference fasta file
    inputBinding:
      position: 101
      prefix: --ref_fn
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Sample name to be used in the VCF file
    inputBinding:
      position: 101
      prefix: --sampleName
  - id: tensor_fn
    type: File
    doc: Input tensor file (e.g., from tensor2Bin.py)
    inputBinding:
      position: 101
      prefix: --tensor_fn
  - id: threshold
    type:
      - 'null'
      - float
    doc: Variant calling threshold
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: call_fn
    type: File
    doc: Output VCF file
    outputBinding:
      glob: $(inputs.call_fn)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clairvoyante:1.02--0
