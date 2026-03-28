🧬

### Initializing gbdraw...

Loading Python engine and dependencies.

Loading gbdraw...

### Generating Diagram...

🧬

# gbdraw A genome diagram generator for microbes and organelles

Save Config

 Load Config

 Save Session

 Load Session

Session

{{ sessionTitleLabel }}

Circular
 Linear

Input Genomes

GenBank
 GFF3 + FASTA

GenBank
 GFF3 + FASTA

Upload BLAST TSV
 Run LOSAT

LOSAT Mode

blastn
 tblastx

LOSAT Settings

Task

megablast
blastn
dc-megablast

Query/DB gencode is set per entry below.

Clear Cache

Cached results are reused when inputs and settings match.

#{{ idx + 1 }}

Definition (optional)

Region (optional)

Record ID (optional)

[ ]  Reverse complement

Start

End

LOSAT Gencode

Compare to next (BLAST)

LOSAT (pair #{{ idx + 1 }} ↔ #{{ idx + 2 }})

Filename (optional)

Default: {{ getLosatPairDefaultName(idx) }}

 Save LOSAT TSV

Add Seq
 Remove

Basic Settings

Output Prefix

Legend

RightLeft
TopBottom
Upper LeftUpper Right
None

Track Layout
TuckinMiddleSpreadout

Track Layout

Above
Middle
Below

Scale Style
Bar (Simple)Ruler (Ticks)

Plot Title

Plot Title Position

None (Default)
Top
Bottom

Plot Title Font Size

Definition Font Size

[ ]

Keep full record definition

Record Definition

Plot Title

Plot Title Position

Center
Top
Bottom (Default)

Plot Title Font Size

Definition Font Size

Show Labels

None
All Records
First Record Only

Labels

None
Out
Both (Out + Inner)

[ ]
Separate Strands

[ ]
Resolve Overlaps

[ ]
Multi-Record Canvas

Record Size Mode

Auto (Default)
Linear
Equal

Min Radius Ratio

Column Gap Ratio

Row Gap Ratio

Record Order

Reload Records

Record Order is available for GenBank input.

Upload a GenBank file to load records.

{{ getCircularRecordOrderLabel(position.selector) }}

{{ rowOption }}

Up
Down

Reset Order

[ ]
Hide GC

[ ]
Hide Skew

Resolve Overlaps is ignored when Separate Strands is enabled.

[ ]
Resolve Overlaps

[ ]
Align Center

[ ]
Normalize Len

[ ]
Ruler on Axis

[ ]
Show GC

[ ]
Show Skew

Colors & Filters

#### PRESET SCHEMES

Affects -d & -t

Select preset...
{{ p.label }}

Applying...
Apply

Preset schemes update the palette and replace existing specific rules.

#### DEFAULT COLORS (-d)

Reset

{{ p }}

{{ feat }}

ADD FEATURE

{{ k }}

COLOR

 Add

- OR UPLOAD FILE -

Override default feature colors.

#### SPECIFIC RULES (-t)

 Clear All

{{rule.feat}}
{{rule.qual}}
/{{rule.val}}/

No rules added

{{ k }}

- OR UPLOAD FILE -

Override colors for specific features.

#### LABEL FILTERING

{{m}}

Exclude labels containing these keywords.

- OR -

Only show labels matching rules.

×

+ Add Rule

- OR -

##### QUALIFIER PRIORITY

{{rule.feat}}
{{rule.order}}

No priority rules defined

{{ k }}

- OR UPLOAD FILE -

 Advanced Options

Window

Step

Dinucleotide

Label Settings

Label Font Size

Label Placement

Auto
Above Feature

Label Rotation

Legend Box Size

Legend Font Size

Styles (Colors & Widths)

Block Stroke Color

Block Stroke Width

Line Stroke Color

Line Stroke Width

Axis Stroke Color

Axis Stroke Width

Linear Specific Settings

Feature H

Axis Gap

GC H

Comp H

SCALE / RULER

Scale Line:

Ruler Label:

BLAST FILTERS

Circular Label Offsets

Feature Width

GC Content Width

GC Content Radius

GC Skew Width

GC Skew Radius

Outer X Offset

Outer Y Offset

Inner X Offset

Inner Y Offset

Scale Interval

Include Features

{{ f }}

Arrow
Rectangle

No features selected

{{ k }}

 Add

About & Citation

**Privacy & Security**
This tool runs **entirely in your browser** using WebAssembly (Pyodide). Your genomic data is processed locally and never leaves your device.

**Citation**

If you use gbdraw in your research, please cite the GitHub repository:

https://github.com/satoshikawato/gbdraw

[GitHub](https://github.com/satoshikawato/gbdraw)
[Issues](https://github.com/satoshikawato/gbdraw/issues)

Generate Diagram
 Processing...

Error Occurred

{{ errorDisplay.summary }}

Details

{{ section.label }}

```
{{ section.text }}
```

Result Preview

Preview: {{ res.name }}

DPI

72 (Web)
96 (Screen)
150 (Draft)
300 (Print)
600 (High)

 SVG
 PNG
 PDF

Reset positions

Canvas padding

{{Math.round(zoom\*100)}}%

Drag record or legend to reposition

Canvas Padding
Reset

Top

Left

Right

Bottom

Add space around the diagram

{{ clickedFeature.label }}

Location: {{ clickedFeatureLocation }}

Legend name (optional)

Suggestions from SPECIFIC RULES (-t)

Select legend text...

{{ entry.caption }}{{ entry.color ? ` (${entry.color})` : '' }}

No SPECIFIC RULES (-t) legend text available yet

Feature visibility

Default (follow feature filters)
On (force show)
Off (force hide)

Applies to this feature only (hash ID rule).

Label text

{{ clickedFeature.labelKey }}

Label visibility

Default (follow filter)
On (force show, bypass filters)
Off (force hide, bypass filters)

Source: {{ clickedFeature.labelSourceText }}

{{ clickedFeature.labelUnavailableReason }}

Apply Label

Fill Color

{{ clickedFeature.color }}

Stroke

### Label Text Scope

Choose how to apply the label text change for "{{ labelTextScopeDialog.sourceText }}".

This label only

All matching source labels ({{ labelTextScopeDialog.matchingCount }})

This label is not linked to a feature ID. "This label only" is applied to the current SVG but may not persist after re-generate.

Cancel

### Enable Labels

Labels are currently off. Choose how to show labels for this edit.

Whitelist only

Show all labels

### Color Change Scope

This feature matches the rule "{{ colorScopeDialog.matchingRule?.cap || colorScopeDialog.matchingRule?.val }}" ({{ colorScopeDialog.ruleMatchCount }} features).

Legend item "{{ colorScopeDialog.legendName }}" is shared by {{ colorScopeDialog.siblingCount + 1 }} features.

There are {{ colorScopeDialog.siblingCount }} other features sharing the legend item "{{ colorScopeDialog.legendName }}".

How do you want to apply the color change?

Apply to all "{{ colorScopeDialog.matchingRule?.cap || colorScopeDialog.matchingRule?.val }}" ({{ colorScopeDialog.ruleMatchCount }})

Apply to all "{{ colorScopeDialog.legendName }}" ({{ colorScopeDialog.siblingCount + 1 }})

This feature only

Apply to all label "{{ colorScopeDialog.displayLabel }}" ({{ colorScopeDialog.displayLabelSiblingCount + 1 }})

Apply to all source label "{{ colorScopeDialog.annotationLabel }}" ({{ colorScopeDialog.annotationLabelSiblingCount + 1 }})

Use existing "{{ colorScopeDialog.legendName }}" color

Cancel

### Reset Fill Color

There are {{ resetColorDialog.siblingCount }} other features with the caption "{{ resetColorDialog.caption }}".

How do you want to reset the color?

Reset all "{{ resetColorDialog.caption }}" ({{ resetColorDialog.siblingCount + 1 }})

This only + add legend entry

This feature only

Cancel

Legend Editor

Drag legend to reposition

|

 Reset

Stroke:

No legend entries found

Reset All Strokes

Feature colors and labels are managed via Feature Editor

Feature Editor

Features ({{ filteredFeatures.length }})

{{ rid }}

{{ feat.type }}

{{ feat.start }}..{{ feat.end }}

{{ feat.product || feat.gene || feat.locus\_tag || feat.note || '(unnamed)' }}

Edit

Label: {{ getEditableLabelByFeatureId(feat.svg\_id).text }}

Label: (not editable)

Visibility: {{ getFeatureVisibility(feat) }}

No features found

Click a feature row or the diagram to edit legend name, label text, and colors.

Label TSV format: record\_id, feature\_type, qualifier, value, label\_text.

Export Label TSV

Load Label TSV

Reset Label Edits

[ ]
Auto Reflow

Reflowing label placement...

Auto Reflow failed. Current diagram is kept.

{{ labelOverrideBuildWarning }}

Configure settings and click Generate

**Disclaimer:** This tool is provided "as is" without warranty of any kind.

License: [MIT](https://github.com/satoshikawato/gbdraw/blob/main/LICENSE.txt) |
Author: [Satoshi Kawato](https://researchmap.jp/satoshi_kawato?lang=en)