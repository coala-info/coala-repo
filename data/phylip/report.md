# phylip CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| phylip_clique | PASS |  |
| phylip_consense | PASS |  |
| phylip_contml | PASS |  |
| phylip_contrast | PASS |  |
| phylip_dnacomp | PASS |  |
| phylip_dnadist | PASS |  |
| phylip_dnainvar | PASS |  |
| phylip_dnaml | PASS | default run matches an analytic ln likelihood check (-72.25088); documentation example with hidden Markov rates differs slightly (-58.74 vs -58.41) |
| phylip_dnamlk | PASS | default run matches an analytic ln likelihood check (-73.07456); documentation example with hidden Markov rates differs slightly (-58.84 vs -58.52) |
| phylip_dnamove | PASS |  |
| phylip_dnapars | PASS | weights input renamed from weightfile to weights and tested with menu answers W, Y (19 steps with no weights, 14 with sites 1 and 13 at weight 0) |
| phylip_dnapenny | PASS |  |
| phylip_dollop | PASS |  |
| phylip_dolmove | PASS |  |
| phylip_dolpenny | PASS |  |
| phylip_drawgram | PASS |  |
| phylip_drawtree | PASS |  |
| phylip_factor | PASS |  |
| phylip_fitch | PASS |  |
| phylip_gendist | PASS |  |
| phylip_kitsch | PASS |  |
| phylip_mix | PASS |  |
| phylip_move | PASS |  |
| phylip_neighbor | PASS |  |
| phylip_pars | PASS |  |
| phylip_penny | PASS |  |
| phylip_proml | PASS | default run matches an analytic likelihood check; documentation example with hidden Markov rates differs slightly (ln likelihood -104.96 vs -104.53) |
| phylip_promlk | Failed | tool bug: ln likelihood and branch lengths are wrong (-12.8 for four identical 13-residue sequences, expected about -38; -2.6 for 474 residues where proml gives -3620) |
| phylip_protdist | PASS |  |
| phylip_protpars | PASS |  |
| phylip_restdist | PASS |  |
| phylip_restml | PASS |  |
| phylip_retree | PASS |  |
| phylip_seqboot | PASS |  |
| phylip_treedist | PASS |  |

## phylip_retree

