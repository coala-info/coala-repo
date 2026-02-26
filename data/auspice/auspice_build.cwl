cwlVersion: v1.2
class: CommandLineTool
baseCommand: auspice build
label: auspice_build
doc: "Build the client source code bundle. For development, you may want to use \"\
  auspice develop\" which recompiles code on the fly as changes are made. You may
  provide customisations (e.g. code, options) to this step to modify the functionality
  and appearance of auspice. To serve the bundle you will need a server such as \"\
  auspice view\".\n\nTool homepage: https://docs.nextstrain.org/projects/auspice/"
inputs:
  - id: analyze_bundle
    type:
      - 'null'
      - boolean
    doc: Load an interactive bundle analyzer tool to investigate the composition
      of produced bundles / chunks.
    inputBinding:
      position: 101
      prefix: --analyzeBundle
  - id: extend
    type:
      - 'null'
      - string
    doc: Build-time customisations to be applied. See documentation for more 
      details.
    inputBinding:
      position: 101
      prefix: --extend
  - id: include_timing
    type:
      - 'null'
      - boolean
    doc: Do not strip timing functions. With these included the browser console 
      will print timing measurements for a number of functions.
    inputBinding:
      position: 101
      prefix: --includeTiming
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print more verbose progress messages.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/auspice:2.66.0--h503566f_2
stdout: auspice_build.out
