cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - compare_genomes_dnadiff.py
label: wub_compare_genomes_dnadiff.py
doc: 'Compare a set of reference sequences (genome) to another set (target assembly)
  using mummer''s dnadiff. It prints the alignment results to stdout. All parsed results
  can be saved in a pickle file.


  Tool homepage: https://github.com/nanoporetech/wub'
inputs:
  - id: reference_fasta
    type: File
    doc: Reference fasta.
    inputBinding:
      position: 1
  - id: target_fasta
    type: File
    doc: Target fasta.
    inputBinding:
      position: 2
  - id: results_pickle
    type:
      - 'null'
      - string
    doc: Save pickled results in this file (None).
    inputBinding:
      position: 103
      prefix: -p
  - id: raw_file
    type:
      - 'null'
      - string
    doc: Save dnadiff report in this file (None).
    inputBinding:
      position: 103
      prefix: -r
  - id: work_dir
    type:
      - 'null'
      - string
    doc: Use this working directory instead of a temporary directory (None).
    inputBinding:
      position: 103
      prefix: -d
  - id: keep_files
    type:
      - 'null'
      - boolean
    doc: Keep dnadiff result files (False).
    inputBinding:
      position: 103
      prefix: -k
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print out dnadiff output (False).
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: dnadiff_txt
    type: File
    doc: Alignment results printed to stdout.
    outputBinding:
      glob: dnadiff.out.txt
  - id: pickle
    type:
      - 'null'
      - File
    doc: Pickled results.
    outputBinding:
      glob: $(inputs.results_pickle)
  - id: raw_report
    type:
      - 'null'
      - File
    doc: Raw dnadiff report.
    outputBinding:
      glob: $(inputs.raw_file)
  - id: work_directory
    type:
      - 'null'
      - Directory
    doc: Kept dnadiff working directory.
    outputBinding:
      glob: $(inputs.work_dir)
stdout: dnadiff.out.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
