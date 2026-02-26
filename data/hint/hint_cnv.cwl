cwlVersion: v1.2
class: CommandLineTool
baseCommand: hint cnv
label: hint_cnv
doc: "prediction of copy number information, as well as segmentation from Hi-C.\n\n\
  Tool homepage: https://github.com/suwangbio/HiNT_py3"
inputs:
  - id: bicseq
    type: File
    doc: /path/to/bicseqDir/
    inputBinding:
      position: 101
      prefix: --bicseq
  - id: doiter
    type:
      - 'null'
      - boolean
    doc: If this switch is on, HiNT will do the iterative regression model by 
      removing copy numer variated regions, DEFAULT=False
    default: false
    inputBinding:
      position: 101
      prefix: --doiter
  - id: enzyme
    type:
      - 'null'
      - string
    doc: enzyme used for the Hi-C experiments, will be used to calculate enzyme 
      sites
    inputBinding:
      position: 101
      prefix: --enzyme
  - id: format
    type:
      - 'null'
      - string
    doc: 'Format for the output contact matrix, DEFAULT: cooler'
    default: cooler
    inputBinding:
      position: 101
      prefix: --format
  - id: genome
    type:
      - 'null'
      - string
    doc: 'Specify your species, choose form hg38, hg19, and mm10. DEFAULT: hg19'
    default: hg19
    inputBinding:
      position: 101
      prefix: --genome
  - id: maptrack
    type:
      - 'null'
      - string
    doc: 'Choose which ENCODE mappability track should be used for regression. See
      more details http://genome.ucsc.edu/cgi-bin/hgTrackUi?db=hg18&g=wgEncodeMapability.
      DEFAULT: 50mer'
    default: 50mer
    inputBinding:
      position: 101
      prefix: --maptrack
  - id: matrixfile
    type: File
    doc: The matrix compressed file contains single or multiple resolutions Hi-C
      contact matrix files (multi-cool, or hic file), resolution should be set 
      via parameter -r; or a sparse | dense format matrix file whole genome 
      widely (not suggest when using a high resolution)
    inputBinding:
      position: 101
      prefix: --matrixfile
  - id: name
    type:
      - 'null'
      - string
    doc: Prefix for the result files. If not set, 'NA' will be used instead
    default: NA
    inputBinding:
      position: 101
      prefix: --name
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Path to the output directory, where you want to store all the output 
      files, if not set, the current directory will be used
    inputBinding:
      position: 101
      prefix: --outdir
  - id: refdir
    type: Directory
    doc: the reference directory that downloaded from dropbox dropbox. 
      (https://www.dropbox.com/sh/2ufsyu4wvrboxxp/AABk5-_Fwy7jdM_t0vIsgYf4a?dl=0.)
    inputBinding:
      position: 101
      prefix: --refdir
  - id: resolution
    type:
      - 'null'
      - int
    doc: 'Resolution for the Hi-C contact matrix used for the CNV detection, unit:
      kb, DEFAULT: 50kb'
    default: 50
    inputBinding:
      position: 101
      prefix: --resolution
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads for running HiNT-cnv, DEFAULT: 16'
    default: 16
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hint:2.2.8--py_1
stdout: hint_cnv.out
