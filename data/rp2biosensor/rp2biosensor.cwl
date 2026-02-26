cwlVersion: v1.2
class: CommandLineTool
baseCommand: rp2biosensor
label: rp2biosensor
doc: "Generate HTML outputs to explore Sensing Enabling Metabolic Pathway from RetroPath2
  results.\n\nTool homepage: https://github.com/conda-forge/rp2biosensor-feedstock"
inputs:
  - id: rp2_results
    type: string
    doc: RetroPath2.0 results
    inputBinding:
      position: 1
  - id: sink_file
    type: string
    doc: Sink file used for RetroPath2.0
    inputBinding:
      position: 2
  - id: cache_dir
    type:
      - 'null'
      - string
    doc: Path to the cache directory. If not specified, None is passed to 
      rrCache.
    default: None
    inputBinding:
      position: 103
      prefix: --cache-dir
  - id: output_json
    type:
      - 'null'
      - string
    doc: Output the graph as json file if the path is not None.
    default: None
    inputBinding:
      position: 103
      prefix: --ojson
  - id: output_path
    type:
      - 'null'
      - string
    doc: Output path.
    default: /biosensor.html
    inputBinding:
      position: 103
      prefix: --opath
  - id: output_type
    type:
      - 'null'
      - string
    doc: Output type. This could be either (i) "dir" which means ouput files 
      will outputted into this directory, or (ii) "file" which means that all 
      files will be embedded into a single HTML page.
    default: file
    inputBinding:
      position: 103
      prefix: --otype
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rp2biosensor:3.2.1
stdout: rp2biosensor.out
