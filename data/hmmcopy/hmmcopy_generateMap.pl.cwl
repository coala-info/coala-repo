cwlVersion: v1.2
class: CommandLineTool
baseCommand: generateMap.pl
label: hmmcopy_generateMap.pl
doc: "Generate a mappability BigWig file for a FASTA reference by aligning fragments with bowtie.\n\nTool homepage: http://compbio.bccrc.ca/software/hmmcopy/"
inputs:
  - id: fasta_reference
    type: File
    secondaryFiles:
      - pattern: .fai
        required: false
    doc: "FASTA reference"
    inputBinding:
      position: 2
  - id: output
    type:
      - 'null'
      - string
    doc: "Output file name (also takes stdout) [default: <FASTA reference>.map.bw]"
    inputBinding:
      position: 1
      prefix: --output
  - id: window
    type:
      - 'null'
      - int
    doc: "Specify the fragment size to calculate mappability values [35]"
    inputBinding:
      position: 1
      prefix: --window
  - id: index
    type:
      - 'null'
      - string
    doc: "Location of a ready built bowtie index of the FASTA input"
    inputBinding:
      position: 1
      prefix: --index
  - id: build
    type:
      - 'null'
      - boolean
    doc: "Build bowtie index for the given FASTA reference"
    inputBinding:
      position: 1
      prefix: --build
  - id: index_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Ready built bowtie index files (.ebwt) of the FASTA reference, staged in the
      working directory (for example built with the build option)
outputs:
  - id: bowtie_index_files
    type:
      type: array
      items: File
    doc: Bowtie index files written by the build option
    outputBinding:
      glob: '*.ebwt'
  - id: mappability
    type:
      - 'null'
      - File
    doc: Mappability BigWig file
    outputBinding:
      glob: $(inputs.output || (inputs.fasta_reference.basename + '.map.bw'))
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fasta_reference)
        writable: true
      - $(inputs.index_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmcopy:0.1.1--h5b0a936_12
stdout: hmmcopy_generateMap.pl.out
