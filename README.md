SMC
=====

R function to calibrate the potato growth model [SOLANUM](https://doi.org/10.21223/P3/E71OS6). Temporal data of potato biomass and canopy cover are required.

Usage
-----
```{r eval=F}
FitCurveSM(x, y, xfun = "Beta", xtime = "tt", init.par = c(300, 900, 1.), use.par.default = TRUE, graph = FALSE)

```
Arguments
-----
- **x:** A vector of the timing (in __*dap -*__ days after planting or __*tt -*__ thermal time) when biomass or canopy cover data were collected.
- **y:** A vector of temporal data of biomass (harvest index) or canopy cover (in %). 
- **xfun:** A character indicating if data will be fitted to a Beta or Gompertz function. Use __*"Beta"*__ for canopy cover and __*"Gompertz"*__ for biomass data.
- **xtime:** A character indicating if __*xtime*__ is days after planting (use __*"dap"*__) or thermal time (__*"tt"*__; by default).
- **init.par:** A vector indicating the 3 initial values of the parameters of the Beta or Gompertz function.
- **use.par.default:** A logical value. If __use.par.default=TRUE__, default values in __*init.par*__ will be used for the Beta or Gompertz function; otherwise, another initial value can be specified in __*init.par*__. Default __use.par.default=TRUE__.
- **graph:** A logical value.

Values
-----
- **$parameters:** A vector of the fitted parameters of the Beta or Gompertz function.
- **$fitted.data:** A data frame of the observed and estimated data.
- **$simulated.data:**  A data frame of simulated data for biomass or canopy cover.
- **$warning.message:** A character indicating any warning message in the model fitting.
- **$out.model:** A summary.nls of the fitted model.

Example
-----
```{r eval=F}
cc<-read.csv("canopy_cover_data.csv")
hi<-read.csv("biomass_data.csv")

# for canopy cover data
out=FitCurveSM(x=cc[,1], y = cc[,5], xfun = "Beta", xtime = "dap")

# Using another set of initial values (in case that default init.par value does not work)
out=FitCurveSM(x=cc[,1], y = cc[,6], xfun = "Beta", xtime = "dap", use.par.default = FALSE, init.par = c(35,65,0.9), graph = TRUE)
```

![plot](https://github.com/jninanya/SMC/blob/main/fig_fitted_cc.png)

```{r eval=F}
# for biomass (harvest index) data
out=FitCurveSM(x=hi[,1], y = hi[,3], xfun = "Gompertz", xtime = "dap", graph = TRUE)
```
![plot](https://github.com/jninanya/SMC/blob/main/fig_fitted_hi.png)



