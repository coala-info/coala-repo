cwlVersion: v1.2
class: CommandLineTool
baseCommand: quantpi_init
label: quantpi_init
doc: "Initialize a quantpi project.\n\nTool homepage: https://github.com/ohmeta/quantpi"
inputs:
  - id: begin
    type:
      - 'null'
      - string
    doc: pipeline starting point
    inputBinding:
      position: 101
      prefix: --begin
  - id: check_samples
    type:
      - 'null'
      - boolean
    doc: check samples
    inputBinding:
      position: 101
      prefix: --check-samples
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
    doc: "desired input:\nsamples list, tsv format required.\n\n                 \
      \       if begin from trimming, rmhost, or assembly:\n                     \
      \       if it is fastq:\n                                the header is: [sample_id,
      fq1, fq2]\n                            if it is sra:\n                     \
      \           the header is: [sample_id, sra]\n                        \n    \
      \                    if begin from simulate:\n                             \
      \   the header is: [id, genome, abundance, reads_num, model]"
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
    dockerPull: quay.io/biocontainers/quantpi:1.0.0--pyh7e72e81_0
stdout: quantpi_init.out
