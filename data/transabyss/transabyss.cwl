cwlVersion: v1.2
class: CommandLineTool
baseCommand: transabyss
label: transabyss
doc: "Assemble RNAseq with Trans-ABySS.\n\nTool homepage: http://www.bcgsc.ca/platform/bioinfo/software/trans-abyss"
inputs:
  - id: se
    type:
      - 'null'
      - type: array
        items: File
    doc: "single-end read files"
    inputBinding:
      prefix: --se
  - id: pe
    type:
      - 'null'
      - type: array
        items: File
    doc: "paired-end read files"
    inputBinding:
      prefix: --pe
  - id: ss
    type:
      - 'null'
      - boolean
    doc: "input reads are strand-specific"
    inputBinding:
      prefix: --SS
  - id: outdir
    type:
      - 'null'
      - string
    default: transabyss_out
    doc: "output directory [/tmp/transabyss_2.0.1_assembly]"
    inputBinding:
      prefix: --outdir
  - id: name
    type:
      - 'null'
      - string
    doc: "assembly name [transabyss] (ie. output assembly: 'transabyss-final.fa')"
    inputBinding:
      prefix: --name
  - id: stage
    type:
      - 'null'
      - string
    doc: "run up to the specified stage (dbg, unitigs, contigs, references, junctions, final) [final]"
    inputBinding:
      prefix: --stage
  - id: length
    type:
      - 'null'
      - int
    doc: "minimum output sequence length [100]"
    inputBinding:
      prefix: --length
  - id: cleanup
    type:
      - 'null'
      - int
    doc: "level of clean-up of intermediate files, 0 to 3 [1]"
    inputBinding:
      prefix: --cleanup
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of threads ('j' in abyss-pe) [1]"
    inputBinding:
      prefix: --threads
  - id: mpi
    type:
      - 'null'
      - int
    doc: "number of MPI processes ('np' in abyss-pe) [0]"
    inputBinding:
      prefix: --mpi
  - id: kmer
    type:
      - 'null'
      - int
    doc: "k-mer size [32]"
    inputBinding:
      prefix: --kmer
  - id: cov
    type:
      - 'null'
      - int
    doc: "minimum mean k-mer coverage of a unitig [2]"
    inputBinding:
      prefix: --cov
  - id: eros
    type:
      - 'null'
      - int
    doc: "minimum erosion k-mer coverage [c]"
    inputBinding:
      prefix: --eros
  - id: seros
    type:
      - 'null'
      - int
    doc: "minimum erosion k-mer coverage per strand [0]"
    inputBinding:
      prefix: --seros
  - id: qends
    type:
      - 'null'
      - int
    doc: "minimum base quality on 5' and 3' ends of a read [3]"
    inputBinding:
      prefix: --qends
  - id: qall
    type:
      - 'null'
      - int
    doc: "minimum base quality throughout a read"
    inputBinding:
      prefix: --qall
  - id: pairs
    type:
      - 'null'
      - int
    doc: "minimum number of pairs for building contigs [2]"
    inputBinding:
      prefix: --pairs
  - id: seed
    type:
      - 'null'
      - int
    doc: "minimum unitig size for building contigs [k]"
    inputBinding:
      prefix: --seed
  - id: gsim
    type:
      - 'null'
      - int
    doc: "maximum iterations of graph simplification [2]"
    inputBinding:
      prefix: --gsim
  - id: indel
    type:
      - 'null'
      - int
    doc: "indel size tolerance [1]"
    inputBinding:
      prefix: --indel
  - id: island
    type:
      - 'null'
      - int
    doc: "minimum length of island unitigs [0]"
    inputBinding:
      prefix: --island
  - id: useblat
    type:
      - 'null'
      - boolean
    doc: "use BLAT alignments to remove redundant sequences."
    inputBinding:
      prefix: --useblat
  - id: pid
    type:
      - 'null'
      - float
    doc: "minimum percent sequence identity of redundant sequences [0.95]"
    inputBinding:
      prefix: --pid
  - id: walk
    type:
      - 'null'
      - float
    doc: "percentage of mean k-mer coverage of seed for path-walking [0.05]"
    inputBinding:
      prefix: --walk
  - id: noref
    type:
      - 'null'
      - boolean
    doc: "do not include reference paths in final assembly"
    inputBinding:
      prefix: --noref
outputs:
  - id: output_dir
    type: Directory
    doc: Assembly output directory (contains the final assembly FASTA).
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transabyss:2.0.1--py27_4
