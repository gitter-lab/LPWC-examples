[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/gitter-lab/LPWC-examples/master?urlpath=rstudio)

# LPWC examples
Examples for running the [LPWC](https://github.com/gitter-lab/LPWC/) R package for time series clustering that are executable within [Binder](https://mybinder.org/).

## Usage
Once R studio is launched, please navigate to the bottom right corner where the files are located.
The `LPWC.R` file executes all the code available in the LPWC vignette.
The `example.R` file provides example code for analyzing time series data using LPWC.
It also shows one way to select the number of clusters using the silhouette method and how to plot the clusters using ggplot2.
The `example.R` is easy to run and instructions are included with each line of code.
After clicking one of the `.R` files, the file should open up in the top left corner of the R studio.
For macOS, click `Command + Enter` to run the particular line and step through the example.
Similarly, Windows users can use `ctrl + Enter` to run each line.
With a large number of genes, `corr.bestlag` takes time to process.
To replace the example dataset with a new dataset, please read the comments in the `example.R` file.

## Troubleshooting
It is normal for Binder to take several minutes to load the executable software environment.
If you see the error message `Failed to connect to event stream` when launching Binder, simply refresh your web browser.
The connection will typically be re-established and launch Binder successfully.

Binder will time out after a period of inactivity.
If this happens, you will need to relaunch Binder and restart the example analysis.
