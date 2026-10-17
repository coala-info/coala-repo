cwlVersion: v1.2
class: CommandLineTool
baseCommand: pygvcf2coverage
label: pygvcf2coverage
doc: "Convert gVCF to coverage. The gVCF is read from standard input and the coverage
  intervals (chromosome, start, end, ploidy) are written to standard output.\n\nTool
  homepage: https://github.com/varda/varda2_preprocessing"
inputs:
  - id: gvcf
    type: File
    doc: Single-sample gVCF file (read from standard input)
  - id: threshold
    type: ['null', int]
    doc: DP threshold
    inputBinding:
      position: 1
      prefix: --threshold
  - id: no_merge
    type: ['null', boolean]
    doc: Do not merge entries
    inputBinding:
      position: 2
      prefix: --no_merge
  - id: distance
    type: ['null', int]
    doc: Merging distance
    inputBinding:
      position: 3
      prefix: --distance
outputs:
  - id: coverage
    type: stdout
    doc: Coverage intervals (tab-separated)
stdin: $(inputs.gvcf.path)
stdout: pygvcf2coverage.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygvcf2coverage:0.2--py_0
