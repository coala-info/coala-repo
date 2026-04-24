cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribotin-hifiasm
label: ribotin_ribotin-hifiasm
doc: "A tool for assembling genomes using hifiasm, with support for various read types
  and advanced phasing options.\n\nTool homepage: https://github.com/maickrau/ribotin"
inputs:
  - id: annotation_gff3
    type:
      - 'null'
      - File
    doc: Lift over the annotations from given reference fasta+gff3 (requires 
      liftoff)
    inputBinding:
      position: 101
      prefix: --annotation-gff3
  - id: annotation_reference_fasta
    type:
      - 'null'
      - File
    doc: Lift over the annotations from given reference fasta+gff3 (requires 
      liftoff)
    inputBinding:
      position: 101
      prefix: --annotation-reference-fasta
  - id: approx_morphsize
    type:
      - 'null'
      - int
    doc: Approximate length of one morph
    inputBinding:
      position: 101
      prefix: --approx-morphsize
  - id: assembly
    type: string
    doc: Input hifiasm assembly prefix (required)
    inputBinding:
      position: 101
      prefix: --assembly
  - id: extra_phasing
    type:
      - 'null'
      - boolean
    doc: (Experimental) Use extra phasing heuristics during nanopore analysis. 
      Not recommended for r9 nanopore reads.
    inputBinding:
      position: 101
      prefix: --extra-phasing
  - id: graphaligner
    type:
      - 'null'
      - string
    doc: GraphAligner path
    inputBinding:
      position: 101
      prefix: --graphaligner
  - id: guess_tangles_using_reference
    type: string
    doc: Guess the rDNA tangles using k-mer matches to given reference sequence 
      (required)
    inputBinding:
      position: 101
      prefix: --guess-tangles-using-reference
  - id: hifi
    type: File
    doc: Input hifi reads (required)
    inputBinding:
      position: 101
      prefix: --hifi
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: 'k-mer size (default: 101)'
    inputBinding:
      position: 101
      prefix: -k
  - id: mbg
    type:
      - 'null'
      - string
    doc: MBG path
    inputBinding:
      position: 101
      prefix: --mbg
  - id: morph_cluster_maxedit
    type:
      - 'null'
      - int
    doc: 'Maximum edit distance between two morphs to assign them into the same cluster
      (default: 200)'
    inputBinding:
      position: 101
      prefix: --morph-cluster-maxedit
  - id: morph_recluster_minedit
    type:
      - 'null'
      - int
    doc: 'Minimum edit distance to recluster morphs (default: 5)'
    inputBinding:
      position: 101
      prefix: --morph-recluster-minedit
  - id: nano
    type:
      - 'null'
      - File
    doc: Input ultralong ONT reads
    inputBinding:
      position: 101
      prefix: --nano
  - id: orient_by_reference
    type:
      - 'null'
      - string
    doc: Rotate and possibly reverse complement the consensus to match the 
      orientation of the given reference
    inputBinding:
      position: 101
      prefix: --orient-by-reference
  - id: out
    type:
      - 'null'
      - Directory
    doc: 'Output folder prefix (default: ./result)'
    inputBinding:
      position: 101
      prefix: --out
  - id: preset_parameters
    type:
      - 'null'
      - string
    doc: Preset parameters
    inputBinding:
      position: 101
      prefix: -x
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Name of the sample added to all morph names
    inputBinding:
      position: 101
      prefix: --sample-name
  - id: samtools
    type:
      - 'null'
      - string
    doc: samtools path
    inputBinding:
      position: 101
      prefix: --samtools
  - id: tangles
    type:
      type: array
      items: File
    doc: Input files for node tangles. Multiple files may be inputed with -c 
      file1.txt -c file2.txt ...
    inputBinding:
      position: 101
      prefix: --tangles
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads (default: 1)'
    inputBinding:
      position: 101
      prefix: -t
  - id: ul_tmp_folder
    type:
      - 'null'
      - Directory
    doc: 'Temporary folder for ultralong ONT read analysis (default: ./tmp)'
    inputBinding:
      position: 101
      prefix: --ul-tmp-folder
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print extra debug information
    inputBinding:
      position: 101
      prefix: --verbose
  - id: winnowmap
    type:
      - 'null'
      - string
    doc: winnowmap/minimap path
    inputBinding:
      position: 101
      prefix: --winnowmap
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotin:1.5--h077b44d_0
stdout: ribotin_ribotin-hifiasm.out
