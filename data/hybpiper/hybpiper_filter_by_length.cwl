cwlVersion: v1.2
class: CommandLineTool
baseCommand: hybpiper filter_by_length
label: hybpiper_filter_by_length
doc: "Filters sequences based on length criteria.\n\nTool homepage: https://github.com/mossmatters/HybPiper"
inputs:
  - id: sequence_type
    type: string
    doc: 'File sequence type for all FASTA files to filter in current directory. For
      example, the amino-acid output of HybPiper would be: aa'
    inputBinding:
      position: 1
  - id: denylist
    type: File
    doc: 'Text file containing gene-sample combinations to omit. The format of the
      file should be one gene per line, a tab, and then a comma-delimited list of
      samples to disallow: gene[tab]sample1,sample2,sample3'
    inputBinding:
      position: 102
      prefix: --denylist
  - id: denylist_filename
    type:
      - 'null'
      - string
    doc: File name for the "deny list" text file (if written). Default is 
      <denylist.txt>
    default: <denylist.txt>
    inputBinding:
      position: 102
      prefix: --denylist_filename
  - id: length_filter
    type:
      - 'null'
      - int
    doc: Minimum length to allow a sequence in nucleotides for DNA or amino 
      acids for protein sequences
    inputBinding:
      position: 102
      prefix: --length_filter
  - id: percent_filter
    type:
      - 'null'
      - float
    doc: Minimum fraction (between 0 and 1) of the mean target length to allow a
      sequence for a gene. Lengths taken from HybPiper stats file.
    inputBinding:
      position: 102
      prefix: --percent_filter
  - id: run_profiler
    type:
      - 'null'
      - boolean
    doc: If supplied, run the subcommand using cProfile. Saves a *.csv file of 
      results
    inputBinding:
      position: 102
      prefix: --run_profiler
  - id: seq_lengths_file
    type: File
    doc: Filename for the seq_lengths file (output of the "hybpiper stats" 
      command), with a list of genes in the first row, mean target lengths in 
      the second row, and sample recovery in other rows.
    inputBinding:
      position: 102
      prefix: --seq_lengths_file
  - id: sequence_dir
    type:
      - 'null'
      - Directory
    doc: Specify directory containing sequences output by the "hybpiper 
      retrieve_sequences" command. Default is to search in the current working 
      directory
    inputBinding:
      position: 102
      prefix: --sequence_dir
outputs:
  - id: filtered_dir
    type:
      - 'null'
      - Directory
    doc: Specify directory for output filtered FASTA files. Default is to write 
      to the current working directory
    outputBinding:
      glob: $(inputs.filtered_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybpiper:2.3.4--pyhdfd78af_0
