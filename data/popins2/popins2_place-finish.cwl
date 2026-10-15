cwlVersion: v1.2
class: CommandLineTool
baseCommand: [popins2, place-finish]
label: popins2_place-finish
doc: "Contig placing, step 3/3: combine the breakpoint positions of the split-read alignments (locations_placed.txt of all samples) and append them to the VCF file.\n\nTool homepage: https://github.com/kehrlab/PopIns2"
inputs:
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Path to the sample directories. Default: '.' (the working directory, where the sample folders are staged)"
    inputBinding:
      position: 1
      prefix: --prefix
  - id: insertions
    type:
      - 'null'
      - string
    doc: "Name of the VCF file written by place-refalign (the placed records are appended). Default: insertions.vcf"
    inputBinding:
      position: 1
      prefix: --insertions
  - id: reference
    type:
      - 'null'
      - File
    secondaryFiles:
      - ".fai"
    doc: "Reference genome FASTA (default name genome.fa); staged in the working directory"
    inputBinding:
      position: 1
      prefix: --reference
      valueFrom: "$(self.basename)"
  - id: insertions_vcf
    type: File
    doc: "VCF written by popins2 place-refalign; staged in the working directory under the name given by insertions"
  - id: locations_file
    type: File
    doc: "Merged locations file written by popins2 place-refalign (locations.txt); staged in the working directory"
  - id: groups_file
    type: File
    doc: "Groups file written by popins2 place-refalign (groups.txt); staged in the working directory"
  - id: sample_dirs
    type:
      type: array
      items: Directory
    doc: "Sample folders written by popins2 place-splitalign (each with locations_placed.txt); staged in the working directory"
outputs:
  - id: vcf
    type: File
    doc: "VCF with all placed insertions"
    outputBinding:
      glob: "${return inputs.insertions || 'insertions.vcf';}"
  - id: log
    type: stderr
    doc: "Log messages"
requirements:
  - class: InlineJavascriptRequirement
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sample_dirs)
      - entryname: $(inputs.insertions || 'insertions.vcf')
        entry: $(inputs.insertions_vcf)
        writable: true
      - $(inputs.locations_file)
      - $(inputs.groups_file)
      - $(inputs.reference)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popins2:0.13.0--h077b44d_0
stderr: popins2_place-finish.log
