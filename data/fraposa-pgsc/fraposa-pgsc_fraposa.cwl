cwlVersion: v1.2
class: CommandLineTool
baseCommand: fraposa
label: fraposa-pgsc_fraposa
doc: "Performs Principal Component Analysis (PCA) prediction using reference and study\
  \ samples.\n\nTool homepage: https://github.com/PGScatalog/fraposa_pgsc"
inputs:
  - id: ref_filepref
    type: string
    doc: Prefix of the binary PLINK file for the reference samples (the files are
      given in ref_files).
    inputBinding:
      position: 1
  - id: ref_files
    type: File[]
    doc: Reference PLINK files <ref_filepref>.bed, .bim and .fam (and the optional
      .popu file); staged in the working directory.
  - id: stu_files
    type:
      - 'null'
      - File[]
    doc: Study PLINK files <stu_filepref>.bed, .bim and .fam; staged in the working
      directory.
  - id: dim_online
    type:
      - 'null'
      - int
    doc: Number of PCs to calculate in online SVD. Only needed for the oadp method.
      Default is 2*dim_stu
    inputBinding:
      position: 102
      prefix: --dim_online
  - id: dim_rand
    type:
      - 'null'
      - int
    doc: Number of reference PCs to calculate when using randomized online SVD
    inputBinding:
      position: 102
      prefix: --dim_rand
  - id: dim_ref
    type:
      - 'null'
      - int
    doc: Number of PCs you need.
    inputBinding:
      position: 102
      prefix: --dim_ref
  - id: dim_spikes
    type:
      - 'null'
      - int
    doc: Number of PCs to adjust for shrinkage. Only needed for the ap method. If
      this argument is not set, dim_spikes_max will be used.
    inputBinding:
      position: 102
      prefix: --dim_spikes
  - id: dim_spikes_max
    type:
      - 'null'
      - int
    doc: The maximal number of PCs to adjust for shrinkage. Only needed for the ap
      method. This argument will be ignored if dim_spikes is set. Default is 4*dim_ref.
    inputBinding:
      position: 102
      prefix: --dim_spikes_max
  - id: dim_stu
    type:
      - 'null'
      - int
    doc: Number of PCs predicted for the study samples before doing the Procrustes
      transformation. Only needed for the oadp and adp methods. Default is 2*dim_ref.
    inputBinding:
      position: 102
      prefix: --dim_stu
  - id: method
    type:
      - 'null'
      - string
    doc: 'The method for PCA prediction. oadp: most accurate. adp: accurate but slow.
      sp: fast but inaccurate. Default is oadp.'
    inputBinding:
      position: 102
      prefix: --method
  - id: out
    type:
      - 'null'
      - string
    doc: Prefix of output file(s). Default is stu_filepref
    inputBinding:
      position: 102
      prefix: --out
  - id: stu_filepref
    type:
      - 'null'
      - string
    doc: Prefix of the binary PLINK file for the study samples (the files are given
      in stu_files).
    inputBinding:
      position: 102
      prefix: --stu_filepref
  - id: stu_filt_iid
    type:
      - 'null'
      - File
    doc: File with list of FIDs and IIDs to extract from the study file (bim format)
    inputBinding:
      position: 102
      prefix: --stu_filt_iid
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: pcs_files
    type: File[]
    doc: Principal component scores written by fraposa (reference and study .pcs files)
    outputBinding:
      glob: '*.pcs'
  - id: dat_files
    type: File[]
    doc: Intermediate reference model files (.dat) that fraposa saves for reuse
    outputBinding:
      glob: '*.dat'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fraposa-pgsc:1.0.2--pyhdfd78af_0
stdout: fraposa-pgsc_fraposa.out
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.ref_files.concat(inputs.stu_files ? inputs.stu_files : []))'
