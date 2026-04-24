cwlVersion: v1.2
class: CommandLineTool
baseCommand: metav
label: metav
doc: "Metagenomics virus detection\n\nTool homepage: https://github.com/ZhijianZhou01/metav"
inputs:
  - id: forward_reads
    type:
      - 'null'
      - File
    doc: forward reads (*.fq) using paired-end sequencing.
    inputBinding:
      position: 101
      prefix: -i1
  - id: identity_threshold
    type:
      - 'null'
      - float
    doc: 'threshold of identity(%) of alignment aa for diamond output filtering, default:
      20.'
    inputBinding:
      position: 101
      prefix: -s
  - id: length_threshold
    type:
      - 'null'
      - int
    doc: 'threshold of length of aa alignment for diamond output filtering, default:
      10.'
    inputBinding:
      position: 101
      prefix: -len
  - id: nr_e_value
    type:
      - 'null'
      - float
    doc: 'specify two e-values threshold used to retain viral hits and exclude non-viral
      hits using nr database, default: 0.1,1e-5.'
    inputBinding:
      position: 101
      prefix: -ne
  - id: out_e_value
    type:
      - 'null'
      - float
    doc: 'specify three e-values threshold used to output the viral reads (or contigs),
    inputBinding:
      position: 101
      prefix: -oe
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: paired-end sequencing.
    inputBinding:
      position: 101
      prefix: -pe
  - id: profiles
    type:
      - 'null'
      - File
    doc: the *.xml file with parameters of dependent software and databases.
    inputBinding:
      position: 101
      prefix: -xml
  - id: qualities
    type:
      - 'null'
      - string
    doc: 'the qualities (phred33 or phred64) of sequenced reads, default: phred33.'
    inputBinding:
      position: 101
      prefix: -q
  - id: reverse_reads
    type:
      - 'null'
      - File
    doc: reverse reads (*.fq) using paired-end sequencing.
    inputBinding:
      position: 101
      prefix: -i2
  - id: run_pipeline_1
    type:
      - 'null'
      - boolean
    doc: run the sub-pipeline 1 (reads blastx [viral-nr and nr db]).
    inputBinding:
      position: 101
      prefix: -r1
  - id: run_pipeline_2
    type:
      - 'null'
      - boolean
    doc: run the sub-pipeline 2 (reads → contigs blastx [viral-nr and nr db]).
    inputBinding:
      position: 101
      prefix: -r2
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: single-end sequencing.
    inputBinding:
      position: 101
      prefix: -se
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of used threads, default: 10.'
    inputBinding:
      position: 101
      prefix: -t
  - id: unpaired_reads
    type:
      - 'null'
      - File
    doc: reads file using single-end sequencing (unpaired reads).
    inputBinding:
      position: 101
      prefix: -u
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output directory to store all results.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metav:2.0.0--pyhdfd78af_0
