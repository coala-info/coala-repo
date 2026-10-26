cwlVersion: v1.2
class: CommandLineTool
baseCommand: unitig-counter
label: unitig-counter
doc: "Count unitigs in sequencing data.\n\nTool homepage: https://github.com/johnlees/unitig-counter"
inputs:
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: Compress unitig output using gzip.
    inputBinding:
      position: 101
      prefix: -gzip
  - id: k
    type:
      - 'null'
      - int
    doc: K-mer size.
    inputBinding:
      position: 101
      prefix: -k
  - id: nb_cores
    type:
      - 'null'
      - int
    doc: number of cores
    inputBinding:
      position: 101
      prefix: -nb-cores
  - id: output
    type:
      - 'null'
      - string
    doc: Path to the folder where the final and temporary files will be stored.
    inputBinding:
      position: 101
      prefix: -output
  - id: strain_files
    type:
      type: array
      items: File
    doc: Fasta files of the strains named in the strains file; they are staged in the working directory so the paths in the strains file resolve
  - id: strains
    type: File
    doc: 'A text file describing the strains containing 2 columns: 1) ID of the strain;
      2) Path to a multi-fasta file containing the sequences of the strain. This file
      needs a header.'
    inputBinding:
      position: 101
      prefix: -strains
      valueFrom: $(self.basename)
  - id: verbose
    type:
      - 'null'
      - int
    doc: verbosity level
    inputBinding:
      position: 101
      prefix: -verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: folder with the final unitig files and the graph
    outputBinding:
      glob: |
        ${ return inputs.output ? inputs.output : 'output'; }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.strain_files)
      - $(inputs.strains)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unitig-counter:1.1.0--h5ca1c30_2
stdout: unitig-counter.out
