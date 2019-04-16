[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/gitter-lab/LPWC-examples/master?urlpath=rstudio)

# LPWC-examples
Examples for running the [LPWC](https://github.com/gitter-lab/LPWC/) R package for time series clustering that are executable within [Binder](https://mybinder.org/).

## Troubleshooting
If you see the error message `Failed to connect to event stream` when lanching Binder, simply refresh your web browser.
The connection will typically be re-established and launch Binder successfully.

## Scripts
The `LPWC.R` file executes all the code available in LPWC vignette.
The `example.R` file provides an example code for analyzing time-series data using LPWC, it also helps you select the right cluster number using silhouette and plot the clusters using ggplot2. 