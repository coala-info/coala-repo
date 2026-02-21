cwlVersion: v1.2
class: CommandLineTool
baseCommand: mne
label: mne
doc: "MNE: Magnetoencephalography (MEG) and Electroencephalography (EEG) data analysis\n
  \nTool homepage: https://github.com/mne-tools/mne-python"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mne:v0.13.1dfsg-3-deb-py2_cv1
stdout: mne.out
