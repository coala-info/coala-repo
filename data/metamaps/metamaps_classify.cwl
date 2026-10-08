cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metamaps
  - classify
label: metamaps_classify
doc: "Classify reads from a metamaps mapDirectly mapping file against a MetaMaps database (EM step); writes <mappings>.EM* files beside the mapping file.\n\nTool homepage: https://github.com/DiltheyLab/MetaMaps"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.mappings)
        writable: true
inputs:
  - id: db
    type: Directory
    doc: Path to DB
    inputBinding:
      position: 1
      prefix: --DB
  - id: mappings
    type: File
    doc: Path to mappings file (from metamaps mapDirectly), with its .meta files
    secondaryFiles:
      - .meta
      - pattern: .meta.unmappedReadsLengths
        required: false
      - pattern: .parameters
        required: false
    inputBinding:
      position: 2
      prefix: --mappings
      valueFrom: $(self.basename)
  - id: minreads
    type: ['null', int]
    doc: Minimum number of reads per contig to be considered for fitting identity and length for the 'Unknown' functionality
    inputBinding:
      position: 3
      prefix: --minreads
  - id: threads
    type: ['null', int]
    doc: 'count of threads for parallel execution [default : 1]'
    inputBinding:
      position: 4
      prefix: --threads
outputs:
  - id: em
    type: File
    doc: EM result file (<mappings>.EM)
    outputBinding:
      glob: $(inputs.mappings.basename).EM
  - id: wimp
    type: File
    doc: Taxonomic abundance estimates (<mappings>.EM.WIMP)
    outputBinding:
      glob: $(inputs.mappings.basename).EM.WIMP
  - id: reads2taxon
    type: File
    doc: Read-to-taxon assignments (<mappings>.EM.reads2Taxon)
    outputBinding:
      glob: $(inputs.mappings.basename).EM.reads2Taxon
  - id: em_files
    type: File[]
    doc: All other files written by classify (<mappings>.EM.*, e.g. krona, contigCoverage, lengthAndIdentitiesPerMappingUnit, evidenceUnknownSpecies)
    outputBinding:
      glob: $(inputs.mappings.basename).EM.*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metamaps:0.1.98102e9--h21ec9f0_2
