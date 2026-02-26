cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seq2science
  - explain
label: seq2science_explain
doc: "Explains what has/will be done for the workflow. This prints a string which
  can serve as a skeleton for your material & methods section. Supported workflows:
  scrna-seq, download-fastq, rna-seq, alignment, atac-seq, scatac-seq, chip-seq\n\n\
  Tool homepage: https://vanheeringen-lab.github.io/seq2science"
inputs:
  - id: workflow
    type: string
    doc: The workflow to explain (e.g., scrna-seq, download-fastq, rna-seq, 
      alignment, atac-seq, scatac-seq, chip-seq)
    inputBinding:
      position: 1
  - id: configfile
    type:
      - 'null'
      - File
    doc: The path to the config file.
    inputBinding:
      position: 102
      prefix: --configfile
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'For developers "only": prints helpful error messages to debug issues.'
    inputBinding:
      position: 102
      prefix: --debug
  - id: hyperref
    type:
      - 'null'
      - boolean
    doc: Print urls as html hyperref
    inputBinding:
      position: 102
      prefix: --hyperref
  - id: profile
    type:
      - 'null'
      - string
    doc: 'Use a seq2science profile. Profiles can be taken from: https://github.com/vanheeringen-lab/seq2science-profiles.'
    inputBinding:
      position: 102
      prefix: --profile
  - id: snakemake_options
    type:
      - 'null'
      - type: array
        items: string
    doc: Extra arguments to pass along to snakemake. An example could be 
      seq2science run alignment --cores 12 --snakemakeOptions 
      resources={mem_gb:100} local_cores=3.
    inputBinding:
      position: 102
      prefix: --snakemakeOptions
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq2science:1.2.4--pyhdfd78af_0
stdout: seq2science_explain.out
