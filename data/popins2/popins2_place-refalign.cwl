cwlVersion: v1.2
class: CommandLineTool
baseCommand: [popins2, place-refalign]
label: popins2_place-refalign
doc: "Contig placing, step 1/3: merge the contig locations of all samples and align contig ends to the reference genome; writes VCF records for placed contigs.\n\nTool homepage: https://github.com/kehrlab/PopIns2"
inputs:
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Path to the sample directories. Default: '.' (the working directory, where the sample folders are staged)"
    inputBinding:
      position: 1
      prefix: --prefix
  - id: locations
    type:
      - 'null'
      - string
    doc: "Name of the merged locations file. Default: locations.txt"
    inputBinding:
      position: 1
      prefix: --locations
  - id: insertions
    type:
      - 'null'
      - string
    doc: "Name of the VCF output file. Default: insertions.vcf"
    inputBinding:
      position: 1
      prefix: --insertions
  - id: contigs
    type:
      - 'null'
      - File
    doc: "Supercontigs FASTA (default name supercontigs.fa); staged in the working directory"
    inputBinding:
      position: 1
      prefix: --contigs
      valueFrom: "$(self.basename)"
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
  - id: groups
    type:
      - 'null'
      - string
    doc: "Name of the file with groups of contigs that can be placed at the same position. Default: groups.txt"
    inputBinding:
      position: 1
      prefix: --groups
  - id: min_score
    type:
      - 'null'
      - float
    doc: "Minimal anchoring score for a location. In range [0..1]. Default: 0.3"
    inputBinding:
      position: 1
      prefix: --minScore
  - id: min_reads
    type:
      - 'null'
      - int
    doc: "Minimal number of anchoring read pairs for a location. Default: 2"
    inputBinding:
      position: 1
      prefix: --minReads
  - id: max_insert_size
    type:
      - 'null'
      - int
    doc: "The maximum expected insert size of the read pairs. Default: 800"
    inputBinding:
      position: 1
      prefix: --maxInsertSize
  - id: read_length
    type:
      - 'null'
      - int
    doc: "The length of the reads. Default: 100"
    inputBinding:
      position: 1
      prefix: --readLength
  - id: group_dist
    type:
      - 'null'
      - int
    doc: "Minimal distance between groups of locations. Default: 100"
    inputBinding:
      position: 1
      prefix: --groupDist
  - id: sample_dirs
    type:
      type: array
      items: Directory
    doc: "Sample folders written by popins2 contigmap (each with locations.txt); staged in the working directory"
outputs:
  - id: vcf
    type:
      - 'null'
      - File
    doc: "VCF with the placed insertions"
    outputBinding:
      glob: "${return inputs.insertions || 'insertions.vcf';}"
  - id: locations_file
    type:
      - 'null'
      - File
    doc: "Merged locations"
    outputBinding:
      glob: "${return inputs.locations || 'locations.txt';}"
  - id: groups_file
    type:
      - 'null'
      - File
    doc: "Groups of contigs that can be placed at the same position"
    outputBinding:
      glob: "${return inputs.groups || 'groups.txt';}"
  - id: sample_dirs_out
    type:
      type: array
      items: Directory
    doc: "Sample folders with locations_unplaced.txt"
    outputBinding:
      glob: "${return inputs.sample_dirs.map(function(d) { return d.basename; });}"
  - id: log
    type: stderr
    doc: "Log messages"
requirements:
  - class: InlineJavascriptRequirement
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sample_dirs)
        writable: true
      - $(inputs.reference)
      - $(inputs.contigs)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popins2:0.13.0--h077b44d_0
stderr: popins2_place-refalign.log
