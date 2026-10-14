cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylophlan_write_config_file
label: phylophlan_write_config_file
doc: "Generates a configuration file to be used with the phylophlan script, with standard parameters for the selected software.\n\nTool homepage: https://github.com/biobakery/phylophlan"
inputs:
  - id: output
    type: string
    doc: "Output file where to write the configurations"
    inputBinding:
      position: 1
      prefix: "--output"
  - id: db_type
    type: string
    doc: "Type of the database: n for nucleotides, a for amino acids"
    inputBinding:
      position: 2
      prefix: "--db_type"
  - id: db_dna
    type:
      - 'null'
      - string
    doc: "Software for building the indexed database (makeblastdb)"
    inputBinding:
      position: 3
      prefix: "--db_dna"
  - id: db_aa
    type:
      - 'null'
      - string
    doc: "Software for building the indexed database (usearch or diamond)"
    inputBinding:
      position: 3
      prefix: "--db_aa"
  - id: map_dna
    type:
      - 'null'
      - string
    doc: "Software for mapping the database against the input genomes (blastn, tblastn or diamond)"
    inputBinding:
      position: 4
      prefix: "--map_dna"
  - id: map_aa
    type:
      - 'null'
      - string
    doc: "Software for mapping the database against the input proteomes (usearch or diamond)"
    inputBinding:
      position: 4
      prefix: "--map_aa"
  - id: msa
    type: string
    doc: "Software for producing the MSAs (muscle, mafft, opal or upp)"
    inputBinding:
      position: 5
      prefix: "--msa"
  - id: trim
    type:
      - 'null'
      - string
    doc: "Software for the gappy regions removal of the MSAs (trimal)"
    inputBinding:
      position: 6
      prefix: "--trim"
  - id: gene_tree1
    type:
      - 'null'
      - string
    doc: "Software for building the phylogenies for the markers in the database (fasttree, raxml or iqtree)"
    inputBinding:
      position: 7
      prefix: "--gene_tree1"
  - id: gene_tree2
    type:
      - 'null'
      - string
    doc: "Software for refining the gene phylogenies built with gene_tree1 (raxml)"
    inputBinding:
      position: 7
      prefix: "--gene_tree2"
  - id: tree1
    type: string
    doc: "Software for building the first phylogeny (fasttree, raxml, iqtree, astral or astrid)"
    inputBinding:
      position: 8
      prefix: "--tree1"
  - id: tree2
    type:
      - 'null'
      - string
    doc: "Software for refining the phylogeny built with tree1 (raxml)"
    inputBinding:
      position: 8
      prefix: "--tree2"
  - id: absolute_path
    type:
      - 'null'
      - boolean
    doc: "Write the absolute path to the executable instead of the executable name found in the system path"
    inputBinding:
      position: 9
      prefix: "--absolute_path"
  - id: force_nucleotides
    type:
      - 'null'
      - boolean
    doc: "Set parameters for phylogenetic analysis software so that they use nucleotide sequences, even in the case of a database of amino acids"
    inputBinding:
      position: 9
      prefix: "--force_nucleotides"
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Overwrite output file if it exists"
    inputBinding:
      position: 9
      prefix: "--overwrite"
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Prints more stuff"
    inputBinding:
      position: 9
      prefix: "--verbose"
outputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: "Configuration file"
    outputBinding:
      glob: "$(inputs.output)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylophlan:3.2.1--pyhdfd78af_0
stdout: phylophlan_write_config_file.out
