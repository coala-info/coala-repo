cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - akt
  - kin
label: akt_kin
doc: "Calculate kinship/IBD statistics from a multisample BCF/VCF\n\nTool homepage:
  https://github.com/Illumina/akt"
inputs:
  - id: input_bcf
    type: File
    doc: Input multisample BCF/VCF containing genotypes
    inputBinding:
      position: 1
  - id: aftag
    type:
      - 'null'
      - string
    doc: allele frequency tag
    default: AF
    inputBinding:
      position: 102
      prefix: --aftag
  - id: force
    type:
      - 'null'
      - boolean
    doc: run kin without -R/-T/-F
    inputBinding:
      position: 102
      prefix: --force
  - id: freq_file
    type:
      - 'null'
      - File
    doc: a file containing population allele frequencies to use in kinship calculation
    inputBinding:
      position: 102
      prefix: --freq-file
  - id: method
    type:
      - 'null'
      - int
    doc: type of estimator. 0:plink (default) 1:king-robust 2:genetic-relationship-matrix
    default: 0
    inputBinding:
      position: 102
      prefix: --method
  - id: minkin
    type:
      - 'null'
      - float
    doc: threshold for relatedness output
    inputBinding:
      position: 102
      prefix: --minkin
  - id: regions
    type:
      - 'null'
      - string
    doc: chromosome region
    inputBinding:
      position: 102
      prefix: --regions
  - id: regions_file
    type:
      - 'null'
      - File
    doc: restrict to regions listed in a file
    inputBinding:
      position: 102
      prefix: --regions-file
  - id: samples
    type:
      - 'null'
      - string
    doc: list of samples
    inputBinding:
      position: 102
      prefix: --samples
  - id: samples_file
    type:
      - 'null'
      - File
    doc: list of samples, file
    inputBinding:
      position: 102
      prefix: --samples-file
  - id: targets
    type:
      - 'null'
      - string
    doc: similar to -r but streams rather than index-jumps
    inputBinding:
      position: 102
      prefix: --targets
  - id: targets_file
    type:
      - 'null'
      - File
    doc: similar to -R but streams rather than index-jumps
    inputBinding:
      position: 102
      prefix: --targets-file
  - id: threads
    type:
      - 'null'
      - int
    doc: num threads
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/akt:0.3.3--h5ca1c30_7
stdout: akt_kin.out
