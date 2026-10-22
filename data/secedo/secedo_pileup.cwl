cwlVersion: v1.2
class: CommandLineTool
baseCommand: pileup
label: secedo_pileup
doc: "Creates pileup files (SECEDO binary and samtools-like text format) from a directory of single-cell BAM files, as input for secedo.\n\nTool homepage: https://github.com/ratschlab/secedo"
inputs:
  - id: input_dir
    type: Directory
    doc: Input directory containing BAM files (each BAM needs its .bai index beside it)
    inputBinding:
      position: 1
      prefix: -i
  - id: output_prefix
    type: string
    doc: "File prefix where the pileup output will be written. Written files will be of the form <out_prefix>_<chromosome_id>.pileup.bin"
    inputBinding:
      position: 1
      prefix: -o
  - id: chromosomes
    type: ['null', string]
    doc: "Chromosomes on which to run the algorithm, comma separated (default 1,2,...,22,X,Y)"
    inputBinding:
      position: 1
      prefix: -chromosomes
  - id: log_level
    type: ['null', string]
    doc: "The log verbosity: debug, trace, info, warn, error, critical, off"
    inputBinding:
      position: 1
      prefix: -log_level
  - id: max_coverage
    type: ['null', int]
    doc: Positions with higher coverage are considered anomalies and discarded during preprocessing (default 100)
    inputBinding:
      position: 1
      prefix: -max_coverage
  - id: min_base_quality
    type: ['null', int]
    doc: Minimum Phred quality score for the sequencer (default 30)
    inputBinding:
      position: 1
      prefix: -min_base_quality
  - id: min_different
    type: ['null', int]
    doc: Minimum number of bases that need to differ from the majority in order to add the locus to the pileup (default 3)
    inputBinding:
      position: 1
      prefix: -min_different
  - id: min_map_quality
    type: ['null', int]
    doc: Minimum score for the mapping quality (default 30)
    inputBinding:
      position: 1
      prefix: -min_map_quality
  - id: min_map_score
    type: ['null', int]
    doc: Minimum score for a read to be accepted (default 0)
    inputBinding:
      position: 1
      prefix: -min_map_score
  - id: num_threads
    type: ['null', int]
    doc: Number of threads to use (default 8)
    inputBinding:
      position: 1
      prefix: -num_threads
outputs:
  - id: pileup_files
    type:
      type: array
      items: File
    doc: Pileup files written with the output prefix
    outputBinding:
      glob: $(inputs.output_prefix)*
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/secedo:1.0.7--ha041835_4
stdout: secedo_pileup.out
