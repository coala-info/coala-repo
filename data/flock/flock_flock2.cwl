cwlVersion: v1.2
class: CommandLineTool
baseCommand: flock2
label: flock_flock2
doc: "FLOCK (FLOw Clustering without K), version 2: automated population discovery in multidimensional flow cytometry data. Results are written to the current directory.\n\nTool homepage: https://github.com/cristhomas/immport-test"
inputs:
  - id: data_file
    type: File
    doc: Tab-delimited text file with one header line, one column per marker and one row per event
    inputBinding:
      position: 1
  - id: max_num_pop_only
    type:
      - 'null'
      - int
    doc: Advanced mode 0, maximum number of populations (use without num_bin and density_index)
    inputBinding:
      position: 2
  - id: num_bin
    type:
      - 'null'
      - int
    doc: Number of equal-sized bins on each axis (advanced modes 1 to 3)
    inputBinding:
      position: 3
  - id: density_index
    type:
      - 'null'
      - int
    doc: Density threshold index (advanced modes 1 to 3)
    inputBinding:
      position: 4
  - id: number_of_pop
    type:
      - 'null'
      - int
    doc: Number of populations (advanced modes 2 and 3)
    inputBinding:
      position: 5
  - id: max_num_pop
    type:
      - 'null'
      - int
    doc: Maximum number of populations (advanced mode 3)
    inputBinding:
      position: 6
outputs:
  - id: coordinates
    type: File
    doc: Intensity values for each marker and event
    outputBinding:
      glob: coordinates.txt
  - id: flock_results
    type: File
    doc: Input data with event identifiers and population identifiers
    outputBinding:
      glob: flock_results.txt
  - id: mfi
    type: File
    doc: Mean fluorescence intensity of each population for each marker
    outputBinding:
      glob: MFI.txt
  - id: percentage
    type: File
    doc: Population identifiers and the percentage of events in each population
    outputBinding:
      glob: percentage.txt
  - id: population_center
    type: File
    doc: Centroid coordinates of each identified population
    outputBinding:
      glob: population_center.txt
  - id: population_id
    type: File
    doc: Population identifier of each event, one per row
    outputBinding:
      glob: population_id.txt
  - id: profile
    type: File
    doc: Expression profile with a level from 1 to 4 for each marker and population
    outputBinding:
      glob: profile.txt
  - id: fcs_properties
    type:
      - 'null'
      - File
    doc: Properties of the input file (dimensions and number of events)
    outputBinding:
      glob: fcs.properties
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flock:1.0--0
