cwlVersion: v1.2
class: CommandLineTool
baseCommand: metapi init
label: metapi_init
doc: "Initialize a metapi project.\n\nTool homepage: https://github.com/ohmeta/metapi"
inputs:
  - id: assembler
    type:
      - 'null'
      - type: array
        items: string
    doc: which assembler used, required when begin with binning, can be changed 
      in config.yaml
      - megahit
    inputBinding:
      position: 101
      prefix: --assembler
  - id: begin
    type:
      - 'null'
      - string
    doc: pipeline starting point
    inputBinding:
      position: 101
      prefix: --begin
  - id: binner
    type:
      - 'null'
      - type: array
        items: string
    doc: wchich binner used
      - metabat2
      - concoct
      - maxbin2
      - vamb
      - dastools
    inputBinding:
      position: 101
      prefix: --binner
  - id: check_samples
    type:
      - 'null'
      - boolean
    doc: check samples
    inputBinding:
      position: 101
      prefix: --check-samples
  - id: gpu
    type:
      - 'null'
      - boolean
    doc: indicate whether GPU is available
    inputBinding:
      position: 101
      prefix: --gpu
  - id: rmhoster
    type:
      - 'null'
      - string
    doc: which rmhoster used
    inputBinding:
      position: 101
      prefix: --rmhoster
  - id: samples
    type:
      - 'null'
      - string
    doc: "desired input: samples list, tsv format required.\n                    \
      \    \n                        if begin from trimming, rmhost, or assembly:\n\
      \                            if it is fastq:\n                             \
      \   the header is: [sample_id, assembly_group, binning_group, fq1, fq2]\n  \
      \                          if it is sra:\n                                the
      header is: [sample_id, assembly_group, binning_group, sra]\n               \
      \         \n                        if begin from simulate:\n              \
      \                  the header is: [id, genome, abundance, reads_num, model]"
    inputBinding:
      position: 101
      prefix: --samples
  - id: trimmer
    type:
      - 'null'
      - string
    doc: which trimmer used
    inputBinding:
      position: 101
      prefix: --trimmer
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: project workdir
    inputBinding:
      position: 101
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metapi:3.0.0--pyhdfd78af_0
stdout: metapi_init.out
