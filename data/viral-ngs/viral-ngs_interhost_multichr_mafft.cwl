cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - interhost.py
  - multichr_mafft
label: viral-ngs_interhost_multichr_mafft
doc: "Run the mafft alignment on a series of chromosomes provided in sample- partitioned FASTA files. Output as FASTA. (i.e. file1.fasta would contain chr1, chr2, chr3; file2.fasta would also contain chr1, chr2, chr3)\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_fastas
    type:
      type: array
      items: File
    doc: "Input FASTA files."
    inputBinding:
      position: 1
  - id: out_directory
    type: string
    doc: "Location for the output files (default is cwd: None)"
    inputBinding:
      position: 2
  - id: localpair
    type:
      - 'null'
      - boolean
    doc: "All pairwise alignments are computed with the Smith- Waterman algorithm."
    inputBinding:
      position: 20
      prefix: --localpair
  - id: globalpair
    type:
      - 'null'
      - boolean
    doc: "All pairwise alignments are computed with the Needleman-Wunsch algorithm."
    inputBinding:
      position: 20
      prefix: --globalpair
  - id: preservecase
    type:
      - 'null'
      - boolean
    doc: "Preserve base or aa case, as well as symbols."
    inputBinding:
      position: 20
      prefix: --preservecase
  - id: reorder
    type:
      - 'null'
      - boolean
    doc: "Output is ordered aligned rather than in the order of the input (default: None)."
    inputBinding:
      position: 20
      prefix: --reorder
  - id: gap_opening_penalty
    type:
      - 'null'
      - float
    doc: "Gap opening penalty (default: 1.53)."
    inputBinding:
      position: 20
      prefix: --gapOpeningPenalty
  - id: ep
    type:
      - 'null'
      - float
    doc: "Offset (works like gap extension penalty)."
    inputBinding:
      position: 20
      prefix: --ep
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Full output (default: False)."
    inputBinding:
      position: 20
      prefix: --verbose
  - id: output_as_clustal
    type:
      - 'null'
      - boolean
    doc: "Write output file in Clustal format rather than FASTA"
    inputBinding:
      position: 20
      prefix: --outputAsClustal
  - id: maxiters
    type:
      - 'null'
      - int
    doc: "Maximum number of refinement iterations (default: 0). Note: if \"--localpair\" or \"--globalpair\" is specified this defaults to 1000."
    inputBinding:
      position: 20
      prefix: --maxiters
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of processing threads (default: -1, where -1 indicates use of all available cores)."
    inputBinding:
      position: 20
      prefix: --threads
  - id: out_file_prefix
    type:
      - 'null'
      - string
    doc: "Prefix for the output file name (default: aligned)"
    inputBinding:
      position: 20
      prefix: --outFilePrefix
  - id: sample_relation_file
    type:
      - 'null'
      - string
    doc: "If the parameter sampleRelationFile is specified (as a file path), a JSON file will be written mapping sample name to sequence position in the output."
    inputBinding:
      position: 20
      prefix: --sampleRelationFile
  - id: sample_name_list_file
    type:
      - 'null'
      - string
    doc: "If the parameter sampleRelationFile is specified (as a file path), a file will be written mapping sample names in the order of their sequence positions in the output."
    inputBinding:
      position: 20
      prefix: --sampleNameListFile
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Base directory for temp files. [default: /tmp]"
    inputBinding:
      position: 20
      prefix: --tmp_dir
  - id: tmp_dir_keep
    type:
      - 'null'
      - boolean
    doc: "Keep the tmp_dir if an exception occurs while running. Default is to delete all temp files at the end, even if there's a failure."
    inputBinding:
      position: 20
      prefix: --tmp_dirKeep
outputs:
  - id: out_directory_dir
    type: Directory
    doc: "Output directory out_directory"
    outputBinding:
      glob: $(inputs.out_directory)
  - id: sample_relation_file_file
    type:
      - 'null'
      - File
    doc: "Output file written to sample_relation_file"
    outputBinding:
      glob: $(inputs.sample_relation_file)
  - id: sample_name_list_file_file
    type:
      - 'null'
      - File
    doc: "Output file written to sample_name_list_file"
    outputBinding:
      glob: $(inputs.sample_name_list_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
