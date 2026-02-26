cwlVersion: v1.2
class: CommandLineTool
baseCommand: java
label: searchgui
doc: "SearchGUI is a graphical user interface for the PeptideShaker software suite,
  designed to facilitate the analysis of mass spectrometry data.\n\nTool homepage:
  https://github.com/compomics/searchgui"
inputs:
  - id: main_class
    type: string
    doc: The main class to execute
    inputBinding:
      position: 1
  - id: classpath
    type:
      - 'null'
      - string
    doc: Java classpath
    inputBinding:
      position: 102
      prefix: -cp
  - id: max_heap_size
    type:
      - 'null'
      - string
    doc: Maximum Java heap size
    inputBinding:
      position: 102
      prefix: -Xmx
  - id: min_heap_size
    type:
      - 'null'
      - string
    doc: Minimum Java heap size
    inputBinding:
      position: 102
      prefix: -Xms
  - id: splash_image
    type:
      - 'null'
      - string
    doc: Path to the splash screen image
    inputBinding:
      position: 102
      prefix: '-splash:'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/searchgui:4.3.15--hdfd78af_0
stdout: searchgui.out
