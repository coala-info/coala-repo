cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PhyloAcc-ST
label: phyloacc_PhyloAcc-ST
doc: "PhyloAcc species tree model: Bayesian estimation of substitution rates of conserved non-coding elements, run on one batch of loci from a parameter file.\n\nTool homepage: https://github.com/phyloacc/PhyloAcc"
inputs:
  - id: param_file
    type: File
    doc: 'Parameter file of one batch, as written by phyloacc (keys such as PHYTREE_FILE,
      SEG_FILE, ID_FILE, ALIGN_FILE, RESULT_FOLDER, PREFIX, BURNIN, MCMC, CHAIN,
      TARGETSPECIES, OUTGROUP, CONSERVE, NUM_THREAD). Paths in it must be relative to
      the working directory, where the files of input_files are staged'
    inputBinding:
      position: 1
  - id: input_files
    type:
      type: array
      items: File
    doc: 'Files named in the parameter file (tree mod file, bed file, id file, alignment)'
  - id: result_folder
    type: string
    doc: Name of the result folder given as RESULT_FOLDER in the parameter file (the
      program needs it to exist, so it is created before the run)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: result_dir
    type:
      - 'null'
      - Directory
    doc: Result folder with the elem_lik.txt table and the posterior files
    outputBinding:
      glob: $(inputs.result_folder)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_files)
      - entryname: $(inputs.result_folder)
        entry: '$({"class": "Directory", "basename": inputs.result_folder, "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloacc:2.4.5--py313h4c9e609_1
stdout: phyloacc_PhyloAcc-ST.out
