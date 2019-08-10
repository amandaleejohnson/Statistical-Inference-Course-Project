#Statistical Inference Course Project
# 
# The project consists of two parts:
#         
#         A simulation exercise.
# Basic inferential data analysis.
# 
# You will create a report to answer the questions. Given the nature of the series, 
# ideally you'll use knitr to create the reports and convert to a pdf. (I will post a 
# very simple introduction to knitr). However, feel free to use whatever software that 
# you would like to create your pdf.
# 
# Each pdf report should be no more than 3 pages with 3 pages of supporting appendix material 
# if needed (code, figures, etcetera).
# 
###########################################
# Review criteria
###########################################

# Did you show where the distribution is centered at and compare it to the theoretical center of 
#         the distribution?
# Did you show how variable it is and compare it to the theoretical variance of the distribution?
# Did you perform an exploratory data analysis of at least a single plot or table highlighting basic 
#         features of the data?
# Did the student perform some relevant confidence intervals and/or tests?
# Were the results of the tests and/or intervals interpreted in the context of the problem correctly?
# Did the student describe the assumptions needed for their conclusions? 

###########################################
# Part 1: Simulation Exercise Instructions
###########################################
# In this project you will investigate the exponential distribution in R and compare it with the 
# Central Limit Theorem. The exponential distribution can be simulated in R with rexp(n, lambda) 
# where lambda is the rate parameter. The mean of exponential distribution is 1/lambda and the 
# standard deviation is also 1/lambda. Set lambda = 0.2 for all of the simulations. You will 
# investigate the distribution of averages of 40 exponentials. Note that you will need to do a 
# thousand simulations.

# Illustrate via simulation and associated explanatory text the properties of the distribution of 
# the mean of 40 exponentials. You should:

        # Using pre-defined parameters
        lambda = 0.2
        n = 40
        sims = 1:1000
        set.seed(1234)
        
        #Load R packages for project:
        if(!require(ggplot2)) {
                install.packages("ggplot2")
        }
        library(ggplot2)
        
        # From directions: 
        # The exponential distribution can be simulated in R with rexp(n, lambda) 
        # where lambda is the rate parameter. 
        # The mean of exponential distribution is 1/lambda and the standard deviation is also 1/lambda.
        
        # Simulate the population:
        pop = data.frame(x=sapply(sims, function(x) {
                mean(rexp(n, lambda))
        }))
        
        # Plot the histogram
        hist.pop = ggplot(pop, aes(x=x)) +
                geom_histogram(aes(y=..count.., fill=..count..), 
                               color = "black") + 
                labs(title="Distribution of Averages of 40 Exponentials ~ 1000 Simulations", 
                     y="Frequency Count", x="Mean")
        hist.pop
        
        #By sampling without replacement, the mean is around 4.5-5.5, seems to be approximating a normal distribution.
        #We've set the seed at 1234. 
        
# Show the sample mean and compare it to the theoretical mean of the distribution.
        sample.mean = mean(pop$x)
        theo.mean = 1/lambda
        cbind(sample.mean, theo.mean)
        
        #The sample mean (4.97) approximates the theoretical mean (5).
        
        # Check the 95% confidence interval for the sample mean
        t.test(pop$x)
        ci = t.test(pop$x)$conf
        lowerci = round(ci[1], 2)
        upperci = round(ci[2], 2)
        #The 95% CI for the sample mean includes the theoretical mean (5) (4.93, 5.02)
        
# Show how variable the sample is (via variance) and compare it to the theoretical variance of the 
# distribution.
        
        sample.var = var(pop$x)
        theo.var = ((1/lambda)^2)/n
        cbind(sample.var, theo.var)
                
        #The sample variance and theoretical variance are very close.
        
# Show that the distribution is approximately normal.
        
        # Plot the sample mean and var vs. theoretical mean and var:
        #We need to plot the density rather than the count because we are 
        #also plotting the geom_vlines. These would be flattened 
        #on the bottom of the y-axis (<1) if the y-axis was count.
        distnormal = ggplot(pop, aes(x=x)) +
                geom_histogram(aes(y=..density.., fill = ..density..), 
                               color = "black") +
                labs(title="Distribution of Averages of 40 Exponentials ~ 1000 Simulations", 
                     y = "Density", 
                     x = "Mean", 
                     caption = "Black = Sample Mean, Red = Theoretical Mean") +
                geom_density(color = "black") +
                geom_vline(xintercept = sample.mean, color = "black", linetype = "dashed", show.legend = TRUE) +
                stat_function(fun = dnorm, args = list(mean = 1/lambda, sd = sqrt(theo.var)), 
                              color = "red") +
                geom_vline(xintercept = theo.mean, color = "red", linetype = "dashed", show.legend = TRUE)
                
        distnormal
        
        #Evaluating the figure, the distribution of the sample mean for 
        #40 exponentials simulated 1000 times approximates the theoretical mean
        #for a normal distribution. 
        
        
