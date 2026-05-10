cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyhmmsearch
label: pyhmmsearch
doc: "Running: pyhmmsearch v2025.10.23.post1 via Python v3.12.12 | /usr/local/bin/python3.12\n\
  \nTool homepage: https://github.com/new-atlantis-labs/pyhmmsearch-stable"
inputs:
  - id: evalue
    type:
      - 'null'
      - float
    doc: E-value threshold
    inputBinding:
      position: 101
      prefix: --evalue
  - id: hmm_database
    type:
      - 'null'
      - File
    doc: path/to/database.hmm cannot be used with -b/-serialized_database. 
      Expects a (concatenated) HMM file and not a directory. You can build a 
      database from a directory using `serialize_hmm_models.py`
    inputBinding:
      position: 101
      prefix: --hmm_database
  - id: hmm_marker_field
    type:
      - 'null'
      - string
    doc: HMM reference type (accession, name)
    inputBinding:
      position: 101
      prefix: --hmm_marker_field
  - id: n_jobs
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --n_jobs
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: No header
    inputBinding:
      position: 101
  - id: proteins
    type: File
    doc: path/to/proteins.fasta. stdin does not stream and loads everything into
      memory.
    inputBinding:
      position: 101
      prefix: --proteins
  - id: score_type
    type:
      - 'null'
      - string
    doc: '{full, domain}'
    inputBinding:
      position: 101
      prefix: --score_type
  - id: scores_cutoff
    type:
      - 'null'
      - File
    doc: path/to/scores_cutoff.tsv[.gz] [id_hmm]<tab>[score_threshold], No 
      header.
    inputBinding:
      position: 101
      prefix: --scores_cutoff
  - id: serialized_database
    type:
      - 'null'
      - File
    doc: path/to/database.pkl cannot be used with -d/--database_directory. 
      Database should be pickled dictionary {name:hmm}
    inputBinding:
      position: 101
      prefix: --serialized_database
  - id: threshold_method
    type:
      - 'null'
      - string
    doc: Cutoff threshold method
    inputBinding:
      position: 101
      prefix: --threshold_method
  - id: domtblout_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: --domtblout
  - id: output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 103
      prefix: --output
  - id: tblout_path
    type:
      - 'null'
      - string
    doc: path/to/output.tblout
    inputBinding:
      position: 104
      prefix: --tblout
outputs:
  - id: output
    type: File
    doc: path/to/output.tsv
    outputBinding:
      glob: $(inputs.output_path)
  - id: tblout
    type:
      - 'null'
      - File
    doc: path/to/output.tblout
    outputBinding:
      glob: $(inputs.tblout_path)
  - id: domtblout
    type:
      - 'null'
      - File
    doc: path/to/output.domtblout
    outputBinding:
      glob: $(inputs.domtblout_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyhmmsearch:2025.10.23.post1--pyh7e72e81_0
