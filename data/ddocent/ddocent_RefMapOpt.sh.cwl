cwlVersion: v1.2
class: CommandLineTool
baseCommand: RefMapOpt.sh
label: ddocent_RefMapOpt.sh
doc: "RefMapOpt\n\nTool homepage: https://ddocent.com"
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.reads)
inputs:
  - id: reads
    type:
      type: array
      items: File
    doc: Demultiplexed reads in dDocent naming, staged in the working 
      directory (<sample>.F.fq.gz and <sample>.R.fq.gz; RefMapOpt.sh also 
      maps the trimmed <sample>.R1.fq.gz and <sample>.R2.fq.gz)
  - id: minK1
    type: int
    doc: minK1
    inputBinding:
      position: 1
  - id: maxK1
    type: int
    doc: maxK1
    inputBinding:
      position: 2
  - id: minK2
    type: int
    doc: minK2
    inputBinding:
      position: 3
  - id: maxK2
    type: int
    doc: maxK2
    inputBinding:
      position: 4
  - id: cluster_similarity
    type: float
    doc: cluster_similarity
    inputBinding:
      position: 5
  - id: assembly_type
    type: string
    doc: Assembly_Type
    inputBinding:
      position: 6
  - id: num_of_processors
    type: int
    doc: Num_of_Processors
    inputBinding:
      position: 7
  - id: optional_list_of_individuals
    type:
      - 'null'
      - File
    doc: Optional file listing the individuals (one name per line) to map; 
      default is a random subset of the individuals
    inputBinding:
      position: 8
outputs:
  - id: mapping_results
    type: File
    doc: 'Mapping statistics for each K1/K2 pair (mapping.results: mean reads per
      contig, contigs, K1, K2, mappings, properly paired, ...)'
    outputBinding:
      glob: mapping.results
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ddocent:2.9.8--hdfd78af_0
stdout: ddocent_RefMapOpt.sh.out
