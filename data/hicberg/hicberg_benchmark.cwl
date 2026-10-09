cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hicberg
  - benchmark
label: hicberg_benchmark
doc: 'Perform benchmarking of the statistical model (this can be time consuming).


  Tool homepage: https://github.com/sebgra/hicberg'
inputs:
  - id: genome
    type: File
    doc: Genome FASTA file.
    inputBinding:
      position: 1
  - id: output_folder
    type: Directory
    doc: Result folder created by hicberg create-folder (and filled by the earlier
      stages). It is staged writable; the stage adds its files to it. It must hold
      the files of the earlier stages, including the group1 BAM files and the chunks
      sub-folder made by hicberg chunk.
    inputBinding:
      position: 100
      prefix: --output
      valueFrom: $(runtime.outdir)/$(inputs.output_folder.basename)
  - id: original_matrix
    type:
      - 'null'
      - File
    doc: Original (not depleted) contact matrix in .cool format to benchmark against.
      It is copied into the result folder as original_map.cool, the name hicberg benchmark
      reads. Not needed if the folder already holds it.
  - id: chromosome
    type:
      - 'null'
      - string
    doc: Chromosome to get as source for duplication.
    inputBinding:
      position: 104
      prefix: --chromosome
  - id: position
    type:
      - 'null'
      - int
    doc: Position to get as source for duplication.
    inputBinding:
      position: 104
      prefix: --position
  - id: trans_chromosome
    type:
      - 'null'
      - string
    doc: Chromosome to get as target for duplication.
    inputBinding:
      position: 104
      prefix: --trans-chromosome
  - id: trans_position
    type:
      - 'null'
      - string
    doc: Position to get as target for duplication.
    inputBinding:
      position: 104
      prefix: --trans-position
  - id: bins
    type:
      - 'null'
      - int
    doc: Number of bins to select from a genomic coordinates.
    inputBinding:
      position: 104
      prefix: --bins
  - id: strides
    type:
      - 'null'
      - string
    doc: Strides to apply from source genomic coordinates to define targets intervals.
      Multiple strides must be coma separated.
    inputBinding:
      position: 104
      prefix: --strides
  - id: auto
    type:
      - 'null'
      - int
    doc: Automatically select auto intervals for duplication.
    inputBinding:
      position: 104
      prefix: --auto
  - id: kernel_size
    type:
      - 'null'
      - int
    doc: Size of the gaussian kernel for contact density estimation.
    inputBinding:
      position: 104
      prefix: --kernel-size
  - id: deviation
    type:
      - 'null'
      - float
    doc: Standard deviation for contact density estimation.
    inputBinding:
      position: 104
      prefix: --deviation
  - id: mode
    type:
      - 'null'
      - string
    doc: Statistical model to use for ambiguous reads assignment. Multiple modes must
      be coma separated.
    inputBinding:
      position: 104
      prefix: --mode
  - id: pattern
    type:
      - 'null'
      - string
    doc: Set pattern if benchmarking considering patterns (loops, borders, hairpins
      or -1).
    inputBinding:
      position: 104
      prefix: --pattern
  - id: threshold
    type:
      - 'null'
      - float
    doc: Set pattern score threshold under which pattern are discarded.
    inputBinding:
      position: 104
      prefix: --threshold
  - id: jitter
    type:
      - 'null'
      - int
    doc: Set jitter for pattern detection interval overlapping.
    inputBinding:
      position: 104
      prefix: --jitter
  - id: trend
    type:
      - 'null'
      - string
    doc: Set if detrending of the contact map has to be performed.
    inputBinding:
      position: 104
      prefix: --trend
  - id: top
    type:
      - 'null'
      - int
    doc: Set the top k % of patterns to retain.
    inputBinding:
      position: 104
      prefix: --top
  - id: iterations
    type:
      - 'null'
      - int
    doc: Set the number of iterations for benchmarking.
    inputBinding:
      position: 104
      prefix: --iterations
  - id: force
    type:
      - 'null'
      - boolean
    doc: Set if previous analysis files have to be deleted.
    inputBinding:
      position: 104
      prefix: --force
  - id: cpus
    type:
      - 'null'
      - int
    doc: Threads to use for analysis.
    inputBinding:
      position: 104
      prefix: --cpus
outputs:
  - id: output_folder_out
    type: Directory
    doc: The same result folder with the files this stage wrote.
    outputBinding:
      glob: $(inputs.output_folder.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.output_folder)
        writable: true
      - '${ return inputs.original_matrix ? {entryname: inputs.output_folder.basename
        + ''/original_map.cool'', entry: inputs.original_matrix} : null; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
