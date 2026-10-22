cwlVersion: v1.2
class: CommandLineTool
baseCommand: taeper
label: taeper
doc: "Simulate the real-time depositing of Nanopore reads into a given folder, conserving
  the order they were processed during sequencing. If pass and fail folders do not
  exist in output_dir they will be created if detected in the file path for the fast5
  file.\n\nTool homepage: https://github.com/mbhall88/taeper"
inputs:
  - id: input_dir
    type: Directory
    doc: Directory where files are located.
    inputBinding:
      position: 101
      prefix: --input_dir
  - id: index
    type:
      - 'null'
      - File
    doc: Provide a prebuilt index file to skip indexing. Paths within an index file
      are relative to the current working directory when they were built.
    inputBinding:
      position: 101
      prefix: --index
  - id: output
    type:
      - 'null'
      - string
    doc: Directory to copy the files to. If not specified, will generate the index
      file only.
    inputBinding:
      position: 101
      prefix: --output
  - id: scale
    type:
      - 'null'
      - float
    doc: Amount to scale the timing by. i.e scale of 10 will deposit the reads 10x
      faster than they were generated. (Default = 1.0)
    inputBinding:
      position: 101
      prefix: --scale
  - id: dump_index
    type:
      - 'null'
      - string
    doc: Path to save index as. Default is 'taeper_index.npy' in current working
      directory.
    inputBinding:
      position: 101
      prefix: --dump_index
  - id: no_index
    type:
      - 'null'
      - boolean
    doc: Dont write the index list to file. This will mean it needs regenerating
      for this dataset on each run.
    inputBinding:
      position: 101
      prefix: --no_index
  - id: log_level
    type:
      - 'null'
      - int
    doc: Level of logging. 0 is none, 5 is for debugging. Default is 4.
    inputBinding:
      position: 101
      prefix: --log_level
  - id: no_progress_bar
    type:
      - 'null'
      - boolean
    doc: Do not display progress bar.
    inputBinding:
      position: 101
      prefix: --no_progress_bar
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory the reads were copied to
    outputBinding:
      glob: $(inputs.output)
  - id: index_file
    type:
      - 'null'
      - File
    doc: Index file written by taeper
    outputBinding:
      glob: $(inputs.dump_index || 'taeper_index.npy')
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taeper:0.1.0--py36_0
stdout: taeper.out
