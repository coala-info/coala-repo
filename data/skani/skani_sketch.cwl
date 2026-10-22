cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - skani
  - sketch
label: skani_sketch
doc: "Sketch (index) genomes. Usage: skani sketch genome1.fa genome2.fa ... -o new_sketch_folder\n\nTool homepage: https://github.com/bluenote-1577/skani"
inputs:
  - id: fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Fasta files to sketch'
    inputBinding:
      position: 1
  - id: fasta_list
    type:
      - 'null'
      - File
    doc: 'File with each line containing one fasta/sketch file'
    inputBinding:
      position: 101
      prefix: -l
  - id: individual_sequences
    type:
      - 'null'
      - boolean
    doc: 'Use individual sequences instead the entire file for multi-fastas'
    inputBinding:
      position: 101
      prefix: -i
  - id: separate_sketches
    type:
      - 'null'
      - boolean
    doc: 'Create separate .sketch files instead of consolidated database format. DOES NOT WORK WITH -i'
    inputBinding:
      position: 101
      prefix: --separate-sketches
  - id: fast
    type:
      - 'null'
      - boolean
    doc: 'Faster skani mode; 2x faster and less memory. Alias for -c 200'
    inputBinding:
      position: 101
      prefix: --fast
  - id: medium
    type:
      - 'null'
      - boolean
    doc: 'Medium skani mode; 2x slower, more accurate AF and ANI for moderately fragmented assemblies. Alias for -c 70'
    inputBinding:
      position: 101
      prefix: --medium
  - id: slow
    type:
      - 'null'
      - boolean
    doc: 'Slower skani mode; 4x slower, much more accurate AF for distant genomes. Alias for -c 30'
    inputBinding:
      position: 101
      prefix: --slow
  - id: compression_factor
    type:
      - 'null'
      - int
    doc: 'Compression factor (k-mer subsampling rate). Default 125'
    inputBinding:
      position: 101
      prefix: -c
  - id: marker_c
    type:
      - 'null'
      - int
    doc: 'Marker k-mer compression factor. Markers are used for filtering. Default 1000'
    inputBinding:
      position: 101
      prefix: -m
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads. Default 3'
    inputBinding:
      position: 101
      prefix: -t
  - id: trace
    type:
      - 'null'
      - boolean
    doc: 'Trace level verbosity'
    inputBinding:
      position: 101
      prefix: --trace
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Debug level verbosity'
    inputBinding:
      position: 101
      prefix: -v
  - id: output_folder
    type: string
    doc: 'Output folder where sketch files are placed'
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: sketch_folder
    type: Directory
    doc: Output folder with the sketch files
    outputBinding:
      glob: $(inputs.output_folder)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skani:0.3.1--ha6fb395_0
