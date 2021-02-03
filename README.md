
# cfpr

<!-- badges: start -->
<!-- badges: end -->

The goal of cfpr is to ...

## Installation

Run the code below to install `cfpr`.

``` r
remotes::install_github("CodeForPhilly/cfpr")
```

## Connecting to Data


> ⚠️ : In order to load the package, you'll need to put in credentials for the CfP data warehouse. If you don't have credentials, message `@machow` on the Code for Philly slack,
or reach out on the #cfp-dashboard channel!

Create a `.Renviron` in your Rstudio project or home directory with the content below.

```
CFP_DIALECT=<FILL_IN>
CFP_USER=<FILL_IN>
CFP_PASSWORD=<FILL_IN>
CFP_PORT=<FILL_IN>
CFP_DB=<FILL_IN>
CFP_HOST=<FILL_IN>
```

Then, replace all the `<FILL_IN>` pieces with settings you received beforehand.


## Example

``` r
library(cfpr)

## Should have access now to all project tags on CodeForPhilly.org
cfp_views_laddr_project_tags()

## note that this is a dbplyr table object, so you can do data analysis on it
library(dplyr)

cfp_views_laddr_project_tags() %>%
  filter(tag_title == "Python") %>%
  collect()

```

