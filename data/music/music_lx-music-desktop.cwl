cwlVersion: v1.2
class: CommandLineTool
baseCommand: music
label: music_lx-music-desktop
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build a SIF format image due to insufficient disk space.
  It does not contain CLI help information or argument definitions.\n\nTool homepage:
  https://github.com/lyswhut/lx-music-desktop"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/music:1.0.0--h2d50403_2
stdout: music_lx-music-desktop.out
