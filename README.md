# COVID-19 Dashboard 
This [dashboard](https://chschoenenberger.shinyapps.io/covid19_dashboard/) shows recent developments of the COVID-19 pandemic. The latest
open data on the COVID-19 spread are regularly downloaded and displayed in
a map, summary tables, key figures and plots.

Our Motivation is to make similar thing, that shows data related to Indian States and India.

## Installation
First install R and your favourite IDE on your machine (I suggest RStudio
or IntelliJ Community Edition with R plugin). To run the dashboard on your 
own machine, clone the repository and install 
[renv](https://rstudio.github.io/renv/articles/renv.html).
To get Renv, we [need](https://www.dummies.com/programming/r/how-to-install-and-load-cran-packages-in-r/) to get RStudio. Renv is a dependency management tool for R. After installing call ``renv::restore()``. This will get all libraries in renv.lock and install them on your machine. Afterwards
you should be able to run the dashboard by calling ``shiny::runApp()``.

### Publishing
I used [RStudio Connect](https://rstudio.com/products/connect/) with 
[Shinyapps.io](https://www.shinyapps.io/) to publish this dashboard. As
the rsconnect library currently does not run smoothly with renv, 
deactivate renv by calling ``renv::deactivate()``. Afterwards you should
be able to deploy the dashboard to Shinyapps using ``rsconnect::deployApp()``.

## Bugs, Issues & Enhancement Requests
If you find any bug / issue or have an idea how to improve the dashboard,
please create an [issue](https://github.com/22shubh22/covid19_dashboard/issues). 
I will try to look into it as soon as possible.

## License
MIT © Christoph Schönenberger
