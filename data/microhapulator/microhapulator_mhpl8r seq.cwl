cwlVersion: v1.2
class: CommandLineTool
baseCommand: mhpl8r seq
label: microhapulator_mhpl8r seq
doc: "Simulate paired-end Illumina MiSeq sequencing of the given profile(s)\n\nTool
  homepage: https://github.com/bioforensics/MicroHapulator/"
inputs:
  - id: tsv
    type: File
    doc: microhaplotype marker definitions in tabular (TSV) format
    inputBinding:
      position: 1
  - id: refrseqs
    type: File
    doc: microhaplotype reference sequences in FASTA format
    inputBinding:
      position: 2
  - id: profiles
    type:
      type: array
      items: File
    doc: one or more simple or complex profiles (JSON files)
    inputBinding:
      position: 3
  - id: num_reads
    type:
      - 'null'
      - int
    doc: number of reads to simulate
    inputBinding:
      position: 104
      prefix: --num-reads
  - id: proportions
    type:
      - 'null'
      - type: array
        items: float
    doc: simulated mixture samples with multiple contributors at the specified 
      proportions; by default even proportions are used
    inputBinding:
      position: 104
      prefix: --proportions
  - id: seeds
    type:
      - 'null'
      - type: array
        items: int
    doc: seeds for random number generator, 1 per profile
    inputBinding:
      position: 104
      prefix: --seeds
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: write simulated paired-end MiSeq reads in FASTQ format to the specified
      file(s); if one filename is provided, reads are interleaved and written to
      the file; if two filenames are provided, reads are written to paired 
      files; by default, reads are interleaved and written to the terminal 
      (standard output)
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
