cwlVersion: v1.2
class: CommandLineTool
baseCommand: best_by_compleasm.py
label: tsebra_best_by_compleasm
doc: "Find or build the best gene set generated with BRAKER and TSEBRA minimizing missing BUSCOs using compleasm. Only computes a new BRAKER gene set if the percentage of missing BUSCOs exceeds 5%.\n\nTool homepage: https://github.com/Gaius-Augustus/TSEBRA"
inputs:
  - id: tmp_dir
    type: string
    doc: "Temporary directory where intermediate files will be written"
    inputBinding:
      position: 101
      prefix: -m
  - id: compleasm_bin
    type:
      - 'null'
      - string
    doc: "Location of compleasm.py on system"
    inputBinding:
      position: 101
      prefix: -c
  - id: input_dir
    type: Directory
    doc: "Output directory of BRAKER"
    inputBinding:
      position: 101
      prefix: -d
  - id: tsebra
    type:
      - 'null'
      - string
    doc: "Location of tsebra.py on system"
    inputBinding:
      position: 101
      prefix: -y
  - id: getanno
    type:
      - 'null'
      - string
    doc: "Location of getAnnoFastaFromJoingenes.py on system"
    inputBinding:
      position: 101
      prefix: -f
  - id: genome
    type: File
    doc: "Genome FASTA file"
    inputBinding:
      position: 101
      prefix: -g
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use for running compleasm"
    inputBinding:
      position: 101
      prefix: -t
  - id: busco_db
    type: string
    doc: "BUSCO lineage for running compleasm"
    inputBinding:
      position: 101
      prefix: -p
  - id: missing_busco_threshold
    type:
      - 'null'
      - float
    doc: "Threshold for the percentage of missing BUSCOs that decides until which point the BUSCOs in augustus and genemark gene sets will simply be added on top of the braker.gtf gene set, upper boundary"
    inputBinding:
      position: 101
      prefix: -n
  - id: diff_to_braker
    type:
      - 'null'
      - float
    doc: "Difference in percentage of missing BUSCOs between braker.gtf and the other gene sets that is allowed for the BUSCOs in the augustus and genemark gene sets to be added on top of the braker.gtf gene set"
    inputBinding:
      position: 101
      prefix: -a
outputs:
  - id: tmp_dir_out
    type:
      - 'null'
      - Directory
    doc: "Temporary and result directory"
    outputBinding:
      glob: $(inputs.tmp_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsebra:1.1.2.5--pyhca03a8a_0
