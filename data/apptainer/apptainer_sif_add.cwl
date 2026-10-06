cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - sif
  - add
label: apptainer_sif_add
doc: "Add a data object to a SIF image.\n\nTool homepage: https://github.com/apptainer/apptainer"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sif_path)
        writable: true
inputs:
  - id: sif_path
    type: File
    doc: SIF image to add the object to (changed in place; a copy is returned)
    inputBinding:
      position: 1
  - id: object_path
    type: File
    doc: File to add as a data object
    inputBinding:
      position: 2
  - id: alignment
    type:
      - 'null'
      - int
    doc: 'set alignment [default: 4096 with --datatype 4-Partition, 0 otherwise]'
    inputBinding:
      position: 102
      prefix: --alignment
  - id: datatype
    type: int
    doc: 'the type of data to add: 1-Deffile, 2-EnvVar, 3-Labels, 4-Partition, 5-Signature,
      6-GenericJSON, 7-Generic, 8-CryptoMessage, 9-SBOM, 10-OCI.RootIndex, 11-OCI.Blob'
    inputBinding:
      position: 102
      prefix: --datatype
  - id: filename
    type:
      - 'null'
      - string
    doc: 'set logical filename/handle [default: input filename]'
    inputBinding:
      position: 102
      prefix: --filename
  - id: groupid
    type:
      - 'null'
      - long
    doc: 'set groupid [default: 0]'
    inputBinding:
      position: 102
      prefix: --groupid
  - id: link
    type:
      - 'null'
      - long
    doc: 'set link pointer [default: 0]'
    inputBinding:
      position: 102
      prefix: --link
  - id: partarch
    type:
      - 'null'
      - int
    doc: 'the main architecture used (with --datatype 4-Partition): 1-386, 2-amd64, 3-arm,
      4-arm64, 5-ppc64, 6-ppc64le, 7-mips, 8-mipsle, 9-mips64, 10-mips64le, 11-s390x,
      12-riscv64'
    inputBinding:
      position: 102
      prefix: --partarch
  - id: partfs
    type:
      - 'null'
      - int
    doc: 'the filesystem used (with --datatype 4-Partition): 1-Squash, 2-Ext3, 3-ImmuObj,
      4-Raw'
    inputBinding:
      position: 102
      prefix: --partfs
  - id: parttype
    type:
      - 'null'
      - int
    doc: 'the type of partition (with --datatype 4-Partition): 1-System, 2-PrimSys, 3-Data,
      4-Overlay'
    inputBinding:
      position: 102
      prefix: --parttype
  - id: sbomformat
    type:
      - 'null'
      - string
    doc: 'the SBOM format (with --datatype 9-sbom): cyclonedx-json, cyclonedx-xml, github-json,
      spdx-json, spdx-rdf, spdx-tag-value, spdx-yaml, syft-json'
    inputBinding:
      position: 102
      prefix: --sbomformat
  - id: signentity
    type:
      - 'null'
      - string
    doc: the entity that signs (with --datatype 5-Signature), e.g. a key fingerprint
    inputBinding:
      position: 102
      prefix: --signentity
  - id: signhash
    type:
      - 'null'
      - int
    doc: 'the signature hash used (with --datatype 5-Signature): 1-SHA256, 2-SHA384, 3-SHA512,
      4-BLAKE2s_256, 5-BLAKE2b_256'
    inputBinding:
      position: 102
      prefix: --signhash
outputs:
  - id: sif_image
    type: File
    doc: The SIF image with the new data object
    outputBinding:
      glob: $(inputs.sif_path.basename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
