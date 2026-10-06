cwlVersion: v1.2
class: CommandLineTool
baseCommand: bttcmp
label: bttcmp
doc: "BTTCMP (Bacillus thuringiensis Toxin Classification and Mining Pipeline)
  predicts Bt toxin genes from reads, assembled genomes, ORFs or proteins. Results
  are written to Results/ in the working directory.\n\nTool homepage: https://github.com/liaochenlanruo/BTTCMP/blob/master/README.md"
inputs:
  - id: seq_path
    type: Directory
    doc: The path of input sequences (the folder is staged writable, because
      some modes write filtered files into it)
    inputBinding:
      position: 101
      prefix: --SeqPath
      valueFrom: $(self.basename)
  - id: sequence_type
    type:
      - 'null'
      - type: enum
        symbols:
          - reads
          - nucl
          - orfs
          - prot
    doc: Sequence type for inputs. "reads", "nucl", "orfs", and "prot" avaliable
      ( Default nucl )
    inputBinding:
      position: 101
      prefix: --SequenceType
  - id: platform
    type:
      - 'null'
      - type: enum
        symbols:
          - illumina
          - pacbio
          - oxford
          - hybrid
    doc: Sequencing Platform, "illumina", "pacbio", "oxford" and "hybrid" available
      ( Default illumina )
    inputBinding:
      position: 101
      prefix: --platform
  - id: assemble_only
    type:
      - 'null'
      - string
    doc: Only perform genome assembly without predicting toxins.
    inputBinding:
      position: 101
      prefix: --assemble_only
  - id: reads1
    type:
      - 'null'
      - string
    doc: '[Required by "reads"] The suffix name of reads 1 (for example ".R1.clean.fastq.gz")'
    inputBinding:
      position: 101
      prefix: --reads1
  - id: reads2
    type:
      - 'null'
      - string
    doc: '[Required by "reads"] The suffix name of reads 2 (not required by "oxford"
      and "pacbio")'
    inputBinding:
      position: 101
      prefix: --reads2
  - id: suffix_len
    type:
      - 'null'
      - int
    doc: '[Required by "reads"] The suffix length of the reads file, that is the
      length of the reads name minus the length of the strain name ( Default 0 )'
    inputBinding:
      position: 101
      prefix: --suffix_len
  - id: short1
    type:
      - 'null'
      - string
    doc: FASTQ file name of first short reads in each pair, inside SeqPath. Needed
      by hybrid assembly
    inputBinding:
      position: 101
      prefix: --short1
  - id: short2
    type:
      - 'null'
      - string
    doc: FASTQ file name of second short reads in each pair, inside SeqPath. Needed
      by hybrid assembly
    inputBinding:
      position: 101
      prefix: --short2
  - id: long
    type:
      - 'null'
      - string
    doc: FASTQ or FASTA file name of long reads, inside SeqPath. Needed by hybrid
      assembly
    inputBinding:
      position: 101
      prefix: --long
  - id: hout
    type:
      - 'null'
      - string
    doc: Output directory for hybrid assembly ( Default ./Results/Assembles/Hybrid
      )
    inputBinding:
      position: 101
      prefix: --hout
  - id: genome_size
    type:
      - 'null'
      - string
    doc: An estimate of the size of the genome, for example 3.7m or 2.8g. Needed
      by PacBio data and Oxford data ( Default 6.07m )
    inputBinding:
      position: 101
      prefix: --genomeSize
  - id: scaf_suffix
    type:
      - 'null'
      - string
    doc: The suffix of scaffolds or genomes ( Default ".filtered.fas" )
    inputBinding:
      position: 101
      prefix: --Scaf_suffix
  - id: orfs_suffix
    type:
      - 'null'
      - string
    doc: The suffix of orfs files ( Default ".ffn" )
    inputBinding:
      position: 101
      prefix: --orfs_suffix
  - id: prot_suffix
    type:
      - 'null'
      - string
    doc: The suffix of protein files ( Default ".faa" )
    inputBinding:
      position: 101
      prefix: --prot_suffix
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to be used ( Default 4 )
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: results
    type: Directory
    doc: Results folder (Results/Toxins holds the toxin predictions and tables)
    outputBinding:
      glob: Results
  - id: log
    type:
      - 'null'
      - File
    doc: BTTCMP log file
    outputBinding:
      glob: BTTCMP.log
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.seq_path)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bttcmp:1.0.3--0
