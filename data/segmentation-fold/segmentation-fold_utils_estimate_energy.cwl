cwlVersion: v1.2
class: CommandLineTool
baseCommand: [segmentation-fold-utils, estimate-energy]
label: segmentation-fold_utils_estimate_energy
doc: "Estimates whether a certain Segment(Loop) is present and for which delta-G this transistion takes place\n\nTool homepage: https://github.com/yhoogstrate/segmentation-fold"
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: LANG
        envValue: C.UTF-8
inputs:
  - id: temp_dir
    type: ['null', string]
    doc: "Path in which temporary config files will be stored (default: /tmp)"
    inputBinding:
      position: 1
      prefix: --temp-dir
  - id: segmentation_fold
    type: ['null', string]
    doc: "Location of segmentation-fold binary (default: segmentation-fold)"
    inputBinding:
      position: 1
      prefix: --segmentation-fold
  - id: xml_file
    type: ['null', File]
    doc: "Location of segments.xml (default: the segments.xml of the install)"
    inputBinding:
      position: 1
      prefix: --xml-file
  - id: threads
    type: ['null', int]
    doc: "Number of threads per spawned instance of segmentation-fold"
    inputBinding:
      position: 1
      prefix: --threads
  - id: precision
    type: ['null', float]
    doc: "Minimal difference for binary split - the smaller this value the slower; 0 sets the difference to infinity (default: 0.05)"
    inputBinding:
      position: 1
      prefix: --precision
  - id: randomize
    type: ['null', int]
    doc: "Shuffle each sequence this many times and predict energy of shuffled sequence(s) (default: 0, disabled)"
    inputBinding:
      position: 1
      prefix: --randomize
  - id: sequences_from_fasta_file
    type: ['null', File]
    doc: "Use sequences from a FASTA file instead of the XML file that also contains the segments"
    inputBinding:
      position: 1
      prefix: --sequences-from-fasta-file
  - id: dbn_output_file
    type: string
    doc: "DBN output file name"
    inputBinding:
      position: 2
outputs:
  - id: dbn_output
    type: File
    doc: "DBN output with estimated energies"
    outputBinding:
      glob: $(inputs.dbn_output_file)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segmentation-fold:1.7.0--py27_0
stdout: segmentation-fold_utils_estimate_energy.out
