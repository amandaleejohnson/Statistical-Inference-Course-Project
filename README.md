# Statistical Inference Course Project #

## Synopsis ##

The project consists of two parts:

        - A simulation exercise
        
        - Basic inferential data analysis

Given the nature of the series, I used knitr to create the reports and convert to a pdf. The pdf report was limited to be no more than 3 pages with 3 pages of supporting appendix material if needed (code, figures, etc.). 

## Review Criteria ##
        
The project required us to answer the following questions:

        - What were the basic features of the data? 
        
        - Where was the distribution centered and how did it compare to the theoretical center of the distribution?
        
        - What was the sample variance and how did it compare to the theoretical variance of the distribution?
        
        - When is it appropriate to present confidence intervals and/or tests? 
        
        - What assumptions are needed for additional context in the conclusions? 

## Part 1: Simulation Exercise Instructions ##

In this project I investigated the exponential distribution in R and compared it with the Central Limit Theorem. The exponential distribution can be simulated in R with rexp(n, lambda) where lambda is the rate parameter. The mean of exponential distribution is 1/lambda and the standard deviation is also 1/lambda. I've set lambda = 0.2 for all of the simulations. I also investigated the distribution of averages of 40 exponentials and completed 1,000 simulations. Note - Before starting, I installed and loaded the following packages in R: R.utils, rmarkdown, knitr, tidyverse, ggplot2, and UsingR. 

I illustrated via simulation and associated explanatory text the properties of the distribution of the mean of 40 exponentials:

 - Displayed the sample mean and compared it to the theoretical mean of the distribution.
 - Demonstrated how variable the sample is (via variance) and compared it to the theoretical variance of the distribution.
 - Displayed that the distribution is approximately normal.

I used the pre-defined parameters and set the seed at 1234. By sampling without replacement, the plot visualizes that the mean is around 5. The distribution in the plot seems to be approximating a normal distribution, however, there is uneven distribution in the tails.
        
## Part 2: Basic Inferential Data Analysis Instructions ##
In the second portion of the project, I analyzed the ToothGrowth data in the R datasets package.
