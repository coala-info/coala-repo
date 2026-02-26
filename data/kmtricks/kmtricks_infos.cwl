cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmtricks
label: kmtricks_infos
doc: "Display build and configuration information for kmtricks.\n\nTool homepage:
  https://github.com/tlemane/kmtricks"
inputs:
  - id: bcli_sha1
    type:
      - 'null'
      - string
    doc: 'bcli: '
    inputBinding:
      position: 101
  - id: build_host
    type:
      - 'null'
      - string
    doc: 'build host: Linux-6.8.0-1041-azure'
    inputBinding:
      position: 101
  - id: c_compiler
    type:
      - 'null'
      - string
    doc: 'c compiler: GNU 12.4.0'
    inputBinding:
      position: 101
  - id: cfrcat_sha1
    type:
      - 'null'
      - string
    doc: 'cfrcat: '
    inputBinding:
      position: 101
  - id: conda
    type:
      - 'null'
      - boolean
    doc: 'conda: ON'
    inputBinding:
      position: 101
  - id: contact
    type:
      - 'null'
      - string
    doc: 'Contact: teo.lemane@genoscope.cns.fr'
    inputBinding:
      position: 101
  - id: cxx_compiler
    type:
      - 'null'
      - string
    doc: 'cxx compiler: GNU 12.4.0'
    inputBinding:
      position: 101
  - id: dev
    type:
      - 'null'
      - boolean
    doc: 'dev: OFF'
    inputBinding:
      position: 101
  - id: fmt_sha1
    type:
      - 'null'
      - string
    doc: 'fmt: '
    inputBinding:
      position: 101
  - id: gtest_sha1
    type:
      - 'null'
      - string
    doc: 'gtest: '
    inputBinding:
      position: 101
  - id: indicators_sha1
    type:
      - 'null'
      - string
    doc: 'indicators: '
    inputBinding:
      position: 101
  - id: kff_sha1
    type:
      - 'null'
      - string
    doc: 'kff: '
    inputBinding:
      position: 101
  - id: kmer
    type:
      - 'null'
      - string
    doc: 'kmer: 32,64,96,128,160,192,224,256'
    inputBinding:
      position: 101
  - id: kmtricks_sha1
    type:
      - 'null'
      - string
    doc: 'kmtricks: '
    inputBinding:
      position: 101
  - id: lz4_sha1
    type:
      - 'null'
      - string
    doc: 'lz4: '
    inputBinding:
      position: 101
  - id: max_c
    type:
      - 'null'
      - int
    doc: 'max_c: 4294967295'
    inputBinding:
      position: 101
  - id: modules
    type:
      - 'null'
      - boolean
    doc: 'modules: ON'
    inputBinding:
      position: 101
  - id: native
    type:
      - 'null'
      - boolean
    doc: 'native: OFF'
    inputBinding:
      position: 101
  - id: robin_hood_hasing_sha1
    type:
      - 'null'
      - string
    doc: 'robin-hood-hasing: '
    inputBinding:
      position: 101
  - id: run_host
    type:
      - 'null'
      - string
    doc: 'run host: Linux 6.8.0-100-generic'
    inputBinding:
      position: 101
  - id: spdlog_sha1
    type:
      - 'null'
      - string
    doc: 'spdlog: '
    inputBinding:
      position: 101
  - id: static
    type:
      - 'null'
      - boolean
    doc: 'static: OFF'
    inputBinding:
      position: 101
  - id: turbop_sha1
    type:
      - 'null'
      - string
    doc: 'turbop: '
    inputBinding:
      position: 101
  - id: xxhash_sha1
    type:
      - 'null'
      - string
    doc: 'xxhash: '
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmtricks:1.5.1--h22625ea_0
stdout: kmtricks_infos.out
