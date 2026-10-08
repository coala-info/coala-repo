cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - duphist
label: duphist
doc: "DupHIST (Duplication History Inference with Substitution-integrated Topology)
  reconstructs the order and timing of gene duplication events in gene families
  from CDS and protein sequences. Usage: duphist [config_file_name]. All inputs
  and options are set in the INI-style config file; the files it names are staged
  in the working directory.\n\nTool homepage: https://github.com/minjeongjj/DupHIST"
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.input_files)
inputs:
  - id: config_file
    type: File
    doc: DupHIST configuration file (cds_fasta, pep_fasta, group_info,
      output_dir, custom_tree_list, statistical, program and thread options).
    inputBinding:
      position: 1
  - id: input_files
    type:
      type: array
      items: File
    doc: Files named in the config file (CDS FASTA, protein FASTA, group info
      file, and optional custom tree list and Newick trees). They are staged in
      the working directory, so the config must name them by base name
      (e.g. test.cds.fa or ./ATHA_G1.nwk).
  - id: output_dir
    type:
      - 'null'
      - string
    doc: Value of output_dir in the config file; used only to collect the
      results.
    default: Results
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: results_dir
    type: Directory
    doc: Output directory with the final table, dendrograms and temp files
    outputBinding:
      glob: $(inputs.output_dir)
  - id: logs
    type:
      type: array
      items: File
    doc: duplication_precheck.log and duplication_progress.log
    outputBinding:
      glob: duplication_*.log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/duphist:1.1.0--hdfd78af_1
stdout: duphist.out
