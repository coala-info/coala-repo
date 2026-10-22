cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sketchlib
  - inverted
  - build
label: sketchlib_inverted_build
doc: "Create sketches from input data and store in an inverted index structure\n\nTool homepage: https://github.com/bacpop/sketchlib.rust"
inputs:
  - id: seq_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'List of input FASTA files'
    inputBinding:
      position: 1
  - id: file_list
    type:
      - 'null'
      - File
    doc: 'File listing input files (tab separated name, sequences, see README)'
    inputBinding:
      position: 101
      prefix: -f
  - id: write_skq
    type:
      - 'null'
      - boolean
    doc: 'Also write an .skq file, which is needed by ''precluster'' mode'
    inputBinding:
      position: 101
      prefix: --write-skq
  - id: species_names
    type:
      - 'null'
      - File
    doc: 'File listing species names, or clusters, for phylogenetic ordering'
    inputBinding:
      position: 101
      prefix: --species-names
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: 'Sketch size [default: 1000]'
    inputBinding:
      position: 101
      prefix: --sketch-size
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: 'K-mer size [default: 21]'
    inputBinding:
      position: 101
      prefix: --kmer-length
  - id: single_strand
    type:
      - 'null'
      - boolean
    doc: 'Ignore reverse complement (all contigs are oriented along same strand)'
    inputBinding:
      position: 101
      prefix: --single-strand
  - id: min_count
    type:
      - 'null'
      - int
    doc: 'Minimum k-mer count (with reads) [default: 5]'
    inputBinding:
      position: 101
      prefix: --min-count
  - id: min_qual
    type:
      - 'null'
      - int
    doc: 'Minimum k-mer quality (with reads) [default: 20]'
    inputBinding:
      position: 101
      prefix: --min-qual
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of CPU threads [default: 1]'
    inputBinding:
      position: 101
      prefix: --threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'Don''t show any messages'
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Show progress messages'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output
    type: string
    doc: 'Output filename for the merged sketch (prefix; .ski is added)'
    inputBinding:
      position: 102
      prefix: -o
  - id: file_list_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Sequence files named in the file list; they are staged in the working directory so that the names in the list resolve (give the list with plain file names)'
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Inverted index files written with the given output prefix (.ski, and .skq with --write-skq)
    outputBinding:
      glob: $(inputs.output)*
requirements:
  - class: InitialWorkDirRequirement
    listing: '${ return inputs.file_list_files ? inputs.file_list_files : []; }'
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sketchlib:0.2.4--h4349ce8_0
