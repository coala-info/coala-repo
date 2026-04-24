cwlVersion: v1.2
class: CommandLineTool
baseCommand: virsorter train-model
label: virsorter_train-model
doc: "Training customized classifier model.\n\nTool homepage: https://github.com/simroux/VirSorter"
inputs:
  - id: snakemake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: SNAKEMAKE_ARGS
    inputBinding:
      position: 1
  - id: balanced
    type:
      - 'null'
      - boolean
    doc: random undersample the larger to the size of the smaller feature file
    inputBinding:
      position: 102
      prefix: --balanced
  - id: jobs
    type:
      - 'null'
      - int
    doc: number of threads for classier
    inputBinding:
      position: 102
      prefix: --jobs
  - id: nonviral_ftrfile
    type: File
    doc: nonviral genome feature file for training
    inputBinding:
      position: 102
      prefix: --nonviral-ftrfile
  - id: use_conda_off
    type:
      - 'null'
      - boolean
    doc: Stop using the conda envs (vs2.yaml) that come with this package and 
      use what are installed in current system; Only useful when you want to 
      install dependencies on your own with your own prefer versions
    inputBinding:
      position: 102
      prefix: --use-conda-off
  - id: viral_ftrfile
    type: File
    doc: viral genome feature file for training
    inputBinding:
      position: 102
      prefix: --viral-ftrfile
  - id: working_dir
    type: Directory
    doc: output directory
    inputBinding:
      position: 102
      prefix: --working-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virsorter:2.2.4--pyhdfd78af_2
stdout: virsorter_train-model.out
