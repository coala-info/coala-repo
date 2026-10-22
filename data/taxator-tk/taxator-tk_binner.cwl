cwlVersion: v1.2
class: CommandLineTool
baseCommand: binner
label: taxator-tk_binner
doc: "Combine the segment predictions of taxator (GFF3) into one taxonomic assignment per query sequence (consensus binning).

Tool homepage: https://github.com/fungs/taxator-tk"
inputs:
  - id: taxonomy_dir
    type: Directory
    doc: "NCBI taxonomy dump directory (nodes.dmp, names.dmp, merged.dmp); given to the tool by the environment variable TAXATORTK_TAXONOMY_NCBI"
  - id: prediction_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "arbitrary number of prediction files (replaces standard input)"
    inputBinding:
      position: 101
      prefix: --files
  - id: sample_identifier
    type:
      - 'null'
      - string
    doc: "unique sample identifier"
    inputBinding:
      position: 101
      prefix: --sample-identifier
  - id: sequence_min_support
    type:
      - 'null'
      - int
    doc: "minimum number of positions supporting a taxonomic signal for any single sequence. If not reached, a fall-back on a more robust algorthm will be used"
    inputBinding:
      position: 101
      prefix: --sequence-min-support
  - id: signal_majority
    type:
      - 'null'
      - float
    doc: "minimum combined fraction of support for any single sequence (> 0.5 to be stable)"
    inputBinding:
      position: 101
      prefix: --signal-majority
  - id: identity_constrain
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --identity-constrain
    doc: "minimum required identity for this rank (e.g. species:0.8 genus:0.7); each value is given as its own --identity-constrain option"
    inputBinding:
      position: 101
  - id: logfile
    type:
      - 'null'
      - string
    doc: "specify name of file for logging (appending lines)"
    inputBinding:
      position: 101
      prefix: --logfile
  - id: ranks
    type:
      - 'null'
      - type: array
        items: string
    doc: "set ranks at which to do predictions (advanced option)"
    inputBinding:
      position: 101
      prefix: --ranks
  - id: sample_min_support
    type:
      - 'null'
      - float
    doc: "minimum support in positions (>=1) or fraction of total support (<1) for any taxon (advanced option)"
    inputBinding:
      position: 101
      prefix: --sample-min-support
  - id: preallocate_num_queries
    type:
      - 'null'
      - int
    doc: "advanced parameter for better memory allocation, set to number of query sequences or similar (advanced option)"
    inputBinding:
      position: 101
      prefix: --preallocate-num-queries
  - id: delete_notranks
    type:
      - 'null'
      - int
    doc: "delete all nodes that don't have any of the given ranks (advanced option)"
    inputBinding:
      position: 101
      prefix: --delete-notranks
outputs:
  - id: stdout
    type: stdout
    doc: "Binning output"
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: TAXATORTK_TAXONOMY_NCBI
        envValue: $(inputs.taxonomy_dir.path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxator-tk:1.3.3e--0
stdout: taxator-tk_binner.out
