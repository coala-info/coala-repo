cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metawrap
  - binning
label: metawrap_binning
doc: "Binning module for metagenomic assemblies\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs:
  - id: reads_a
    type:
      type: array
      items: File
    doc: Reads file(s) for replicate A (e.g., readsA_1.fastq readsA_2.fastq)
    inputBinding:
      position: 1
  - id: reads_x
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional reads file(s) for other replicates (e.g., readsX_1.fastq 
      readsX_2.fastq)
    inputBinding:
      position: 2
  - id: assembly_file
    type: File
    doc: metagenomic assembly file
    inputBinding:
      position: 103
      prefix: -a
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: the input read files contain interleaved paired-end reads
    inputBinding:
      position: 103
      prefix: --interleaved
  - id: memory
    type:
      - 'null'
      - int
    doc: amount of RAM available
    inputBinding:
      position: 103
      prefix: -m
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: minimum contig length to bin
    inputBinding:
      position: 103
      prefix: -l
  - id: run_checkm
    type:
      - 'null'
      - boolean
    doc: immediately run CheckM on the bin results (requires 40GB+ of memory)
    inputBinding:
      position: 103
      prefix: --run-checkm
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: non-paired reads mode (provide *.fastq files)
    inputBinding:
      position: 103
      prefix: --single-end
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 103
      prefix: -t
  - id: use_concoct
    type:
      - 'null'
      - boolean
    doc: bin contigs with CONCOCT
    inputBinding:
      position: 103
      prefix: --concoct
  - id: use_maxbin2
    type:
      - 'null'
      - boolean
    doc: bin contigs with MaxBin2
    inputBinding:
      position: 103
      prefix: --maxbin2
  - id: use_metabat1
    type:
      - 'null'
      - boolean
    doc: bin contigs with the original metaBAT
    inputBinding:
      position: 103
      prefix: --metabat1
  - id: use_metabat2
    type:
      - 'null'
      - boolean
    doc: bin contigs with metaBAT2
    inputBinding:
      position: 103
      prefix: --metabat2
  - id: use_universal_markers
    type:
      - 'null'
      - boolean
    doc: use universal marker genes instead of bacterial markers in MaxBin2 
      (improves Archaea binning)
    inputBinding:
      position: 103
      prefix: --universal
outputs:
  - id: output_dir
    type: Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap:1.2--0
