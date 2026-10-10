cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitohifi.py
label: mitohifi_mitohifi.py
doc: "MitoHiFi assembles and annotates animal or plant mitochondrial genomes from
  PacBio HiFi reads (-r) or finds and annotates the mitogenome in already assembled
  contigs (-c), using a closely related mitogenome as reference.\n\nTool homepage:
  https://github.com/marcelauliano/MitoHiFi"
inputs:
  - id: reads
    type:
      - 'null'
      - File
    doc: "-r: Pacbio Hifi Reads from your species (FASTA). Use either reads or contigs."
    inputBinding:
      position: 1
      prefix: -r
  - id: contigs
    type:
      - 'null'
      - File
    doc: "-c: Assembled fasta contigs/scaffolds to be searched to find the mitogenome.
      Use either reads or contigs."
    inputBinding:
      position: 2
      prefix: -c
  - id: related_fasta
    type: File
    doc: "-f: Close-related mitogenome in fasta format"
    inputBinding:
      position: 3
      prefix: -f
  - id: related_genbank
    type: File
    doc: "-g: Close-related species mitogenome in GenBank format"
    inputBinding:
      position: 4
      prefix: -g
  - id: threads
    type: int
    doc: "-t: Number of threads for (i) hifiasm and (ii) the blast search"
    inputBinding:
      position: 5
      prefix: -t
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "-d: debug mode to output additional info on log"
    inputBinding:
      position: 6
      prefix: -d
  - id: kingdom
    type:
      - 'null'
      - string
    doc: "-a: Choose between animal (default) or plant"
    inputBinding:
      position: 7
      prefix: -a
  - id: query_percentage
    type:
      - 'null'
      - int
    doc: "-p: Percentage of query in the blast match with close-related mito"
    inputBinding:
      position: 8
      prefix: -p
  - id: bloom_filter
    type:
      - 'null'
      - int
    doc: "-m: Number of bits for HiFiasm bloom filter [it maps to -f in HiFiasm]
      (default = 0)"
    inputBinding:
      position: 9
      prefix: -m
  - id: circular_size
    type:
      - 'null'
      - int
    doc: Size to consider when checking for circularization
    inputBinding:
      position: 10
      prefix: --circular-size
  - id: circular_offset
    type:
      - 'null'
      - int
    doc: Offset from start and finish to consider when looking for circularization
    inputBinding:
      position: 11
      prefix: --circular-offset
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: "-o: Organism genetic code following NCBI table (for mitogenome annotation),
      e.g. 1 Standard, 2 Vertebrate Mitochondrial, 5 Invertebrate Mitochondrial"
    inputBinding:
      position: 12
      prefix: -o
outputs:
  - id: final_fasta
    type:
      - 'null'
      - File
    doc: Final mitochondrial genome assembly.
    outputBinding:
      glob: final_mitogenome.fasta
  - id: final_genbank
    type:
      - 'null'
      - File
    doc: Annotated final mitochondrial genome in GenBank format.
    outputBinding:
      glob: final_mitogenome.gb
  - id: contigs_stats
    type:
      - 'null'
      - File
    doc: Statistics of the candidate mitochondrial contigs.
    outputBinding:
      glob: contigs_stats.tsv
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reads)
        writable: true
      - entry: $(inputs.contigs)
        writable: true
      - entry: $(inputs.related_fasta)
        writable: true
      - entry: $(inputs.related_genbank)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mitohifi:2.2_cv1
stdout: mitohifi_mitohifi.py.out
