cwlVersion: v1.2
class: CommandLineTool
baseCommand: fraposa_pred
label: fraposa-pgsc_fraposa_pred
doc: "Predicts the ancestry (population membership) of study samples from their PC\
  \ scores and a labelled reference population.\n\nTool homepage: https://github.com/PGScatalog/fraposa_pgsc"
inputs:
  - id: ref_filepref
    type: string
    doc: Prefix of binary PLINK file for the reference data.
    inputBinding:
      position: 1
  - id: stu_filepref
    type: string
    doc: Prefix of binary PLINK file for the study data.
    inputBinding:
      position: 2
  - id: ref_files
    type: File[]
    doc: 'Reference files from a fraposa run: <ref_filepref>.bed, .bim, .fam, .popu,
      .pcs and the .dat files'
  - id: stu_files
    type: File[]
    doc: 'Study files from a fraposa run: <stu_filepref>.pcs (and the PLINK files)'
  - id: nneighbors
    type:
      - 'null'
      - int
    doc: The number of neighbors for each study sample. Default is 20.
    inputBinding:
      position: 103
      prefix: --nneighbors
  - id: weights
    type:
      - 'null'
      - string
    doc: 'The method for calculating the weights in the nearest neighbor method. uniform:
      each neighbor receives the same weight; distance: the weight of each neighbor
      is inversely proportional to its distance from the study sample. Default is
      uniform.'
    inputBinding:
      position: 103
      prefix: --weights
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: popu_file
    type: File
    doc: Predicted population memberships of the study samples (<stu_filepref>.popu)
    outputBinding:
      glob: $(inputs.stu_filepref).popu
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fraposa-pgsc:1.0.2--pyhdfd78af_0
stdout: fraposa-pgsc_fraposa_pred.out
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.ref_files.concat(inputs.stu_files ? inputs.stu_files : []))'
