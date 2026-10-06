cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bactopia-sketcher
label: bactopia-sketcher
doc: "Sketch FASTQ reads for Bactopia: Mash sketches at k=21 and k=31 and a Sourmash\
  \ signature (k=21,31,51).\n\nUsage: bactopia-sketcher <PREFIX> <FASTQ> <OPT1> ...\
  \ <OPTN>\n\nTool homepage: https://bactopia.github.io/"
inputs:
  - id: prefix
    type: string
    doc: Sample name used as the prefix of the output files
    inputBinding:
      position: 1
  - id: fastq
    type: File
    doc: Gzip-compressed FASTQ file of the sample reads
    inputBinding:
      position: 2
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional options (OPT1 ... OPTN); the script accepts them but does not
      use them
    inputBinding:
      position: 3
outputs:
  - id: mash_k21
    type: File
    doc: Mash sketch with k=21
    outputBinding:
      glob: $(inputs.prefix)-k21.msh
  - id: mash_k31
    type: File
    doc: Mash sketch with k=31
    outputBinding:
      glob: $(inputs.prefix)-k31.msh
  - id: sourmash_sig
    type: File
    doc: Sourmash signature (k=21,31,51, abundance, scaled=1000)
    outputBinding:
      glob: $(inputs.prefix).sig
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bactopia-sketcher:1.0.2--hdfd78af_0