# In point 3, focus on the difference between the distribution of a large collection of random 
# exponentials and the distribution of a large collection of averages of 40 exponentials.
# 
# As a motivating example, compare the distribution of 1000 random uniforms
        set.seed(1234)
        hist(runif(1000))
# and the distribution of 1000 averages of 40 random uniforms
        mns = NULL
        for (i in 1 : 1000) mns = c(mns, mean(runif(40)))
        hist(mns)
# This distribution looks far more Gaussian than the original uniform distribution!
# 
# This exercise is asking you to use your knowledge of the theory given in class to relate the two 
# distributions.
# 
# Confused? Try re-watching video lecture 07 for a starter on how to complete this project.
        
###########################################        
# Sample Project Report Structure
###########################################
# Of course, there are multiple ways one could structure a report to address the requirements above. 
# However, the more clearly you pose and answer each question, the easier it will be for reviewers to 
# clearly identify and evaluate your work.
# 
# A sample set of headings that could be used to guide the creation of your report might be:
# 
# Title (give an appropriate title) and Author Name
# Overview: In a few (2-3) sentences explain what is going to be reported on.
# Simulations: Include English explanations of the simulations you ran, with the accompanying R code. 
#         Your explanations should make clear what the R code accomplishes.
# Sample Mean versus Theoretical Mean: Include figures with titles. In the figures, highlight the 
#         means you are comparing. Include text that explains the figures and what is shown on them, 
#         and provides appropriate numbers.
# Sample Variance versus Theoretical Variance: Include figures (output from R) with titles. Highlight 
#         the variances you are comparing. Include text that explains your understanding of the 
#         differences of the variances.
# Distribution: Via figures and text, explain how one can tell the distribution is approximately 
#         normal.

###########################################
# Part 2: Basic Inferential Data Analysis Instructions
###########################################
# Now in the second portion of the project, we're going to analyze the ToothGrowth data in the R 
# datasets package.
        
# Load the ToothGrowth data and perform some basic exploratory data analyses
        library(UsingR)
        data(ToothGrowth)
# Provide a basic summary of the data.
        str(ToothGrowth)
        summary(ToothGrowth)
        summary(ToothGrowth$len ~ ToothGrowth$supp)
        summary(ToothGrowth$len ~ ToothGrowth$dose)
        
        
        qplot(supp,len,data=ToothGrowth, 
              main="Tooth length by supplement type", 
              xlab="Supplement type", ylab="Tooth length") + 
                geom_boxplot(aes(fill = supp))
        
        qplot(dose,len,data=ToothGrowth, 
              main="Tooth length by dose (mg)", 
              xlab="Dose (mg)", ylab="Tooth length")
        
        qplot(supp,len,data=ToothGrowth, facets=~dose, 
              main="Tooth length by supplement type and dosage (mg)", 
              xlab="Supplement type", ylab="Tooth length") + 
        geom_boxplot(aes(fill = supp))
        
        
# Use confidence intervals and/or hypothesis tests to compare tooth growth by supp and dose. 
# (Only use the techniques from class, even if there's other approaches worth considering)

        ##SUPPLEMENT##
        
        #Since the variances appear to be unequal, we need a Welch's t-test:
        t.test(len ~ supp, paired = FALSE, var.equal = FALSE, data = ToothGrowth)
        ttest = t.test(len ~ supp, paired = FALSE, var.equal = FALSE, data = ToothGrowth)
        length(ttest)
        pvalue = ttest$p.value
        
        #What about a hypothesis that mean tooth length is greater when given the OJ supplement?
        t.test(len ~ supp, alternative = "greater", paired = FALSE, var.equal = FALSE, data = ToothGrowth)
        #This is significant!
        
        
        ##DOSE##
        
        #THe variance for the 0.5 dose looks slightly larger, so use unequal just to be safe
        #Since we can only report t-tests with two samples right now (we don't know how to do ANOVAs yet!)
        #we first need to compare the 0.5 dose vs. the 1.0 dose, 
        #then the 1.0 dose vs. the 2.0 dose.
        #(Then maybe the 0.5 dose vs. 2.0 dose?)
        
        #FIrst, create three subsets so that dose is only two levels:
        # using subset function
        halfvsone = subset(ToothGrowth, dose<2) 
        
        onevstwo = subset(ToothGrowth, dose>0.5)
        
        halfvstwo = subset(ToothGrowth, dose==0.5 | dose==2)
        
        #0.5 vs 1 mg:
        t.test(len ~ dose, paired = FALSE, var.equal = FALSE, data = halfvsone)
        #If it's a significant two-sided test, then it's a significant one-sided test
        
        #1 vs 2 mg:
        t.test(len ~ dose, paired = FALSE, var.equal = FALSE, data = onevstwo)
        #If it's a significant two-sided test, then it's a significant one-sided test
        
        #0.5 vs 2 mg:
        t.test(len ~ dose, paired = FALSE, var.equal = FALSE, data = halfvstwo)
        #If it's a significant two-sided test, then it's a significant one-sided test
        
        
        
# State your conclusions and the assumptions needed for your conclusions.
        
        