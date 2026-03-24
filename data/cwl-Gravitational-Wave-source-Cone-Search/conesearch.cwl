#!/usr/bin/env cwl-runner

arguments:
- -m
- nb2workflow.nbadapter
- https://renkulab.io/gitlab/dsavchenko/gw-backend/-/raw/master/notebooks/conesearch.ipynb
baseCommand: python
class: CommandLineTool
cwlVersion: v1.0
id: conesearch
inputs:
- default: '2017-08-16T12:00:00'
  id: t1
  inputBinding:
    prefix: --inp-t1=
    separate: false
  type: string
- default: '2017-08-18T12:00:00'
  id: t2
  inputBinding:
    prefix: --inp-t2=
    separate: false
  type: string
- default: false
  id: do_cone_search
  inputBinding:
    prefix: --inp-do_cone_search=
    separate: false
  type: boolean
- default: 250
  id: ra
  inputBinding:
    prefix: --inp-ra=
    separate: false
  type: int
- default: -30.0
  id: dec
  inputBinding:
    prefix: --inp-dec=
    separate: false
  type: float
- default: 10
  id: radius
  inputBinding:
    prefix: --inp-radius=
    separate: false
  type: int
- default: 10
  id: level_threshold
  inputBinding:
    prefix: --inp-level_threshold=
    separate: false
  type: int
- default: 50,90
  id: contour_levels
  inputBinding:
    prefix: --inp-contour_levels=
    separate: false
  type: string
outputs:
- doc: lines found with the pattern
  id: asciicat
  type: string
- doc: lines found with the pattern
  id: skymap_files
  type: string
- doc: lines found with the pattern
  id: image
  type: string
- doc: lines found with the pattern
  id: contours
  type: string
