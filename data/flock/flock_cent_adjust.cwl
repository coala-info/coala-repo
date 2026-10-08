cwlVersion: v1.2
class: CommandLineTool
baseCommand: cent_adjust
label: flock_cent_adjust
doc: "Adjust FLOCK population centers: assign the events of a data file to given population centers and recompute population ids and mean fluorescence intensities. Results are written to the current directory. The program has no return value in main(), so its exit code is 209 after a successful run.\n\nTool homepage: https://github.com/cristhomas/immport-test"
inputs:
  - id: input_center
    type: File
    doc: Population center file (population_center.txt written by flock1 or flock2)
    inputBinding:
      position: 1
  - id: input_data_file
    type: File
    doc: Tab-delimited text data file with one header line
    inputBinding:
      position: 2
outputs:
  - id: population_id
    type: File
    doc: Population identifier of each event
    outputBinding:
      glob: population_id.txt
  - id: mfi
    type: File
    doc: Mean fluorescence intensity of each population for each marker
    outputBinding:
      glob: MFI.txt
successCodes:
  - 0
  - 209
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flock:1.0--0
