cwlVersion: v1.2
class: CommandLineTool
baseCommand: ktserver
label: kyototycoon_ktserver
doc: "Kyoto Tycoon: a handy cache/storage server\n\nTool homepage: https://github.com/alticelabs/kyoto"
inputs:
  - id: db
    type:
      - 'null'
      - type: array
        items: string
    doc: databases
    inputBinding:
      position: 1
  - id: ash
    type:
      - 'null'
      - boolean
    doc: ash
    inputBinding:
      position: 102
      prefix: -ash
  - id: asi
    type:
      - 'null'
      - int
    doc: asi
    inputBinding:
      position: 102
      prefix: -asi
  - id: bgs
    type:
      - 'null'
      - Directory
    doc: bgs
    inputBinding:
      position: 102
      prefix: -bgs
  - id: bgsc
    type:
      - 'null'
      - string
    doc: bgsc
    inputBinding:
      position: 102
      prefix: -bgsc
  - id: bgsi
    type:
      - 'null'
      - int
    doc: bgsi
    inputBinding:
      position: 102
      prefix: -bgsi
  - id: cmd
    type:
      - 'null'
      - Directory
    doc: cmd
    inputBinding:
      position: 102
      prefix: -cmd
  - id: dmn
    type:
      - 'null'
      - boolean
    doc: dmn
    inputBinding:
      position: 102
      prefix: -dmn
  - id: host
    type:
      - 'null'
      - string
    doc: host
    inputBinding:
      position: 102
      prefix: -host
  - id: le
    type:
      - 'null'
      - boolean
    doc: le
    inputBinding:
      position: 102
      prefix: -le
  - id: li
    type:
      - 'null'
      - boolean
    doc: li
    inputBinding:
      position: 102
      prefix: -li
  - id: log
    type:
      - 'null'
      - File
    doc: log
    inputBinding:
      position: 102
      prefix: -log
  - id: ls
    type:
      - 'null'
      - boolean
    doc: ls
    inputBinding:
      position: 102
      prefix: -ls
  - id: lz
    type:
      - 'null'
      - boolean
    doc: lz
    inputBinding:
      position: 102
      prefix: -lz
  - id: mhost
    type:
      - 'null'
      - string
    doc: mhost
    inputBinding:
      position: 102
      prefix: -mhost
  - id: mport
    type:
      - 'null'
      - int
    doc: mport
    inputBinding:
      position: 102
      prefix: -mport
  - id: oas
    type:
      - 'null'
      - boolean
    doc: oas
    inputBinding:
      position: 102
      prefix: -oas
  - id: oat
    type:
      - 'null'
      - boolean
    doc: oat
    inputBinding:
      position: 102
      prefix: -oat
  - id: onl
    type:
      - 'null'
      - boolean
    doc: onl
    inputBinding:
      position: 102
      prefix: -onl
  - id: onr
    type:
      - 'null'
      - boolean
    doc: onr
    inputBinding:
      position: 102
      prefix: -onr
  - id: ord
    type:
      - 'null'
      - boolean
    doc: ord
    inputBinding:
      position: 102
      prefix: -ord
  - id: otl
    type:
      - 'null'
      - boolean
    doc: otl
    inputBinding:
      position: 102
      prefix: -otl
  - id: pid
    type:
      - 'null'
      - File
    doc: pid
    inputBinding:
      position: 102
      prefix: -pid
  - id: pldb
    type:
      - 'null'
      - File
    doc: pldb
    inputBinding:
      position: 102
      prefix: -pldb
  - id: plex
    type:
      - 'null'
      - string
    doc: plex
    inputBinding:
      position: 102
      prefix: -plex
  - id: plsv
    type:
      - 'null'
      - File
    doc: plsv
    inputBinding:
      position: 102
      prefix: -plsv
  - id: port
    type:
      - 'null'
      - int
    doc: port
    inputBinding:
      position: 102
      prefix: -port
  - id: riv
    type:
      - 'null'
      - int
    doc: riv
    inputBinding:
      position: 102
      prefix: -riv
  - id: rts
    type:
      - 'null'
      - File
    doc: rts
    inputBinding:
      position: 102
      prefix: -rts
  - id: scr
    type:
      - 'null'
      - File
    doc: scr
    inputBinding:
      position: 102
      prefix: -scr
  - id: sid
    type:
      - 'null'
      - int
    doc: sid
    inputBinding:
      position: 102
      prefix: -sid
  - id: th
    type:
      - 'null'
      - int
    doc: th
    inputBinding:
      position: 102
      prefix: -th
  - id: tout
    type:
      - 'null'
      - int
    doc: tout
    inputBinding:
      position: 102
      prefix: -tout
  - id: uasi
    type:
      - 'null'
      - int
    doc: uasi
    inputBinding:
      position: 102
      prefix: -uasi
  - id: ulim
    type:
      - 'null'
      - int
    doc: ulim
    inputBinding:
      position: 102
      prefix: -ulim
  - id: ulog
    type:
      - 'null'
      - Directory
    doc: ulog
    inputBinding:
      position: 102
      prefix: -ulog
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kyototycoon:20170410--hbed32c3_5
stdout: kyototycoon_ktserver.out
