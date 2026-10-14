cwlVersion: v1.2
class: CommandLineTool
baseCommand: phytest
label: phytest
doc: "Run phytest, a pytest-based tool that checks phylogenetic data (sequences, trees, data tables) with a test file.\n\nTool homepage: https://github.com/phytest-devs/phytest"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: testfile
    type: File
    doc: Path to test file.
    inputBinding:
      position: 100
  - id: sequence
    type:
      - 'null'
      - File
    doc: Path to sequence file.
    inputBinding:
      position: 1
      prefix: --sequence
  - id: sequence_format
    type:
      - 'null'
      - string
    doc: "Sequence file format: abi, abi-trim, ace, fasta, fasta-2line, ig, embl, embl-cds, gb, gck, genbank, genbank-cds, imgt, nib, cif-seqres, cif-atom, pdb-atom, pdb-seqres, phd, pir, fastq, fastq-sanger, fastq-solexa, fastq-illumina, qual, seqxml, sff, snapgene, sff-trim, swiss, tab, twobit, uniprot-xml, xdna, clustal, emboss, fasta-m10, maf, mauve, msf, nexus, phylip, phylip-sequential, phylip-relaxed, stockholm. [default: fasta]"
    inputBinding:
      position: 1
      prefix: --sequence-format
  - id: tree
    type:
      - 'null'
      - File
    doc: Path to tree file.
    inputBinding:
      position: 1
      prefix: --tree
  - id: tree_format
    type:
      - 'null'
      - string
    doc: "Tree file format: newick, nexus, phyloxml, nexml. [default: newick]"
    inputBinding:
      position: 1
      prefix: --tree-format
  - id: data
    type:
      - 'null'
      - File
    doc: Path to data file.
    inputBinding:
      position: 1
      prefix: --data
  - id: data_format
    type:
      - 'null'
      - string
    doc: "Data file format: csv, tsv, excel. [default: csv]"
    inputBinding:
      position: 1
      prefix: --data-format
  - id: report_path
    type:
      - 'null'
      - string
    doc: Path to HTML report to generate.
    inputBinding:
      position: 1
      prefix: --report
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 1
      prefix: --verbose
  - id: keyword
    type:
      - 'null'
      - string
    doc: Only run tests which match the given substring expression.
    inputBinding:
      position: 1
      prefix: -k
  - id: cores
    type:
      - 'null'
      - string
    doc: Number of cores. Use 'auto' to spawn a number of workers processes
      equal to the number of available CPUs.
    inputBinding:
      position: 1
      prefix: -n
outputs:
  - id: report
    type:
      - 'null'
      - File
    doc: HTML report
    outputBinding:
      glob: $(inputs.report_path)
  - id: stdout
    type: stdout
    doc: Standard output (test results)
successCodes: [0, 1]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phytest:1.4.1--pyhdfd78af_0
stdout: phytest.out
