cwlVersion: v1.2
class: CommandLineTool
baseCommand: flye
label: flye
doc: Assembly of long reads with repeat graphs
inputs:
  - id: pacbio_raw
    type:
      - 'null'
      - type: array
        items: File
    doc: PacBio regular CLR reads (<20% error)
    inputBinding:
      position: 101
      prefix: --pacbio-raw
  - id: pacbio_corr
    type:
      - 'null'
      - type: array
        items: File
    doc: PacBio reads that were corrected with other methods (<3% error)
    inputBinding:
      position: 101
      prefix: --pacbio-corr
  - id: pacbio_hifi
    type:
      - 'null'
      - type: array
        items: File
    doc: PacBio HiFi reads (<1% error)
    inputBinding:
      position: 101
      prefix: --pacbio-hifi
  - id: nano_raw
    type:
      - 'null'
      - type: array
        items: File
    doc: ONT reads with odler chemistries, pre R9 Guppy5 (10-20% error)
    inputBinding:
      position: 101
      prefix: --nano-raw
  - id: nano_corr
    type:
      - 'null'
      - type: array
        items: File
    doc: ONT reads that were corrected with other methods (<3% error)
    inputBinding:
      position: 101
      prefix: --nano-corr
  - id: nano_hq
    type:
      - 'null'
      - type: array
        items: File
    doc: ONT R10 reads, aka Q20 (<3% error). For R9 Guppy5+, increase 
      --read-error slightly
    inputBinding:
      position: 101
      prefix: --nano-hq
  - id: subassemblies
    type:
      - 'null'
      - type: array
        items: File
    doc: '[deprecated] high-quality contigs input'
    inputBinding:
      position: 101
      prefix: --subassemblies
  - id: genome_size
    type:
      - 'null'
      - string
    doc: estimated genome size (for example, 5m or 2.6g)
    inputBinding:
      position: 101
      prefix: --genome-size
  - id: out_dir
    type: string
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: number of parallel threads [1]
    inputBinding:
      position: 101
      prefix: --threads
  - id: iterations
    type:
      - 'null'
      - int
    doc: number of polishing iterations [1]
    inputBinding:
      position: 101
      prefix: --iterations
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: minimum overlap between reads [auto]
    inputBinding:
      position: 101
      prefix: --min-overlap
  - id: asm_coverage
    type:
      - 'null'
      - int
    doc: reduced coverage for initial disjointig assembly [not set]
    inputBinding:
      position: 101
      prefix: --asm-coverage
  - id: hifi_error
    type:
      - 'null'
      - float
    doc: '[deprecated] same as --read-error'
    inputBinding:
      position: 101
      prefix: --hifi-error
  - id: read_error
    type:
      - 'null'
      - float
    doc: adjust parameters for given read error rate (as fraction e.g. 0.03)
    inputBinding:
      position: 101
      prefix: --read-error
  - id: extra_params
    type:
      - 'null'
      - string
    doc: extra configuration parameters list (comma-separated)
    inputBinding:
      position: 101
      prefix: --extra-params
  - id: plasmids
    type:
      - 'null'
      - boolean
    doc: unused (retained for backward compatibility)
    inputBinding:
      position: 101
      prefix: --plasmids
  - id: meta
    type:
      - 'null'
      - boolean
    doc: metagenome / uneven coverage mode
    inputBinding:
      position: 101
      prefix: --meta
  - id: keep_haplotypes
    type:
      - 'null'
      - boolean
    doc: do not collapse alternative haplotypes
    inputBinding:
      position: 101
      prefix: --keep-haplotypes
  - id: no_alt_contigs
    type:
      - 'null'
      - boolean
    doc: do not output contigs representing alternative haplotypes
    inputBinding:
      position: 101
      prefix: --no-alt-contigs
  - id: scaffold
    type:
      - 'null'
      - boolean
    doc: enable scaffolding using graph [disabled by default]
    inputBinding:
      position: 101
      prefix: --scaffold
  - id: trestle
    type:
      - 'null'
      - boolean
    doc: '[deprecated] enable Trestle [disabled by default]'
    inputBinding:
      position: 101
      prefix: --trestle
  - id: polish_target
    type:
      - 'null'
      - File
    doc: run polisher on the target sequence
    inputBinding:
      position: 101
      prefix: --polish-target
  - id: resume
    type:
      - 'null'
      - boolean
    doc: resume from the last completed stage
    inputBinding:
      position: 101
      prefix: --resume
  - id: resume_from
    type:
      - 'null'
      - string
    doc: resume from a custom stage
    inputBinding:
      position: 101
      prefix: --resume-from
  - id: stop_after
    type:
      - 'null'
      - string
    doc: stop after the specified stage completed
    inputBinding:
      position: 101
      prefix: --stop-after
  - id: debug
    type:
      - 'null'
      - boolean
    doc: enable debug output
    inputBinding:
      position: 101
      prefix: --debug
  - id: deterministic
    type:
      - 'null'
      - boolean
    doc: perform disjointig assembly single-threaded
    inputBinding:
      position: 101
      prefix: --deterministic
outputs:
  - id: output_out_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flye:2.9.6--py310h275bdba_0
s:url: https://github.com/fenderglass/Flye/
$namespaces:
  s: https://schema.org/
