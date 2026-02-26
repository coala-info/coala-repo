cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribotin-ref
label: ribotin_ribotin-ref
doc: "Ribotin reference-based analysis\n\nTool homepage: https://github.com/maickrau/ribotin"
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
  - id: extra_phasing
    type:
      - 'null'
      - boolean
    doc: (Experimental) Use extra phasing heuristics during nanopore analysis. 
      Not recommended for r9 nanopore reads.
    inputBinding:
      position: 101
      prefix: --extra-phasing
  - id: graphaligner_path
    type:
      - 'null'
      - string
    doc: GraphAligner path
    inputBinding:
      position: 101
      prefix: --graphaligner
  - id: input_hifi_duplex_reads
    type:
      type: array
      items: File
    doc: Input HiFi/duplex reads. Multiple files can be input with -i file1.fa 
      -i file2.fa etc
    inputBinding:
      position: 101
      prefix: --in
  - id: input_ultralong_ont_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: Input ultralong ONT reads. Multiple files can be input with --nano 
      file1.fa --nano file2.fa etc
    inputBinding:
      position: 101
      prefix: --nano
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size
    default: 101
    inputBinding:
      position: 101
      prefix: -k
  - id: mbg_path
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
    doc: Maximum edit distance between two morphs to assign them into the same 
      cluster
    default: 200
    inputBinding:
      position: 101
      prefix: --morph-cluster-maxedit
  - id: morph_recluster_minedit
    type:
      - 'null'
      - int
    doc: Minimum edit distance to recluster morphs
    default: 5
    inputBinding:
      position: 101
      prefix: --morph-recluster-minedit
  - id: orient_by_reference
    type:
      - 'null'
      - string
    doc: Rotate and possibly reverse complement the consensus to match the 
      orientation of the given reference
    inputBinding:
      position: 101
      prefix: --orient-by-reference
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Output folder
    default: ./result
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
  - id: reference
    type: File
    doc: Reference used for recruiting reads
    inputBinding:
      position: 101
      prefix: --reference
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Name of the sample added to all morph names
    inputBinding:
      position: 101
      prefix: --sample-name
  - id: samtools_path
    type:
      - 'null'
      - string
    doc: samtools path
    inputBinding:
      position: 101
      prefix: --samtools
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print extra debug information
    inputBinding:
      position: 101
      prefix: --verbose
  - id: winnowmap_path
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
stdout: ribotin_ribotin-ref.out
