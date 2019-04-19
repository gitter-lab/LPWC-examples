[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/gitter-lab/LPWC-examples/master?urlpath=rstudio)

# LPWC examples
Examples for running the [LPWC](https://github.com/gitter-lab/LPWC/) R package for time series clustering that are executable within [Binder](https://mybinder.org/).

## Scripts
** TODO: How does the user run these? 
We need some instructions for what they should do after landing in R studio.
We also need to give some indication of how long some of these steps take.
In code, give guidance on what users can inspect in the Environment tab in R studio and what output they should look for.
Tell users they can modify the code to test different LPWC settings. **

The `LPWC.R` file executes all the code available in the LPWC vignette.
The `example.R` file provides example code for analyzing time series data using LPWC.
It also shows one way to select the number of clusters using the silhouette method and how to plot the clusters using ggplot2.

## Troubleshooting
It is normal for Binder to take several minutes to load the executable software environment.
If you see the error message `Failed to connect to event stream` when launching Binder, simply refresh your web browser.
The connection will typically be re-established and launch Binder successfully.

Binder will time out after a period of inactivity.
If this happens, you will need to relaunch Binder and restart the example analysis.
