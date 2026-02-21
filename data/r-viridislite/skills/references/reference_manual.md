Package ‘viridisLite’

February 4, 2026

Type Package

Title Colorblind-Friendly Color Maps (Lite Version)

Version 0.4.3

Date 2026-02-03

Maintainer Simon Garnier <garnier@njit.edu>

Description Color maps designed to improve graph readability for readers with
common forms of color blindness and/or color vision deficiency. The color
maps are also perceptually-uniform, both in regular form and also when
converted to black-and-white for printing. This is the 'lite' version of the
'viridis' package that also contains 'ggplot2' bindings for discrete and
continuous color and fill scales and can be found at
<https://cran.r-project.org/package=viridis>.

License MIT + file LICENSE

Encoding UTF-8

Depends R (>= 2.10)

Suggests hexbin (>= 1.27.0), ggplot2 (>= 1.0.1), testthat, covr

URL https://sjmgarnier.github.io/viridisLite/,

https://github.com/sjmgarnier/viridisLite/

BugReports https://github.com/sjmgarnier/viridisLite/issues/

RoxygenNote 7.3.3

NeedsCompilation no

Author Simon Garnier [aut, cre],
Noam Ross [ctb, cph],
Bob Rudis [ctb, cph],
Marco Sciaini [ctb, cph],
Antônio Pedro Camargo [ctb, cph],
Cédric Scherer [ctb, cph]

Repository CRAN

Date/Publication 2026-02-04 06:40:10 UTC

1

2

Contents

viridis

.
viridis .
viridis.map .

.

.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
4

6

Index

viridis

Viridis Color Palettes

Description

This function creates a vector of n equally spaced colors along the selected color map.

Usage

viridis(n, alpha = 1, begin = 0, end = 1, direction = 1, option = "D")

viridisMap(n = 256, alpha = 1, begin = 0, end = 1, direction = 1, option = "D")

magma(n, alpha = 1, begin = 0, end = 1, direction = 1)

inferno(n, alpha = 1, begin = 0, end = 1, direction = 1)

plasma(n, alpha = 1, begin = 0, end = 1, direction = 1)

cividis(n, alpha = 1, begin = 0, end = 1, direction = 1)

rocket(n, alpha = 1, begin = 0, end = 1, direction = 1)

mako(n, alpha = 1, begin = 0, end = 1, direction = 1)

turbo(n, alpha = 1, begin = 0, end = 1, direction = 1)

Arguments

n

alpha

begin

end

direction

option

The number of colors (≥ 1) to be in the palette.

The alpha transparency, a number in [0,1], see argument alpha in hsv.

The (corrected) hue in [0,1] at which the color map begins.

The (corrected) hue in [0,1] at which the color map ends.

Sets the order of colors in the scale. If 1, the default, colors are ordered from
darkest to lightest. If -1, the order of colors is reversed.

A character string indicating the color map option to use. Eight options are
available:

• "magma" (or "A")
• "inferno" (or "B")

viridis

3

• "plasma" (or "C")
• "viridis" (or "D")
• "cividis" (or "E")
• "rocket" (or "F")
• "mako" (or "G")
• "turbo" (or "H")

Details

Here are the color scales:

magma(), plasma(), inferno(), cividis(), rocket(), mako(), and turbo() are convenience
functions for the other color map options, which are useful when the scale must be passed as a
function name.

Semi-transparent colors (0 < alpha < 1) are supported only on some devices: see rgb.

Value

viridis returns a character vector, cv, of color hex codes. This can be used either to create a user-
defined color palette for subsequent graphics by palette(cv), a col = specification in graphics
functions or in par.

viridisMap returns a n lines data frame containing the red (R), green (G), blue (B) and alpha (alpha)
channels of n equally spaced colors along the selected color map. n = 256 by default.

4

Author(s)

Simon Garnier: <garnier@njit.edu> / @lostintheswarm

viridis.map

Examples

library(ggplot2)
library(hexbin)

dat <- data.frame(x = rnorm(10000), y = rnorm(10000))

ggplot(dat, aes(x = x, y = y)) +
geom_hex() + coord_fixed() +
scale_fill_gradientn(colours = viridis(256, option = "D"))

# using code from RColorBrewer to demo the palette
n = 200
image(

1:n, 1, as.matrix(1:n),
col = viridis(n, option = "D"),
xlab = "viridis n", ylab = "", xaxt = "n", yaxt = "n", bty = "n"

)

viridis.map

Color Map Data

Description

A data set containing the RGB values of the color maps included in the package. These are:

• ’magma’, ’inferno’, ’plasma’, and ’viridis’ as defined in Matplotlib for Python. These color
maps are designed in such a way that they will analytically be perfectly perceptually-uniform,
both in regular form and also when converted to black-and-white. They are also designed to
be perceived by readers with the most common form of color blindness. They were created
by Stéfan van der Walt and Nathaniel Smith;

• ’cividis’, a corrected version of ’viridis’, ’cividis’, developed by Jamie R. Nuñez, Christopher
R. Anderton, and Ryan S. Renslow, and originally ported to R by Marco Sciaini. It is designed
to be perceived by readers with all forms of color blindness;

• ’rocket’ and ’mako’ as defined in Seaborn for Python;

• ’turbo’, an improved Jet rainbow color map for reducing false detail, banding and color blind-

ness ambiguity.

Usage

viridis.map

viridis.map

Format

A data frame with 2048 rows and 4 variables:

R: Red value;

G: Green value;

B: Blue value;

5

opt: The colormap "option" (A: magma; B: inferno; C: plasma; D: viridis; E: cividis; F: rocket;

G: mako; H: turbo).

Author(s)

Simon Garnier: <garnier@njit.edu> / @lostintheswarm

References

magma, inferno, plasma, viridis https://bids.github.io/colormap/

cividis https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0199239

rocket, mako https://seaborn.pydata.org/index.html

turbo https://ai.googleblog.com/2019/08/turbo-improved-rainbow-colormap-for.html

Index

∗ datasets

viridis.map, 4

cividis (viridis), 2

hsv, 2

inferno (viridis), 2

magma (viridis), 2
mako (viridis), 2

plasma (viridis), 2

rgb, 3
rocket (viridis), 2

turbo (viridis), 2

viridis, 2
viridis.map, 4
viridisMap (viridis), 2

6

