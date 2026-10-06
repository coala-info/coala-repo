cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - PipelineStatus
label: biopet_tool_PipelineStatus
doc: "Report the job status of a Biopet (Queue) pipeline run from its output directory.\n\n\
  Tool homepage: https://github.com/biopet/biopet"
inputs:
  - id: pipeline_dir
    type: Directory
    doc: Output directory of the pipeline
    inputBinding:
      position: 101
      prefix: --pipelineDir
  - id: output_dir
    type: string
    doc: Output directory of this tool
    inputBinding:
      position: 101
      prefix: --outputDir
  - id: deps_file
    type:
      - 'null'
      - File
    doc: Location of deps file, not required
    inputBinding:
      position: 101
      prefix: --depsFile
  - id: follow
    type:
      - 'null'
      - boolean
    doc: This will follow a run
    inputBinding:
      position: 101
      prefix: --follow
  - id: refresh
    type:
      - 'null'
      - int
    doc: Time to check again, default set on 30 seconds
    inputBinding:
      position: 101
      prefix: --refresh
  - id: complete_plots
    type:
      - 'null'
      - boolean
    doc: Add complete plots, each job shown separately
    inputBinding:
      position: 101
      prefix: --completePlots
  - id: skip_compress_plots
    type:
      - 'null'
      - boolean
    doc: Disable compressed plots. By default compressed plots are enabled.
    inputBinding:
      position: 101
      prefix: --skipCompressPlots
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Level of log information printed. Possible levels: ''debug'', ''info'', ''warn'',
      ''error'''
    inputBinding:
      position: 101
      prefix: --log_level
outputs:
  - id: output
    type: Directory
    doc: Status output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
