cwlVersion: v1.2
class: CommandLineTool
baseCommand: hubPublicCheck
label: ucsc-hubpubliccheck_hubPublicCheck
doc: "checks that the labels in hubPublic match what is in the hub labels\n   outputs
  SQL statements to put the table into compliance\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: table_name
    type: string
    doc: The name of the table to check
    inputBinding:
      position: 1
  - id: hg_conf
    type:
      - 'null'
      - File
    doc: hg.conf file (mode 600) with the db.host, db.user and db.password of the
      UCSC MySQL server holding the hubPublic table. It is staged as .hg.conf in
      the working directory, where the program looks for it.
  - id: add_hub
    type:
      - 'null'
      - string
    doc: output statments to add url to table
    inputBinding:
      position: 102
      prefix: -addHub=
      separate: false
  - id: udc_dir
    type:
      - 'null'
      - string
    doc: place to put cache for remote bigBed/bigWigs
    inputBinding:
      position: 102
      prefix: -udcDir=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .hg.conf
        entry: $(inputs.hg_conf)
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hubpubliccheck:482--h0b57e2e_0
stdout: ucsc-hubpubliccheck_hubPublicCheck.out
successCodes: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254]
