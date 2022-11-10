SMC
=====

R function to calibrate the potato growth model [SOLANUM](https://doi.org/10.21223/P3/E71OS6). Temporal data of potato biomass and canopy cover are required.

Usage
-----
```{r eval=F}
FitCurveSM(x, y, xfun = "Beta", xtime = "tt", init.par = c(300, 900, 1.), use.par.default = "yes", graph = FALSE)

```
Arguments
-----
- **x:** Row name of the data frame __*data*__.
- **y:** Column name of the yield data of drought stress condition. 
- **xfun:** Column name of the yield data of potential condition.
- **xtime:** A data frame.
- **init.par:** A drought stress index (SSI, TOL, MP, GMP, and STI) calculated in the function __*"Thiry"*__.
- **use.par.default:** A logical value. If __inv=TRUE__, the drought stress index (__*x*__) is inverted. Default __inv=FALSE__.
- **graph:** A logi

Values
-----
- **$indexes:** A data frame of the drought stress indexes SSI, TOL, MP, GMP, and STI.
- **$scores:** A data frame of the Thiry's scores.
- **$corr1.:**  A matrix of Pearson correlation among the drought stress indexes and the Thiry's scores.
- **$range:** A list object with the range of the Thiry's scores SSI, TOL, MP, GMP, and STI. 
- **$comb1.:** A data frame of combinations of the Thiry's scores.  
- **$corr2.:** A matrix of Pearson correlation among Thiry's combinations and the yield data (**ys** and **yp**).
- **$comb2.:** A data frame of the best Thiry's combination.

Example
-----
```{r eval=F}
n=20
data=data.frame("id"=1:n,"ys"=runif(n)*5,"yp"=runif(n)*10)
ts=Thiry("id","ys","yp",data)
```
![plot](https://github.com/jninanya/SMC/blob/main/Picture1.png)

<img src="[https://your-image-url.type](https://github.com/jninanya/SMC/blob/main/Picture1.png)" width="800" height="800">
