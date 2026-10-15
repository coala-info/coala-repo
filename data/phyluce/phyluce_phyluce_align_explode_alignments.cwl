cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_explode_alignments]
label: phyluce_phyluce_align_explode_alignments
doc: "Explode a directory of alignments into FASTA-formatted files for each locus or taxon.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: "Input folder of alignments."
    inputBinding:
      position: 1
      prefix: --alignments
  - id: output
    type: string
    doc: "Output folder of fasta files."
    inputBinding:
      position: 2
      prefix: --output
  - id: input_format
    type: ['null', string]
    doc: "The input alignment format. One of: fasta, nexus, phylip, clustal, emboss, stockholm (default: nexus)."
    inputBinding:
      position: 3
      prefix: --input-format
  - id: conf
    type: ['null', File]
    doc: "Config file for renaming."
    inputBinding:
      position: 4
      prefix: --conf
  - id: section
    type: ['null', string]
    doc: "Section of config file to use."
    inputBinding:
      position: 5
      prefix: --section
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: "Taxa/taxon to exclude."
    inputBinding:
      position: 6
      prefix: --exclude
  - id: by_taxon
    type: ['null', boolean]
    doc: "Explode file by taxon instead of by-locus."
    inputBinding:
      position: 7
      prefix: --by-taxon
  - id: include_locus
    type: ['null', boolean]
    doc: "Include the locus name in the FASTA header."
    inputBinding:
      position: 8
      prefix: --include-locus
outputs:
  - id: output_dir
    type: Directory
    doc: "Folder of FASTA files, one per locus or per taxon."
    outputBinding:
      glob: "$(inputs.output)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
