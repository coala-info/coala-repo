cwlVersion: v1.2
class: CommandLineTool
baseCommand: pprodigal
label: pprodigal
doc: "Parallel Prodigal gene prediction\n\nTool homepage: https://github.com/sjaenick/pprodigal"
inputs:
  - id: chunksize
    type:
      - 'null'
      - int
    doc: 'number of input sequences to process within a chunk (default: 2000)'
    inputBinding:
      position: 101
      prefix: --chunksize
  - id: closed
    type:
      - 'null'
      - boolean
    doc: Closed ends. Do not allow genes to run off edges.
    inputBinding:
      position: 101
      prefix: --closed
  - id: format
    type:
      - 'null'
      - string
    doc: Select output format (gbk, gff, or sco). Default is gbk.
    inputBinding:
      position: 101
      prefix: --format
  - id: gencode
    type:
      - 'null'
      - int
    doc: Specify a translation table to use (default 11).
    inputBinding:
      position: 101
      prefix: --gencode
  - id: input
    type:
      - 'null'
      - File
    doc: Specify FASTA/Genbank input file (default reads from stdin).
    inputBinding:
      position: 101
      prefix: --input
  - id: mask
    type:
      - 'null'
      - boolean
    doc: Treat runs of N as masked sequence; don't build genes across them.
    inputBinding:
      position: 101
      prefix: --mask
  - id: nosd
    type:
      - 'null'
      - boolean
    doc: Bypass Shine-Dalgarno trainer and force a full motif scan.
    inputBinding:
      position: 101
      prefix: --nosd
  - id: procedure
    type:
      - 'null'
      - string
    doc: Select procedure (single or meta). Default is single.
    inputBinding:
      position: 101
      prefix: --procedure
  - id: tasks
    type:
      - 'null'
      - int
    doc: 'number of prodigal processes to start in parallel (default: 20)'
    inputBinding:
      position: 101
      prefix: --tasks
  - id: nucl_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `nucl_path`
    inputBinding:
      position: 102
      prefix: --nucl
  - id: output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 103
      prefix: --output
  - id: proteins_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `proteins_path`
    inputBinding:
      position: 104
      prefix: --proteins
  - id: scorefile_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `scorefile_path`
    inputBinding:
      position: 105
      prefix: --scorefile
outputs:
  - id: proteins
    type:
      - 'null'
      - File
    doc: Write protein translations to the selected file.
    outputBinding:
      glob: $(inputs.proteins_path)
  - id: nucl
    type:
      - 'null'
      - File
    doc: Write nucleotide sequences of genes to the selected file.
    outputBinding:
      glob: $(inputs.nucl_path)
  - id: output
    type:
      - 'null'
      - File
    doc: Specify output file (default writes to stdout).
    outputBinding:
      glob: $(inputs.output_path)
  - id: scorefile
    type:
      - 'null'
      - File
    doc: Write all potential genes (with scores) to the selected file.
    outputBinding:
      glob: $(inputs.scorefile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pprodigal:1.0.1--pyhdfd78af_0
