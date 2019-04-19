[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/gitter-lab/LPWC-examples/master?urlpath=rstudio)

# LPWC examples
Examples for running the [LPWC](https://github.com/gitter-lab/LPWC/) R package for time series clustering that are executable within [Binder](https://mybinder.org/).

## Scripts
The `LPWC.R` file executes all the code available in the LPWC vignette.
The `example.R` file provides example code for analyzing time series data using LPWC.
It also shows one way to select the number of clusters using the silhouette method and how to plot the clusters using ggplot2.

## Troubleshooting
If you see the error message `Failed to connect to event stream` when launching Binder, simply refresh your web browser.
The connection will typically be re-established and launch Binder successfully.