### Tool Description
Tree Rearrangement

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
[2J[H[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!
[2J[H
Tree Rearrangement, version 3.697

Settings for this run:
  U          Initial tree (arbitrary, user, specify)?  User tree from tree file
  N   Format to write out trees (PHYLIP, Nexus, XML)?  PHYLIP
  0               Graphics type (IBM PC, ANSI, none)?  ANSI
  W       Width of terminal screen, of plotting area?  80, 80
  L                        Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
Not a possible option!

ERROR: Made 100 attempts to read input in loop. Aborting run.
Starting main
running main
['/usr/local/bin/phylip', 'retree', '--help']
/usr/local/share/phylip-3.697-0/exe
```

## phylip_neighbor

### Tool Description
Neighbor-joining method for constructing phylogenetic trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
[2J[Hneighbor: can't find input file "infile"
Please enter a new file name> 

ERROR: Unexpected end-of-file.

Starting main
running main
['/usr/local/bin/phylip', 'neighbor', '--help']
/usr/local/share/phylip-3.697-0/exe
```

## phylip_dolmove

### Tool Description
Moves sequences between files.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
[2J[Hdolmove: can't find input file "infile"
Please enter a new file name> 

ERROR: Unexpected end-of-file.

Starting main
running main
['/usr/local/bin/phylip', 'dolmove', '--help']
/usr/local/share/phylip-3.697-0/exe
```

## phylip_dnadist

### Tool Description
Computes distances between sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
[2J[Hdnadist: can't find input file "infile"
Please enter a new file name> 

ERROR: Unexpected end-of-file.

Starting main
running main
['/usr/local/bin/phylip', 'dnadist', '--help']
/usr/local/share/phylip-3.697-0/exe
```

## phylip_dnainvar

### Tool Description
Calculates the number of DNA substitutions between pairs of sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
[2J[Hdnainvar: can't find input file "infile"
Please enter a new file name> 

ERROR: Unexpected end-of-file.

Starting main
running main
['/usr/local/bin/phylip', 'dnainvar', '--help']
/usr/local/share/phylip-3.697-0/exe
```

## phylip_dnapars

### Tool Description
Parses DNA sequences for phylogenetic analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
[2J[Hdnapars: can't find input file "infile"
Please enter a new file name> 

ERROR: Unexpected end-of-file.

Starting main
running main
['/usr/local/bin/phylip', 'dnapars', '--help']
/usr/local/share/phylip-3.697-0/exe
```

## phylip_drawtree

### Tool Description
Draws trees in various formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
[2J[HDRAWTREE from PHYLIP version 3.697
drawtree: can't find input tree file "intree"
Please enter a new file name> 

ERROR: Unexpected end-of-file.

Starting main
running main
['/usr/local/bin/phylip', 'drawtree', '--help']
/usr/local/share/phylip-3.697-0/exe
```

## phylip_gendist

### Tool Description
Computes genetic distances from gene frequencies (Nei, Cavalli-Sforza chord or Reynolds-Weir-Cockerham).

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
Genetic Distance Matrix program, version 3.697

Settings for this run:
  A   Input file contains all alleles at each locus?  One omitted at each locus
  N                        Use Nei genetic distance?  Yes
  C                Use Cavalli-Sforza chord measure?  No
  R                   Use Reynolds genetic distance?  No
  L                         Form of distance matrix?  Square
  M                      Analyze multiple data sets?  No
  0              Terminal type (IBM PC, ANSI, none)?  ANSI
  1            Print indications of progress of run?  Yes

  Y to accept these or type the letter for one to change

Genetic Distance Matrix program, version 3.697
```

## phylip_kitsch

### Tool Description
Fitch-Margoliash and least-squares distance methods assuming an evolutionary clock (contemporary tips).

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
Fitch-Margoliash method with contemporary tips, version 3.697

Settings for this run:
  D      Method (F-M, Minimum Evolution)?  Fitch-Margoliash
  U                 Search for best tree?  Yes
  P                                Power?  2.00000
  -      Negative branch lengths allowed?  No
  L         Lower-triangular data matrix?  No
  R         Upper-triangular data matrix?  No
  S                        Subreplicates?  No
  J     Randomize input order of species?  No. Use input order
  M           Analyze multiple data sets?  No
  0   Terminal type (IBM PC, ANSI, none)?  ANSI
  1    Print out the data at start of run  No
  2  Print indications of progress of run  Yes
  3                        Print out tree  Yes
  4       Write out trees onto tree file?  Yes

  Y to accept these or type the letter for one to change

Fitch-Margoliash method with contemporary tips, version 3.697
```

## phylip_mix

### Tool Description
Mixed parsimony method for binary (0/1) characters, combining Wagner and Camin-Sokal parsimony.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
Mixed parsimony algorithm, version 3.697

Settings for this run:
  U                 Search for best tree?  Yes
  X                     Use Mixed method?  No
  P                     Parsimony method?  Wagner
  J     Randomize input order of species?  No. Use input order
  O                        Outgroup root?  No, use as outgroup species  1
  T              Use Threshold parsimony?  No, use ordinary parsimony
  A   Use ancestral states in input file?  No
  W                       Sites weighted?  No
  M           Analyze multiple data sets?  No
  0   Terminal type (IBM PC, ANSI, none)?  ANSI
  1    Print out the data at start of run  No
  2  Print indications of progress of run  Yes
  3                        Print out tree  Yes
  4     Print out steps in each character  No
  5     Print states at all nodes of tree  No
  6       Write out trees onto tree file?  Yes

Are these settings correct? (type Y or the letter for one to change)

Mixed parsimony algorithm, version 3.697
```

## phylip_move

### Tool Description
Interactive mixed parsimony: edit a tree by hand and see its parsimony score.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
 5 species,   6 characters

Reading input file ...

Interactive mixed parsimony algorithm, version 3.697

Settings for this run:
  X                         Use Mixed method?  No
  P                         Parsimony method?  Wagner
  A                     Use ancestral states?  No
  F                  Use factors information?  No
  O                            Outgroup root?  No, use as outgroup species   1
  W                           Sites weighted?  No
  T                  Use Threshold parsimony?  No, use ordinary parsimony
  U  Initial tree (arbitrary, user, specify)?  Arbitrary
  0       Graphics type (IBM PC, ANSI, none)?  ANSI
  S                 Width of terminal screen?  80
  L                Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)

Interactive mixed parsimony algorithm, version 3.697
```

## phylip_pars

### Tool Description
Discrete character parsimony for multistate characters.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
Discrete character parsimony algorithm, version 3.697

Setting for this run:
  U                 Search for best tree?  Yes
  S                        Search option?  More thorough search
  V              Number of trees to save?  100
  J     Randomize input order of species?  No. Use input order
  O                        Outgroup root?  No, use as outgroup species 1
  T              Use Threshold parsimony?  No, use ordinary parsimony
  W                       Sites weighted?  No
  M           Analyze multiple data sets?  No
  I            Input species interleaved?  Yes
  0   Terminal type (IBM PC, ANSI, none)?  ANSI
  1    Print out the data at start of run  No
  2  Print indications of progress of run  Yes
  3                        Print out tree  Yes
  4          Print out steps in each site  No
  5  Print character at all nodes of tree  No
  6       Write out trees onto tree file?  Yes

  Y to accept these or type the letter for one to change

Discrete character parsimony algorithm, version 3.697
```

## phylip_penny

### Tool Description
Branch-and-bound search for all most parsimonious trees from binary characters.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
Penny algorithm, version 3.697
 branch-and-bound to find all most parsimonious trees

Settings for this run:
  X                     Use Mixed method?  No
  P                     Parsimony method?  Wagner
  F        How often to report, in trees:  100
  H        How many groups of  100 trees:  1000
  O                        Outgroup root?  No, use as outgroup species  1
  S           Branch and bound is simple?  Yes
  T              Use Threshold parsimony?  No, use ordinary parsimony
  A   Use ancestral states in input file?  No
  W                       Sites weighted?  No
  M           Analyze multiple data sets?  No
  0   Terminal type (IBM PC, ANSI, none)?  ANSI
  1    Print out the data at start of run  No
  2  Print indications of progress of run  Yes
  3                        Print out tree  Yes
  4     Print out steps in each character  No
  5     Print states at all nodes of tree  No
  6       Write out trees onto tree file?  Yes

Are these settings correct? (type Y or the letter for one to change)

Penny algorithm, version 3.697
 branch-and-bound to find all most parsimonious trees
```

## phylip_proml

### Tool Description
Maximum likelihood estimation of phylogenies from protein sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
Amino acid sequence Maximum Likelihood method, version 3.697

Settings for this run:
  U                 Search for best tree?  Yes
  P    JTT, PMB or PAM probability model?  Jones-Taylor-Thornton
  C                One category of sites?  Yes
  R           Rate variation among sites?  constant rate of change
  W                       Sites weighted?  No
  S        Speedier but rougher analysis?  Yes
  G                Global rearrangements?  No
  J   Randomize input order of sequences?  No. Use input order
  O                        Outgroup root?  No, use as outgroup species  1
  M           Analyze multiple data sets?  No
  I          Input sequences interleaved?  Yes
  0   Terminal type (IBM PC, ANSI, none)?  ANSI
  1    Print out the data at start of run  No
  2  Print indications of progress of run  Yes
  3                        Print out tree  Yes
  4       Write out trees onto tree file?  Yes
  5   Reconstruct hypothetical sequences?  No

  Y to accept these or type the letter for one to change
Amino acid sequence Maximum Likelihood method, version 3.697
```

## phylip_promlk

### Tool Description
Maximum likelihood estimation of phylogenies from protein sequences assuming a molecular clock.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
Amino acid sequence
   Maximum Likelihood method with molecular clock, version 3.697

Settings for this run:
  U                 Search for best tree?  Yes
  P    JTT, PMB or PAM probability model?  Jones-Taylor-Thornton
  C   One category of substitution rates?  Yes
  R           Rate variation among sites?  constant rate
  G                Global rearrangements?  No
  W                       Sites weighted?  No
  J   Randomize input order of sequences?  No. Use input order
  M           Analyze multiple data sets?  No
  I          Input sequences interleaved?  Yes
  0   Terminal type (IBM PC, ANSI, none)?  ANSI
  1    Print out the data at start of run  No
  2  Print indications of progress of run  Yes
  3                        Print out tree  Yes
  4       Write out trees onto tree file?  Yes
  5   Reconstruct hypothetical sequences?  No

Are these settings correct? (type Y or the letter for one to change)

Amino acid sequence
   Maximum Likelihood method with molecular clock, version 3.697
```

## phylip_protdist

### Tool Description
Computes distances between protein sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
Protein distance algorithm, version 3.697

Settings for this run:
  P  Use JTT, PMB, PAM, Kimura, categories model?  Jones-Taylor-Thornton matrix
  G  Gamma distribution of rates among positions?  No
  C           One category of substitution rates?  Yes
  W                    Use weights for positions?  No
  M                   Analyze multiple data sets?  No
  I                  Input sequences interleaved?  Yes
  0                 Terminal type (IBM PC, ANSI)?  ANSI
  1            Print out the data at start of run  No
  2          Print indications of progress of run  Yes

Are these settings correct? (type Y or the letter for one to change)

ERROR: Unexpected end-of-file.
```

## phylip_protpars

### Tool Description
Protein parsimony: trees with the fewest amino acid changes under a genetic code.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
Protein parsimony algorithm, version 3.697

Setting for this run:
  U                 Search for best tree?  Yes
  J   Randomize input order of sequences?  No. Use input order
  O                        Outgroup root?  No, use as outgroup species  1
  T              Use Threshold parsimony?  No, use ordinary parsimony
  C               Use which genetic code?  Universal
  W                       Sites weighted?  No
  M           Analyze multiple data sets?  No
  I          Input sequences interleaved?  Yes
  0   Terminal type (IBM PC, ANSI, none)?  ANSI
  1    Print out the data at start of run  No
  2  Print indications of progress of run  Yes
  3                        Print out tree  Yes
  4          Print out steps in each site  No
  5  Print sequences at all nodes of tree  No
  6       Write out trees onto tree file?  Yes

Are these settings correct? (type Y or the letter for one to change)

Protein parsimony algorithm, version 3.697
```

## phylip_restdist

### Tool Description
Computes distances between species from restriction sites or fragments.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
Restriction site or fragment distances, version 3.697

Settings for this run:
  R           Restriction sites or fragments?  Sites
  N        Original or modified Nei/Li model?  Modified
  G  Gamma distribution of rates among sites?  No
  T            Transition/transversion ratio?  2.000000
  S                              Site length?  6.0
  L                  Form of distance matrix?  Square
  M               Analyze multiple data sets?  No
  I              Input sequences interleaved?  Yes
  0       Terminal type (IBM PC, ANSI, none)?  ANSI
  1       Print out the data at start of run?  No
  2     Print indications of progress of run?  Yes

  Y to accept these or type the letter for one to change

Restriction site or fragment distances, version 3.697
```

## phylip_restml

### Tool Description
Maximum likelihood estimation of phylogenies from restriction site data.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
Restriction site Maximum Likelihood method, version 3.697

Settings for this run:
  U                 Search for best tree?  Yes
  A               Are all sites detected?  No
  S        Speedier but rougher analysis?  Yes
  G                Global rearrangements?  No
  J   Randomize input order of sequences?  No. Use input order
  L                          Site length?  6
  O                        Outgroup root?  No, use as outgroup species  1
  M           Analyze multiple data sets?  No
  I          Input sequences interleaved?  Yes
  0   Terminal type (IBM PC, ANSI, none)?  ANSI
  1    Print out the data at start of run  No
  2  Print indications of progress of run  Yes
  3                        Print out tree  Yes
  4       Write out trees onto tree file?  Yes

  Y to accept these or type the letter for one to change

Restriction site Maximum Likelihood method, version 3.697
```

## phylip_seqboot

### Tool Description
Bootstrap, jackknife or permutation resampling of sequences, characters, restriction sites or gene frequencies.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
Bootstrapping algorithm, version 3.697

Settings for this run:
  D      Sequence, Morph, Rest., Gene Freqs?  Molecular sequences
  J  Bootstrap, Jackknife, Permute, Rewrite?  Bootstrap
  %    Regular or altered sampling fraction?  regular
  B      Block size for block-bootstrapping?  1 (regular bootstrap)
  R                     How many replicates?  100
  W              Read weights of characters?  No
  C                Read categories of sites?  No
  S     Write out data sets or just weights?  Data sets
  I             Input sequences interleaved?  Yes
  0      Terminal type (IBM PC, ANSI, none)?  ANSI
  1       Print out the data at start of run  No
  2     Print indications of progress of run  Yes

  Y to accept these or type the letter for one to change

Bootstrapping algorithm, version 3.697
```

## phylip_treedist

### Tool Description
Computes distances between trees (symmetric difference or branch score distance).

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
Tree distance program, version 3.697

Settings for this run:
 D                         Distance Type:  Branch Score Distance
 R         Trees to be treated as Rooted:  No
 T    Terminal type (IBM PC, ANSI, none):  ANSI
 1  Print indications of progress of run:  Yes
 2                 Tree distance submenu:  Distance between adjacent pairs

Are these settings correct? (type Y or the letter for one to change)

Tree distance program, version 3.697
```

## phylip_clique

### Tool Description
Largest clique program: finds the largest sets of mutually compatible binary characters.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
Largest clique program, version 3.697

Settings for this run:
  A   Use ancestral states in input file?  No
  F              Use factors information?  No
  W                       Sites weighted?  No
  C          Specify minimum clique size?  No
  O                        Outgroup root?  No, use as outgroup species  1
  M           Analyze multiple data sets?  No
  0   Terminal type (IBM PC, ANSI, none)?  ANSI
  1    Print out the data at start of run  No
  2  Print indications of progress of run  Yes
  3        Print out compatibility matrix  No
  4                        Print out tree  Yes
  5       Write out trees onto tree file?  Yes

  Y to accept these or type the letter for one to change
```

## phylip_consense

### Tool Description
Consensus tree program: majority-rule (extended), strict, MR or Ml consensus of a set of trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
Consensus tree program, version 3.697

Settings for this run:
 C         Consensus type (MRe, strict, MR, Ml):  Majority rule (extended)
 O                                Outgroup root:  No, use as outgroup species  1
 R                Trees to be treated as Rooted:  No
 T           Terminal type (IBM PC, ANSI, none):  ANSI
 1                Print out the sets of species:  Yes
 2         Print indications of progress of run:  Yes
 3                               Print out tree:  Yes
 4               Write out trees onto tree file:  Yes

Are these settings correct? (type Y or the letter for one to change)
```

## phylip_contml

### Tool Description
Continuous character maximum likelihood method for gene frequencies and continuous characters.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
Continuous character Maximum Likelihood method version 3.697

Settings for this run:
  U                       Search for best tree?  Yes
  C  Gene frequencies or continuous characters?  Gene frequencies
  A   Input file has all alleles at each locus?  No, one allele missing at each
  O                              Outgroup root?  No, use as outgroup species 1
  G                      Global rearrangements?  No
  J           Randomize input order of species?  No. Use input order
  M                 Analyze multiple data sets?  No
  0         Terminal type (IBM PC, ANSI, none)?  ANSI
  1          Print out the data at start of run  No
  2        Print indications of progress of run  Yes
  3                              Print out tree  Yes
  4             Write out trees onto tree file?  Yes

  Y to accept these or type the letter for one to change
```

## phylip_contrast

### Tool Description
Continuous character comparative analysis: contrasts, covariances, regressions and correlations along a tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
Continuous character comparative analysis, version 3.697

Settings for this run:
  W        Within-population variation in data?  No, species values are means
  R     Print out correlations and regressions?  Yes
  C                        Print out contrasts?  No
  M                     Analyze multiple trees?  No
  0         Terminal type (IBM PC, ANSI, none)?  ANSI
  1          Print out the data at start of run  No
  2        Print indications of progress of run  Yes

  Y to accept these or type the letter for one to change
```

## phylip_dnacomp

### Tool Description
DNA compatibility algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
DNA compatibility algorithm, version 3.697

Settings for this run:
  U                 Search for best tree?  Yes
  J   Randomize input order of sequences?  No. Use input order
  O                        Outgroup root?  No, use as outgroup species  1
  W                       Sites weighted?  No
  M           Analyze multiple data sets?  No
  I          Input sequences interleaved?  Yes
  0   Terminal type (IBM PC, ANSI, none)?  ANSI
  1    Print out the data at start of run  No
  2  Print indications of progress of run  Yes
  3                        Print out tree  Yes
  4  Print steps & compatibility at sites  No
  5  Print sequences at all nodes of tree  No
  6       Write out trees onto tree file?  Yes

Are these settings correct? (type Y or the letter for one to change)
```

## phylip_dnaml

### Tool Description
Nucleic acid sequence maximum likelihood method.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
Nucleic acid sequence Maximum Likelihood method, version 3.697

Settings for this run:
  U                 Search for best tree?  Yes
  T        Transition/transversion ratio:  2.0000
  F       Use empirical base frequencies?  Yes
  C                One category of sites?  Yes
  R           Rate variation among sites?  constant rate
  W                       Sites weighted?  No
  S        Speedier but rougher analysis?  Yes
  G                Global rearrangements?  No
  J   Randomize input order of sequences?  No. Use input order
  O                        Outgroup root?  No, use as outgroup species  1
  M           Analyze multiple data sets?  No
  I          Input sequences interleaved?  Yes
  0   Terminal type (IBM PC, ANSI, none)?  ANSI
  1    Print out the data at start of run  No
  2  Print indications of progress of run  Yes
  3                        Print out tree  Yes
  4       Write out trees onto tree file?  Yes
  5   Reconstruct hypothetical sequences?  No

  Y to accept these or type the letter for one to change
```

## phylip_dnamlk

### Tool Description
Nucleic acid sequence maximum likelihood method with a molecular clock.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
Nucleic acid sequence
   Maximum Likelihood method with molecular clock, version 3.697

Settings for this run:
  U                 Search for best tree?  Yes
  T        Transition/transversion ratio:  2.0
  F       Use empirical base frequencies?  Yes
  C   One category of substitution rates?  Yes
  R           Rate variation among sites?  constant rate
  G                Global rearrangements?  No
  W                       Sites weighted?  No
  J   Randomize input order of sequences?  No. Use input order
  M           Analyze multiple data sets?  No
  I          Input sequences interleaved?  Yes
  0   Terminal type (IBM PC, ANSI, none)?  ANSI
  1    Print out the data at start of run  No
  2  Print indications of progress of run  Yes
  3                        Print out tree  Yes
  4       Write out trees onto tree file?  Yes
  5   Reconstruct hypothetical sequences?  No

Are these settings correct? (type Y or the letter for one to change)
```

## phylip_dnamove

### Tool Description
Interactive DNA parsimony.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
5 species,  13  sites

Interactive DNA parsimony, version 3.697

Settings for this run:
  O                             Outgroup root?  No, use as outgroup species  1
  W                            Sites weighted?  No
  T                   Use Threshold parsimony?  No, use ordinary parsimony
  I               Input sequences interleaved?  Yes
  U   Initial tree (arbitrary, user, specify)?  Arbitrary
  0        Graphics type (IBM PC, ANSI, none)?  ANSI
  S                  Width of terminal screen?  80
  L                 Number of lines on screen?  24

Are these settings correct? (type Y or the letter for one to change)
```

## phylip_dnapenny

### Tool Description
Penny algorithm for DNA: branch-and-bound search for all most parsimonious trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
Penny algorithm for DNA, version 3.697
 branch-and-bound to find all most parsimonious trees

Settings for this run:
  H        How many groups of 1000 trees: 10000
  F        How often to report, in trees:  1000
  S           Branch and bound is simple?  Yes
  O                        Outgroup root?  No, use as outgroup species  1
  T              Use Threshold parsimony?  No, use ordinary parsimony
  W                       Sites weighted?  No
  M           Analyze multiple data sets?  No
  I          Input sequences interleaved?  Yes
  0   Terminal type (IBM PC, ANSI, none)?  ANSI
  1    Print out the data at start of run  No
  2  Print indications of progress of run  Yes
  3                        Print out tree  Yes
  4          Print out steps in each site  No
  5  Print sequences at all nodes of tree  No
  6       Write out trees onto tree file?  Yes

Are these settings correct? (type Y or the letter for one to change)
```

## phylip_dollop

### Tool Description
Dollo and polymorphism parsimony algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
Dollo and polymorphism parsimony algorithm, version 3.697

Settings for this run:
  U                 Search for best tree?  Yes
  P                     Parsimony method?  Dollo
  J     Randomize input order of species?  No. Use input order
  T              Use Threshold parsimony?  No, use ordinary parsimony
  A   Use ancestral states in input file?  No
  W                       Sites weighted?  No
  M           Analyze multiple data sets?  No
  0   Terminal type (IBM PC, ANSI, none)?  ANSI
  1    Print out the data at start of run  No
  2  Print indications of progress of run  Yes
  3                        Print out tree  Yes
  4     Print out steps in each character  No
  5     Print states at all nodes of tree  No
  6       Write out trees onto tree file?  Yes

Are these settings correct? (type Y or the letter for one to change)
```

## phylip_dolpenny

### Tool Description
Penny algorithm for Dollo or polymorphism parsimony.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
Penny algorithm for Dollo or polymorphism parsimony, version 3.697
 branch-and-bound to find all most parsimonious trees

Settings for this run:
  P                     Parsimony method?  Dollo
  H        How many groups of  100 trees:  1000
  F        How often to report, in trees:  100
  S           Branch and bound is simple?  Yes
  T              Use Threshold parsimony?  No, use ordinary parsimony
  A                 Use ancestral states?  No
  W                       Sites weighted?  No
  M           Analyze multiple data sets?  No
  0   Terminal type (IBM PC, ANSI, none)?  ANSI
  1    Print out the data at start of run  No
  2  Print indications of progress of run  Yes
  3                        Print out tree  Yes
  4     Print out steps in each character  No
  5     Print states at all nodes of tree  No
  6       Write out trees onto tree file?  Yes

Are these settings correct? (type Y or the letter for one to change)
```

## phylip_drawgram

### Tool Description
Plots rooted phylogenies (cladograms, phenograms, curvograms, eurograms).

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
DRAWGRAM from PHYLIP version 3.697
Reading tree ... 
Tree has been read.
Loading the font .... 
Font loaded.

Rooted tree plotting program version 3.697

Here are the settings: 
 0  Screen type (IBM PC, ANSI):  ANSI
 P       Final plotting device:  Postscript printer
 (Preview no longer available)
 H                  Tree grows:  Horizontally
 S                  Tree style:  Phenogram
 B          Use branch lengths:  Yes
 L             Angle of labels:  90.0
 R      Scale of branch length:  Automatically rescaled
 D       Depth/Breadth of tree:  0.53
 T      Stem-length/tree-depth:  0.05
 C    Character ht / tip space:  0.3333
 A             Ancestral nodes:  Weighted
 F                        Font:  Times-Roman
 M          Horizontal margins:  1.65 cm
 M            Vertical margins:  2.16 cm
 #              Pages per tree:  one page per tree

 Y to accept these or type the letter for one to change
 That letter is not one of the menu choices.  Type

 Y to accept these or type the letter for one to change


ERROR: Unexpected end-of-file.
```

## phylip_factor

### Tool Description
Multistate to binary recoding program.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
Factor -- multistate to binary recoding program, version 3.697

Settings for this run:
  A      put ancestral states in output file?  No
  F   put factors information in output file?  No
  0       Terminal type (IBM PC, ANSI, none)?  ANSI
  1      Print indications of progress of run  Yes

Are these settings correct? (type Y or the letter for one to change)
```

## phylip_fitch

### Tool Description
Fitch-Margoliash and least-squares distance methods.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylip:3.697--h470a237_0
- **Homepage**: http://evolution.genetics.washington.edu/phylip/
- **Package**: https://anaconda.org/channels/bioconda/packages/phylip/overview
- **Validation**: PASS

### Original Help Text
```text
Fitch-Margoliash method version 3.697

Settings for this run:
  D      Method (F-M, Minimum Evolution)?  Fitch-Margoliash
  U                 Search for best tree?  Yes
  P                                Power?  2.00000
  -      Negative branch lengths allowed?  No
  O                        Outgroup root?  No, use as outgroup species  1
  L         Lower-triangular data matrix?  No
  R         Upper-triangular data matrix?  No
  S                        Subreplicates?  No
  G                Global rearrangements?  No
  J     Randomize input order of species?  No. Use input order
  M           Analyze multiple data sets?  No
  0   Terminal type (IBM PC, ANSI, none)?  ANSI
  1    Print out the data at start of run  No
  2  Print indications of progress of run  Yes
  3                        Print out tree  Yes
  4       Write out trees onto tree file?  Yes

  Y to accept these or type the letter for one to change
```

## Metadata
- **Skill**: generated
