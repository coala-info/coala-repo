cwlVersion: v1.2
class: CommandLineTool
baseCommand: toppred
label: toppred
doc: "Predicts transmembrane topology of proteins\n\nTool homepage: https://github.com/C3BI-pasteur-fr/toppred"
inputs:
  - id: input_file
    type: File
    doc: Input file for analysis
    inputBinding:
      position: 1
  - id: certain_cutoff
    type:
      - 'null'
      - float
    doc: Use <val> as certain cut-off
    inputBinding:
      position: 102
      prefix: -c
  - id: core_window_length
    type:
      - 'null'
      - int
    doc: Use <val> as core window length
    inputBinding:
      position: 102
      prefix: -n
  - id: critical_distance
    type:
      - 'null'
      - int
    doc: Use <val> as critical distance between 2 transmembrane segments
    inputBinding:
      position: 102
      prefix: -d
  - id: critical_loop_length
    type:
      - 'null'
      - int
    doc: Use <val> as critical loop length
    inputBinding:
      position: 102
      prefix: -s
  - id: eucaryotes
    type:
      - 'null'
      - boolean
    doc: For use with Eucaryotes
    inputBinding:
      position: 102
      prefix: -e
  - id: hydrophobic_profile_format
    type:
      - 'null'
      - string
    doc: Display or produce Hydropphobic profile, in the specified <format> (ps,
      png, ppm, x11 and none)
    inputBinding:
      position: 102
      prefix: -g
  - id: hydrophobicity_file
    type:
      - 'null'
      - File
    doc: Use Hydrophobycitie values from <file>
    inputBinding:
      position: 102
      prefix: -H
  - id: output_format
    type:
      - 'null'
      - string
    doc: Print output in the specified <format> (old, new (default), html)
    inputBinding:
      position: 102
      prefix: -O
  - id: putative_cutoff
    type:
      - 'null'
      - float
    doc: Use <val> as putative cut-off
    inputBinding:
      position: 102
      prefix: -p
  - id: topology_image_format
    type:
      - 'null'
      - string
    doc: Produce images of the topologies in the specified <format> (png and 
      none)
    inputBinding:
      position: 102
      prefix: -t
  - id: wedge_window_length
    type:
      - 'null'
      - int
    doc: Use <val> as wedge window length
    inputBinding:
      position: 102
      prefix: -q
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Place the output into <file>
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/toppred:v1.10-7-deb_cv1
