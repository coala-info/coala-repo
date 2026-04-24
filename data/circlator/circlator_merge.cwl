cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - circlator
  - merge
label: circlator_merge
doc: "Merge original and new assembly\n\nTool homepage: https://github.com/sanger-pathogens/circlator"
inputs:
  - id: original_fasta
    type: File
    doc: Name of original assembly
    inputBinding:
      position: 1
  - id: new_fasta
    type: File
    doc: Name of new assembly
    inputBinding:
      position: 2
  - id: outprefix
    type: string
    doc: Prefix of output files
    inputBinding:
      position: 3
  - id: assemble_not_careful
    type:
      - 'null'
      - boolean
    doc: Do not use the --careful option with SPAdes (used by default)
    inputBinding:
      position: 104
      prefix: --assemble_not_careful
  - id: assemble_not_only_assembler
    type:
      - 'null'
      - boolean
    doc: Do not use the --assemble-only option with SPAdes (used by default)
    inputBinding:
      position: 104
      prefix: --assemble_not_only_assembler
  - id: assembler
    type:
      - 'null'
      - string
    doc: Assembler to use for reassemblies
    inputBinding:
      position: 104
      prefix: --assembler
  - id: b2r_length_cutoff
    type:
      - 'null'
      - int
    doc: All reads mapped to contigs shorter than this will be kept
    inputBinding:
      position: 104
      prefix: --b2r_length_cutoff
  - id: b2r_split_all_reads
    type:
      - 'null'
      - boolean
    doc: By default, reads mapped to shorter contigs are left unchanged. This 
      option splits them into two, broken at the middle of the contig to try to 
      force circularization. May help if the assembler does not detect circular 
      contigs (eg canu)
    inputBinding:
      position: 104
      prefix: --b2r_split_all_reads
  - id: breaklen
    type:
      - 'null'
      - int
    doc: breaklen option used by nucmer
    inputBinding:
      position: 104
      prefix: --breaklen
  - id: data_type
    type:
      - 'null'
      - string
    doc: String representing one of the 4 type of data analysed (only used for 
      Canu)
    inputBinding:
      position: 104
      prefix: --data_type
  - id: diagdiff
    type:
      - 'null'
      - int
    doc: Nucmer diagdiff option
    inputBinding:
      position: 104
      prefix: --diagdiff
  - id: min_id
    type:
      - 'null'
      - float
    doc: Nucmer minimum percent identity
    inputBinding:
      position: 104
      prefix: --min_id
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of hit for nucmer to report
    inputBinding:
      position: 104
      prefix: --min_length
  - id: min_length_merge
    type:
      - 'null'
      - int
    doc: Minimum length of nucmer hit to use when merging
    inputBinding:
      position: 104
      prefix: --min_length_merge
  - id: min_spades_circ_pc
    type:
      - 'null'
      - float
    doc: Min percent of contigs needed to be covered by nucmer hits to spades 
      circular contigs
    inputBinding:
      position: 104
      prefix: --min_spades_circ_pc
  - id: reads
    type:
      - 'null'
      - File
    doc: FASTA file of corrected reads that made the new assembly. Using this 
      triggers iterative contig pair merging
    inputBinding:
      position: 104
      prefix: --reads
  - id: reassemble_end
    type:
      - 'null'
      - int
    doc: max distance allowed between nucmer hit and end of reassembly contig
    inputBinding:
      position: 104
      prefix: --reassemble_end
  - id: ref_end
    type:
      - 'null'
      - int
    doc: max distance allowed between nucmer hit and end of input assembly 
      contig
    inputBinding:
      position: 104
      prefix: --ref_end
  - id: spades_k
    type:
      - 'null'
      - string
    doc: Comma separated list of kmers to use when running SPAdes. Max kmer is 
      127 and each kmer should be an odd integer
    inputBinding:
      position: 104
      prefix: --spades_k
  - id: spades_use_first
    type:
      - 'null'
      - boolean
    doc: Use the first successful SPAdes assembly. Default is to try all kmers 
      and use the assembly with the largest N50
    inputBinding:
      position: 104
      prefix: --spades_use_first
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for remapping/assembly (only applies if --reads is 
      used)
    inputBinding:
      position: 104
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/circlator:v1.5.5-3-deb_cv1
stdout: circlator_merge.out
