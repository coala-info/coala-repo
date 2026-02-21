cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - autocycler
  - compress
label: autocycler_compress
doc: "compress input contigs into a unitig graph\n\nTool homepage: https://github.com/rrwick/Autocycler"
inputs:
  - id: assemblies_dir
    type: Directory
    doc: Directory containing input assemblies
    inputBinding:
      position: 101
      prefix: --assemblies_dir
  - id: kmer
    type:
      - 'null'
      - int
    doc: K-mer size for De Bruijn graph
    default: 51
    inputBinding:
      position: 101
      prefix: --kmer
  - id: max_contigs
    type:
      - 'null'
      - int
    doc: refuse to run if mean contigs per assembly exceeds this value
    default: 25
    inputBinding:
      position: 101
      prefix: --max_contigs
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads
    default: 8
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: autocycler_dir
    type: Directory
    doc: Autocycler directory to be created
    outputBinding:
      glob: $(inputs.autocycler_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0
