cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitofinder
label: mitofinder
doc: "Mitofinder is a pipeline to assemble and annotate mitochondrial DNA from trimmed
  sequencing reads.\n\nTool homepage: https://github.com/parklab/xTea"
inputs:
  - id: adjust_direction
    type:
      - 'null'
      - boolean
    doc: This option tells MitoFinder to adjust the direction of selected 
      contig(s) (given the reference).
    inputBinding:
      position: 101
      prefix: --adjust-direction
  - id: allow_intron
    type:
      - 'null'
      - boolean
    doc: 'This option tells MitoFinder to search for genes with introns. Recommendation
      : Use it on mitochondrial contigs previously found with MitoFinder without this
      option.'
    inputBinding:
      position: 101
      prefix: --allow-intron
  - id: assembly
    type:
      - 'null'
      - File
    doc: File with your own assembly
    inputBinding:
      position: 101
      prefix: --assembly
  - id: blast_eval
    type:
      - 'null'
      - float
    doc: e-value of blast program used for contig identification and annotation.
      Default = 0.00001
    inputBinding:
      position: 101
      prefix: --blast-eval
  - id: blast_identity_nucl
    type:
      - 'null'
      - int
    doc: Nucleotide identity percentage for a hit to be retained. Default = 50
    inputBinding:
      position: 101
      prefix: --blast-identity-nucl
  - id: blast_identity_prot
    type:
      - 'null'
      - int
    doc: Amino acid identity percentage for a hit to be retained. Default = 40
    inputBinding:
      position: 101
      prefix: --blast-identity-prot
  - id: blast_size
    type:
      - 'null'
      - int
    doc: Percentage of overlap in blast best hit to be retained. Default = 30
    inputBinding:
      position: 101
      prefix: --blast-size
  - id: cds_merge
    type:
      - 'null'
      - boolean
    doc: This option tells MitoFinder to not merge the exons in the NT and AA 
      fasta files.
    inputBinding:
      position: 101
      prefix: --cds-merge
  - id: circular_offset
    type:
      - 'null'
      - int
    doc: Offset from start and finish to consider when looking for 
      circularization. Default = 200
    inputBinding:
      position: 101
      prefix: --circular-offset
  - id: circular_size
    type:
      - 'null'
      - int
    doc: Size to consider when checking for circularization. Default = 45
    inputBinding:
      position: 101
      prefix: --circular-size
  - id: citation
    type:
      - 'null'
      - boolean
    doc: How to cite MitoFinder
    inputBinding:
      position: 101
      prefix: --citation
  - id: config
    type:
      - 'null'
      - File
    doc: Use this option to specify another Mitofinder.config file.
    inputBinding:
      position: 101
      prefix: --config
  - id: example
    type:
      - 'null'
      - boolean
    doc: Print getting started examples
    inputBinding:
      position: 101
      prefix: --example
  - id: idba
    type:
      - 'null'
      - boolean
    doc: Use IDBA-UD for assembly.
    inputBinding:
      position: 101
      prefix: --idba
  - id: ignore
    type:
      - 'null'
      - boolean
    doc: This option tells MitoFinder to ignore the non- standart mitochondrial 
      genes.
    inputBinding:
      position: 101
      prefix: --ignore
  - id: intron_size
    type:
      - 'null'
      - int
    doc: Size of intron allowed. Default = 5000 bp
    inputBinding:
      position: 101
      prefix: --intron-size
  - id: max_contig
    type:
      - 'null'
      - int
    doc: Maximum number of contigs matching to the reference to keep. Default = 
      0 (unlimited)
    inputBinding:
      position: 101
      prefix: --max-contig
  - id: max_contig_size
    type:
      - 'null'
      - int
    doc: Maximum size of a contig to be considered. Default = 25000
    inputBinding:
      position: 101
      prefix: --max-contig-size
  - id: max_memory
    type:
      - 'null'
      - string
    doc: max memory to use in Go (MEGAHIT or MetaSPAdes)
    inputBinding:
      position: 101
      prefix: --max-memory
  - id: megahit
    type:
      - 'null'
      - boolean
    doc: Use Megahit for assembly. (Default)
    inputBinding:
      position: 101
      prefix: --megahit
  - id: metaspades
    type:
      - 'null'
      - boolean
    doc: Use MetaSPAdes for assembly.
    inputBinding:
      position: 101
      prefix: --metaspades
  - id: min_contig_size
    type:
      - 'null'
      - int
    doc: Minimum size of a contig to be considered. Default = 1000
    inputBinding:
      position: 101
      prefix: --min-contig-size
  - id: new_genes
    type:
      - 'null'
      - boolean
    doc: This option tells MitoFinder to try to annotate the non-standard animal
      mitochondrial genes (e.g. rps3 in fungi). If several references are used, 
      make sure the non-standard genes have the same names in the several 
      references
    inputBinding:
      position: 101
      prefix: --new-genes
  - id: numt
    type:
      - 'null'
      - boolean
    doc: 'This option tells MitoFinder to search for both mitochondrial genes and
      NUMTs. Recommendation : Use it on nuclear contigs previously found with MitoFinder
      without this option.'
    inputBinding:
      position: 101
      prefix: --numt
  - id: nwalk
    type:
      - 'null'
      - int
    doc: Maximum number of codon steps to be tested on each size of the gene to 
      find the start and stop codon during the annotation step. Default = 5 (30 
      bases)
    inputBinding:
      position: 101
      prefix: --nwalk
  - id: organism_type
    type:
      - 'null'
      - int
    doc: 'Organism genetic code following NCBI table (integer): 1. The Standard Code
      2. The Vertebrate Mitochondrial Code 3. The Yeast Mitochondrial Code 4. The
      Mold, Protozoan, and Coelenterate Mitochondrial Code and the Mycoplasma/Spiroplasma
      Code 5. The Invertebrate Mitochondrial Code 6. The Ciliate, Dasycladacean and
      Hexamita Nuclear Code 9. The Echinoderm and Flatworm Mitochondrial Code 10.
      The Euplotid Nuclear Code 11. The Bacterial, Archaeal and Plant Plastid Code
      12. The Alternative Yeast Nuclear Code 13. The Ascidian Mitochondrial Code 14.
      The Alternative Flatworm Mitochondrial Code 16. Chlorophycean Mitochondrial
      Code 21. Trematode Mitochondrial Code 22. Scenedesmus obliquus Mitochondrial
      Code 23. Thraustochytrium Mitochondrial Code 24. Pterobranchia Mitochondrial
      Code 25. Candidate Division SR1 and Gracilibacteria Code'
    inputBinding:
      position: 101
      prefix: --organism
  - id: out_gb
    type:
      - 'null'
      - boolean
    doc: Do not create annotation output file in GenBank format.
    inputBinding:
      position: 101
      prefix: --out-gb
  - id: override
    type:
      - 'null'
      - boolean
    doc: This option forces MitoFinder to override the previous output directory
      for the selected assembler.
    inputBinding:
      position: 101
      prefix: --override
  - id: paired_end1
    type:
      - 'null'
      - File
    doc: File with forward paired-end reads
    inputBinding:
      position: 101
      prefix: --Paired-end1
  - id: paired_end2
    type:
      - 'null'
      - File
    doc: File with reverse paired-end reads
    inputBinding:
      position: 101
      prefix: --Paired-end2
  - id: process_name
    type:
      - 'null'
      - string
    doc: Sequence ID to be used throughout the process
    inputBinding:
      position: 101
      prefix: --seqid
  - id: processors_to_use
    type:
      - 'null'
      - int
    doc: Number of threads Mitofinder will use at most.
    inputBinding:
      position: 101
      prefix: --processors
  - id: refseq_file
    type:
      - 'null'
      - File
    doc: Reference mitochondrial genome in GenBank format (.gb).
    inputBinding:
      position: 101
      prefix: --refseq
  - id: rename_contig
    type:
      - 'null'
      - string
    doc: '"yes/no" If "yes", the contigs matching the reference(s) are renamed. Default
      is "yes" for de novo assembly and "no" for existing assembly (-a option)'
    inputBinding:
      position: 101
      prefix: --rename-contig
  - id: shortest_contig
    type:
      - 'null'
      - int
    doc: Shortest contig length to be used (MEGAHIT). Default = 100
    inputBinding:
      position: 101
      prefix: --length
  - id: single_end
    type:
      - 'null'
      - File
    doc: File with single-end reads
    inputBinding:
      position: 101
      prefix: --Single-end
  - id: trna_annotation
    type:
      - 'null'
      - string
    doc: '"arwen"/"mitfi"/"trnascan" tRNA annotater to use.'
    inputBinding:
      position: 101
      prefix: --tRNA-annotation
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitofinder:1.4.1--py27h9801fc8_1
stdout: mitofinder.out
