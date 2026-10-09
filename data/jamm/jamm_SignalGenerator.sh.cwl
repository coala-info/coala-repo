cwlVersion: v1.2
class: CommandLineTool
baseCommand: SignalGenerator.sh
label: jamm_SignalGenerator.sh
doc: "JAMM Signal Generator Script: generates read signal tracks for given regions from sample (and control) read files.\n\nTool homepage: https://github.com/mahmoudibrahim/JAMM"
inputs:
  - id: sample_dir
    type: Directory
    doc: Directory containing sample files (required)
    inputBinding:
      position: 101
      prefix: -s
  - id: genome_size_file
    type: File
    doc: Genome size file (required)
    inputBinding:
      position: 101
      prefix: -g
  - id: output_dir_path
    type: string
    doc: Output Directory (required)
    inputBinding:
      position: 101
      prefix: -o
  - id: control_dir
    type:
      - 'null'
      - Directory
    doc: directory containing input or control files
    inputBinding:
      position: 101
      prefix: -c
  - id: regions_file
    type: File
    doc: file with Regions to get signal for (required)
    inputBinding:
      position: 101
      prefix: -r
  - id: bin_size
    type:
      - 'null'
      - int
    doc: Bin size for signal generation (default 10)
    inputBinding:
      position: 101
      prefix: -b
  - id: fragment_lengths
    type:
      - 'null'
      - string
    doc: Fragment lengths (required if -t is "single")
    inputBinding:
      position: 101
      prefix: -f
  - id: num_processors
    type:
      - 'null'
      - int
    doc: Number of processors used by R scripts (default 1)
    inputBinding:
      position: 101
      prefix: -p
  - id: type
    type:
      - 'null'
      - string
    doc: Alignment type, paired or single (default single)
    inputBinding:
      position: 101
      prefix: -t
  - id: normalization
    type:
      - 'null'
      - string
    doc: Normalization method, chromAverage or depth (default chromAverage)
    inputBinding:
      position: 101
      prefix: -n
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with the signal files
    outputBinding:
      glob: $(inputs.output_dir_path)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jamm:1.0.8.0--hdfd78af_1
stdout: jamm_SignalGenerator.sh.out
