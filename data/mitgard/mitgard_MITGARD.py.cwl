cwlVersion: v1.2
class: CommandLineTool
baseCommand: MITGARD.py
label: mitgard_MITGARD.py
doc: "MITGARD (Mitochondrial Genome Assembly from RNA-seq Data) recovers the mitochondrial
  genome from short-read RNA-seq data, using single-end or paired-end reads and a
  reference mitogenome.\n\nTool homepage: https://github.com/pedronachtigall/MITGARD"
inputs:
  - id: sample_id
    type: string
    doc: Mandatory - sample ID to be used in the output files and final mitogenome
      assembly
    inputBinding:
      position: 101
      prefix: --sample
  - id: single_end
    type:
      - 'null'
      - File
    doc: Mandatory (unless paired reads are given) - input single-end fq file
      (FASTQ format); the fq file can be in the .gz compressed format
    inputBinding:
      position: 101
      prefix: --single_end
  - id: paired_read1
    type:
      - 'null'
      - File
    doc: Mandatory (unless single-end reads are given) - input paired-end read 1
      fq file (FASTQ format); the fq file can be in the .gz compressed format
    inputBinding:
      position: 101
      prefix: --paired_read1
  - id: paired_read2
    type:
      - 'null'
      - File
    doc: Mandatory (unless single-end reads are given) - input paired-end read 2
      fq file (FASTQ format); the fq file can be in the .gz compressed format
    inputBinding:
      position: 101
      prefix: --paired_read2
  - id: reference
    type: File
    doc: Mandatory - input mitogenome in FASTA format to be used as reference
    inputBinding:
      position: 101
      prefix: --reference
  - id: assembler
    type:
      - 'null'
      - string
    doc: Optional - assembler tools used to generate the mitochondrial contigs.
      Choose one from trinity, spades and mitoz or combine them (e.g. "trinity,spades,mitoz").
      By default, MITGARD uses trinity and spades. [default=trinity,spades]
    inputBinding:
      position: 101
      prefix: --assembler
  - id: low_coverage
    type:
      - 'null'
      - string
    doc: Optional - what to do with low coverage regions. Use "N" to assign N's
      in the low coverage regions. Use "R" to assign the reference nucleotides in
      the low coverage regions. [default=N]
    inputBinding:
      position: 101
      prefix: --low_coverage
  - id: rearrangement
    type:
      - 'null'
      - string
    doc: Optional - turn on/off an additional step to check for rearrangements
      using the mitochondrial contigs generated. To turn on set "True". [Default=False]
    inputBinding:
      position: 101
      prefix: --rearrangement
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: Optional - genetic code to be used in the "--genetic_code" parameter of
      the MitoZ assembler [Default=2]
    inputBinding:
      position: 101
      prefix: --genetic_code
  - id: clade
    type:
      - 'null'
      - string
    doc: Optional - taxonomic clade to be used in the "--clade" parameter of the
      MitoZ assembler [Default=Chordata]
    inputBinding:
      position: 101
      prefix: --clade
  - id: cpu
    type:
      - 'null'
      - int
    doc: Optional - number of threads to be used in each step [default=1]
    inputBinding:
      position: 101
      prefix: --cpu
  - id: memory
    type:
      - 'null'
      - string
    doc: Optional - max memory usage to be passed to the Trinity assembler
      [default=4G], use the same format as stated by Trinity
    inputBinding:
      position: 101
      prefix: --memory
outputs:
  - id: mitogenome
    type:
      - 'null'
      - File
    doc: Final mitogenome assembly.
    outputBinding:
      glob: $(inputs.sample_id)_mitogenome.fa*
  - id: contigs
    type:
      - 'null'
      - File
    doc: All contigs generated and used to build the mitogenome assembly.
    outputBinding:
      glob: $(inputs.sample_id)_contigs.fasta
  - id: rearrangement_check
    type:
      - 'null'
      - Directory
    doc: Rearrangement check results (only with --rearrangement True).
    outputBinding:
      glob: RearrangementCheck
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reference)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitgard:1.1--hdfd78af_0
stdout: mitgard_MITGARD.py.out
