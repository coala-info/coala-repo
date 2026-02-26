cwlVersion: v1.2
class: CommandLineTool
baseCommand: fba kallisto_wrapper
label: fba_kallisto_wrapper
doc: "Deploy kallisto/bustools for feature barcoding quantification (just a wrapper)
  (Bray, N.L., et al. 2016).\n\nTool homepage: https://github.com/jlduan/fba"
inputs:
  - id: feature_ref
    type: File
    doc: specify a reference of feature barcodes
    inputBinding:
      position: 101
      prefix: --feature_ref
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: specify a temp directory. Default (./kallisto)
    default: ./kallisto
    inputBinding:
      position: 101
      prefix: --output_directory
  - id: read1
    type: File
    doc: specify fastq file for read 1
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type: File
    doc: specify fastq file for read 2
    inputBinding:
      position: 101
      prefix: --read2
  - id: technology
    type:
      - 'null'
      - string
    doc: specify feature barcoding technology. The default is 10xv3
    default: 10xv3
    inputBinding:
      position: 101
      prefix: --technology
  - id: threads
    type:
      - 'null'
      - int
    doc: specify number of kallisto/bustools threads to launch. Default (1)
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: whitelist
    type: File
    doc: specify a whitelist of accepted cell barcodes
    inputBinding:
      position: 101
      prefix: --whitelist
outputs:
  - id: output
    type: File
    doc: specify an output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fba:0.0.13--pyhdfd78af_0
