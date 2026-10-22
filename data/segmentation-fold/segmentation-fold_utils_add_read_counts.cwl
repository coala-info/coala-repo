cwlVersion: v1.2
class: CommandLineTool
baseCommand: [segmentation-fold-utils, add-read-counts]
label: segmentation-fold_utils_add_read_counts
doc: "Annotate sequences by adding the read counts from a bam file, within a region contained in the fasta header of the dbn file\n\nTool homepage: https://github.com/yhoogstrate/segmentation-fold"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.bam_input_file)
        writable: true
  - class: EnvVarRequirement
    envDef:
      - envName: LANG
        envValue: C.UTF-8
inputs:
  - id: regex
    type: ['null', string]
    doc: "Regex to capture the targeted location in DBN file (default: '>.*?(chr[^:]):([0-9]+)-([0-9]+)' )"
    inputBinding:
      position: 1
      prefix: --regex
  - id: dbn_input_file
    type: File
    doc: "DBN input file"
    inputBinding:
      position: 2
  - id: bam_input_file
    type: File
    doc: "BAM input file"
    inputBinding:
      position: 3
      valueFrom: $(self.basename)
  - id: dbn_output_file
    type: string
    doc: "DBN output file name"
    inputBinding:
      position: 4
outputs:
  - id: dbn_output
    type: File
    doc: "DBN output with read counts"
    outputBinding:
      glob: $(inputs.dbn_output_file)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segmentation-fold:1.7.0--py27_0
stdout: segmentation-fold_utils_add_read_counts.out
