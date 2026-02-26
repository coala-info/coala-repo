cwlVersion: v1.2
class: CommandLineTool
baseCommand: traitar new
label: traitar_new
doc: "create new phenotype model archive\n\nTool homepage: http://github.com/aweimann/traitar"
inputs:
  - id: models_dir
    type: Directory
    doc: directory with phenotype models to be included
    inputBinding:
      position: 1
  - id: pf_acc2desc
    type: File
    doc: a mapping between Pfam families and phenotype ids to accessions
    inputBinding:
      position: 2
  - id: pt_id2acc_desc
    type: File
    doc: a mapping between phenotype ids and descriptions
    inputBinding:
      position: 3
  - id: hmm_database
    type: string
    doc: hmm database used
    inputBinding:
      position: 4
  - id: hmm_model_f
    type: File
    doc: hmm database compatible with the phenotype archive
    inputBinding:
      position: 5
  - id: archive_name
    type: string
    doc: name of the model, which is created
    inputBinding:
      position: 6
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/traitar:3.0.1--pyhdfd78af_0
stdout: traitar_new.out
