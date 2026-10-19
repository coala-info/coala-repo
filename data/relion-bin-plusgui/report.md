# relion-bin-plusgui CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| relion-bin-plusgui_relion_preprocess | Failed | tool bug: the normalised stack is written as <o>.mrcs.mrcs while the output STAR file names <o>.mrcs, so the STAR file points to a missing stack |

