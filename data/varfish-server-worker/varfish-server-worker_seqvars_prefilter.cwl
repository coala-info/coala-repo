cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varfish-server-worker
  - seqvars
  - prefilter
label: varfish-server-worker_seqvars_prefilter
doc: 'Prefilter an ingested variant VCF.


  Tool homepage: https://github.com/varfish-org/varfish-server-worker'
inputs:
  - id: path_in
    type: File
    doc: Path to input file
    inputBinding:
      position: 102
      prefix: --path-in
  - id: params
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --params
    doc: Prefilter parameters (JSON with prefilter_path, max_freq, max_exon_dist)
      or @ with path to JSONL file; may be given several times
    inputBinding:
      position: 102
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase logging verbosity
    inputBinding:
      position: 102
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Decrease logging verbosity
    inputBinding:
      position: 102
      prefix: --quiet
outputs:
  - id: prefiltered_vcfs
    type:
      type: array
      items: File
    doc: Prefiltered VCF files written to the prefilter_path of each parameter set
    outputBinding:
      glob:
        - '*.vcf'
        - '*.vcf.gz'
  - id: stdout
    type: stdout
    doc: Standard output (log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varfish-server-worker:0.17.3--h13c227e_0
stdout: varfish-server-worker_seqvars_prefilter.out
