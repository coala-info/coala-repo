import argparse
import json
import os
import sys
from typing import List, Sequence, Optional, Tuple, Union, cast

import matplotlib.colors as mcolors
import matplotlib.pyplot as plt
import numpy as np
from osgeo import gdal

Path = Union[str, os.PathLike[str]]
Number = Tuple[float, int]
ColorScale = Sequence[Tuple[Number, Tuple[Number, Number, Number]]]
ColorScaleFloat = List[Tuple[float, Tuple[float, float, float, float]]]


def plot_geotiff_gdal(
    input_image: Path,
    output_file: Path,
    output_plot: Path,
    color_scale: ColorScale,
    plot_title: Optional[str] = None,
    clip_min: Optional[Number] = None,
    clip_max: Optional[Number] = None,
) -> None:

    # Open the dataset
    dataset = gdal.Open(input_image)
    if not dataset:
        raise ValueError(f"Unable to open the image from file [{input_image}].")

    # Read the first band
    band = dataset.GetRasterBand(1)
    if not band:
        raise ValueError(f"Unable to retrieve the image band from file [{input_image}].")

    # Read data into numpy array
    data = band.ReadAsArray().astype(float)

    # Handle NoData values
    nodata = band.GetNoDataValue()
    nodata_mask = None
    if nodata is not None:
        print(f"nodata value: {nodata}")
        nodata_mask = np.logical_or(data == nodata, data == np.nan)
        data[nodata_mask] = np.nan
        print(f"nodata count: {np.sum(nodata_mask)}")
    else:
        print(f"nodata value not provided!")

    # Check if the data is valid
    if np.isnan(data).all():
        raise ValueError("Cannot use selected band. Image band contains only NaN values.")

    if (
        not color_scale
        or not len(color_scale) >= 2
        or not all(
            len(scale) == 2 and isinstance(scale[-1], (tuple, list)) and len(scale[-1]) == 3
            for scale in color_scale
        )
    ):
        raise ValueError(
            "Invalid color scale format. Must be a sequence of (value, color) with each color as (R, G, B) numbers. "
            f"Got {color_scale!s} instead."
        )

    # Custom color scale from your data
    color_scale = cast(
        ColorScaleFloat,
        [
            (
                float(scale[0]),  # type: ignore
                tuple([
                    float(num if num < 1 else num / 255)  # type: ignore
                    for num in scale[-1]
                ] + [1])  # solid color (alpha)
            )
            for scale in color_scale
        ]
    )

    # update scales to add transparent for nodata
    if nodata is not None:
        color_scale.append((nodata, (0, 0, 0, 0)))

    bins = [scale[0] for scale in color_scale]
    scales = [scale[-1] for scale in color_scale]

    # Create a colormap object
    cmap = mcolors.LinearSegmentedColormap.from_list("custom_cmap", scales, N=len(bins))  # type: ignore

    # Normalize the data to fit the scale
    data_min, data_max = np.nanmin(data), np.nanmax(data)
    print(f"Data range: {data_min} to {data_max}")

    # clip values if requested
    if clip_min is not None:
        clip_min_mask = (data < clip_min)
        if nodata_mask is not None:
            clip_min_mask = np.logical_and(clip_min_mask, ~nodata_mask)
        data[clip_min_mask] = clip_min
    if clip_max is not None:
        clip_max_mask = (data > clip_max)
        if nodata_mask is not None:
            clip_max_mask = np.logical_and(clip_max_mask, ~nodata_mask)
        data[clip_max_mask] = clip_max
    print(f"Clip values below minimum: {clip_min} (except 'nodata')")
    print(f"Clip values above maximum: {clip_max} (except 'nodata')")

    data_min = clip_min or data_min
    data_max = clip_max or data_max
    norm_color_scale = [
        [(scale[0] - data_min) / (data_max - data_min), scale[-1]]
        for scale in color_scale
    ]
    norm_bins = [scale[0] for scale in norm_color_scale]
    print(f"Normalized Color Scales: {json.dumps(norm_color_scale, indent=2)}")

    # normalize and colorize
    norm = mcolors.BoundaryNorm(bins, cmap.N)
    im_norm = norm(data)
    im_color = cmap(im_norm)

    # save color-map only
    plt.imsave(output_file, im_color, format="TIFF")

    # save color-map plot
    plt.figure(figsize=(10, 10))
    img = plt.imshow(im_color, cmap=cmap, norm=norm)
    bounds = bins
    labels = [f"{_bin if _bin < 255 else _bin:,.3e} ({_scale:,.3e})" for _bin, _scale in zip(bins, norm_bins)]
    if nodata is not None:
        labels = labels[:-1] + [f"nodata\n({nodata:,.3e})"]
    cbar = plt.colorbar(img, label="Value", boundaries=bounds, ticks=bounds)
    cbar.ax.set_yticklabels(labels)
    if plot_title:
        plt.title(plot_title)
    plt.savefig(output_plot)


def make_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="plot-image",
        description="Applies the specified color mapping with scaled bins to a geospatial image.",
    )
    parser.add_argument("--input-image", type=str, required=True)  # str instead of FileType to avoid unnecessary open
    parser.add_argument("--color-scale", type=str, required=True)
    parser.add_argument("--output-name", type=str, required=False, default="output")
    parser.add_argument("--plot-name", type=str, required=False, default="plot")
    parser.add_argument("--plot-title", type=str, required=False)
    parser.add_argument("--clip-min", type=float, required=False, default=None)
    parser.add_argument("--clip-max", type=float, required=False, default=None)
    return parser


def main(args: Sequence[str]) -> None:
    parser = make_parser()
    ns = parser.parse_args(args)
    try:
        color_scale = json.loads(ns.color_scale)
    except Exception:
        raise ValueError("Could not parse color scale. Value is not a valid JSON structure.")
    output_file = f"{os.path.basename(ns.output_name)}.tif"
    output_plot = f"{os.path.basename(ns.plot_name)}.png"
    plot_geotiff_gdal(
        ns.input_image,
        output_file,
        output_plot,
        color_scale,
        ns.plot_title,
        ns.clip_min,
        ns.clip_max,
    )


if __name__ == "__main__":
    main(sys.argv[1:])
